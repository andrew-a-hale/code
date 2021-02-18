#' @export
print.sudoku <- function(grid) {
  box::use(purrr[walk])
  walk(
    1:nrow(grid),
    function(.x) {
      cat(unlist(grid[.x, ]), "\n")
    }
  )
}

#' @export
floorToClosestN <- function(x, n) {
  (((x - 1) %/% n) * n)
}

#' @export
`%notin%` <- Negate(`%in%`)


