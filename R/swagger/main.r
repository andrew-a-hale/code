#' @apiTitle Sample Pet Store App
#' @apiDescription This is a sample server for a pet store.
#' @apiTOS http://example.com/terms/
#' @apiVersion 1.0.1
#' @apiTag pet Pets operations
#' @apiTag toy Toys operations
#' @apiTag "toy space" Toys operations
 
#' @get /
#' @tag "toy space"
function() {
  "Hello World!"
}