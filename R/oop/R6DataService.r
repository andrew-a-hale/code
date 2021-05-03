DataService <- R6::R6Class(
  public = list(
    initialize = function() {
      require(AHD.reporting)
      future::plan(future::multisession)
    },
    #' @description
    #' Wraper function to fetch data in various different ways.
    #' @param ... Ordered list of args. See private methods for further details.
    #' @examples
    #' fetch("iris")
    #' fetch("mtcars")
    #' query <- DBI::SQL("SELECT 1")
    #' fetch(query)
    fetch = function(...) {
      args <- rlang::dots_list(...)
      args[[1]] <- get(args[[1]])
      if (class(args[[1]]) == "SQL") {
        private$fetchSQL(private$connPool, !!!args)
      } else if (class(args[[1]]) == "URL") {
        private$fetchURL(args[[1]])
      } else if (class(args[[1]]) == "function") {
        private$fetchFunction(!!!args)
      } else {
        args[[1]]
      }
    },
    #' @description
    #' method to perform multiple async fetches at once
    #' @param ... A list of multiple fetches. See `fetch`
    #' @examples
    #' fetchAll(list("iris"), list("mtcars"))
    fetchAll = function(...) {
      furrr::future_map(
        rlang::dots_list(...),
        ~ self$fetch(!!!.x),
        .options = furrr::furrr_options(
          globals = c(
            "AHD.reporting",
            purrr::map_chr(list(...), purrr::pluck, 1, 1)
          )
        )
      )
    }
  ),
  private = list(
    #' @description
    #' unload packages and close db connections
    finalize = function() {
      unloadNamespace("AHD.reporting")
    },
    #' @description
    #' fetch from sql db
    fetchSQL = function(...) {
      conn <- structure("sql connection", class = "dbConn")
      Sys.sleep(2)
      cat("is SQL\n")
      cat(conn)
      cat("\n")
      tibble::tibble(1)
    },
    #' @description
    #' fetch from url using curl
    fetchURL = function(url) {
      call <- curl::curl_fetch_memory(url)
      cat(rawToChar(call$headers))
      rawToChar(call$content)
    },
    fetchFunction = function(...) {
      args <- rlang::dots_list(...)
      do.call(args[[1]], args[-1])
    }
  ),
  active = list(
    #' @description
    #' available datasets
    datasets = function() {
      data(package = "AHD.reporting")$results[, c(3, 4)]
    }
  ),
  cloneable = FALSE
)

dataService <- DataService$new()
dataService$datasets

query <- DBI::SQL("SELECT 1")
url <- structure("http://httpbin.org/get?a=1", class = "URL")
getIris <- function(filters) iris %>% dplyr::filter(!!!filters)
filters <- list(rlang::quo(Species == "setosa"), rlang::quo(Petal.Width >= 0.5))

system.time({
  dataService <- DataService$new()
  d1 <- dataService$fetch("iris")
  d2 <- dataService$fetch("mtcars")
  d3 <- dataService$fetch("query", a = 1)
  d4 <- dataService$fetch("query", a = 1)
  d5 <- dataService$fetch("query", a = 1)
  colours <- dataService$fetch("ahdColourSeq")
  get <- dataService$fetch("url")
  filteredIris <- dataService$fetch("getIris", filters)
})

library(zeallot)
system.time({
  dataService <- DataService$new()
  dataService$fetchAll(
    list(name = "iris"),
    list(name = "mtcars"),
    list(name = "query", a = 1),
    list(name = "query", a = 2),
    list(name = "query", a = 3),
    list(name = "ahdColourSeq"),
    list("url"),
    list("getIris", filters)
  ) %->%
    c(iris, mtcars, df1, df2, df3, colours, get, filteredIris)
})
