getCandidates <- function(grid, c, n = NULL) {
  row <- rowFromCell(c, grid)
  col <- colFromCell(c, grid)
  
  rv <- grid[row, ]
  cv <- grid[, col]
  sgv <- getSubGrid(grid, row, col)
  
  if (anyDuplicated(unlist(rv), 0)) return(NULL)
  if (anyDuplicated(unlist(cv), 0)) return(NULL)
  if (anyDuplicated(unlist(sgv), 0)) return(NULL)
   
  found <- unlist(
    list(
      rv, 
      cv, 
      sgv
    ),
    use.names = FALSE
  )
  
  candidates <- FULL_SET[FULL_SET %notin% found]

  if (identical(length(candidates), 0L)) return(NULL)
  if (missing(n)) return(candidates)
  if (n <= length(candidates)) {
    return(candidates[n])
  }
  else if (n > length(candidates)) {
    logger::log_error("out of array")
    return(sample(candidates, 1))
  } else {
    candidates
  }
  
}

getSubGrid <- function(grid, row, col) {
  subGridRows <- floorToClosestN(row, subGridSize) + 1 + 0:(subGridSize - 1)
  subGridCols <- floorToClosestN(col, subGridSize) + 1 + 0:(subGridSize - 1)

  grid[subGridRows, subGridCols]
}

solveGrid <- function(grid) {
  if (0 %notin% grid) return(grid)
  changeFlag <- F
  for (c in which(grid == 0)) {

    cs <- getCandidates(grid, c)

    if (identical(length(cs), 1L)) {
      grid[c] <- cs
      changeFlag <- T
    }
    else if (is.null(cs)) {
      failStates <<- union(failStates, gridToString(grid))
      return(initGrid)
    }
  }
  if (!changeFlag) {
    c <- sample(which(grid == 0), 1)
    guess <- 1
    grid[c] <- getCandidates(grid, c, guess)
    while (gridToString(grid) %in% failStates) {
      guess <- guess + 1
      grid[c] <- getCandidates(grid, c, guess)
    }
  }
  solveGrid(grid)
}

rowFromCell <- function(c, grid) {
  (c - 1) %% rows + 1
}

colFromCell <- function(c, grid) {
  (c - 1) %/% rows + 1
}