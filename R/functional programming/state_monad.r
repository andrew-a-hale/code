# simple problem in the functional style, function are pure

library(magrittr)

#' @export
some_procedure <- function(a, b, another_title_section = NULL) {
	input <- parse_args(a, b, another_title_section)
	init_output <- list(n = 0, title = "")
  append(input, init_output) %>%
    calculate_n() %>%
    add_title() %>%
		create_output()
}

#' @keywords internal
create_output <- function(x) {
	paste0(x$title, " - n = ", x$n)
}

#' @keywords internal
add_to_n <- function(x) {
  purrr::modify_at(x, "n", `+`, as.numeric(x$a))
}

#' @keywords internal
multiply_on_n <- function(x) {
  purrr::modify_at(x, "n", `*`, x$b)
}

#' @keywords internal
calculate_n <- purrr::compose(add_to_n, multiply_on_n, .dir = "forward")

#' @keywords internal
add_title <- function(x) {
  purrr::list_modify(
    x,
    title = stringr::str_c("my title", x$another_title_section, sep = " - ")
  )
}

#' @keywords internal
parse_args <- function(...) {
  args <- rlang::dots_list(..., .named = TRUE)
  stopifnot(
    "missing a" = exists("a", args),
    "missing b" = exists("b", args)
  )
  args
}

some_procedure(a = "13", b = 123, another_title_section = "dynamic arg")
