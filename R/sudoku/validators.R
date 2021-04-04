validateGrid <- function(grid) {
  map_lgl(
    seq_along(grid), 
    ~ validateContext(grid, getContext(grid, .x))
  ) %>%
    all(grid > 0)
}

validateContext <- function(grid, context) {
  row <- context[seq_len(sudokuConfig$rows)]
  col <- context[seq_len(sudokuConfig$rows) + sudokuConfig$rows]
  subgrid <- context[seq_len(sudokuConfig$rows) + (2 * sudokuConfig$rows)]
  
  !any(
    anyDuplicated(row, 0), 
    anyDuplicated(col, 0), 
    anyDuplicated(subgrid, 0)
  )
}
