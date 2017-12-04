# R tutorial

## Overview

The goal of today will be to learn to manipulate and visualize data using R. To this end, we will be using the package 'tidyverse' that contains two very important tools, dplyr and ggplot2.

dplyr is a grammar of data manipulation, providing a consistent set of verbs that help you solve the most common data manipulation challenges:

-   `mutate()` adds new variables that are functions of existing variables
-   `select()` picks variables based on their names.
-   `filter()` picks cases based on their values.
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
- Option A: Go to `Session -> Set Working Directory -> Choose Directory...` and navigate to the `tidyverse_tutorial-master` folder.

- Option B: Use the `setwd()` command with the system path to the `tidyverse_tutorial-master` folder, like so:
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

#### select
Select is used to select certain columns of the dataframe. With complex dataframes, we may not want to keep all columns, especially if some are less than informative. The format for using select is as follows: `select(dataframe, column_to_select`
```
> select(sleep, name, sleep_total)

                             name sleep_total
1                         Cheetah        12.1
2                      Owl monkey        17.0
3                 Mountain beaver        14.4
4      Greater short-tailed shrew        14.9
5                             Cow         4.0
6                Three-toed sloth        14.4
...

> select(sleep, -conservation, -sleep_rem, -sleep_cycle)

                             name         genus    vore           order sleep_total awake brainwt   bodywt
1                         Cheetah      Acinonyx   carni       Carnivora        12.1 11.90      NA   50.000
2                      Owl monkey         Aotus    omni        Primates        17.0  7.00 0.01550    0.480
3                 Mountain beaver    Aplodontia   herbi        Rodentia        14.4  9.60      NA    1.350
4      Greater short-tailed shrew       Blarina    omni    Soricomorpha        14.9  9.10 0.00029    0.019
5                             Cow           Bos   herbi    Artiodactyla         4.0 20.00 0.42300  600.000
...

> select(sleep, contains('wt'))

   brainwt   bodywt
1       NA   50.000
2  0.01550    0.480
3       NA    1.350
4  0.00029    0.019
5  0.42300  600.000
6       NA    3.850
...

```

#### Filter

Filter is used for removing or selecting rows of a dataframe base on a condition. The formula for using filter is as follows: `filter(dataframe, conditional_statement`

```
> filter(sleep, name == 'Cheetah')

     name    genus  vore     order conservation sleep_total sleep_rem sleep_cycle awake brainwt bodywt
1 Cheetah Acinonyx carni Carnivora           lc        12.1        NA          NA  11.9      NA     50

> filter(sleep, name != 'Cheetah')

                             name         genus    vore           order conservation sleep_total sleep_rem sleep_cycle awake brainwt   bodywt
1                      Owl monkey         Aotus    omni        Primates         <NA>        17.0       1.8          NA  7.00 0.01550    0.480
2                 Mountain beaver    Aplodontia   herbi        Rodentia           nt        14.4       2.4          NA  9.60      NA    1.350
3      Greater short-tailed shrew       Blarina    omni    Soricomorpha           lc        14.9       2.3   0.1333333  9.10 0.00029    0.019
4                             Cow           Bos   herbi    Artiodactyla domesticated         4.0       0.7   0.6666667 20.00 0.42300  600.000
5                Three-toed sloth      Bradypus   herbi          Pilosa         <NA>        14.4       2.2   0.7666667  9.60      NA    3.850
6               Northern fur seal   Callorhinus   carni       Carnivora           vu         8.7       1.4   0.3833333 15.30      NA   20.490
...

> filter(sleep, order == 'Carnivora')

                name        genus  vore     order conservation sleep_total sleep_rem sleep_cycle awake brainwt  bodywt
1            Cheetah     Acinonyx carni Carnivora           lc        12.1        NA          NA  11.9      NA  50.000
2  Northern fur seal  Callorhinus carni Carnivora           vu         8.7       1.4   0.3833333  15.3      NA  20.490
3                Dog        Canis carni Carnivora domesticated        10.1       2.9   0.3333333  13.9  0.0700  14.000
4       Domestic cat        Felis carni Carnivora domesticated        12.5       3.2   0.4166667  11.5  0.0256   3.300
5          Gray seal Haliochoerus carni Carnivora           lc         6.2       1.5          NA  17.8  0.3250  85.000
6              Tiger     Panthera carni Carnivora           en        15.8        NA          NA   8.2      NA 162.564
7             Jaguar     Panthera carni Carnivora           nt        10.4        NA          NA  13.6  0.1570 100.000
8               Lion     Panthera carni Carnivora           vu        13.5        NA          NA  10.5      NA 161.499
9       Caspian seal        Phoca carni Carnivora           vu         3.5       0.4          NA  20.5      NA  86.000
10             Genet      Genetta carni Carnivora         <NA>         6.3       1.3          NA  17.7  0.0175   2.000
11        Arctic fox       Vulpes carni Carnivora         <NA>        12.5        NA          NA  11.5  0.0445   3.380
12           Red fox       Vulpes carni Carnivora         <NA>         9.8       2.4   0.3500000  14.2  0.0504   4.230

> filter(sleep, sleep_total > 12)

                             name        genus    vore           order conservation sleep_total sleep_rem sleep_cycle awake brainwt  bodywt
1                         Cheetah     Acinonyx   carni       Carnivora           lc        12.1        NA          NA  11.9      NA  50.000
2                      Owl monkey        Aotus    omni        Primates         <NA>        17.0       1.8          NA   7.0 0.01550   0.480
3                 Mountain beaver   Aplodontia   herbi        Rodentia           nt        14.4       2.4          NA   9.6      NA   1.350
4      Greater short-tailed shrew      Blarina    omni    Soricomorpha           lc        14.9       2.3   0.1333333   9.1 0.00029   0.019
5                Three-toed sloth     Bradypus   herbi          Pilosa         <NA>        14.4       2.2   0.7666667   9.6      NA   3.850
6                      Chinchilla   Chinchilla   herbi        Rodentia domesticated        12.5       1.5   0.1166667  11.5 0.00640   0.420
...

> filter(sleep, order == 'Carnivora' & sleep_total > 12)

          name    genus  vore     order conservation sleep_total sleep_rem sleep_cycle awake brainwt  bodywt
1      Cheetah Acinonyx carni Carnivora           lc        12.1        NA          NA  11.9      NA  50.000
2 Domestic cat    Felis carni Carnivora domesticated        12.5       3.2   0.4166667  11.5  0.0256   3.300
3        Tiger Panthera carni Carnivora           en        15.8        NA          NA   8.2      NA 162.564
4         Lion Panthera carni Carnivora           vu        13.5        NA          NA  10.5      NA 161.499
5   Arctic fox   Vulpes carni Carnivora         <NA>        12.5        NA          NA  11.5  0.0445   3.380

```

#### Arrange

Arrange sorts the dataframe based on the values of a column. The formula for using arrange is as follows: `arrange(dataframe, column_to_sort_by`

```
> arrange(sleep, brainwt)

                             name         genus    vore           order conservation sleep_total sleep_rem sleep_cycle awake brainwt   bodywt
1       Lesser short-tailed shrew     Cryptotis    omni    Soricomorpha           lc         9.1       1.4   0.1500000 14.90 0.00014    0.005
2                Little brown bat        Myotis insecti      Chiroptera         <NA>        19.9       2.0   0.2000000  4.10 0.00025    0.010
3      Greater short-tailed shrew       Blarina    omni    Soricomorpha           lc        14.9       2.3   0.1333333  9.10 0.00029    0.019
4                   Big brown bat     Eptesicus insecti      Chiroptera           lc        19.7       3.9   0.1166667  4.30 0.00030    0.023
5                      Musk shrew        Suncus    <NA>    Soricomorpha         <NA>        12.8       2.0   0.1833333 11.20 0.00033    0.048
6                     House mouse           Mus   herbi        Rodentia           nt        12.5       1.4   0.1833333 11.50 0.00040    0.022

```

#### Mutate
