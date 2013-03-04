partition <- function(a, l, r, type){
  ## type 1, use the first element as pivot
  ## type 2, use the last element as pivot
  ## type 3, use the median of the first, last and ``middle'' element as pivot
  if(type==2) {temp <- a[r]; a[r] <- a[l]; a[l] <- temp}
  if(type==3) {
    med <- floor((l+r)/2)
    p1 <- a[l]; p2 <- a[med]; p3 <- a[r];
    p <- median(c(p1, p2, p3))
    if(p==p2) {temp <- a[med]; a[med] <- a[l]; a[l] <- temp}
    if(p==p3) {temp <- a[r]; a[r] <- a[l]; a[l] <- temp}
  }
  p <- a[l];
  i <- l + 1;
  for (j in (l+1):r) {
    if (a[j] < p) {
      temp <- a[j];
      a[j] <- a[i];
      a[i] <- temp;
      i <- i + 1;
    }
  }
  ## swap pivot to its rightful position
  temp <- a[i-1];
  a[i-1] <- a[l];
  a[l] <- temp;
  return(list(a=a, pivot=i-1))
}

m <- 0 # count number of comparisons
QuickSort <- function(a){
  n <- length(a);
  if (n==1) return(a);
  m <<- m + n -1
  alist <- partition(a, l=1, r=n, type=3);
  a <- alist$a; pivot <- alist$pivot;
  if(pivot>1) a[1:(pivot-1)] <- QuickSort(a[1:(pivot-1)]);
  if(pivot<n) a[(pivot+1):n] <- QuickSort(a[(pivot+1):n]);
  return(a)
}

A <- read.table("QuickSort_hw2.txt")[,]
A_sort <- QuickSort(A)
m # number of comparisons
