#R Data Reporting & Visualization 2026

####PACKAGES####

#install tidyverse and readr package (only once)
#install.packages("tidyverse") #remove # to run
#install.packages("readr")

#load tidyverse package 
#(each time you want to use functions in the package)
library(tidyverse)
library(readr)

####DATASET####

#we will be working on "songs" dataset
#mean ratings of likeability,likelihood of sharing with a friend and cathiness 
#91 songs, including three genres: pop, rock, country
#it's a mock dataset - not real data!

songs <- read_csv("songs.csv")

#check how the df looks like
head(songs)
#check variable types and summarize
str(songs)
summary(songs)

####GGPLOT ESSENTIALS####

#####DATA#####
ggplot(data = songs)

#####MAPPINGS - X and Y axis#####
ggplot(data = songs, 
       mapping = aes(x = likeability, y = share_likelihood))

#####GEOM#####
#geometrical object
#geoms and different variable types

#What is the relationship song's likeability 
#and likelihood of sharing with a friend?

#Scatterplot:
#what is the type of the variables?
ggplot(data = songs, 
       mapping = aes(x = likeability, y = share_likelihood)) +
  geom_point()

#What are the differences in the share_likelihood between three genres of songs?
#Boxplot
#what is the type of the variables?
ggplot(data = songs, 
       mapping = aes(x = genre, y = share_likelihood)) +
  geom_boxplot()

#####PRACTICE 1#####
#Visualize the relationship between song likeability and catchiness
#What draws your attention on the plot?
ggplot(data = songs, 
       mapping = aes(x = likeability, y = catchiness)) +
  geom_point()

#Visualize and compare the distrubution of catchiness in three genres of songs
ggplot(data = songs, 
       mapping = aes(x = genre, y = catchiness)) +
  geom_boxplot()

#Barplot
#only x - categorical
ggplot(data = songs, 
       mapping = aes(x = genre)) +
  geom_bar()

#####STATISTICAL TRANSFORMATION#####
#what's the statistical transformation (stat) for bar plot? (check help)
#what's the default stat for scatterplot?

#there are many geom functions (more than 40)
#and many extensions: https://r-graph-gallery.com/
#we have to think about our data and select an appropriate representation (geom)
#https://www.data-to-viz.com/#explore

####AESTHETIC MAPPING: COLOR and others####

#let's make our plot a bit more communicative
#How to add information on songs' genre to the plot?

ggplot(data = songs, 
       mapping = aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point()

#what appeared on our plot?
#what does it reveal about our data?

#let's do the same for our boxplot
ggplot(data = songs, 
       mapping = aes(x = genre, y = catchiness, fill = genre)) +
  geom_boxplot()

#there are also other aesthetics:
#shape
ggplot(data = songs, 
       mapping = aes(x = likeability, y = share_likelihood, shape = genre)) +
  geom_point()
#size, not advised for discrete variables
ggplot(data = songs, mapping = aes(x = likeability, y = share_likelihood, size = genre)) +
  geom_point()
#alpha (transparency), not advised for discrete variables
ggplot(data = songs, mapping = aes(x = likeability, y = share_likelihood, alpha = genre)) +
  geom_point()
#not every aesthetic works with each geom (shape and boxplot)!
ggplot(data = songs, mapping = aes(x = likeability, y = share_likelihood, size = genre)) +
  geom_boxplot()

####SAVING YOUR PLOT####

ggplot(data = songs, 
       mapping = aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point()

#you can save the list plot...
ggsave("plot.png")

#...or you can also first save your plot in the environment...
ggplot(data = songs, 
       mapping = aes(x = likeability, 
                     y = share_likelihood, 
                     color = genre)) +
  geom_point() -> plot

#...and then save it
#it will be saved in your working directory
ggsave(filename = "plot2.jpg",plot,
       dpi = 320, #resolution
       width = 5.33, height = 4.61,
       units = "in")

#### PRACTICE 2####
#What's wrong with this plot and how to fix it?
ggplot(data = songs,
       mapping = aes(x = likeability, y = share_likelihood)) + 
  geom_boxplot()

#### PRACTICE 3####
#What's wrong with this plot and how to fix it?
ggplot(data = songs,
       mapping = aes(x = likeability, y = share_likelihood, fill = genre)) + 
  geom_point()

#### PRACTICE 4####
#Why are the legends different?
ggplot(data = songs,
       mapping = aes(x = likeability, y = share_likelihood, color = catchiness)) + 
  geom_point()

ggplot(data = songs,
       mapping = aes(x = likeability, y = share_likelihood, color = genre)) + 
  geom_point()

#### PRACTICE 5####
#Why do we have two legends?
ggplot(data = songs,
       mapping = aes(x = likeability, y = share_likelihood, color = genre, 
                     alpha = catchiness)) +
  geom_point()
