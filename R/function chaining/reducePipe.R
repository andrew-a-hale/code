## reducePipe??
## i want to apply a function n times on the result of the previous
library(magrittr)
library(rlang)

f <- function(x) x + 1
g <- function(x, ...) x^2 ## ... is a hack to make this function work for purrr::reduce
n <- 10

## problem 1, apply g n times

1 %>% f %>% g %>% g %>% g %>% g %>% g %>% g %>% g %>% g %>% g %>% g

purrr::reduce(1:n, g, .init = f(1))

## problem 2, arbitrary function chain

fChain <- . %>% f %>% g %>% g %>% g %>% g %>% f %>% g

## a functional that returns a "composed" function
composeFromCharList <- function(functionList) {
  fn_list <- purrr::map(functionList, get)
  purrr::compose(!!!fn_list, .dir = "forward")
}

## this composed function will be identical to the chain above
fCompose <- composeFromCharList(c("f", rep("g", 4), "f", "g"))

a <- fChain(1)
b <- fCompose(1)

identical(a, b)
