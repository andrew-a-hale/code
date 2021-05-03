new_report <- function(report_data = list(), ...) {
	structure(
		report_data,
		class = c("report", "data.frame"),
		...
	)
}

my_new_report <- new_report(iris, a = 1, b = "string", title = "my table")

print.report <- function(x) {
	print(paste0("fancy class ", attributes(x)$class))
	str(attributes(x)$params)
	str(class(x))
	print(unclass(x))
}

print.html_report <- function(x) {
	htmltools::html_print(x)
}

transform_data <- function(x) UseMethod("transform_data")
transform_data.report <- function(x) {
	dplyr::count(x, .data$Species)
}

format.report <- function(x) {
	x <- emailable.html.table::dfToHtmlTable(x, title = attributes(x)$title)
	class(x) <- "html_report"
	x
}

my_new_report %>%
	transform_data() %>%
	format() %>%
	print()
