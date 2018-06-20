#Downloading data
download.file("https://ndownloader.figshare.com/files/2292169", "data/portal_data_joined.cvs")

#Load the data
surveys <- read.csv("data/portal_data_joined.cvs")

#Examine the first 6 lines
head(surveys)

#Structure 
str(surveys)

#Indexing and subsettings
surveys [1,1] #first element in first column
surveys [1, 6] #first element in 6 column
surveys [1:3, 7] #first 3 elements in the 7 column
surveys [ ,1] #all values in first column
surveys [8:11, ] #all values in rows 8 to 11

#Create a data.frame (surveys_200) containing only the data in row 200 of the surveys dataset
surveys_200 <- surveys [200, ]

#number of rows
nrow(surveys)

#Create a new data frame (surveys_last) from that last row.
n_rows <- nrow(surveys)
surveys_last <- surveys ["n_rows", ]

#Use nrow() to extract the row that is in the middle of the data frame. Store the content of this row in an object named surveys_middle
middle_row <- nrow(surveys)/2
surveys_middle <-  surveys["middle row", ]

#Combine nrow() with the - notation above to reproduce the behavior of head(surveys), keeping just the first through 6th rows of the surveys dataset
surveys_head <- surveys [-(7:n_rows), ]
