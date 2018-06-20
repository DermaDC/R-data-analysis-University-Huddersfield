#Analysing data

#Installing Tidyverse
install.packages("tidyverse")

#Load the library
library("tidyverse")

#Load the surveys data again (more felixibility with read_csv instead of read.csv)
surveys <- read_csv("data/portal_data_joined.cvs")
str(surveys)

head(surveys) #shows tibble which only lets you see the dataframe that fits in your window to avoid too much info
colnames(surveys)

#Use square bracket subsetting to select rows from 1978 only
surveys[surveys$year=="1978", ]
#or
#dplyr - for data manipulation
#filter - used to select rows - in dplyr:
filter(surveys, year == 1978)

#Select - for selecting columns
select(surveys, year, plot_id, species_id)

#select only the three columns above but only from 1978
surveys_filtered <- filter(surveys, year == 1978)
surveys_filtered
select (surveys_filtered, year, plot_id, species_id)
#or
#stitching together with a pipe
# %>% - shortcut to type a pipe is shift-ctrl-m (same as pipe in Shell)
surveys %>% filter(year == 1978) %>% select(year, plot_id, species_id)

#to save this: 
surveys_short <- surveys %>% filter(year == 1978) %>% select(year, plot_id, species_id)

# Mutate - to create new columns based on existing columns or on some operations done on existing columns
surveys %>% select(weight, species)

#calculate the weight from g to kg
surveys %>% mutate(weight_kg = weight/1000) %>% select(starts_with("w"))

#Challenge 1

#Create a new data frame from surveys that contains:
#only species_id column and a new column called hindfoot_half containing half values from column hindfoot_length. All the values in hindfoot_half should be smaller than 30.

surveys %>% mutate(hindfoot_half = hindfoot_length/2) %>% filter(hindfoot_half < 30) %>% select(species_id, hindfoot_half)

#how to remove missing observations
surveys %>% mutate(weight_kg = weight/1000) %>% select(starts_with("w")) %>% filter(!is.na(weight)) #filters out rows in column weight that are not NA (missing data)

#other functions to remove missing data (NA)
?complete cases 
?na.omit 
?na.rm = TRUE

#how to have a summary overview of a dataset
table(surveys$year)

length(table(surveys$year))

range (surveys$year) #gives the first and las  nt value of the selected column

summary(surveys) # for each column

#splitting and running calculations on groups
surveys %>% group_by(year) %>% summarise(mean_hindfoot_length = mean(hindfoot_length))
#need to remove NA before calculating average - na.rm = TRUE
surveys %>% group_by(year) %>% summarise(mean_hindfoot_length = mean(hindfoot_length, na.rm = TRUE))

surveys %>% group_by(sex, species_id)
surveys %>% filter(!is.na(weight)) %>% group_by(sex, species_id) %>% summarise(mean_weight = mean(weight))

surveys %>% filter(!is.na(weight)) %>% group_by(sex, species_id) %>% summarise(mean_weight = mean(weight), sd_weight = sd(weight))
# calculate standard deviation - sd()

surveys %>% count(sex, species) %>% print(n=81) #print() shows all lines, not just tibble
surveys %>% count(species, sort = TRUE) #sort=TRUE gives the list of species in a descending number order

#arrange - used to arrange/sort rows
surveys %>% count(sex, species) %>% arrange(species, desc(n))

#Challenge 2
#How many individuals were caught in each plot_type? Answer in 2 ways, using group by and count
surveys %>% count(plot_type)
surveys %>% group_by(plot_type) %>% tally()

#Challenge 3
#What is the heaviest animal measured in each year? Return columns year, genus, species_id and weight. DO not return missing observations.
surveys %>% filter(!is.na(weight)) %>% group_by(year) %>% select(year, species_id, genus, weight) #my try - incomplete

#jarek's try:
surveys %>% filter(!is.na(weight)) %>% group_by(year) %>% summarise(max_weight = max(weight)) 
surveys %>% filter(!is.na(weight)) %>% group_by(year) %>% filter(weight == max(weight)) %>% select(year, species_id, genus, weight) %>% arrange(desc(weight))




surveys_complete <- surveys %>% filter(!is.na(weight), !is.na(hindfoot_length), !is.na(sex))

#keep species for which there are at least 50 observations
species_count <- surveys_complete %>% count (species_id) %>% filter(n >= 50)
#or just 1000 observations
num_surveys_complete <- surveys_complete %>% count(species_id) %>% filter(n>=1000)
#go through surveys_complete and only find the species selected innum_species_complete
surveys_complete %>% filter(species_id %in% num_surveys_complete$species_id)  

#reduce the surveys_complete object so that it only contains species with at leat 50 observations (in species_counts)
surveys_complete <- surveys_complete %>% filter(species_id %in% species_count$species_id) #%in% does the command for all different species
dim(surveys_complete) 

write.csv(surveys_complete, "data/surveys_complete.cvs")


animals <- c("pig", "cat", "dog", "donkey", "gorilla", "mouse", "zebra", "parrot", "camel")
animals
other_animals <- c("zebra", "parrot", "donkey", "camel", "cat")
animals

animals %in% other_animals #shows if each element of the 1st group is present (TRUE) or absent (FALSE) in 2nd group
other_animals %in% animals

intersect(animals, other_animals) #shows common elements of both groups
