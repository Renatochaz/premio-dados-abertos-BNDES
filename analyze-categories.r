## This file analyze the basic differences between
## the base for "financiamentos diretos"
## and "financiamentos indiretos" from BNDES open datasets.

## Load dependencies.
library(data.table)

## Define work directory.
setwd("/home/renatochaz/git/dados-abertos")

## Load Operações de Financiamento from
## https://dadosabertos.bndes.gov.br/dataset/operacoes-financiamento
non_direct_ops <- fread("https://dadosabertos.bndes.gov.br/datastore/dump/332d446e-d340-46ef-af64-ee6f36e7bd50?bom=True")
direct_ops <- fread("https://dadosabertos.bndes.gov.br/dataset/0f335c85-92a8-4343-9423-f073fb40774e/resource/9534f677-9525-4bf8-a3aa-fd5d3e152a93/download/operacoes-financiamento-operacoes-indiretas-automaticas.csv")


## Get mean desembolso (R$)
mean_indireta <- mean((as.numeric
(gsub(",", ".", non_direct_ops$valor_desembolsado_reais))))

mean_direta <- mean((as.numeric(
    gsub(",", ".", direct_ops$valor_desembolsado_reais)
)),
na.rm = TRUE
)

## Get category of financial instruments from BNDES
fonte_recursos_indireta <- levels(
    as.factor(direct_ops$fonte_de_recurso_desembolsos)
)

produto_indireta <- levels(as.factor(direct_ops$produto))

instrumento_fin_indireta <- levels(as.factor(direct_ops$instrumento_financeiro))

fonte_recursos_direta <- levels(
    as.factor(non_direct_ops$fonte_de_recurso_desembolsos)
)

produto_direta <- levels(as.factor(non_direct_ops$produto))

instrumento_fin_direta <- levels(
    as.factor(non_direct_ops$instrumento_financeiro)
)

## Print result

## Means.
paste(
    "média operações indiretas: ",
    round(mean_indireta, digits = 2)
)
paste(
    "média operações diretas: ",
    round(mean_direta, digits = 2)
)

## Fontes de recursos.
paste(
    "Tipos diferentes de fontes de recursos para operações indiretas: ",
    length(fonte_recursos_indireta)
)
paste(
    "Tipos diferentes de fontes de recursos para operações indiretas: ",
    length(fonte_recursos_direta)
)
paste(
    "Fontes de recursos indiretas contidas nas operações diretas: ",
    sum(fonte_recursos_indireta %in% fonte_recursos_direta)
)

## Produtos.
paste(
    "Tipos diferentes de produtos para operações indiretas: ",
    length(produto_indireta)
)
paste(
    "Tipos diferentes de produtos para operações diretas: ",
    length(produto_direta)
)
paste(
    "Produtos indiretas contidos nos produtos diretas: ",
    sum(produto_indireta %in% produto_direta)
)

## Instrumentos financeiros.
paste(
    "Tipos diferentes de instrumentos financeiros para operações indiretas: ",
    length(instrumento_fin_indireta)
)
paste(
    "Tipos diferentes de instrumentos financeiros para operações diretas: ",
    length(instrumento_fin_direta)
)
paste(
    "Instrumentos financeiros indiretos contidos nos instrumentos financeiros diretos: ",
    sum(instrumento_fin_indireta %in% instrumento_fin_direta)
)