## TODO: change random guessing to smart guessing (don't guess the same thing twice)

logger::log_threshold(level = logger::INFO)
rm(list = ls())
source("utils.R")
source("sudoku-helpers.R")
source("sudoku-input.R")

print.sudoku(currentGrid)
cat("----------------\n")

n <- 0
startGrid <- currentGrid
FULL_SET <- 1:nrow(startGrid)
logger::log_tictoc(level = logger::TRACE)
while (0 %in% currentGrid) {
  currentGrid <- solveGrid(currentGrid)
  n <- n + 1
  if (n %% 100 == 0) logger::log_info("iteration {n}")
}
logger::log_success("finished on iteration {n}")
logger::log_tictoc(level = logger::INFO)
print.sudoku(currentGrid)
