box::use(sudoku/utils[floorToClosestN, `%notin%`])

#' @export
getCandidates <- function(grid, cell) {
  rows <- nrow(grid)
  FULL_SET <- 1:rows
  row <- (cell - 1) %% rows + 1
  col <- (cell - 1) %/% rows + 1
  
  candidates <- setdiff(FULL_SET, unlist(list(grid[row, ], grid[, col], getSubGrid(grid, row, col))))

  if (identical(length(candidates), 0L)) return(NULL)
  candidates
}

#' @export
getSubGrid <- function(grid, row, col) {
  rows <- nrow(grid)
  subGridSize <- sqrt(rows)

  subGridRows <- floorToClosestN(row, subGridSize) + 1 + 0:(subGridSize - 1)
  subGridCols <- floorToClosestN(col, subGridSize) + 1 + 0:(subGridSize - 1)

  grid[subGridRows, subGridCols]
}

#' @export
solveGrid <- function(grid, startGrid) {
  tmpGrid <- grid
  for (c in which(grid == 0)) {

    cs <- getCandidates(grid, c)

    if (identical(length(cs), 1L)) {
      grid[c] <- cs
    }
    else if (is.null(cs)) {
      return(startGrid)
    }
  }
  if (identical(grid, tmpGrid)) {
    c <- which(grid == 0)[1]
    grid[c] <- sample(getCandidates(grid, c), 1)
  }
  grid
}
