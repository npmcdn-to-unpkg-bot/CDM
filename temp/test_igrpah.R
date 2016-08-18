### test igraph###

data <- read.csv('C:/Users/QIN_XUZ/Downloads/FlightRadar24 2016-08-17 09_53_43.csv',stringsAsFactors = FALSE)
# data <- data[sample(nrow(data)/10),]

data <- data.table(ORG = data$ORG, DST = data$DST)
freq <- data[, .N ,by = list(ORG, DST)]

# df <- unique(data.frame(ORG = data$ORG, DST = data$DST, stringsAsFactors = FALSE))

edges <- NULL
weight <- freq$N
for (i in 1:nrow(freq)){
  OD <- c(freq[i]$ORG, freq[i]$DST)
  edges <- c(edges,OD)
}


g3 <- graph( edges)

E(g3)$weight <- weight
E(g3)$width <- E(g3)$weight/mean(E(g3)$weight)


vertex_name <- V(g3)$name
vertex_list <- data.table(c(data$ORG, data$DST))
vertex_freq <- data.frame(vertex_list[, .N ,by = V1])
row.names(vertex_freq) <- vertex_freq$V1
vertex_size <- vertex_freq[vertex_name,]$N
# V(g3)$size <- log( (vertex_size - min(vertex_size)) / ((max(vertex_size)-min(vertex_size))*100 +1 ) + 1.1)*3
# 
# size <- log((vertex_size - min(vertex_size))/(max(vertex_size)-min(vertex_size))*100+1)*3

size2 <- log((vertex_size - min(vertex_size))/(max(vertex_size)-min(vertex_size))*100+1)*3

if(all(is.na(size2))){
  V(g3)$size = rep(10, length(vertex_size))
} else {
  V(g3)$size = size2
}


l <- layout_with_fr(g3)
# l <- layout_in_circle(g3)
plot(g3, edge.arrow.size=.2, vertex.color="gold", 
     
     vertex.frame.color="gray", vertex.label.color="black", 
     
     vertex.label.cex=0.8, vertex.label.dist=0, edge.curved=0.2,
     layout=l) 

