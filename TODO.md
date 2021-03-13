
# TODO

Ideas from github code search:

- [x] Subset objects using names in another object? `named_in`?

This is like `x[names(y)]` except that it doesn't create an `NA` for any
"misses".

Or perhaps in general, `named_in(x, y)` should do `x[y]` but without `NA`s.
i.e. `x[intersect(names(x), y)]`

- [ ] `named_sorted`: `x[sort(names(x))]`

- [ ] `named_except`: `x[setdiff(names(x), y)]`

Maybe `named_not`?

- [ ] Checks like `names_are_same`, `names_are_in`, `names_contain`,
      `names_are_unique()`? 

Useful for tests and assertions.
