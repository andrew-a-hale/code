go <- function(n) {
  if (n <= 2) {
    return(2)
  }
  primes <- c()
  nums <- seq.int(2, n)
  N <- as.integer(ceiling(sqrt(n)))
  for (i in 2L:N) {
    nums <- nums[!(nums %% i == 0L)]
  }
  return(c(primes, nums, go(N)))
}

system.time(go(10L))
system.time(go(100L))
system.time(go(1000L))
system.time(go(10000L))
system.time(go(100000L))
system.time(go(1000000L))
