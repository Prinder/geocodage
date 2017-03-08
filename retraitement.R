require(data.table)
load("adresses.rdata")

pos_tiret <- regexpr("-",adresses$V1)
vi_vo <- substr(adresses$V1,1,pos_tiret-1)
vi_vo_un <- unique(vi_vo)

voie_unique <- data.frame(code=vi_vo_un)
voie_unique$voie <- toupper(adresses$V3[match(vi_vo_un,vi_vo)])
voie_unique$ville <- toupper(adresses$V5[match(vi_vo_un,vi_vo)])

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

voie_unique$voie[997:1000]

voie_unique$voie <- suppraccent(voie_unique$voie)
voie_unique$voie <- unlist(lapply(voie_unique$voie,suppmotscourants))

voie_unique$ville <- suppraccent(voie_unique$ville)
voie_unique$ville <- unlist(lapply(voie_unique$ville,suppmotscourants))

adresses_lgt <- adresses[,c("V1","V2","V7","V8")]

save(voie_unique,adresses_lgt,vi_vo,file="in.rdata")

length(unique(voie_unique$ville))
b51 <- read.csv("bano-51.csv")
