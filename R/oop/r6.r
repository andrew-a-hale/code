Report <- R6::R6Class(
  public = list(
    data = NULL,
    html_report = NULL,
    print = function() {
      self$html_report %>%
        htmltools::html_print()
    },
    initialize = function(data) {
      stopifnot(is.data.frame(data))
      self$data <- data
    },
    process = function(...) {
      args <- rlang::dots_list(...)
      private$transform_data(args$column)
      private$format_data(args$title)
    }
  ),
  private = list(
    transform_data = function(column) {
      self$data <- dplyr::count(self$data, .data[[column]])
    },
    format_data = function(title) {
      self$html_report <-
        emailable.html.table::dfToHtmlTable(self$data, title = title)
    }
  )
)

my_new_report <- Report$new(iris)
my_new_report$process(title = "my title", column = "Species")
my_new_report

LargeReport <- R6::R6Class(
  "large_report",
  inherit = Report,
  public = list(
    print = function() {
      cat("large report!\n")
      super$print()
    }
  )
)

my_large_report <- LargeReport$new(mtcars)
my_large_report$process(title = "my bigger title", column = "cyl")
my_large_report