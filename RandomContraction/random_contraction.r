#### Read Graph
## a <- read.table("kargerMinCut.txt")
a <- readLines("test.txt")
graph <- list()
for(edge in a) {
  ##  edge1 <- strsplit(edge, split='\t')[[1]]
  ## graph <- c(graph, list(as.numeric(edge1[-1])))
  graph <- c(graph, list(as.numeric(strsplit(edge, split=' ')[[1]])))
}
names(graph) <- 1:20


count_edges <- function(graph) {
  n <- 0
  for (vertex in graph) {
    n <- n + length(vertex) -1
  }
  n
}
####

#### sample a random edge
random_sample_edge <- function(graph) {
  v1 <- NULL; v2 <- NULL
  for(vertex in graph) {
    v1 <- c(v1, rep(vertex[1], length(vertex)-1))
    v2 <- c(v2, vertex[-1])
  }
  s <- sample(length(v2), 1)
  v1_s <- v1[s]; v2_s <- v2[s]
  v1 <- min(v1_s, v2_s)
  v2 <- max(v1_s, v2_s)
  return(c(v1, v2))
}
####

#### contract the graph according
#### to the randomly selected edge
contraction <- function(g, edge){
  v1 <- edge[1]; v2 <- edge[2]
  v1_ind <- which(names(g)==v1)
  v2_ind <- which(names(g)==v2)
  g[[v1_ind]] <- c(g[[v1_ind]], g[[v2_ind]][-1])
  g <- g[-v2_ind] ## get rid of vertex v2
  
  for(i in 1:length(g)){
    g[[i]] <- ifelse(g[[i]]==v2, v1, g[[i]])
  }
  edges <- g[[v1_ind]][-1]
  g[[v1_ind]] <- c(v1, edges[edges!=v1])
  return(g)
}
####
####

#### MinCut
MinCut <- function(g){
  while(length(g)>2) {
    edge <- random_sample_edge(g)
    g <- contraction(g, edge)
  }
  return(length(g[[1]])-1)
}
####

#### boosted MinCut
MinCut_boosted <- function(g, N){
  cut_holder <- rep(NULL, N)
  for (i in 1:N) {
    cut_holder[i] <- MinCut(graph)
    print(i)
  }
  return(min(cut_holder))
}
#### 
