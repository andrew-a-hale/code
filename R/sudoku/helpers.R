getContext <- function(grid, c) {
  unlist(grid[contextIndexes[[c]]])
}

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

getCandidates <- function(grid, c) {
  if (grid[c] > 0) return(NULL)
  context <- getContext(grid, c)
  
  if (isFALSE(validateContext(grid, context))) return(NULL)
  
  candidates <- sudokuConfig$full_set[sudokuConfig$full_set %notin% context]

  if (identical(length(candidates), 0L)) return(NULL)
  candidates
}

makeGuess <- function(sudoku, c) {
  allCandidates <- getCandidates(sudoku$currentGrid, c)
  if (is.null(allCandidates)) return(sudoku)
  for (candidate in allCandidates) {
    sudoku$currentGrid[c] <- candidate
    if (gridToString(sudoku$currentGrid) %notin% sudoku$failStates) {
      sudoku <- updateChanges(
        sudoku, 
        list(cell = c, value = candidate)
      )
      return(sudoku)
    }
  }
  sudoku$currentGrid[c] <- 0
  
  # in fail state 
  ## add to fail state and restart
  sudoku <- updateFailState(sudoku)
  sudoku <- revertLastChange(sudoku)
  return(sudoku)
}

solveGrid <- function(sudoku) {
  if (0 %notin% sudoku$currentGrid) return(sudoku)
  candidates <- seq_along(sudoku$currentGrid) %>%
    purrr::map(~ getCandidates(sudoku$currentGrid, .x))
  indexToChange <- purrr::detect_index(candidates, ~length(.) == 1)
  error <- purrr::detect(seq_along(sudoku$currentGrid), function(.x) {
    is.null(candidates[[.x]]) && sudoku$currentGrid[.x] == 0
  })
  
  proposedChange <- {
    x <- sudoku$currentGrid
    x[indexToChange] <- candidates[indexToChange]
    x
  }
  if (gridToString(proposedChange) %in% sudoku$failStates) {
    error <- indexToChange
  }
  
  if (!is.null(error)) {
    # in fail state 
    ## add to fail state and restart
    sudoku <- updateFailState(sudoku)
    sudoku <- revertLastChange(sudoku)
    return(sudoku)
  }
  
  if (indexToChange > 0) {
    sudoku$currentGrid[indexToChange] <- candidates[indexToChange]
    sudoku <- updateChanges(
      sudoku, 
      list(cell = indexToChange, value = candidates[[indexToChange]])
    )
  }
  
  if (indexToChange == 0) {
    c <- sample(which(sudoku$currentGrid == 0), 1)
    sudoku <- makeGuess(sudoku, c)
  }
  solveGrid(sudoku)
}

rowFromCell <- function(c) {
  (c - 1) %% sudokuConfig$rows + 1
}

colFromCell <- function(c) {
  (c - 1) %/% sudokuConfig$rows + 1
}

updateFailState <- function(sudoku) {
  sudoku$failStates <- union(
    sudoku$failStates, 
    gridToString(sudoku$currentGrid)
  )
  return(sudoku)
}

updateChanges <- function(sudoku, lastChange) {
  sudoku$changes <- append(sudoku$changes, list(lastChange))
  return(sudoku)
}

revertLastChange <- function(sudoku) {
  # sudoku$changes[-length(sudoku$changes)]
  # c <- sudoku$changes[[length(sudoku$changes)]]$cell
  # sudoku$currentGrid[c] <- 0
  sudoku$currentGrid <- sudoku$initGrid
  return(sudoku)
}
