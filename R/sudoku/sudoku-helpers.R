getCandidates <- function(grid, cell) {
  row <- (cell - 1) %% 9 + 1
  col <- (cell - 1) %/% 9 + 1

  candidates <- Reduce(
    setdiff,
    list(
      unlist(grid[row, ]),
      unlist(grid[, col]),
      unlist(getSubGrid(grid, row, col))
    ),
    init = FULL_SET
  )

  if (identical(length(candidates), 0L)) return(NULL)
  candidates
}

getSubGrid <- function(grid, row, col) {
  rows <- nrow(grid)
  subGridSize <- sqrt(rows)

  subGridRows <- floorToClosestN(row, subGridSize) + 1 + 0:(subGridSize - 1)
  subGridCols <- floorToClosestN(col, subGridSize) + 1 + 0:(subGridSize - 1)

  grid[subGridRows, subGridCols]
}

solveGrid <- function(grid) {
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
