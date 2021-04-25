## without rle
f <- function(s) {
  ls <- strsplit(s, "")[[1]]
  r <- list()
  j <- 1
  for (i in seq_along(ls)) {
    if (identical(i, 1L)) {
      r[[j]] <- list(ls[i], 1)
    }
    else if (ls[i] != ls[i - 1]) {
      j <- j + 1
      r[[j]] <- list(ls[i], 1)
    }
    else {
      r[[j]][[2]] <- r[[j]][[2]] + 1
    }
  }
  r
}

## with rle
g <- function(s) {
  r <- rle(strsplit(s, "")[[1]])
  r
}

jsonlite::toJSON(f("aaaabbbcca"), auto_unbox = T)
g("aaaabbbcca")[[1]]

## benchmarking
system.time(f(strrep("aaaabbbcca", 100000)))
system.time(g(strrep("aaaabbbcca", 100000)))
