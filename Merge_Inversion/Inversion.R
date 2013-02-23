merge_two <-
    function(sorted.d1, sorted.d2){
        n1 <- length(sorted.d1)
        n2 <- length(sorted.d2)
        n <- n1 + n2
        sorted.d <- rep(NA, n)
        i <- 1; j <- 1;
        k <- 1
        while(k <= n) {
            if(i>n1) {
                sorted.d[k:n] <- sorted.d2[j:n2]
                k <- n
            }
            else {
                if(j>n2) {
                    sorted.d[k:n] <-sorted.d1[i:n1]
                    k <- n
                }
                else {
                    if(sorted.d1[i] < sorted.d2[j]) {
                        sorted.d[k] <- sorted.d1[i]; i <- i + 1;
                    }
                    else {
                        sorted.d[k] <- sorted.d2[j]; j <- j + 1;
                    }
                }
            }
            k <- k + 1;
        }
        return(sorted.d)
    }


merge_sort<- function(d){
    n <- length(d)
    if(n>1) {
        breakpoint <- floor(n/2)
        d1 <- d[1:breakpoint]
        d2 <- d[(breakpoint+1):n]
        sorted.d1 <- merge_sort(d1)
        sorted.d2 <- merge_sort(d2)
        return(merge_two(sorted.d1, sorted.d2))
    }
    else
        return(d)
}

count_inv_split <-
    function(sorted.d1, sorted.d2){
        n1 <- length(sorted.d1); n2 <- length(sorted.d2)
        n <- n1 + n2
        sorted.d <- rep(NA, n)
        count <- 0
        i <- 1; j <- 1;
        k <- 1
        while(k <= n) {
            if(i>n1) {
                sorted.d[k:n] <- sorted.d2[j:n2]
                k <- n
            }
            else {
                if(j>n2) {
                    sorted.d[k:n] <-sorted.d1[i:n1]
                    k <- n
                }
                else {
                    if(sorted.d1[i] < sorted.d2[j]) {
                        sorted.d[k] <- sorted.d1[i]; i <- i + 1;
                    }
                    else {
                        sorted.d[k] <- sorted.d2[j]; j <- j + 1;
                        count <- count + n1 - i+1
                    }
                }
            }
            k <- k + 1;
        }
        return(list(sorted=sorted.d, count=count))
}

count_inversion <-
    function(d){
        n <- length(d)
        if(n>1) {
            breakpoint <- floor(n/2)
            d1 <- d[1:breakpoint]
            d2 <- d[(breakpoint+1):n]
            temp <- count_inversion(d1)
            sorted.d1 <- temp$sorted
            count.1 <- temp$count
            temp <- count_inversion(d2)
            sorted.d2 <- temp$sorted
            count.2 <- temp$count
            temp <- count_inv_split(sorted.d1, sorted.d2)
            sorted.d <- temp$sorted
            count.3 <- temp$count
            count <- count.1 + count.2 + count.3
            return(list(sorted=sorted.d, count=count))
        }
        else
            return(list(sorted=d, count=0))
    }




range.minmax <- function(..., na.rm = FALSE) {
    parts <- list(...)
    lapply(parts, function(d) c(attr(d, "min"), attr(d, "max")))
  ## if (length(parts) == 1) {
  ##   attr(parts[[1]], "max")
  ## } else {
  ##   stop("Maximum of more than one minmax not",
  ##     "implemented")
  ## }
}

col_means <- function(df) {
  stopifnot(is.data.frame(df))
  numeric <- vapply(df, is.numeric, logical(1))
  numeric_cols <- df[, numeric, drop=FALSE]

  data.frame(lapply(numeric_cols, mean))
}

d <- read.table("IntegerArray.txt")
count <- count_inversion(d)
