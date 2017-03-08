rm(list = ls())
gc()
require(data.table)
require(leaflet)

load("in.rdata")

suppraccent <- function(text) {
  text <- gsub("['`^~\"]", " ", text)
  text <- iconv(text, to="ASCII//TRANSLIT//IGNORE")
  text <- gsub("['`^~\"]", "", text)
  return(text)
}

suppmotscourants <-  function(text) {
  a<-unlist(strsplit(text," "))
  asuppr <- c("LE","LA","L","DU","DE","D","EN","")
  if(sum(a %in% asuppr)==0){return(paste(a,collapse = " "))}
  paste(a[-which(a %in% asuppr)],collapse=" ")
}

