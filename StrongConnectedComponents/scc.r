## Breadth-First Search
BFS <- function(g, s){
  verteces <- unique(g$V1)
  explored <- rep(0, length(verteces))
  names(explored) <- verteces
  explored[as.character(s)] <- 1
  Q <- list(s)
  while(length(Q) > 0) {
    v <- Q[[1]]
    Q <- Q[-1]
    W <- subset(g, V1==v)$V2
    for (w in W) {
      if (explored[as.character(w)]==0) {
        explored[as.character(w)] <- 1
        Q <- c(Q, w)
      }
    }
  }
  return(explored)
}

## Connecdted-Component for Undirected Graph

## Depth-First Search
## because of recursion, we need to keep a global variable explored
verteces <- unique(test1$V1)
  explored <- rep(0, length(verteces))
  names(explored) <- verteces
DFS <- function(g, s){
  explored[as.character(s)] <<- 1
  W <- subset(g, V1==s)$V2
  for (w in W) {
    if (explored[as.character(w)]==0) {
      DFS(g, w)
    }
  }
}
DFS(test1, 4)

DFS_container <- function(g, s){
  verteces <- unique(test1$V1)
  explored <- rep(0, length(verteces))
  names(explored) <- verteces
  DFS(g, s)
  return(explored)
}

## Strongly Connected Component based on DFS
## below it is assumed that the nodes are indexed
## by 1:n
DFS_1st <- function(g, i){
  explored[i] <<- 1
  W <- subset(g, V1==i)$V2
  for (w in W) {
    if (is.na(explored[w])) DFS_1st(g, w)
  }
  t <<- t + 1
  finish_time[i] <<- t
}

DFS_2nd <- function(g, i){
  leaders[i] <<- s
  W <- subset(g, V1==i)$V2
  for (w in W) {
    if (is.na(leaders[w])) DFS_2nd(g, w)
  }
}

reversed <- function(g){ return(data.frame(V1=g$V2, V2=g$V1)) }

verteces <- unique(c(test$V1, test$V2))
finish_time <- rep(NA, length(verteces))
explored <- rep(NA, length(verteces))
t <- 0;
for (i in rev(verteces)) {
  if(is.na(explored[i])) {
    ## s <- i;
    DFS_1st(reversed(test), i)
  }
}
leaders <- rep(NA, length(verteces))
s <- NULL
for (i in order(finish_time, decreasing = T)) {
  if(is.na(leaders[i])) {
    s <- i
    DFS_2nd(test, i)
  }
}
table(leaders)

## test1 <- read.table("test1.txt")
## test2 <- read.table("test2.txt")
## test3 <- read.table("test3.txt")
## test <- read.table("SCC.txt")
