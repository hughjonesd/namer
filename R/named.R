

#' @importFrom stats setNames
NULL


#' Common documentation
#'
#' @param x An object with names.
#' @param pattern A regular expression string (see [regex]).
#' @name doc-common
NULL


#' Subset objects by name using a regular expression
#'
#' @inherit doc-common
#'
#' @return
#' ```
#' x[grepl(pattern, names(x))]
#' ```
#' @export
#'
#' @examples
#'
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' named_like(vec, "^t")
#'
named_like <- function (x, pattern) {
  stopifnot(length(pattern) == 1)
  x[grepl(pattern, names(x))]
}


#' Subset objects by name using an initial substring
#'
#' @inherit doc-common
#' @param prefix A character string
#'
#' @return
#' ```
#' x[startsWith(names(x), prefix)]
#' ```
#' @export
#'
#' @examples
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' named_starting(vec, "t")
named_starting <- function (x, prefix) {
  stopifnot(length(prefix) == 1)
  x[startsWith(names(x), prefix)]
}
