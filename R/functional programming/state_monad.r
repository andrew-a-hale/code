library(magrittr)

f <- function(x) {
	purrr::modify_in(x, list("return_obj", "n"), `+`, as.numeric(x$state$a))
}

g <- function(x) {
	purrr::modify_in(x, list("return_obj", "n"), `*`, x$state$b)
}

h <- function(x) {
	purrr::assign_in(x, list("return_obj", "title"), "my title") %>%
		purrr::pluck("return_obj")
}

state <- list(a = "123", b = 123)
return_obj <- list(n = 0, title = "")
init <- list(return_obj = return_obj, state = state)

init %>%
	f() %>%
	g() %>%
	h()
