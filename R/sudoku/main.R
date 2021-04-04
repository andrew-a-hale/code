library(magrittr)
library(logger)
library(purrr)
source("~/code/R/sudoku/procedures.R")
source("~/code/R/sudoku/utils.R")
source("~/code/R/sudoku/validators.R")
source("~/code/R/sudoku/input.R")

initGrid <- currentGrid <- final

sudokuConfig = list(
  rows = sqrt(length(initGrid)),
  full_set = seq_len(sqrt(length(initGrid))),
  subgridsize = sqrt(sqrt(length(initGrid)))
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
