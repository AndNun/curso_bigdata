library("here")
library("dplyr")
library("arrow")

# Leitura dos dados
caminho_arquivos <- "C:/Users/AndsonSilva/Desktop/Curso_BigData/curso_bigdata/Projeto01/dados"
caminho_customers <- here(caminho_arquivos, "olist_customers_dataset.csv")
caminho_orders <- here(caminho_arquivos, "olist_orders_dataset.csv")
caminho_reviews <- here(caminho_arquivos, "olist_order_reviews_dataset.csv")

base_customers <- open_dataset(caminho_customers, format = "csv")
print(base_customers)

base_orders <- open_dataset(caminho_orders, format = "csv")
print(base_orders)

base_reviews <- open_dataset(caminho_reviews, format = "csv")
print(base_reviews)

# Qual a cidade que possui clientes com menos pedidos para cada mês do ano?


# Fazendo inner join entre a base de clientes e pedidos, 
# depois estou agrupamento por cidade e ano mês ("AAAA-MM") e ordernando pela quantidade de pedidos

base_customers %>% inner_join(base_orders, by = "customer_id") %>%
  mutate(calc_safra_ano_mes = year(order_purchase_timestamp)*100 + month(order_purchase_timestamp)) %>%
  group_by(customer_city, calc_safra_ano_mes
) %>% summarize(
                qtd_pedidos = n()
) %>% arrange(qtd_pedidos, desc(calc_safra_ano_mes)) %>% collect() %>% print()


# Acabei cosiderando as top 10 cidades com menos pedidos de acordo com o periodo mais recentes

#customer_city  ano_mes qtd_pedidos
#<chr>          <chr>         <int>
#1 picos          2018-10           1
#2 pirai          2018-10           1
#3 registro       2018-10           1
#4 sorocaba       2018-10           1
#5 guarulhos      2018-09           1
#6 mafra          2018-09           1
#7 praia grande   2018-09           1
#8 registro       2018-09           1
#9 rio de janeiro 2018-09           1
#10 santa luzia   2018-09           1
                 
# Clientes de qual cidade tendem a dar avaliações piores ?

base_customers %>% inner_join(base_orders, by = "customer_id") %>% 
                   inner_join(base_reviews, by = "order_id") %>%
                   group_by(customer_city) %>% 
                   summarize(media_avaliacao = mean(review_score)) %>%
                   arrange(media_avaliacao) %>% collect %>% print()

# Top 10 cidades com deram as piores avaliações

#customer_city            media_avaliacao
#<chr>                              <dbl>
#1 cafeara                                1
#2 japi                                   1
#3 maioba                                 1
#4 rainha do mar                          1
#5 dores de guanhaes                      1
#6 vista alegre                           1
#7 igapora                                1
#8 itaguacu da bahia                      1
#9 sao francisco do humaita               1
#10 itororo                               1


# Qual é o cliente que possui mais pedidos ?

base_customers %>%
  group_by(customer_id
  ) %>% summarize(
    qtd_pedidos = n()
  ) %>% arrange(desc(qtd_pedidos)) %>% collect() %>% print()
  
 