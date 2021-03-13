
#' Manipulate objects by name
#'
#' @includeRmd README.Rmd
#'
"_PACKAGE"


#' Other useful resources for manipulating names
#'
#'
#' Obviously, [base::names()] gets an object's names and `base::names<-()`
#'   sets them.
#'
#' [stats::setNames()] directly returns the object after setting names.
#'
#' [base::make.names()] turns a character vector into syntactically valid
#'   names.
#'
#' [base::make.unique()] makes elements of a character vector unique by appending
#'   sequence numbers to duplicates.
#'
#' [rlang::set_names()] is like [setNames()] but also takes a function to
#'   transform names.
#'
#' [rlang::names2()] is like [names()] but returns a character vector of `""`
#'   rather than `NULL`.
#'
#' [https://principles.tidyverse.org/names-attribute.html] is a principled
#'   framework for thinking about names in R.
#'
#' @name other-resources
NULL

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL
