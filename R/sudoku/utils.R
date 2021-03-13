printSudoku <- function(grid) {
  purrr::walk(
    seq_len(nrow(grid)),
    function(.x) {
      cat(unlist(grid[.x, ]), "\n")
    }
  )
}

gridToString <- function(grid) {
  paste0(unlist(grid), collapse = "")
}

floorToClosestN <- function(x, n) {
  (((x - 1) %/% n) * n)
}

`%notin%` <- Negate(`%in%`)


