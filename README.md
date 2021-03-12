
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![R-CMD-check](https://github.com/hughjonesd/rumpel/workflows/R-CMD-check/badge.svg)](https://github.com/hughjonesd/rumpel/actions)
<!-- badges: end -->

In the fairy tale, Rumpelstiltskin could be controlled once the heroine
learned his name.

Rumpel is a tiny r package containing convenience functions for
manipulating objects by their names. Using these functions makes your
code easier to read, and reduces duplication:

``` r
library(rumpel)
library(magrittr)
my_object <- c(One = 1, Two = 2, Three = 3, Four = 4)

# Base R:
my_object[startsWith(names(my_object), "T")]
#>   Two Three 
#>     2     3

# Clearer:
my_object %>% named_starting("T")
#>   Two Three 
#>     2     3


# Base R:
some_names <- names(my_object) %in% c("Two", "Three")
names(my_object)[some_names] <- tolower(names(my_object)[some_names])

# Clearer:
my_object %>% rename_in(c("Two", "Three"), tolower)
#>   One   two three  Four 
#>     1     2     3     4
```

Functions that start with `named` return a subset of the original
object:

``` r
vec <- c(One = 1, Two = 2, Three = 3, Four = 4)
vec %>% named_in(c("Two", "Three", "Non-existent"))
#>   Two Three 
#>     2     3
vec %>% named_starting("T")
#>   Two Three 
#>     2     3
vec %>% named_like("[A-Z].*e$")
#>   One Three 
#>     1     3
```

Functions that start with `rename` return the object with its names
changed. You can use a named character vector:

``` r
vec %>% rename_in(c("One", "Two"), c(one = "One", two = "Two"))
#>   one   two Three  Four 
#>     1     2     3     4
```

Or an unnamed character vector:

``` r
vec %>% rename_in(c("One", "Two"), c("First", "Second"))
#>  First Second  Three   Four 
#>      1      2      3      4
```

Or a function:

``` r
vec %>% rename_all(tolower)
#>   one   two three  four 
#>     1     2     3     4
vec %>% rename_starting("T", tolower)
#>   One   two three  Four 
#>     1     2     3     4
vec %>% rename_in(c("One", "Two"), paste, 1:2, sep = ".")
#> One.1 Two.2 Three  Four 
#>     1     2     3     4
```

Or you can use a one-sided formula, as in
[purrr](https://purrr.tidyverse.org/):

``` r
vec %>% rename_in(c("One", "Two"), ~paste(.x, 1:2, sep = "."))
#> One.1 Two.2 Three  Four 
#>     1     2     3     4
```

Or use a regular expression with `rename_gsub`:

``` r
vec %>% rename_gsub("[aeiou]", "e")
#>   One   Twe Three  Feer 
#>     1     2     3     4
```

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("hughjonesd/rumpel")
```
