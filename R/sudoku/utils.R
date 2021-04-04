printSudoku <- function(grid) {
  walk(
    seq_len(sudokuConfig$rows),
    function(.x) {
      cat(unlist(grid[rowIndexes[[.x]]]), "\n")
    }
  )
}

gridToString <- function(grid) {
  paste0(unlist(grid), collapse = "")
}

floorToClosestN <- function(x, n) {
  (((x - 1) %/% n) * n) + 1
}

`%notin%` <- Negate(`%in%`)

getContext <- function(grid, c) {
  unlist(grid[contextIndexes[[c]]])
}

rowFromCell <- function(c) {
  (c - 1) %% sudokuConfig$rows + 1
}

colFromCell <- function(c) {
  (c - 1) %/% sudokuConfig$rows + 1
}
