# Create a reactive value that only triggers when its value changes

If you understand shiny and reactivity well, you will know that a reactive expression gets re-run whenever any of its reactive dependencies are invalidated. This is generally the desired behaviour, but there is one caveat that comes up occassionally: even if the underlying value of the reactive dependency hasn't changed, it can still be considered "invalidated". This can mean that a reactive expression will run again with exactly the same values because its dependencies have not changed, even though they're invalidated. Joe Cheng (author of shiny) has [a solution](https://github.com/rstudio/shiny/issues/1484#issuecomment-262812760) for this.

Define a `dedupe` function as follows:

```
dedupe <- function(r) {
  makeReactiveBinding("val")
  observe(val <<- r(), priority = 10)
  reactive(val)
}
```

And now you can wrap any `reactive(...)` expression with `dedupe(reactive(...))` so that it will only get invalidated if the actual value changes.