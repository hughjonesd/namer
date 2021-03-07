
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- badges: start -->

[![R-CMD-check](https://github.com/hughjonesd/rumpel/workflows/R-CMD-check/badge.svg)](https://github.com/hughjonesd/rumpel/actions)
<!-- badges: end -->

In the fairy tale, Rumpelstiltskin could be controlled once the heroine
learned his name.

Rumpel is a tiny r package containing convenience functions for
manipulating objects by their names.

Functions that start with `named` return a subset of the original
object:

``` r
library(rumpel)
library(magrittr)

vec <- c(One = 1, Two = 2, Three = 3, Four = 4)
vec %>% named("One")
#> One 
#>   1
vec %>% named_in(c("Two", "Three"))
#>   Two Three 
#>     2     3
vec %>% named_like("[A-Z].*e$")
#>   One Three 
#>     1     3
```

Functions that start with `rename` return the object with its names
changed:

``` r
vec %>% rename_gsub("[aeiou]", "e")
#>   One   Twe Three  Feer 
#>     1     2     3     4
vec %>% rename_toupper()
#>   ONE   TWO THREE  FOUR 
#>     1     2     3     4
vec %>% rename_tolower()
#>   one   two three  four 
#>     1     2     3     4
vec %>% rename_paste(".", 1:4)
#>   One.1   Two.2 Three.3  Four.4 
#>       1       2       3       4
vec %>% rename_fn(~paste0("Number", .x))
#>   NumberOne   NumberTwo NumberThree  NumberFour 
#>           1           2           3           4
```

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("hughjonesd/rumpel")
```
