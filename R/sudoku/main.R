box::use(
  logger[log_threshold, log_tictoc, log_info, log_success, INFO, TRACE], 
  magrittr[`%>%`]
)
source("~/code/R/sudoku/procedures.R")
source("~/code/R/sudoku/utils.R")
source("~/code/R/sudoku/validators.R")
source("~/code/R/sudoku/input.R")

initGrid <- currentGrid <- fiveStar

sudokuConfig = list(
  rows = nrow(initGrid),
  full_set = seq_len(nrow(initGrid)),
  subgridsize = sqrt(nrow(initGrid))
)

sudoku <- list(
  initGrid = initGrid,
  currentGrid = currentGrid,
  failStates = list(),
  changes = list()
)

log_tictoc(level = TRACE)
source("~/code/R/sudoku/precalculations.R")
while (isFALSE(validateGrid(sudoku$currentGrid))) {
  sudoku <- solveGrid(sudoku)
}
log_success()
log_tictoc(level = INFO)
printSudoku(sudoku$currentGrid)
