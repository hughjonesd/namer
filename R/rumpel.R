

#' @importFrom stats setNames
NULL


#' Common documentation
#'
#' @param x An object with names.
#' @param pattern A regular expression string (see [regex]).
#' @name doc-common
NULL


#' Select objects by name using a regular expression
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


#' Select objects by name
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


#' Select objects by name using a vector of matches
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


#' Rename using a regular expression
#'
#' @inherit doc-common
#' @param replacement A replacement string. See [sub()].
#' @param ... Passed to [sub()] or [gsub()].
#'
#' @return
#' ```
#' setNames(x, sub(pattern, replacement, names(x), ...))
#' ```
#' @export
#'
#' @examples
#'
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' rename_sub(vec, "[aeiou]", "e")
#' rename_gsub(vec, "[aeiou]", "e")
#'
rename_sub <- function (x, pattern, replacement, ...) {
  stopifnot(length(pattern) == 1, length(replacement) == 1)
  setNames(x, sub(pattern, replacement, names(x), ...))
}


#' @rdname rename_sub
#' @export
rename_gsub <- function (x, pattern, replacement, ...) {
  stopifnot(length(pattern) == 1, length(replacement) == 1)
  setNames(x, gsub(pattern, replacement, names(x), ...))
}


#' Rename to upper or lower case or by a translation table
#'
#' @inherit doc-common
#' @param old,new Character strings passed to [chartr()].
#'
#' @return
#' ```
#' setNames(x, tolower(names(x)))
#' ```
#'
#' or similar.
#'
#' @export
#'
#' @examples
#'
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' rename_toupper(vec)
rename_chartr <- function (x, old, new) {
  stopifnot(length(old) == 1, length(new) == 1)
  setNames(x, chartr(old, new, names(x)))
}


#' @rdname rename_chartr
#' @export
rename_tolower <- function (x) {
  setNames(x, tolower(names(x)))
}


#' @rdname rename_chartr
#' @export
rename_toupper <- function (x) {
  setNames(x, toupper(names(x)))
}


#' Rename using `paste()`
#'
#' @inherit doc-common
#' @param ... Character vectors to paste after the names.
#' @param sep Passed to [paste()]. Note that the default is `""`.
#'
#' @return
#' ```
#' setNames(x, paste(names(x), ..., sep = sep))
#' ```
#' @export
#'
#' @examples
#'
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' rename_paste(vec, "X")
#'
rename_paste <- function (x, ..., sep = "") {
  stopifnot(length(sep) == 1)
  setNames(x, paste(names(x), ..., sep = sep))
}


#' Rename using a function
#'
#' @inherit doc-common
#' @param f A function or one-sided formula, as in [rlang::as_function()].
#' @param where A set of indices for the names.
#'
#' @return
#' `x` after `names(x)[where] <- f(names(x)[where])`.
#'
#' @export
#'
#' @examples
#'
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' rename_fn(vec, ~ substr(.x, 1, 2), where = 2:3)
#'
rename_fn <- function (x, f, where = TRUE) {
  f <- rlang::as_function(f)
  names(x)[where] <- f(names(x)[where])
  x
}



