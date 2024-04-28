library("here")
library("dplyr")
library("arrow")

# Leitura dos dados

# Qual a maior diferença entre a data estimada de entrega e a data efetiva ?

caminho_arquivos <- "C:/Users/AndsonSilva/Desktop/Curso_BigData/curso_bigdata/Projeto01/dados"

caminho_order <- here(caminho_arquivos, "olist_orders_dataset.csv")

base_order <- open_dataset(caminho_order, format = "csv")

print(base_order)

#order_delivered_customer_date real
#order_estimated_delivery_date estimada

base_order <- collect(base_order)


base_order$dif_date <- as.numeric(difftime(base_order$order_estimated_delivery_date, base_order$order_delivered_customer_date, units = "days"))


maximo_dif_date <- max(base_order$dif_date, na.rm = TRUE)


print(maximo_dif_date)

# R : A maior diferença é aprox 146 dias.
