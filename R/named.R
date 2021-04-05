

#' @importFrom stats setNames
NULL


#' @param x An object with names.
#' @param pattern A regular expression string (see [regex]).
#' @name doc-common
NULL


#' Subset objects by name
#'
#' @inherit doc-common
#' @param y A vector of names.
#'
#' @details
#'
#' `named_in(x, y)` is similar to `x[y]` except that:
#'
#' * unmatched elements of `y` do not return an `NA` element;
#' * elements are returned in their original order within `x`.
#'
#' `named_except(x, y)` returns elements of `x` whose name is not
#' an element of `y`.
#'
#' @return
#'
#' For `named_in`: `x[names(x) %in% y]`.
#'
#' For `not_named_in`: `x[! names(x) %in% y]`.
#'
#' @export
#'
#' @examples
#'
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' named_in(vec, c("two", "one", "three", "five"))
#' not_named_in(vec, c("two", "three"))
named_in <- function (x, y) {
  x[names(x) %in% y]
}


#' @export
#' @rdname named_in
not_named_in <- function (x, y) {
  x[! names(x) %in% y]
}


#' Subset objects by name using a regular expression
#'
#' @inherit doc-common
#' @param ... Passed in to [grepl()].
#'
#' @return
#'
#' For `named_like`: `x[grepl(pattern, names(x), ...)]`.
#'
#' For `not_named_like`: `x[! grepl(pattern, names(x), ...)]`.
#'
#' @export
#'
#' @examples
#'
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' named_like(vec, "^t")
#' not_named_like(vec, "e$")
#'
named_like <- function (x, pattern, ...) {
  stopifnot(length(pattern) == 1)
  x[grepl(pattern, names(x), ...)]
}


#' @rdname named_like
#' @export
not_named_like <- function (x, pattern, ...) {
  stopifnot(length(pattern) == 1)
  x[! grepl(pattern, names(x), ...)]
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
