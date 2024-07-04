
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![R-CMD-check](https://github.com/hughjonesd/namer/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/hughjonesd/namer/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

`{namer}` is a tiny r package containing convenience functions for
manipulating objects by their names. Using these functions makes your
code easier to read, and reduces duplication:

``` r
library(namer)

vec <- c(One = 1, Two = 2, Three = 3, Four = 4)

# Base R:
vec[startsWith(names(vec), "T")]
#>   Two Three 
#>     2     3

# Clearer:
vec |> named_starting("T")
#>   Two Three 
#>     2     3


# Base R:
some_names <- names(vec) %in% c("Two", "Three")
names(vec)[some_names] <- tolower(names(vec)[some_names])

# Clearer:
vec |> rename_in(c("Two", "Three"), tolower)
#>   One   two three  Four 
#>     1     2     3     4


# Base R:
vec[sort(names(vec))]
#>  Four   One three   two 
#>     4     1     3     2

# Clearer:
vec |> sort_by_name()
#>  Four   One three   two 
#>     4     1     3     2
```

Functions that start with `named` return a subset of the original
object:

``` r

vec <- c(One = 1, Two = 2, Three = 3, Four = 4)
vec |> named_in(c("Two", "Three", "Non-existent"))
#>   Two Three 
#>     2     3
vec |> named_starting("T")
#>   Two Three 
#>     2     3
vec |> named_like("[A-Z].*e$")
#>   One Three 
#>     1     3
```

`sort_by_name()` sorts object by name:

``` r
sort_by_name(vec)
#>  Four   One Three   Two 
#>     4     1     3     2
```

Functions that start with `rename` return the object with its names
changed. You can use a named character vector:

``` r
vec |> rename_in(c("One", "Two"), c(one = "One", two = "Two"))
#>   one   two Three  Four 
#>     1     2     3     4
```

Or an unnamed character vector:

``` r
vec |> rename_in(c("One", "Two"), c("First", "Second"))
#>  First Second  Three   Four 
#>      1      2      3      4
```

Or a function:

``` r
vec |> rename_all(tolower)
#>   one   two three  four 
#>     1     2     3     4
vec |> rename_starting("T", tolower)
#>   One   two three  Four 
#>     1     2     3     4
```

Or you can use a one-sided formula, as in
[purrr](https://purrr.tidyverse.org/):

``` r
vec |> rename_in(c("One", "Two"), ~paste(.x, 1:2, sep = "."))
#> One.1 Two.2 Three  Four 
#>     1     2     3     4
```

Or use a regular expression with `rename_gsub`:

``` r
vec |> rename_gsub("[aeiou]", "e")
#>   One   Twe Three  Feer 
#>     1     2     3     4
```

Or match names from old to new with `rename_lookup`:

``` r
df <- data.frame(
        old = c("One", "Two", "Three", "Four"),
        new = c("A", "B", "C", "D")
      )
vec |> rename_lookup(df$old, df$new)
#> A B C D 
#> 1 2 3 4
```

## Installation

You can install from R-universe:

``` r
install.packages("namer", repos = c("https://hughjonesd.r-universe.dev", 
                 "https://cloud.r-project.org"))
```

Or install the development version from [GitHub](https://github.com/):

``` r
# install.packages("remotes")
remotes::install_github("hughjonesd/namer")
```
