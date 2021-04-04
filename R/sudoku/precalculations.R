colIndexes <- lapply(seq_len(sudokuConfig$rows), function(col, rows = NULL) {
  start <- (col - 1) * sudokuConfig$rows + 1
  indexes <- seq(start, start + sudokuConfig$rows - 1, 1)
  if (!missing(rows)) {
    indexes[rows]
  } else {
    indexes
  }
})

rowIndexes <- lapply(seq_len(sudokuConfig$rows), function(row, cols = NULL) {
  start <- row
  indexes <- seq(start, sudokuConfig$rows^2, sudokuConfig$rows)
  if (!missing(cols)) {
    indexes[cols]
  } else {
    indexes
  }
})

subgridIndexes <- lapply(seq_along(sudoku$initGrid), function(c) {
  row <- rowFromCell(c)
  col <- colFromCell(c)
  
  rowStart <- floorToClosestN(row, sudokuConfig$subgridsize)
  subGridRows <- seq.int(rowStart, rowStart + sudokuConfig$subgridsize - 1, 1)
  
  colStart <- floorToClosestN(col, sudokuConfig$subgridsize)
  subGridCols <- seq.int(colStart, colStart + sudokuConfig$subgridsize - 1, 1)
  
  unlist(purrr::map(rowIndexes[subGridRows], ~ `[`(.x, subGridCols)))
})

contextIndexes <- lapply(seq_along(sudoku$initGrid), function(c) {
  unlist(
    list(
      rowIndexes[rowFromCell(c)],
      colIndexes[colFromCell(c)],
      subgridIndexes[c]
    )
  )
})
