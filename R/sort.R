

#' Sort an object by its names
#'
#' @inherit doc-common params
#' @param decreasing Logical. Should sort order be increasing or decreasing?
#'
#' @return
#'
#' `x[sort(names(x), decreasing = decreasing)]`
#'
#' @export
#'
#' @examples
#'
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' sort_by_name(vec)
#' sort_by_name(vec, decreasing = TRUE)
sort_by_name <- function (x, decreasing = FALSE) {
  x[sort(names(x), decreasing = decreasing)]
}
