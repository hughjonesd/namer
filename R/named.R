

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


#' Subset objects by name
#'
#' @inherit doc-common
#' @param y A character scalar.
#'
#' @return
#' ```
#' x[names(x) == y]
#' ```
#' @export
#'
#' @examples
#'
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' named(vec, "one")
#'
named <- function (x, y) {
  stopifnot(length(y) == 1)
  x[names(x) == y]
}


#' Subset objects by name using a vector of matches
#'
#' @inherit doc-common
#' @param table A vector.
#'
#' @return
#' ```
#' x[names(x) %in% table]
#' ```
#' @export
#'
#' @examples
#'
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' named_in(vec, c("one", "four"))
#'
named_in <- function (x, table) {
  stopifnot(is.vector(table))
  x[names(x) %in% table]
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
