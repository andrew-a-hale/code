print.sudoku <- function(grid) {
  purrr::walk(
    1:nrow(grid),
    function(.x) {
      cat(unlist(grid[.x, ]), "\n")
    }
  )
}

floorToClosestN <- function(x, n) {
  (((x - 1) %/% n) * n)
}


