library(tidyverse)
# Skeleton file 1 for Assignment 1 in BAN400. 
# -------------------------------------------

# Comments below describes briefly a set of steps that solves Problem 1.

# Read the entire data file into memory using the readLines()-function. Use the
# URL direcly or read the data from the local file that is in the repository.

raw_data <- readLines("http://www.sao.ru/lv/lvgdb/article/suites_dw_Table1.txt")
head(raw_data,25)


# Identify the line number L of the separator line between the column names and
# the rest of the data table.

line_start=substr(x = raw_data, start = 0, stop = 2)
L<- which(line_start=="--") %>% 
  min(L)
L

# Save the variable descriptions (i.e. the information in lines 1:(L-2)) in a
# text-file for future reference using the cat()-function

var_descriptions<- cat(raw_data[1:(L-2)], sep="\n",file="variable_descriptions.txt")

# Extract the variable names (i.e. line (L-1)), store the names in a vector.
var_names<- 
  str_split(string = raw_data[L-1], pattern = "\\|") %>% 
  unlist() %>% 
  str_trim()
var_names

# Read the data. One way to do this is to rewrite the data to a new .csv-file
# with comma-separators for instance using cat() again, with the variable names
# from the step above on the first line (see for instance paste() for collapsing
# that vector to a single string with commas as separators).

comma_separated_values <- 
  raw_data %>% 
  gsub("\\|", ",", .) %>% 
  gsub(" ", "", .)

comma_separated_values_with_names <- 
  c(paste(var_names, collapse = ","),
    comma_separated_values) 

cat(comma_separated_values_with_names, sep = "\n", file = "data_clean.csv")

# Read the finished .csv back into R in the normal way.
data_clean <-read.csv("data_clean.csv")



