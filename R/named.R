

#' @importFrom stats setNames
NULL


#' @name doc-common
#' @param x An object with names.
#' @param pattern A regular expression string (see [regex]).
NULL



#' Subset objects by name
#'
#' `x |> named(y)` is the same as `x[y]`, but
#'
#' * it makes your intent clearer;
#' * it throws an error if `y` is not a character vector;
#' * unmatched elements of `y` return `NA`, but with the name of
#'   the element, whereas `x[y]` would return an `NA` name.
#'
#' @inherit doc-common
#' @param y A vector of names.
#'
#' @return
#' `setNames(x[y], y)`.
#'
#' @export
#'
#' @examples
#'
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' nms <- c("three", "two", "five")
#' vec |> named(nms)
#' # Compare to:
#' vec[nms]
named <- function (x, y) {
  stopifnot(is.character(y))
  setNames(x[y], y)
}


#' Subset objects by name, preserving order
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
#' `not_named_in(x, y)` returns elements of `x` whose name is not
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
#' vec |> named_in(c("two", "one", "three", "five"))
#' vec |> not_named_in(c("two", "three"))
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
#' vec |> named_like("^t")
#' vec |> not_named_like("e$")
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
#' vec |> named_starting("t")
named_starting <- function (x, prefix) {
  stopifnot(length(prefix) == 1)
  x[startsWith(names(x), prefix)]
}
