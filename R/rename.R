


#' @name doc-common-rename
#' @param x An object with names.
#' @param pattern A regular expression string (see [regex]).
#' @param f A function, one-sided formula, or character vector.
#' @param ... Passed into `f`. An error is thrown if `...` is non-empty when `f`
#'   is a character vector.
#' @details
#'
#' * If `f` is a function it will be applied to the selected names. If it is
#' a formula and the 'rlang' package is installed, it will be converted to a
#' function by [rlang::as_function()], then
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
#' namer:::f_to_function(paste)
#' namer:::f_to_function(~paste(.x, 1))
#' namer:::f_to_function(c("name1", "name2"))
#' namer:::f_to_function(c(new1 = "old1", new2 = "old2"))
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
    if (inherits(f, "formula")) {
      if (! requireNamespace("rlang", quietly = TRUE)) stop(
        "To use a formula, you need the 'rlang' package installed. Type:\n",
        "install.packages(\"rlang\")")
      f <- rlang::as_function(f)
    }
  }

  if (! is.function(f)) stop("`f` must be a function, formula or character vector.")

  f
}


#' Rename names indexed by a subset
#'
#' @inherit doc-common-rename
#' @param index A logical or numeric index.
#'
#' @export
#'
#' @examples
#'
#' vec <- c("One" = 1, "Two" = 2, "Three" = 3, "Four" = 4)
#' rename_where(vec, 2:3, paste0, 2:3)
#'
rename_where <- function (x, index, f, ...) {
  f <- f_to_function(f, ...)
  names(x)[index] <- f(names(x)[index], ...)
  x
}



#' Rename all names
#'
#' @inherit doc-common-rename
#'
#' @export
#'
#' @examples
#'
#' vec <- c("One" = 1, "Two" = 2, "Three" = 3, "Four" = 4)
#' vec |> rename_all(tolower)
#'
rename_all <- function (x, f, ...) {
  rename_where(x, TRUE, f, ...)
}

#' Rename names in a set
#'
#' Elements of `x` whose names are in `nm` will be renamed.
#'
#' @inherit doc-common-rename
#' @param nm A character vector passed to `%in%`.
#'
#' @export
#'
#' @examples
#'
#' vec <- c("One" = 1, "Two" = 2, "Three" = 3, "Four" = 4)
#' vec |> rename_in(c("Two", "Three"), paste0, "x")
#'
rename_in <- function (x, nm, f, ...) {
  matches <- names(x) %in% nm
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
#' vec |> rename_starting("T", \(x) gsub(x, "[aeiou]", "e"))
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
#' vec |> rename_gsub("[aeiou]", "e")
#' vec |> rename_sub("([aeiou])", "-\\1-")
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


#' Rename by looking up names in a table
#'
#' This is useful when you have a vector of old names and a vector of new names,
#' or columns in a data frame.
#'
#' Unmatched names are left unchanged.
#'
#' @inherit doc-common-rename
#' @param old Character vector. Existing names will be found using
#'   `match(names(x), old)`
#' @param new Character vector. A vector of new names to replace corresponding
#'   elements in `old`.
#' @param warn Logical. Warn if any names are unmatched?
#'
#' @return
#'
#' `x` renamed according to `names(x) <- new[match(names(x), old)]`.
#'
#' @export
#'
#' @examples
#'
#' df <- data.frame(
#'         old = c("One", "Two", "Three"),
#'         new = c("New", "Newer", "Newest")
#'       )
#' vec <- c("One" = 1, "Two" = 2, "Three" = 3, "Four" = 4)
#' vec |> rename_lookup(df$old, df$new)
#'
rename_lookup <- function (x, old, new, warn = FALSE) {
  matches <- match(names(x), old, nomatch = NA_character_)
  new <- new[matches]
  if (warn && any(is.na(matches))) {
    warning("Unmatched names: ", paste(names(x)[is.na(matches)], sep = ", "))
  }
  new[is.na(matches)] <- names(x)[is.na(matches)]
  names(x) <- new
  x
}


#' Remove a prefix or suffix from names
#'
#' @inherit doc-common-rename
#' @param prefix,suffix A length 1 character vector to remove.
#'
#' @return
#'
#' `x` with the prefix or suffix removed from `names(x)`.
#'
#' @export
#'
#' @examples
#'
#' vec <- c("a.1" = 1, "aaa.1" = 2, "other" = 3, ".1" = 4)
#' vec |> rename_remove_suffix(".1")
#'
#' vec <- c("x.a" = 1, "x.aaa" = 2, "other" = 3, "x." = 4)
#' vec |> rename_remove_prefix("x.")
rename_remove_prefix <- function (x, prefix) {
  stopifnot(length(prefix) == 1)
  matches <- startsWith(names(x), prefix)
  new <- names(x)[matches]
  new <- substr(new, nchar(prefix) + 1, nchar(new))
  names(x)[matches] <- new
  x
}


#' @export
#' @rdname rename_remove_prefix
rename_remove_suffix <- function (x, suffix) {
  stopifnot(length(suffix) == 1)
  matches <- endsWith(names(x), suffix)
  new <- names(x)[matches]
  new <- substr(new, 1, nchar(new) - nchar(suffix))
  names(x)[matches] <- new
  x
}
