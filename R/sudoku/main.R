## TODO: change random guessing to smart guessing (don't guess the same thing twice)

options(box.path = "C:/Users/derpi/Documents//code//code-main//R")
box::use(
  hs = sudoku/helpers[getCandidates, getSubGrid, solveGrid],
  input = sudoku/input[final, fiveStar, fourStar, threeStar, twoStar, oneStar],
  us = sudoku/utils[print.sudoku, floorToClosestN],
  log = logger[log_threshold, log_tictoc, log_info, log_success, INFO, TRACE]
)

log_threshold(level = INFO)

startGrid <- fiveStar
currentGrid <- startGrid
print.sudoku(currentGrid)
log_tictoc(level = TRACE)
n <- 0
while (0 %in% currentGrid) {
  currentGrid <- solveGrid(currentGrid, startGrid)
  n <- n + 1
  if (n %% 100 == 0) log_info("iteration {n}")
}
log_success("finished on iteration {n}")
log_tictoc(level = INFO)
print.sudoku(currentGrid)
