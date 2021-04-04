validateGrid <- function(grid) {
  purrr::map_lgl(
    seq_along(grid), 
    ~ validateContext(grid, getContext(grid, .x))
  ) %>%
    all(grid > 0)
}

validateContext <- function(grid, context) {
  row <- context[1:9]
  col <- context[10:18]
  subgrid <- context[19:27]
  
  !any(
    anyDuplicated(row, 0), 
    anyDuplicated(col, 0), 
    anyDuplicated(subgrid, 0)
  )
}