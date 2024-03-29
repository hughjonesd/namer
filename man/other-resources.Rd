% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/namer-package.R
\name{other-resources}
\alias{other-resources}
\title{Other useful resources for manipulating names}
\description{
There are several existing functions for working with names in R.
}
\details{
Obviously, \code{\link[base:names]{base::names()}} gets an object's names and \verb{names<-}
sets them.

\code{\link[stats:setNames]{stats::setNames()}} directly returns the object after setting names.

\code{\link[base:make.names]{base::make.names()}} turns a character vector into syntactically valid
names. \code{\link[vctrs:vec_as_names]{vctrs::vec_as_names()}} does the same thing, r-lib style.

\code{\link[base:make.unique]{base::make.unique()}} makes elements of a character vector unique by appending
sequence numbers to duplicates.

\code{\link[rlang:set_names]{rlang::set_names()}} is like \code{\link[=setNames]{setNames()}} but also takes a function to
transform names.

\code{\link[rlang:names2]{rlang::names2()}} is like \code{\link[=names]{names()}} but returns a character vector of \code{""}
rather than \code{NULL} if an object has no \code{names} attribute.

\code{\link[dplyr:rename]{dplyr::rename()}} and friends change the names of data frames or tibbles,
but not other objects.

\url{https://principles.tidyverse.org/names-attribute.html} is a principled
framework for thinking about names in R.
}
