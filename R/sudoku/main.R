box::use(logger[log_threshold, log_tictoc, log_info, log_success, INFO, TRACE])
source("~/code/R/sudoku/helpers.R")
source("~/code/R/sudoku/utils.R")
source("~/code/R/sudoku/input.R")

log_threshold(level = INFO)

initGrid <- currentGrid <- fiveStar
failStates <- list()

rows <- nrow(initGrid)
FULL_SET <- seq_len(rows)
subGridSize <- sqrt(rows)

log_tictoc(level = TRACE)

while (0 %in% currentGrid) {
  currentGrid <- solveGrid(initGrid)
}
log_success()
log_tictoc(level = INFO)
printSudoku(currentGrid)
