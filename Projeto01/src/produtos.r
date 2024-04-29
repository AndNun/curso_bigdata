library("here")
library("dplyr")
library("arrow")

# Leitura dos dados
caminho_arquivos <- "C:/Users/AndsonSilva/Desktop/Curso_BigData/curso_bigdata/Projeto01/dados"
caminho_products <- here(caminho_arquivos, "olist_products_dataset.csv")
caminho_order_items <- here(caminho_arquivos, "olist_order_items_dataset.csv")
caminho_reviews <- here(caminho_arquivos, "olist_order_reviews_dataset.csv")

base_products <- open_dataset(caminho_products, format = "csv")
print(base_products)

base_reviews <- open_dataset(caminho_reviews, format = "csv")
print(base_reviews)

base_order_items <- open_dataset(caminho_order_items, format = "csv")
print(base_order_items)

## Qual a categoria de produtos que tem a pior avaliação média ?

base_products %>% inner_join(base_order_items, by = 'product_id')  %>%
                  inner_join(base_reviews, by = 'order_id') %>%
                  group_by(product_category_name) %>% 
                  summarize(media_avaliacao = mean(review_score)) %>%
                  arrange(media_avaliacao) %>% collect %>% print()

# R : a categoria seguros_e_servicos (2.)5 é a categoria de produtos que possui a pior avaliação 

## Qual a categoria que possui o maior score de avaliação ?

base_products %>% inner_join(base_order_items, by = 'product_id')  %>%
  inner_join(base_reviews, by = 'order_id') %>%
  group_by(product_category_name) %>% 
  summarize(media_avaliacao = mean(review_score)) %>%
  arrange(desc(media_avaliacao)) %>% collect %>% print()

# R : a categoria cds_dvds_musicais 4.64 é a que possui maior score de avaliação
          
## Qual a categoria que possui mais produtos ?

base_products %>% group_by(product_category_name) %>%
                 summarize(qtd_produtos = n()) %>%
                 arrange(desc(qtd_produtos)) %>% collect() %>% print()

# R : A categoria que possui mais produtos é cama_mesa_banho com 3.029 produtos
