library(tidyverse)

setwd('~/Dropbox/sarah/tidyverse_tutorial/')

# Read in the data we want to analyze
movies <- read.csv('movies.csv')
sleep <- read.csv('msleep.csv')

# Look at the top of our dataframe
head(sleep)
head(movies)

# Look at the columns of our dataframe
str(sleep)

