# this script produces a sarcoma wordmap
library(wordcloud)

# a colorblind safe palette
pal <- c(
  "#88CCEE", # light sky‑blue
  "#6699CC", # soft blue
  "#332288", # dark navy
  "#44AA99", # bluish teal
  "#117733", # mid green
  "#999933", # olive
  "#DDCC77", # sand
  "#661100", # brown
  "#882255", # burgundy
  "#AA4499", # magenta
  "#CC6677", # rose
  "#DDAA33", # golden‑orange   
  "#CCBB44", # khaki‑lime      
  "#669966", # medium sage     
  "#44AA66", # mint            
  "#4477AA", # cornflower      
  "#225588", # denim           
  "#994466", # muted plum      
  "#BB5566", # dusty coral     
  "#777777", # medium gray     
  "#888888")  # neutral gray


db <- read.csv('input/pinieux2021.csv', sep = ';')
db$tot <- rowSums(db[,4:7])
db$tot <- db$tot / sum(db$tot)
db[db[,3] == 'Undifferentiated pleomorphic sarcoma',3] <- 'UPS'
db[db[,3] == 'Gastrointestinal stromal tumors (GIST).',3] <- 'GIST'
db[db[,3] == 'Atypical lipomatous tumour/well-differentiated liposarcoma',3] <- 'ALT/WDLPS'
db[db[,3] == 'Myxoid Round Cell LPS',3] <- 'MLPS'
db[db[,3] == 'Extraskeletal myxoid chondrosarcoma',3] <- 'EMCS'
db[db[,3] == 'Dermatofibrosarcoma Protuberans',3] <- 'DFSP'
db[db[,3] == 'Epithelioid haemangioendothelioma',3] <- 'EHE'
db[db[,3] == 'Kaposi sarcoma',3] <- 'Kaposi'
db[db[,3] == 'Liposarcoma-dedifferentiated',3] <- 'DDLPS'
db[db[,3] == 'Leiomyosarcoma',3] <- 'LMS'
db[db[,3] == 'Solitary fibrous tumour',3] <- 'SFT'
db$col <- pal[as.integer(as.factor(db[,2]))]


png('output/wordcloud.png', width = 3000, height = 3000, res = 600)
with(db, {
  wordcloud(word = histotype, 
            freq = sqrt(tot), 
            scale = c(3, 0.1),
            colors = col,
            ordered.colors = TRUE)
  })
dev.off()
