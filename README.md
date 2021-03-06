
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rumpel

<!-- badges: start -->
<!-- badges: end -->

Rumpel is a tiny r package containing convenience functions for
manipulating objects by their names.

Functions that start with `named` return a subset of the original
object:

``` r
library(rumpel)
library(magrittr)

vec <- c(one = 1, two = 2, three = 3, four = 4)
vec %>% named("one")
#> one 
#>   1
vec %>% named_like("^t")
#>   two three 
#>     2     3
```

Functions that start with `rename` return the object with its names
changed:

``` r
vec <- c(one = 1, two = 2, three = 3, four = 4)
vec %>% rename_gsub("[aeiou]", "e")
#>   ene   twe three  feer 
#>     1     2     3     4
vec %>% rename_toupper()
#>   ONE   TWO THREE  FOUR 
#>     1     2     3     4
```

## Installation

You can install the released version of rumpel from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("rumpel")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("hughjonesd/rumpel")
```
