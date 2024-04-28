library("here")
library("dplyr")
library("arrow")

# Leitura dos dados
caminho_arquivos <- "C:/Users/AndsonSilva/Desktop/Curso_BigData/curso_bigdata/Projeto01/dados"

caminho_payments <- here(caminho_arquivos, "olist_order_payments_dataset.csv")

base_payments <- open_dataset(caminho_payments, format = "csv")


print(base_payments)


# Qual método de pagamento possui o maior montante em valor ?

base_payments %>% group_by(payment_type) %>% 
                  summarize(vl_pagamento = sum(payment_value)) %>%
                  collect() %>% print()

# R : credit_card 12.542.084


# Qual o maior parcelamento registrado ?

base_payments_df <- collect(base_payments)

maximo <- max(base_payments_df$payment_installments)

print(maximo)

# R : o maior parcelamento registrado é 24
  