logger::log_threshold(logger::TRACE)
logger::log_appender(logger::appender_stdout)
IGNORE <- structure(1000L, level = "IGNORE", class = c("loglevel", "integer"))

f <- function(s) {
  logger::log_tictoc(level = IGNORE)
  logger::log_info("process initialising...")
  ls <- strsplit(s, "")[[1]]
  r <- list()
  j <- 1
  logger::log_info("process start!")
  for (i in seq_along(ls)) {
    if (identical(i %% (length(ls) %/% 10), 0)) logger::log_trace("iteration {i} of {length(ls)}")
    if (identical(i, 1L)) {
      r[[j]] <- list(ls[i], 1)
    }
    else if (ls[i] != ls[i-1]) {
      j <- j + 1
      r[[j]] <- list(ls[i], 1)
    }
    else {
      r[[j]][[2]] <- r[[j]][[2]] + 1
    }
  }
  logger::log_success("process finished!")
  logger::log_tictoc()
  gsub("\"", "", gsub("list", "", paste0("[", paste(r, collapse = ", "), "]")))
}

f("aaaabbbcca")

a <- rle(strsplit("aaaabbbcca", "")[[1]])
paste0("[(", paste(paste(a$values, a$lengths, sep = ", "), collapse = "), ("), ")]")
