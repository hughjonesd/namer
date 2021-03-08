
#' Doc for rename
#' @name doc-common-rename
#' @inherit doc-common
#' @param f A function or one-sided formula, interpreted by [rlang::as_function()].
#' @param ... Passed into `f`.
#' @return The renamed object.
NULL


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
#' rename_subset(vec, 2:3, paste0, 2:3)
#'
rename_subset <- function (x, matches, f, ...) {
  f <- rlang::as_function(f)
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
  rename_subset(x, matches, f, ...)
}


#' Rename names that match a regular expression
#'
#' @inherit doc-common-rename
#' @param ignore.case,perl,fixed,use.bytes Passed into [grepl()].
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
  rename_subset(x, matches, f, ...)
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
  rename_subset(x, matches, f, ...)
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

