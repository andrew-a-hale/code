DataService <- R6::R6Class(
  public = list(
    initialize = function() {
      require(AHD.reporting)
    },
    #' @description
    #' Workhorse function to fetch data. If the data refers to a sql query
    #' then the fetchSQL private method is called.
    #' @param ... Ordered list of args. The first element is expected to be a
    #' dataset that is loadable with \code{get} or a sql query. If it is a
    #' sql query then the first arg must be the name of the sql query and
    #' and further arguments must be ordered according to order they are
    #' substituted into the query (same as \code{dbBind}).
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
      } else {
        args[[1]]
      }
    },
    #' @description
    #' method to perform multiple fetches at once
    #' @param ... A list of multiple fetches. See \code{fetch}
    #' @examples
    #' fetchAll(list("iris"), list("mtcars"))
    fetchAll = function(...) {
      purrr::map(rlang::dots_list(...), ~ self$fetch(!!!.x))
    }
  ),
  private = list(
    connPool = structure("valid connection", class = "Pool"),
    #' @description
    #' unload packages and close db connections
    finalize = function() {
      unloadNamespace("AHD.reporting")
    },
    #' @description
    #' fetch from sql db
    fetchSQL = function(conn, ...) {
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

query <- DBI::SQL("SELECT 1")
url <- structure("http://httpbin.org/get?a=1", class = "URL")
dataService <- DataService$new()
dataService$datasets
d1 <- dataService$fetch("iris")
d2 <- dataService$fetch("mtcars")
d3 <- dataService$fetch("query", a = 1)
colours <- dataService$fetch("ahdColourSeq")
get <- dataService$fetch("url")

library(zeallot)
c(iris, mtcars, df, colours, get) %<-% dataService$fetchAll(
  list(name = "iris"),
  list(name = "mtcars"),
  list(name = "query", a = 1),
  list(name = "ahdColourSeq"),
  list("url")
)