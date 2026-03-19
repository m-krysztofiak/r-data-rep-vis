#R Data Reporting & Visualization 2026

####PACKAGES####

#install tidyverse and readr package (only once)
#install.packages("tidyverse") #remove # to run
#install.packages("readr")

#load tidyverse package 
#(each time you want to use functions in the package)


####DATASET####

#we will be working on "songs" dataset
#mean ratings of songs' likeability,
#likelihood of sharing with a friend and cathiness 
#91 songs, including three genres: pop, rock, country
#it's a mock dataset - not real data!


#check how the df looks like

#check variable types and summarize



####GGPLOT ESSENTIALS####

#####DATA#####


#####MAPPINGS - X and Y axis#####


#####GEOM#####
#geometrical object
#geoms and different variable types

#What is the relationship between song likeability 
#and likelihood of sharing with a friend?

#Scatterplot:
#what is the type of the variables?

#What are the differences in the share_likelihood between three genres of songs?
#Boxplot
#what is the type of the variables?

#####PRACTICE 1#####
#Visualize the relationship between song likeability and catchiness
#What draws your attention on the plot?


#Visualize and compare the distrubution of catchiness in three genres of songs


#Barplot
#only x - categorical

#####STATISTICAL TRANSFORMATION#####
#what's the statistical transformation (stat) for bar plot? (check help)
#what's the default stat for scatterplot?

#there are many geom functions (more than 40)
#and many extensions: https://r-graph-gallery.com/
#we have to think about our data and select an appropriate representation (geom)
#https://www.data-to-viz.com/#explore

####AESTHETIC MAPPING: COLOR and others####

#Let's make our plot a bit more communicative
#How to add information on songs' genre to the plot?


#what appeared on our plot?
#what does it reveal about our data?

#let's do the same for our boxplot


#there are also other aesthetics:
#shape

#size, not advised for discrete variables

#alpha (transparency), not advised for discrete variables

#not every aesthetic works with each geom (shape and boxplot)!


####SAVING YOUR PLOT####


#you can save the list plot...

#...or you can also first save your plot in the environment...

#...and then save it
#it will be saved in your working directory
#dpi is resolution, width, height, units

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
