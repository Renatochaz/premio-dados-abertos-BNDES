## joing web scrapping with operacoes-ajustado
library(dplyr)
bndes<-read.csv("/Users/rondon/Downloads/operacoes-ajustado.csv",sep = ",",encoding = "UTF-8" )
cnpjs<-unique(bndes$cnpj)
cnpjs<-gsub('[-]','',cnpjs)
cnpjs<-gsub('[./]','',cnpjs)

biz<-read.csv("/Users/rondon/Downloads/empresas_processos.xlsx - empresas_processos.csv",header = FALSE)
names(biz)<-c("cliente","processos")
write.csv(biz,"/Users/rondon/Downloads/enterprises.csv",row.names=FALSE)

biz$processos<-gsub('processo.*','',biz$processos)
biz$processos<-gsub('[.]','',biz$processos)
bndesf<-left_join(bndes,biz,by="cliente")
write.csv(bndesf,"/Users/rondon/Downloads/bndes_processos2.csv",row.names=FALSE)