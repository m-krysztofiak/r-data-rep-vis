#Class 2: Visualizing Distributions, Colors and Legends

####PACKAGES####
#install.packages("tidyverse")
library(tidyverse)
#install.packages("ggthemes")
library(ggthemes) #extra themes, scales and geoms for ggplot2
#install.packages("viridis")
library(viridis) #color scales

####IMPORT THE DATASET####

#how to check the format of the dataset within RStudio?
#"Files" tab (bottom right window) --> Click on the file --> View
#for Cowles the separator is ","
#read_csv (separator "," and decimal point ".")
#read_csv2 (separator ";" and decimal point ",")

#Cowles dataset
#https://vincentarelbundock.github.io/Rdatasets/doc/carData/Cowles.html

#let's view the data

#check the structure of the data

#summarize to see descriptive statistics


####DATA CLEANING & WRANGLING####

#####change variable type####


#####renaming####
#we have variable "rownames" in column 1, let's rename it to "id"

#new variable name first then the original name
#check column names


#####selecting####
#let's select id, extraversion, volunteer and sex
#I'm creating a new df so we can go back to the main one later


#or we could just exclude neuroticism


#or select defined range of columns (names and numbers)


#let's check if it worked

#####PRACTICE 1#####
#from data select only id, neuroticism and sex
#THEN rename neuroticism to neuroticism_score
#try to do it using "%>%"
#name the new df data_neuro


####EXPLORE####

#####BARPLOT & FACETS#####
#what's the distribution of extraversion scores? 
#(step 1) how can we check it with ggplot?
#(step 2) distribution in volunteers and non-volunteers?
#(step 3) distribution in volunteers and non-volunteers and males and females?


#####DESCRPITIVE STATISTICS#####
#How to find the size of each group?
#check "Help" tab (on the bottom-right) for the summarise function 
#scroll to examples and then run examples;
#Is group size anywhere in the output? 
#How was it calculated?


####TWO GEOMS: BOXPLOT and SCATTERPLOT####
#(step 1) simple boxplot
#(step 2) add another layer: geom_point
#(step 3) display all datapoints (position = jitter)
#(step 4) change the amount of jitter (default = 0.4)
#(step 5) make the boxes transparent, supress outlier display
#(step 6) geom_jitter() and change datapoints' size


#####PRACTICE 2#####
#Change the previous plot to show the points *behind* the box plot
#How to color data points by sex (without chaning the boxplot)?


####SCALES - COLORS####

#let's go back to our simple boxplot
#we will assign color to each volunteer group
#each mapping (x,y,fill) is associated with it's own scale
#and we can modify their parameters or replace the scale
ggplot(data = data_extra,
       mapping = aes(x = volunteer,y = extraversion, fill = volunteer)) +
  geom_boxplot() +
  scale_x_discrete() + 
  scale_y_continuous() +
  scale_fill_discrete() 
#name depends on the aesthetic mapping and variable type

#ASSIGN COLORS MANUALLY
#name -- check colors()
#or HEX code (RGB colors) e.g., https://html-color-codes.info/
#https://www.w3schools.com/colors/colors_picker.asp
#e.g, skyblue2 and #66c2a5
ggplot(data = data_extra,
       mapping = aes(x = volunteer,y = extraversion, fill = volunteer)) +
  geom_boxplot()

#colors in R
colors()

#we can also indicate by group
ggplot(data = data_extra,
       mapping = aes(x = volunteer,y = extraversion, fill = volunteer)) +
  geom_boxplot()

#MAKE A COLOR SCHEME
#no = "#3182bd"; yes = "#deebf7" (hex codes)
ggplot(data = data_extra,
       mapping = aes(x = volunteer,y = extraversion, fill = volunteer)) +
  geom_boxplot()

#####PRACTICE 3####
#make your own color scheme for males and females
#make a boxplot 
#show sex on x axis and extraversion on y

#READY COLOR PALETTES
#back to the songs data
read_csv("songs.csv") -> songs

#scale_color_brewer
#https://colorbrewer2.org/#type=qualitative&scheme=Paired&n=3
#other palettes available
ggplot(data = songs, 
       aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point()

#scale_color_viridis
#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
#we need to specify that our variable is discrete with "_d"
#"_c" for continuous
#there are different color scales 
#(see Help --> search "scale_color_viridis" --> check option)
ggplot(data = songs, 
       aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point()

#scale_color_colorblind()
#https://jrnold.github.io/ggthemes/reference/colorblind.html
ggplot(data = songs, 
       aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point()

#greyscale
#you can modify the grey value from 0 to 1 (start, end)
#add shapes
ggplot(data = songs, 
       aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point()

####LEGEND####
#change name
ggplot(data = songs, 
       aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point() +
  scale_color_colorblind()

#remove
ggplot(data = songs, 
       aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point() +
  scale_color_colorblind()

#change legend labels
ggplot(data = songs, 
       aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point() +
  scale_color_colorblind()

####LABELS####
#we can change title, subtitle, x and y and legend name
ggplot(data = songs, 
       aes(x = likeability, 
           y = share_likelihood, 
           color = genre)) +
  geom_point()

####SAVING####
#save the previous plot in the environment
#save with predefined specifications

ggsave(filename = "plot_music.jpg",plot_music,
       dpi = 320, #resolution
       width = 5.33, height = 4.61,
       units = "in")

####PRACTICE 4####

#Tweak the plot:
#map sex to the shape
#try to color all datapoints
#BUT do not assign the color to any of the variables
#fill (don't color) the boxes (you can select the colors)
#change transparency of the datapoints
#change transparency of the boxes
#remove the legend for the volunteer status
#change the labels of the x,y-axis and legend
#add a title to the plot
#save the plot

ggplot(data = data_extra,aes(x = volunteer,
                             y = extraversion)) +
  geom_jitter() +
  geom_boxplot()

####COLORBLIND CHECK####
#https://jakubnowosad.com/colorblindcheck/
install.packages("colorblindcheck")
library(colorblindcheck)
palette_check(my_palette, plot = TRUE)
