box::use(logger[log_threshold, log_tictoc, log_info, log_success, INFO, TRACE])
source("~/code/code-main/R/sudoku/helpers.R")
source("~/code/code-main/R/sudoku/utils.R")
source("~/code/code-main/R/sudoku/input.R")

log_threshold(level = INFO)

initGrid <- currentGrid <- final
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
