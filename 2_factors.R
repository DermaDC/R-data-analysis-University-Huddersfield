# Factors
sex <- factor(c("male", "female", "female", "male"))
levels(sex)
nlevels(sex)

#plot of females captured against males (in surveys)
plot(surveys$sex)

#create a subset of the sex data
sex <- surveys$sex
levels(sex)

#overwrite the missing label in "Sex"
levels(sex)[1] <- "Undetermined"
levels(sex)
plot(sex)
#Change lablrd F to Female and M to Male
levels(sex) [2] <- "Female"
levels(sex)
levels(sex)[3] <- "Male"
levels(sex)
#or both labels at once
levels(sex)[2:3] <- c("Female", "Male")
levels(sex)
plot(sex)

#re-order the position of the factors to put "undetermined" last
sex <- factor(sex, levels = c("Female", "Male", "Undetermined"))
plot(sex)
