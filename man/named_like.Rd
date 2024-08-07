% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/named.R
\name{named_like}
\alias{named_like}
\alias{not_named_like}
\title{Subset objects by name using a regular expression}
\usage{
named_like(x, pattern, ...)

not_named_like(x, pattern, ...)
}
\arguments{
\item{x}{An object with names.}

\item{pattern}{A regular expression string (see \link{regex}).}

\item{...}{Passed in to \code{\link[=grepl]{grepl()}}.}
}
\value{
For \code{named_like}: \code{x[grepl(pattern, names(x), ...)]}.

For \code{not_named_like}: \code{x[! grepl(pattern, names(x), ...)]}.
}
\description{
Subset objects by name using a regular expression
}
\examples{

vec <- c(one = 1, two = 2, three = 3, four = 4)
vec |> named_like("^t")
vec |> not_named_like("e$")

}
