library("here")
library("dplyr")
library("arrow")


# Leitura dados 

caminho_arquivos <- "C:/Users/AndsonSilva/Desktop/Curso_BigData/curso_bigdata/Projeto01/dados"
caminho_sellers <- here(caminho_arquivos, "olist_sellers_dataset.csv")

base_sellers <- open_dataset(caminho_sellers, format = "csv")

## Qual a cidade que possui mais vendedores ?

base_sellers %>% group_by(seller_city) %>% 
  summarize(qtd_vendedores_cidade = n()) %>% 
  arrange(desc(qtd_vendedores_cidade)) %>% collect() %>% print()

# R : São Paulo possui o maior numero de vendedores
 