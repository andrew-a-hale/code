## reducePipe??
## i want to apply a function n times on the result of the previous
library(magrittr)
library(rlang)

f <- function(x) x + 1
g <- function(x, .in) x^2

## problem 1, apply g n times

1 %>% f %>% g %>% g %>% g %>% g %>% g %>% g %>% g %>% g %>% g %>% g

purrr::reduce(1:10, g, .init = f(1))

## problem 2, arbitrary functional chain

1 %>% f %>% g %>% g %>% g %>% g %>% f %>% g

composeFromCharList <- function(functionList) {
  fn_list <- purrr::map(functionList, ~eval(rlang::parse_expr(.x)))
  purrr::compose(!!!fn_list, .dir = "forward")
}

composeFromCharList(c("f", rep("g", 4), "f", "g"))(2)
