#hot to plot with ggplot2

ggplot(data = surveys_complete) #nothing really happens, it just takes in the data
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))+ geom_point()

survey_plot <- ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length)) #save the data in one object, then you just use that to add GEOM
# example - surveys_plot + geom_point()

#20.06.2018 - continue ggplot

library("tidyverse")

#ggplot needs data
#ggplot needs aesthaetics or mapping of variables from the plot
#ggplot needs visualisation type of data

ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))+ geom_point()
#results in a plot wih 34K points

#make points tranparent  - use alpha in geom point
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))+ geom_point(alpha = 0.1, colour = "blue")

#colour different species - change aesthaetics inside geom
ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))+ geom_point(alpha = 0.1, aes(color = species_id)) 

#new type of graph - box plot 
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight))+ geom_boxplot() 
ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length))+ geom_boxplot() + geom_jitter(alpha = 0.1, colour = "tomato")
#jitter helps visualise when you have large number of points

yearly_counts <- surveys_complete %>% group_by(year, species_id) %>% tally()
surveys_complete %>% group_by(year, species_id) %>% tally()

yearly_counts
ggplot(data = yearly_counts, mapping =aes(x = year, y = n)) + geom_line() #counted total number observ per year
#we want to see it for each different species
ggplot(data = yearly_counts, mapping =aes(x = year, y = n, group = species_id)) + geom_line()
#need some colour to distinguish beteen species
ggplot(data = yearly_counts, mapping =aes(x = year, y = n, colour = species_id)) + geom_line()

#faceting - splitting display of data into multiple subgroups (multiple graphs blotted together) - facet_wrap (~X)
ggplot(data = yearly_counts, mapping =aes(x = year, y = n)) + geom_line() + facet_wrap(~species_id)

yearly_sex_counts <- surveys_complete %>% group_by(year, species_id, sex) %>% tally()
yearly_sex_counts
ggplot(data = yearly_sex_counts, mapping =aes(x = year, y = n, colour = sex)) + geom_line() + facet_wrap(~species_id)

#add title in figure
ggplot(data = yearly_sex_counts, mapping =aes(x = year, y = n, colour = sex)) + geom_line() + facet_wrap(~species_id) + ggtitle("Species counts over time")

#add labels - labs function
ggplot(data = yearly_sex_counts, mapping =aes(x = year, y = n, colour = sex)) + geom_line() + facet_wrap(~species_id) + labs(title = "Speices counts over time", x = "Year of observation", y = "Number of species")

#theme - change orientation of x labels
ggplot(data = yearly_sex_counts, mapping =aes(x = year, y = n, colour = sex)) + geom_line() + facet_wrap(~species_id) + labs(title = "Species counts over time", x = "Year of observation", y = "Number of species") + theme(axis.text.x = element_text(angle = 45)) 

ggsave("data/my_fancy_plot.tiff", width = 15, height = 10, dpi = 300)
