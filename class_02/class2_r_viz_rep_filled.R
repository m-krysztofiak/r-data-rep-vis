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

data <- read_csv("class_02/Cowles.csv")
test <- read_csv2("class_02/Cowles.csv")

#Cowles dataset
#https://vincentarelbundock.github.io/Rdatasets/doc/carData/Cowles.html

#let's view the data
head(data)
#check the structure of the data
str(data)
#summarize to see descriptive statistics
summary(data)

####DATA CLEANING & WRANGLING####

#####change variable type####
data$sex <- as.factor(data$sex)
data$volunteer <- as.factor(data$volunteer)
str(data)

#####renaming####
#we have variable "rownames" in column 1, let's rename it to "id"
data %>% rename("id" = "rownames") -> data
#new variable name first then the original name
#check column names
head(data)

#####selecting####
#let's select id, extraversion, volunteer and sex
#I'm creating a new df so we can go back to the main one later
data %>%
  select(id, extraversion, volunteer, sex) -> data_extra
head(data_extra)

#or we could just exclude neuroticism
data %>% select(-neuroticism) -> data_extra

#or select defined range of columns (names and numbers)
data %>%
  select(id,extraversion:volunteer) -> data_extra

data %>% select(1,3:5) -> data_extra
#let's check if it worked
head(data_extra)

#####PRACTICE 1#####
#from data select only id, neuroticism and sex
#THEN rename neuroticism to neuroticism_score
#try to do it using "%>%"
#name the new df data_neuro
data %>%
  select(id, neuroticism, sex) %>% 
  rename("neuroticism_score" = "neuroticism") -> data_neuro
  
head(data_neuro)  

####EXPLORE####

#####BARPLOT & FACETS#####

#what's the distribution of extraversion scores? 
#how can we check it with ggplot?
ggplot(data = data_extra, aes(x = extraversion)) + geom_bar()

#how can we see the distribution in volunteers and non-volunteers?
#facet_wrap
ggplot(data = data_extra, aes(x = extraversion)) + geom_bar() +
  facet_wrap(~volunteer)

#facet_grid for two variables: sex and volunteer
#rows ~ columns
ggplot(data = data_extra, aes(x = extraversion)) + geom_bar() +
  facet_grid(sex~volunteer)

#####DESCRPITIVE STATISTICS#####

#How to find the size of each group?
#check "Help" tab (on the bottom-right) for the summarise function 
#scroll to examples and then run examples;
#Is group size anywhere in the output? 
#How was it calculated?

data %>% group_by(volunteer) %>% 
  summarise(n(), mean = mean(extraversion), sd(extraversion))

#we can also group by two variables
data %>% group_by(volunteer, sex) %>% 
  summarise(n(), mean = mean(extraversion), sd(extraversion))

####TWO GEOMS: BOXPLOT and SCATTERPLOT####
ggplot(data = data_extra, aes(x = volunteer, y = extraversion)) +
  geom_boxplot()

#let's add another layer: geom_point
ggplot(data = data_extra, aes(x = volunteer, y = extraversion)) +
  geom_boxplot() + geom_point()

#why are there so few data points? We have 1421 observations.
#what's the default position for geom_point?
#why it could be useful to change it in this case?

ggplot(data = data_extra, aes(x = volunteer, y = extraversion)) +
  geom_boxplot() + geom_point(position = "jitter")

#We can also change the amount of jitter of data points 
#default is 0.4
#let's also make the boxes transparent

ggplot(data = data_extra, aes(x = volunteer, y = extraversion)) +
  geom_boxplot(fill = NA, outlier.shape = NA) + 
  geom_point(position = position_jitter(width = 0.3, heigh = 0.5))

#we can also use a special geom
#geom_jitter
#you can control the size of the data points too!
ggplot(data = data_extra, aes(x = volunteer, y = extraversion)) +
  geom_boxplot(fill = NA, outlier.shape = NA) +
  geom_boxplot() + geom_jitter(width = 0.3, height = 0.5, size = 1)

#####PRACTICE 2#####
#Change the previous plot to show the points *behind* the box plot
#How to color data points by sex (without chaning the boxplot)?
ggplot(data = data_extra, aes(x = volunteer, y = extraversion)) +
  geom_jitter(aes(color = sex), size = 1) +
  geom_boxplot(fill = NA, outlier.shape = NA)

#ggplot() = global mappings
#geom_xxx = local mappings

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
  geom_boxplot() +
  scale_fill_manual(values = c("skyblue2", "#66c2a5"))

#colors in R
colors()

#we can also indicate by group
ggplot(data = data_extra,
       mapping = aes(x = volunteer,y = extraversion, fill = volunteer)) +
  geom_boxplot() +
  scale_fill_manual(values = c("yes" =  "skyblue2", "no" = "#66c2a5"))

#MAKE A COLOR SCHEME
#no = "#3182bd"; yes = "#deebf7" (hex codes)
my_palette <- c("no" = "#3182bd", "yes" = "#deebf7")

ggplot(data = data_extra,
       mapping = aes(x = volunteer,y = extraversion, fill = volunteer)) +
  geom_boxplot() +
  scale_fill_manual(values = my_palette)

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
  geom_point() +
  scale_color_brewer(palette = "Set2")

#scale_color_viridis
#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
#we need to specify that our variable is discrete with "_d"
#"_c" for continuous
#there are different color scales 
#(see Help --> search "scale_color_viridis" --> check option)
ggplot(data = songs, 
       aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point() +
  scale_color_viridis_d()

#scale_color_colorblind()
#https://jrnold.github.io/ggthemes/reference/colorblind.html
ggplot(data = songs, 
       aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point() +
  scale_color_colorblind()

#greyscale
#you can modify the grey value from 0 to 1 (start, end)
ggplot(data = songs, 
       aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point() +
  scale_color_grey(start = .2, end = .7) 

#adding shapes
ggplot(data = songs, 
       aes(x = likeability, 
           y = share_likelihood, 
           color = genre, shape = genre)) +
  geom_point() +
  scale_color_grey(start = .2, end = .7) 

####LEGEND####

#change name
ggplot(data = songs, 
       aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point() +
  scale_color_colorblind(name = "Music Genre")

#remove
ggplot(data = songs, 
       aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point() +
  scale_color_colorblind(guide = "none")

#change legend labels
ggplot(data = songs, 
       aes(x = likeability, y = share_likelihood, color = genre)) +
  geom_point() +
  scale_color_colorblind(name = "Music Genre",
    labels = c("pop" = "Pop",
               "rock" = "Rock",
               "country" = "Country")) 
#first old name then new

####LABELS####
#we can change title, subtitle, x and y and legend name
ggplot(data = songs, 
       aes(x = likeability, 
           y = share_likelihood, 
           color = genre)) +
  geom_point() +
  scale_color_colorblind(labels = c("pop" = "Pop",
                                    "rock" = "Rock",
                                    "country" = "Country")) +
  labs(x = "Sharing Likelihood",
       y = "Likeability",
       title = "Songs' Likeability x Sharing Likelihood",
       color = "Music Genre")


####SAVING####
#save with predefined specifications
#save the select plot in the environment
ggplot(data = songs, 
       aes(x = likeability, 
           y = share_likelihood, 
           color = genre)) +
  geom_point() +
  scale_color_colorblind(labels = c("pop" = "Pop",
                                    "rock" = "Rock",
                                    "country" = "Country")) +
  labs(x = "Sharing Likelihood",
       y = "Likeability",
       title = "Songs' Likeability x Sharing Likelihood",
       color = "Music Genre") -> plot_music
#KEEP
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

#Solution
solution <- ggplot(data = data_extra,aes(x = volunteer,
                                         y = extraversion, 
                                         fill = volunteer)) +
  geom_jitter(aes(shape = sex), 
              color = "#00416d", alpha = .7) + #local mapping for geom_jitter
  geom_boxplot(alpha = .5, outlier.shape = NA) +
  scale_fill_brewer(guide = "none") +
  labs(x = "Volunteer Status", 
       y = "Extraversion Score", 
       shape = "Sex",
       title = "Extraversion Scores and Volunteering")

solution

ggsave("class2_solution.png", solution, dpi = 320, 
       width = 4.5, height = 5)


####COLORBLIND CHECK####
#https://jakubnowosad.com/colorblindcheck/
install.packages("colorblindcheck")
library(colorblindcheck)
palette_check(my_palette, plot = TRUE)
