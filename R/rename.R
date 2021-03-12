


#' @name doc-common-rename
#' @param x An object with names.
#' @param pattern A regular expression string (see [regex]).
#' @param f A function, one-sided formula, or character vector.
#' @param ... Passed into `f`. An error is thrown if `...` is non-empty when `f`
#'   is a character vector.
#' @details
#'
#' * If `f` is a function it will be applied to the selected names. If it is
#' a formula it will be converted to a function by [rlang::as_function()], then
#' applied.
#' * If `f` is a named character vector like `c(new_name = "old_name", ...)` then
#' `"old_name"` will become `"new_name"`, as in `dplyr::rename()`.
#' * If `f` is an unnamed character vector, these will be the new names in order.
#'
#' @return The renamed object.
NULL


#' Internal: Return functions for character vectors
#'
#' @param char Named or unnamed character vector.
#'
#' @return
#' `named_renamer` returns a function which converts
#' elements of `nms` matching `char` to the corresponding elements of
#' `names(char)`.
#'
#' `unnamed_renamer` returns a function which returns `char[seq_along(nms)]`.
#'
#' @noRd
#'
#' @examples
#'
#' nr <- named_renamer(c(new1 = "old1", new2 = "old2"))
#' nr(c("old1", "old2", "other"))
#' unr <- unnamed_renamer(c("a", "b", "c"))
#' unr(c("d", "e", "f"))
named_renamer <- function (char) {
  force(char) # necessary or char will get overwritten as the function
  function (nms) {
    matches <- match(nms, char)
    nms[! is.na(matches)] <- names(char)[matches[! is.na(matches)]]
    nms
  }
}


#' @rdname named_renamer
#' @noRd
unnamed_renamer <- function (char) {
  force(char) # necessary or char will get overwritten as the function
  function (nms) {
    char[seq_along(nms)]
  }
}


#' Internal: convert `f` argument to a function.
#'
#' @inherit doc-common-rename
#'
#' @return A function which takes names and replaces them.
#' @noRd
#'
#' @examples
#'
#' rumpel:::f_to_function(paste)
#' rumpel:::f_to_function(~paste(.x, 1))
#' rumpel:::f_to_function(c("name1", "name2"))
#' rumpel:::f_to_function(c(new1 = "old1", new2 = "old2"))
#'
f_to_function <- function (f, ...) {
  if (is.character(f)) {
    stopifnot(...length() == 0)
    if (is.null(names(f))) {
      f <- unnamed_renamer(f)
    } else {
      f <- named_renamer(f)
    }
  } else {
    f <- rlang::as_function(f)
  }

  f
}


#' Rename names indexed by a subset
#'
#' @inherit doc-common-rename
#' @param matches A logical or numeric index.
#'
#' @export
#'
#' @examples
#'
#' vec <- c("One" = 1, "Two" = 2, "Three" = 3, "Four" = 4)
#' rename_where(vec, 2:3, paste0, 2:3)
#'
rename_where <- function (x, matches, f, ...) {
  f <- f_to_function(f, ...)
  names(x)[matches] <- f(names(x)[matches], ...)
  x
}


#' Rename names `%in%` a set
#'
#' @inherit doc-common-rename
#' @param table A character vector passed to `%in%`.
#'
#' @export
#'
#' @examples
#'
#' vec <- c("One" = 1, "Two" = 2, "Three" = 3, "Four" = 4)
#' rename_in(vec, c("Two", "Three"), paste0, "x")
#'
rename_in <- function (x, table, f, ...) {
  matches <- names(x) %in% table
  rename_where(x, matches, f, ...)
}


#' Rename names that match a regular expression
#'
#' @inherit doc-common-rename
#' @param ignore.case,perl,fixed,useBytes Passed into [grepl()].
#'
#' @export
#'
#' @examples
#'
#' vec <- c("One" = 1, "Two" = 2, "Three" = 3, "Four" = 4)
#' rename_like(vec, "^T", paste0, "x")
#'
rename_like <- function (x, pattern, f, ..., ignore.case = FALSE, perl = FALSE,
                         fixed = FALSE, useBytes = FALSE) {
  stopifnot(length(pattern) == 1)
  matches <- grepl(pattern, x, ignore.case = ignore.case, perl = perl,
                   fixed = fixed, useBytes = useBytes)
  rename_where(x, matches, f, ...)
}


#' Rename names that start with a prefix
#'
#' @inherit doc-common-rename
#' @param prefix A string.
#'
#' @export
#'
#' @examples
#'
#' vec <- c("One" = 1, "Two" = 2, "Three" = 3, "Four" = 4)
#' rename_starting(vec, "T", gsub, "[aeiou]", "e")
rename_starting <- function (x, prefix, f, ...) {
  matches <- startsWith(names(x), prefix)
  rename_where(x, matches, f, ...)
}


#' Rename using a regular expression
#'
#' @inherit doc-common-rename
#' @param pattern,replacement,... Passed into [sub()] or [gsub()].
#'
#' @details
#' These functions always apply to all names.
#'
#' @export
#'
#' @examples
#'
#' vec <- c("One" = 1, "Two" = 2, "Three" = 3, "Four" = 4)
#' rename_gsub(vec, "[aeiou]", "e")
#' rename_sub(vec, "([aeiou])", ".\\1.")
rename_sub <- function (x, pattern, replacement, ...) {
  names(x) <- sub(pattern, replacement, names(x), ...)
  x
}

#' @export
#' @rdname rename_sub
rename_gsub <- function (x, pattern, replacement, ...) {
  names(x) <- gsub(pattern, replacement, names(x), ...)
  x
}

