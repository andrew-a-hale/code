pascal <- function(n) {
  x <- list(c(1L))
  for (i in 2:n)
    x[[i]] = bitwXor(c(0L, x[[i-1]]), c(x[[i-1]], 0L))
  x
}

pascal(128)
