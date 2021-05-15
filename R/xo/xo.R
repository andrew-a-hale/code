library(tidyverse)

mod <- function(x, y) {
  return(x %% y == 0)
}

second <- c(2, 4, 6, 8)
first <- c(1, 3, 5, 7, 9)
primes <- c(2, 3, 5, 7, 11, 13, 17, 19, 23)

winning_seqs <- list(
  c(1, 2, 3),
  c(4, 5, 6),
  c(7, 8, 9),
  c(1, 4, 7),
  c(2, 5, 8),
  c(3, 6, 9),
  c(1, 5, 9),
  c(3, 5, 7)
)

winning_prod <- winning_seqs %>% unlist()
winning_prod <- primes[winning_prod] %>%
  matrix(nrow = 8, ncol = 3, byrow = TRUE)
winning_prod <- apply(winning_prod, 1, prod)

x <- gtools::permutations(9, 9, repeats.allowed = FALSE)

## 5th turn
fifth <- primes[x[, first[1:3]]] %>%
  matrix(ncol = 3) %>%
  apply(1, prod) %>%
  sapply(mod, winning_prod) %>%
  colSums()

fifth_turn_wins <- nrow(x[fifth > 0, ]) / factorial(4)

## 6th turn
sixth <- primes[x[, second[1:3]]] %>%
  matrix(ncol = 3) %>%
  apply(1, prod) %>%
  sapply(mod, winning_prod) %>%
  colSums()

sixth_turn_wins <- nrow(x[sixth > 0 & fifth == 0, ]) / factorial(3)

## 7th turn
seventh <- primes[x[, first[1:4]]] %>%
  matrix(ncol = 4) %>%
  apply(1, prod) %>%
  sapply(mod, winning_prod) %>%
  colSums()

seventh_turn_wins <-
  nrow(x[seventh > 0 & sixth == 0 & fifth == 0, ]) / factorial(2)

## 8th turn
eigth <- primes[x[, second[1:4]]] %>%
  matrix(ncol = 4) %>%
  apply(1, prod) %>%
  sapply(mod, winning_prod) %>%
  colSums()

eigth_turn_wins <- nrow(x[eigth > 0 & seventh == 0 & sixth == 0 & fifth == 0, ])

## 9th turn
ninth <- primes[x[, first[1:5]]] %>%
  matrix(ncol = 5) %>%
  apply(1, prod) %>%
  sapply(mod, winning_prod) %>%
  colSums()

ninth_turn_wins <-
  nrow(x[ninth > 0 & eigth == 0 & seventh == 0 & sixth == 0 & fifth == 0, ])

total_wins <- nrow(x[ninth > 0, ])
total_draws <- nrow(x[ninth == 0, ])

draws <-
  nrow(x[ninth == 0 & eigth == 0 & seventh == 0 & sixth == 0 & fifth == 0, ])
