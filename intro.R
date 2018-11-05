library(tidyverse)

setwd('~/Dropbox/sarah/tidyverse_tutorial/')
list.files()

#################################################
#
#     Load data and quick examination
#
#################################################

# Load the data
sleep <- read_csv('msleep.csv')

# Examine the data
head(sleep)
str(sleep)

nrow(sleep)
ncol(sleep)
dim(sleep)

#################################################
#
#     Dataframe manipulation
#
#################################################

# Select cetain columns of the dataframe
head(sleep)

select(sleep, name, sleep_total)

select(sleep, -conservation, -sleep_rem, -sleep_cycle)

select(sleep, contains('wt'))

# Filtering rows from the dataframe

filter(sleep, name == 'Cheetah')

filter(sleep, name != 'Cheetah')

filter(sleep, order == 'Carnivora')

filter(sleep, sleep_total > 12)

filter(sleep, order == 'Carnivora' & sleep_total > 12)

# Arranging the data

arrange(sleep, brainwt)

# Adding columns using mutate

mutate(sleep, total_time = sleep_total + awake)

mutate(sleep, brain_to_body_ratio = brainwt / bodywt)

# Combining commands using pipe (%>%)

sleep %>%
  select(name, vore, sleep_total) %>%
  filter(vore == 'carni') %>%
  arrange(-sleep_total)

# To do the same without pipe, you would have to:

df1 <- select(sleep, name, vore, sleep_total)

df1 <- filter(df1, vore == 'carni')

arrange(df1, -sleep_total)

#################################################
#
#     Visualizing the data with ggplot
#
#################################################

# What is the relationship between -vore status and total sleep?
df1 <- sleep %>%
  select(name, vore, sleep_total) %>%
  filter(!is.na(vore) & vore != 'omni')

ggplot(data = df1, aes(x = vore, y = sleep_total)) +
  geom_boxplot()

df1 %>%
  filter(vore == 'insecti')

# What is the relationship between body weight and total sleep?
ggplot(sleep, aes(sleep_total, bodywt)) +
  geom_point(aes(color = vore))

ggplot(sleep, aes(sleep_total, bodywt)) +
  geom_point(aes(color = vore)) +
  scale_y_continuous(trans = 'log2')

ggplot(sleep, aes(sleep_total, bodywt)) +
  geom_point(aes(color = vore)) +
  geom_smooth(method = 'lm') +
  scale_y_continuous(trans = 'log2')

ggplot(sleep, aes(sleep_total, bodywt)) +
  geom_point(aes(color = vore), size = 3) +
  stat_smooth(method = 'lm', fullrange = T) +
  scale_x_continuous('Total sleep',
                     limits = c(0, 24),
                     breaks = c(0,6,12,18,24),
                     expand = c(0,0)) +
  scale_y_continuous(trans = 'log2') +
  ggtitle('Relationship between weight and sleep') +
  theme_classic()

model <- lm(formula = sleep$sleep_total ~ sleep$bodywt)

summary(model)

# How does sleep time of Round-tailed muskrat compared to other rodentia members?
df2 <- sleep %>%
  filter(order == 'Rodentia') %>%
  mutate(name = reorder(name, -sleep_total)) %>%
  mutate(muskrat = ifelse(name == 'Round-tailed muskrat', 'Yes', 'No')) %>%
  select(name, order, sleep_total, muskrat)

ggplot(df2, aes(name, sleep_total, fill = muskrat)) +
  geom_bar(stat = 'identity') +
  scale_fill_manual(values = c('grey50', 'red')) +
  scale_y_continuous('Total sleep (hours)',
               expand = c(0,0)) +
  ggtitle('Sleepy rodents') +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5),
        legend.position="none")



#################################################
#
#     Try out these methods on the movies dataset
#
#################################################

### Questions to answer

# What is the top rated movie of the 1990s?

# Is there a correlation between movie budget and rating?

# What is the top rated Comedy of the 1980s with at least 10 votes? What about Action film?

