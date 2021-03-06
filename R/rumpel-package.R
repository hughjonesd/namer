
#' Functions to manipulate objects by name
#'
#' In the fairy tale, Rumpelstiltskin could be controlled once the heroine
#' learned his name. The rumpel package contains convenience functions
#' to control R objects by name.
#'
#' @keywords internal
#'
#' @details
#' Functions that start with `named` return a subset of the original
#' object:
#'
#' ```
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' vec %>% named("one")
#' vec %>% named_like("^t")
#' ```
#'
#' Functions that start with `rename` return the object with its
#' names changed:
#'
#' ```
#' vec <- c(one = 1, two = 2, three = 3, four = 4)
#' vec %>% rename_gsub("[aeiou]", "e")
#' vec %>% rename_toupper()
#' ```
#'
"_PACKAGE"

# The following block is used by usethis to automatically manage
# roxygen namespace tags. Modify with care!
## usethis namespace: start
## usethis namespace: end
NULL
