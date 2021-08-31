## joing web scrapping with operacoes-ajustado
library(dplyr)
bndes<-read.csv("bases-ajustadas/operacoes-ajustado.csv",sep = ",",encoding = "UTF-8" )
cnpjs<-unique(bndes$cnpj)
cnpjs<-gsub('[-]','',cnpjs)
cnpjs<-gsub('[./]','',cnpjs)

biz<-read.csv("bases-auxiliares/empresas.csv",header = FALSE)
names(biz)<-c("cliente","processos")

biz$processos<-gsub('processo.*','',biz$processos)
biz$processos<-gsub('[.]','',biz$processos)
bndesf<-left_join(bndes,biz,by="cliente")
write.csv(bndesf,"bases-auxiliares/bndes_processos.csv",row.names=FALSE)
