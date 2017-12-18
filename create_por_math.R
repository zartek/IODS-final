# Mikael Jumppanen, 21.11.17 
# Logistic regression model exercice data wrangling. 

mathData <- read.csv("Data/student-mat.csv", sep=";")
porData <- read.csv("Data/student-por.csv", sep=";")

dim(math)
dim(por)
str(math)
str(math)

library("dplyr")

# I decided not to join data set but analazy them as separate datasets. Final grade will be categorazided to four levels: low, low_med, med_high, high. 
# First I need to scale all of the numeric variables. Let's also add alcohol use variables to data set

mathData <- mathData %>% mutate(alc_use = (Dalc + Walc)/2) %>% mutate(high_use = alc_use>2) %>%  mutate_if(is.numeric, scale) 

porData <- porData %>% mutate(alc_use = (Dalc + Walc)/2) %>% mutate(high_use = alc_use>2) %>%  mutate_if(is.numeric, scale) 

# Calculate quantiles for finale grade

bins_math <- quantile(mathData$G3)
bins_math

# Calculate quantiles for finale grade

bins_por <- quantile(porData$G3)
bins_por


# create a categorical variable Grade for math and por data

math_grade <- cut(mathData$G3, breaks = bins_math, include.lowest = TRUE, label=c("low","med_low","med_high","high"))

# look at the new factors
math_grade


por_grade <- cut(porData$G3, breaks = bins_por, include.lowest = TRUE, label=c("low","med_low","med_high","high"))

# look at the new factors
por_grade

# add the new categorical values to scaled data

mathData <- data.frame(mathData, math_grade)



porData <- data.frame(porData, por_grade)

write.csv(porData,"por_data.csv", row.names = F)
write.csv(mathData,"math_data.csv", row.names = F)
