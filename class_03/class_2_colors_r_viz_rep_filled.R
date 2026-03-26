#Class 3 (cont. of class 2): Colors and Legends

####PACKAGES####
#install.packages("tidyverse")
library(tidyverse)
#install.packages("ggthemes")
library(ggthemes) #extra themes, scales and geoms for ggplot2
#install.packages("viridis")
library(viridis) #color scales

####IMPORT THE DATASETS####
cowles <- read_csv("class_02/cowles.csv")

#FREE DATA FROM WORLD BANK VIA GAPMINDER.ORG
#only for 2007
gapminder_07 <- read_csv("class_03/gapminder_2007.csv")

####What's wrong with this code?####
ggplot(gapminder_07, 
       aes(x = volunteer, y = extraversion)) +
  geom_jitter(color = sex, size = 1) +
  geom_boxplot(fill = NA, outlier.shape = NA) +
  scale_fill_manual(values = c("female" = "#5773CCFF", 
                               "male" = "#FFB900FF"))
#Solution
#(1) aes missing from geom_jitter
#(2) wrong scale - "fill" instead of "manual"
ggplot(cowles, 
       aes(x = volunteer, y = extraversion)) +
  geom_jitter(aes(color = sex), size = 1) +
  geom_boxplot(fill = NA, outlier.shape = NA) +
  scale_color_manual(values = c("female" = "#5773CCFF", 
                               "male" = "#FFB900FF"))
####SCALES - COLORS####
#each mapping (x,y,fill) is associated with it's own scale
#and we can modify their parameters or replace the scale
ggplot(cowles, 
       aes(x = volunteer, y = extraversion, fill = volunteer)) +
  geom_boxplot() +
  scale_x_discrete() + 
  scale_y_continuous() +
  scale_fill_discrete() 
#name depends on the aesthetic mapping and variable type

#ASSIGN COLORS MANUALLY
#name -- check colors()
#or HEX code (RGB colors) 
#e.g.,https://www.w3schools.com/colors/colors_picker.asp
#e.g, skyblue2 and #66c2a5

ggplot(cowles,
       aes(x = volunteer, y = extraversion, fill = volunteer)) +
  geom_boxplot() +
  scale_fill_manual(values = c("skyblue2", "#66c2a5"))

#colors in R
colors()

#we can also indicate by group
ggplot(cowles,
       aes(x = volunteer, y = extraversion, fill = volunteer)) +
  geom_boxplot() +
  scale_fill_manual(values = c("yes" =  "skyblue2", "no" = "#66c2a5"))

#MAKE A COLOR SCHEME
#no = "#3182bd"; yes = "#deebf7" (hex codes)
my_palette <- c("no" = "#3182bd", "yes" = "#deebf7")

ggplot(cowles,
       aes(x = volunteer,y = extraversion, fill = volunteer)) +
  geom_boxplot() +
  scale_fill_manual(values = my_palette)

#READY COLOR PALETTES
#scale_color_brewer
#https://colorbrewer2.org/#type=qualitative&scheme=Paired&n=3
#other palettes available
ggplot(gapminder_07, #gapminder
       aes(x = lifeExp, y = gdpPercap, color = continent)) +
  geom_point() +
  scale_color_brewer(palette = "Accent")

#scale_color_viridis
#https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
#we need to specify that our variable is discrete with "_d"
#"_c" for continuous
#there are different color scales 
#(see Help --> search "scale_color_viridis" --> check option)
ggplot(gapminder_07, #gapminder
       aes(x = lifeExp, y = gdpPercap, color = continent)) +
  geom_point() +
  scale_color_viridis_d()

#scale_color_colorblind()
#https://jrnold.github.io/ggthemes/reference/colorblind.html
ggplot(gapminder_07, #gapminder
       aes(x = lifeExp, y = gdpPercap, color = continent)) +
  geom_point() +
  scale_color_colorblind()

#greyscale
#you can modify the grey value from 0 to 1 (start, end)
ggplot(gapminder_07, #gapminder
       aes(x = lifeExp, y = gdpPercap, color = continent)) +
  geom_point() +
  scale_color_grey(start = .2, end = .7) 

#adding shapes
ggplot(gapminder_07, #gapminder
       aes(x = lifeExp, y = gdpPercap, 
           color = continent,
           shape = continent)) +
  geom_point() +
  scale_color_grey(start = .2, end = .7) 

#paleteer
#https://github.com/EmilHvitfeldt/paletteer?tab=readme-ov-file
#https://r-graph-gallery.com/color-palette-finder
arcadia = c("#FED789FF", "#023743FF", 
            "#72874EFF", "#476F84FF",
            "#A4BED5FF", "#453947FF")

ggplot(gapminder_07,
       aes(x = lifeExp, y = gdpPercap, 
           color = continent)) +
  geom_point() +
  scale_color_manual(values = arcadia) 

####COLORBLIND CHECK####
#https://jakubnowosad.com/colorblindcheck/
#install.packages("colorblindcheck")
library(colorblindcheck)
palette_check(arcadia, plot = TRUE)

#####PRACTICE####
#use gapminder_07 df
#compare the distrubution of gdpPercap between 5 continents
#display datapoints for countries
#show each continent in a different color
#make datapoints the same color as their continent
#avoid overplotting

palette = c("#024873FF", "#A2A637FF",
            "#D9AA1EFF", "#D98825FF", "#BF4F26FF")

ggplot(gapminder_07, aes(x = continent, y = gdpPercap)) +
  geom_jitter(aes(color = continent), alpha = .5) +
  geom_boxplot(aes(fill = continent), alpha = .5, outlier.shape = NA) + 
  scale_fill_manual(values = palette) +
  scale_color_manual(values = palette)

####LEGEND####

#change name
ggplot(gapminder_07,
       aes(x = lifeExp, y = gdpPercap, 
           color = continent)) +
  geom_point() +
  scale_color_viridis_d(name = "Continent")

#remove
ggplot(gapminder_07,
       aes(x = lifeExp, y = gdpPercap, 
           color = continent)) +
  geom_point() +
  scale_color_viridis_d(guide = "none")

#change legend labels
ggplot(gapminder_07, #gapminder
       aes(x = lifeExp, y = gdpPercap, 
           color = continent)) +
  geom_point() +
  scale_color_colorblind(name = "Continent",
    labels = c("Africa" = "AF", "Americas" = "NA&SA")) 
#first old name then new

####LABELS####
#we can change title, subtitle, x and y and legend name
ggplot(gapminder_07, #gapminder
       aes(x = lifeExp, y = gdpPercap, 
           color = continent)) +
  geom_point() +
  labs(x = "Life Expectancy",
       y = "GDP per capita",
       title = "Life Expectancy x GDP per capita",
       color = "Continent")

####SAVING####
#save with predefined specifications
ggsave(filename = "plot_03.jpg", plot,
       dpi = 320, #resolution
       width = 5.33, height = 4.61,
       units = "in")