
install.packages("dplyr")
install.packages("ggplot2")

library(readr)
library(dplyr)
library(ggplot2)


data <- read_csv("sexual violence.csv")
data
#overview of data
head(data)
summary(data)
str(data)
colnames(data)

# Check for missing values
any(is.na(data))

# Identify and remove duplicates
data <- unique(data)
data

colnames(data)[colnames(data) == "Narital status"] <- "Marital status"
data




