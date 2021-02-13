## TODO: change random guessing to smart guessing (don't guess the same thing twice)

rm(list = ls())
source("utils.R")
source("sudoku-helpers.R")
source("sudoku-input.R")

print.sudoku(currentGrid)
cat("----------------\n")

n <- 0
startGrid <- currentGrid
FULL_SET <- 1:nrow(startGrid)
SAVED_GUESSES <- list()
LAST_GUESS <- list()
while (0 %in% currentGrid) {
  currentGrid <- solveGrid(currentGrid)
  n <- n + 1
}
print(paste("finished on iteration", n))
print.sudoku(currentGrid)
