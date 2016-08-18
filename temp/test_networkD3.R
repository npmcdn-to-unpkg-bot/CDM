#### test networkD3
apt <- get.airport.loc()
library(networkD3)
data(MisLinks)
data(MisNodes)
class(MisLinks)
# Plot
forceNetwork(Links = MisLinks, Nodes = MisNodes,
             Source = "source", Target = "target",
             Value = "value", NodeID = "name",
             Group = "group", opacity = 0.8)


airport <- data.table(label = c(data$ORG, data$DST))
freq <- airport[, .N ,by = label]
nodes <- data.frame(name = freq$label, size = freq$N,
                    group = 1
                   )

match <- data.table(as.numeric(rownames(nodes))-1, nodes$name)

routes <- data.table(ORG = data$ORG, DST = data$DST)
freq_routes <- routes[, .N ,by = list(ORG, DST)]

freq_routes <- merge(freq_routes, match, by.x="ORG", by.y="V2", all.x=TRUE, all.y=FALSE)
freq_routes <- merge(freq_routes, match, by.x="DST", by.y="V2", all.x=TRUE, all.y=FALSE)
links <- data.frame(freq_routes)

links$dist <- rnorm(nrow(links), mean = 10)^2

links$V1.x <- as.numeric(links$V1.x)
links$V1.y <- as.numeric(links$V1.y)
class(links$V1.y)
# Plot

simp <- data.frame(links$ORG, links$DST)
simpleNetwork(simp)


forceNetwork(Links = links, Nodes = nodes,
             Source = "V1.x", Target = "V1.y", Nodesize = 'size',
             Value = "N", NodeID = "name", 
             Group = "group", opacity = 0.8, linkDistance = links$dist, zoom=TRUE)


# Load igraph
library(igraph)

# Use igraph to make the graph and find membership
karate <- make_graph("Zachary")
wc <- cluster_walktrap(g3)
members <- membership(wc)

# Convert to object suitable for networkD3
g3_d3 <- igraph_to_networkD3(g3, group = members)

# Create force directed network plot
forceNetwork(Links = g3_d3$links, Nodes = g3_d3$nodes, 
             Source = 'source', Target = 'target', 
             NodeID = 'name', Group = 'group',zoom = TRUE,linkDistance = 100)

