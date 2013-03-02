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

## Depth-First Search via recursion
DFS <- function(g, s){
  explored[as.character(s)] <<- 1
  W <- subset(g, V1==s)$V2
  for (w in W) {
    if (explored[as.character(w)]==0) {
      DFS(g, w)
    }
  }
}
verteces <- unique(c(test$V1, test$V2))
explored <- rep(0, length(verteces))
names(explored) <- verteces
DFS(test, 5)

DFS_container <- function(g, s){
  verteces <- unique(test1$V1)
  explored <- rep(0, length(verteces))
  names(explored) <- verteces
  DFS(g, s)
  return(explored)
}

## Strongly Connected Component based on DFS_recursion
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

## test <- read.table("test1.txt")
## test <- read.table("test2.txt")
## test <- read.table("test3.txt")
## test <- read.table("SCC.txt")


## implement DFS via stack
DFS_stack <- function(g, s){
  verteces <- sort( unique(c(g$V1, g$V2)))
  explored <- rep(0, length(verteces))
##   names(explored) <- verteces
  Q <- list(s)
  while(length(Q) > 0){
    v <- Q[[length(Q)]]
    Q <- Q[-length(Q)]
    if(explored[v]==0) {
      explored[v] <- 1
      W <- unique(subset(g, V1==v)$V2)
      for (w in W) {
        if (explored[w]==0) {
          Q <- c(Q, w)
        }
      }
    } 
  }
  return(explored)
}

## Strongly Connected Component based on DFS_stack
## below it is assumed that the nodes are indexed
## by 1:n
DFS_stack_1st <- function(g, i){
  Q <- list(i)
  while(length(Q) > 0){
    v <- Q[[length(Q)]]
    Q <- Q[-length(Q)]
    if(!explored[v]) {
      explored[v] <<- 1      
      t <<- t + 1
      finish_time[v] <<- t
      W <- unique(subset(g, V1==v)$V2)
      for (w in W) {
        if (!explored[w]) {
          Q <- c(Q, w);
          flag <- 1;
        }
      }
    } 
  }
}

DFS_stack_2nd <- function(g, i){
  Q <- list(i)
  while(length(Q) > 0){
    v <- Q[[length(Q)]]
    Q <- Q[-length(Q)]
    if(!leaders[v]) {
      leaders[v] <<- s
      W <- unique(subset(g, V1==v)$V2)
      for (w in W) {
        if (!leaders[w]) 
          Q <- c(Q, w)        
      }      
    } 
  }
}


reversed <- function(g){ return(data.frame(V1=g$V2, V2=g$V1)) }

verteces <- unique(sort(c(test$V1, test$V2)))
finish_time <- rep(0, length(verteces))
explored <- rep(0, length(verteces))
t <- 0;
for (i in rev(verteces)) {
  if(!explored[i]) {
    ## s <- i;
    DFS_stack_1st(reversed(test), i)
  }
}

leaders <- rep(0, length(verteces))
s <- NULL
for (i in order(finish_time, decreasing = T)) {
  if(!leaders[i]) {
    s <- i
    DFS_stack_2nd(test, i)
  }
}
head(sort(table(leaders), decreasing = T))
