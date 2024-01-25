
install.packages("ggplot2")
library(ggplot2)
install.packages("dplyr")
library(dplyr)
library(readr)
library(usethis)
use_git()

data <- read_csv("sexual violence.csv")
data

#overview of data
head(data)
summary(data)
colnames(data)

# Check for missing values
any(is.na(data))

# Identify and remove duplicates
data <- unique(data)
colnames(data)[colnames(data) == "Narital status"] <- "Marital status"
data

