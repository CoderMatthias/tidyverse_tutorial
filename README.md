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

We can now load our data. In the next command, we are loading the data contained in msleep.csv and storing it in the variable sleep.
```
> sleep <- read.csv('msleep.csv')
```

Let's examine our data.
```
> head(sleep)

                        name      genus  vore        order conservation sleep_total sleep_rem sleep_cycle awake brainwt  bodywt
1                    Cheetah   Acinonyx carni    Carnivora           lc        12.1        NA          NA  11.9      NA  50.000
2                 Owl monkey      Aotus  omni     Primates         <NA>        17.0       1.8          NA   7.0 0.01550   0.480
3            Mountain beaver Aplodontia herbi     Rodentia           nt        14.4       2.4          NA   9.6      NA   1.350
4 Greater short-tailed shrew    Blarina  omni Soricomorpha           lc        14.9       2.3   0.1333333   9.1 0.00029   0.019
5                        Cow        Bos herbi Artiodactyla domesticated         4.0       0.7   0.6666667  20.0 0.42300 600.000
6           Three-toed sloth   Bradypus herbi       Pilosa         <NA>        14.4       2.2   0.7666667   9.6      NA   3.850

> str(sleep)

'data.frame':	83 obs. of  11 variables:
 $ name        : Factor w/ 83 levels "African elephant",..: 12 57 52 36 17 77 55 81 21 67 ...
 $ genus       : Factor w/ 77 levels "Acinonyx","Aotus",..: 1 2 3 4 5 6 7 8 9 10 ...
 $ vore        : Factor w/ 4 levels "carni","herbi",..: 1 4 2 4 2 2 1 NA 1 2 ...
 $ order       : Factor w/ 19 levels "Afrosoricida",..: 3 15 17 19 2 14 3 17 3 2 ...
 $ conservation: Factor w/ 6 levels "cd","domesticated",..: 4 NA 5 4 2 NA 6 NA 2 4 ...
 $ sleep_total : num  12.1 17 14.4 14.9 4 14.4 8.7 7 10.1 3 ...
 $ sleep_rem   : num  NA 1.8 2.4 2.3 0.7 2.2 1.4 NA 2.9 NA ...
 $ sleep_cycle : num  NA NA NA 0.133 0.667 ...
 $ awake       : num  11.9 7 9.6 9.1 20 9.6 15.3 17 13.9 21 ...
 $ brainwt     : num  NA 0.0155 NA 0.00029 0.423 NA NA NA 0.07 0.0982 ...
 $ bodywt      : num  50 0.48 1.35 0.019 600 ...
 
> nrow(sleep)

[1] 83

> ncol(sleep)

[1] 11

> dim(sleep)

[1] 83 11
```

We started this exploration with the command head, which displays the first 6 lines of our dataframe. We followed that by the str command, which is an abbreviation of *str*ucture and displays what our columns are named and what kind of data we have in those columns. Our last three commands are to look at the number of rows, number of columns and dimensions (nrow, ncol, and dim, respectively).

Now that we've loaded and examined the dataframe, we can begin manipulating the data frame using dplyr.



