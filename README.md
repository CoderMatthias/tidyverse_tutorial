# R tutorial

## Overview

The goal of today will be to learn to manipulate and visualize data using R. To this end, we will be using the package 'tidyverse' that contains two very important tools, dplyr and ggplot2.

dplyr is a grammar of data manipulation, providing a consistent set of verbs that help you solve the most common data manipulation challenges:

-   `mutate()` adds new variables that are functions of existing variables
-   `select()` picks variables based on their names.
-   `filter()` picks cases based on their values.
-   `summarise()` reduces multiple values down to a single summary.
-   `arrange()` changes the ordering of the rows.

ggplot2 is a visualization package encompassing many different types of graphs.

## Getting started

By this point you should have installed R and Rstudio. First we need to install the tidyverse package. At the top of Rstudio, go to `Tools -> Install Packages...`. This will give you a popup window. In the packages text box, type `tidyverse` and click install.

Next, we will download the data we will be using today. On this page, click the `Clone or Download` button at the top right and click `download zip`. Unzip `tidyverse_tutorial-master.zip` and enter the `tidyverse_tutorial-master` folder. In this folder you should see the following files:
```
intro.R
movies.csv
msleep.csv
README.md
```

At this point we are set to start the R portion of the analysis.

## Data manipulation in R

We need to first set our working directory to where our data is located. This can be done two ways.
Option A: Go to `Session -> Set Working Directory -> Choose Directory...` and navigate to the `tidyverse_tutorial-master` folder.

Option B: Use the `setwd()` command with the system path to the `tidyverse_tutorial-master` folder, like so:
```
set_wd('path/to/tidyverse_tutorial-master')
```

Next we will load the tidyverse package (you should see a similar output).
```
> library(tidyverse)

Loading tidyverse: ggplot2
Loading tidyverse: tibble
Loading tidyverse: tidyr
Loading tidyverse: readr
Loading tidyverse: purrr
Loading tidyverse: dplyr
Conflicts with tidy packages --------------------------------------------------------------------------------------
filter(): dplyr, stats
lag():    dplyr, stats
```
