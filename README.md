# R tutorial

## Finding a movie using R

Overview
--------

dplyr is a grammar of data manipulation, providing a consistent set of verbs that help you solve the most common data manipulation challenges:

-   `mutate()` adds new variables that are functions of existing variables
-   `select()` picks variables based on their names.
-   `filter()` picks cases based on their values.
-   `summarise()` reduces multiple values down to a single summary.
-   `arrange()` changes the ordering of the rows.

These all combine naturally with `group_by()` which allows you to perform any operation "by group". You can learn more about them in `vignette("dplyr")`. As well as these single-table verbs, dplyr also provides a variety of two-table verbs, which you can learn about in `vignette("two-table")`.

dplyr is designed to abstract over how the data is stored. That means as well as working with local data frames, you can also work with remote database tables, using exactly the same R code. Install the dbplyr package then read `vignette("databases", package = "dbplyr")`.

If you are new to dplyr, the best place to start is the [data transformation chapter](http://r4ds.had.co.nz/transform.html) in R for data science.

Today we are going to learn to import, manipulate, and graph data in R. In R, we'll be using a library called 'tidyverse'.
