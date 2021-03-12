
# allow dplyr's select and rename semantics for any named object
# not sure this is a great idea :-P

# select.default <- function (.data, ...) {
#   loc <- tidyselect::eval_select(rlang::expr(c(...)), .data)
#   .data[loc]
# }
#
#
# rename.default <- function (.data, ...) {
#   loc <- tidyselect::eval_rename(rlang::expr(c(...)), .data)
#   names <- names(.data)
#   names[loc] <- names(loc)
#   names(.data) <- names
#   .data
# }
