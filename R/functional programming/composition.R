## reducePipe??
## i want to apply a function n times on the result of the previous
library(magrittr)
library(rlang)

f <- function(x) x + 1
g <- function(x, ...) x^2
n <- 5

## problem 1, apply g n times

1 %>% f %>% g %>% g %>% g %>% g %>% g

purrr::reduce(1:n, g, .init = f(1))

## problem 2, arbitrary function chain

fChain <- . %>% f %>% g %>% g %>% g %>% g %>% f %>% g

## a functional that returns a "composed" function
composeFromCharList <- function(functionList) {
  # create a list of functions from the list of function names
  fl <- purrr::map(functionList, get)
  purrr::compose(!!!fl, .dir = "forward")
}

a <- fChain(1)
b <- composeFromCharList(c("f", rep("g", 4), "f", "g"))(1)

identical(a, b)

## partial application
h <- function(a, b) {
  a + b
}

h_a4 <- . %>% h(a = 4)
identical(h_a4(5), 9)

h_a2 <- purrr::partial(h, a = 2)
identical(h_a2(4), 6)

h_complete <- purrr::partial(h, a = 1, b = 2)
identical(h_complete(), 3)
