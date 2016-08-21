### test igraph###
# install.packages('visNetwork')
install.packages('sna')
library(sna)
library(visNetwork)

data <- fread('C:/Users/QIN_XUZ/Downloads/FlightRadar24 2016-08-19 10_17_13.csv')
# data <- data[sample(nrow(data)/100),]


apt_loc <- data.table(get.airport.loc(detail = TRUE))
apt_region <- apt_loc[,c('IATA','name','region_name'), with = FALSE]


airport <- data.table(label = c(data$ORG, data$DST))

freq <- airport[, .N ,by = label]
freq <- merge(freq, apt_region, by.x = 'label', by.y = 'IATA', all.x=TRUE, all.y=FALSE)

nodes <- data.frame(id = row.names(freq), label = freq$label, value = freq$N, group = freq$region_name,
                    
                    title = paste0("<p><b>Airport: ", freq$name ,"</b><br>Frequency: ", freq$N,"</p>"))

match <- data.table(nodes$id, nodes$label)

routes <- data.table(ORG = data$ORG, DST = data$DST)
freq_routes <- routes[, .N ,by = list(ORG, DST)]

freq_routes <- merge(freq_routes, match, by.x="ORG", by.y="V2", all.x=TRUE, all.y=FALSE)
freq_routes <- merge(freq_routes, match, by.x="DST", by.y="V2", all.x=TRUE, all.y=FALSE)

edges <- data.frame(from = freq_routes$V1.x, to = freq_routes$V1.y )

# df <- unique(data.frame(ORG = data$ORG, DST = data$DST, stringsAsFactors = FALSE))

visNetwork(nodes, edges)%>%
  visIgraphLayout() %>%
  visPhysics(stabilization = FALSE)%>%
  visEdges(smooth = FALSE, arrows = list(to = list(enabled = TRUE, scaleFactor = 0.3)))%>%
  visOptions(highlightNearest = TRUE, 
             selectedBy = "group",
             manipulation = TRUE) %>%
  visLegend(width = 0.1, position = "right")%>%
  visNodes(font = list(size=20), scaling = list(min = 20, max = 80))




nrow(edges)


visNetwork(nodes, edges)%>%
  # visIgraphLayout() %>%
  # visPhysics(stabilization = TRUE)%>%
  visEdges(arrows = list(to = list(enabled = TRUE, scaleFactor = 0.5)), smooth = TRUE)%>%
  visOptions(highlightNearest = TRUE, 
             selectedBy = "group",
             manipulation = TRUE) %>%
  visLegend(width = 0.1, position = "right")%>%
  visNodes(font = list(size=30))


nnodes <- 100
nnedges <- 200

nodes <- data.frame(id = 1:nnodes)
edges <- data.frame(from = sample(1:nnodes, nnedges, replace = T),
                    to = sample(1:nnodes, nnedges, replace = T))

visIgraph(g3)

# with defaut layout
visNetwork(nodes, edges, height = "500px") %>%
  visIgraphLayout() %>%
  visNodes(size = 10)




data
routes

routes[(ORG == 'XIY' & DST == 'PEK')]

mtx <- get.adjacency(graph_from_edgelist(as.matrix(routes), directed = TRUE))
dt_trx <- as.matrix(mtx)


net= graph.adjacency(mtx,mode="directed",diag=FALSE)

centr_degree(net)$centralization


E(net)$weight

data.table(name = names(closeness(net)),closeness(net))
data.table(name = names(betweenness(net)),betweenness(net))

betweenness(net)


diameter(net)
get.shortest.paths(net)
dt <- distances(net, mode = 'out', algorithm = 'dijkstra')

distance_table(net, directed = TRUE)

shortest_paths(net, 'CNX')

g <- make_ring(10)



distances(g)
shortest_paths(g, 5)
all_shortest_paths(g, 1, 6:8)
mean_distance(g)
