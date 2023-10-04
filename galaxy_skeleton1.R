library(tidyverse)
library(ggplot2)
# Skeleton file 1 for Assignment 1 in BAN400. 
# -------------------------------------------

# Comments below describes briefly a set of steps that solves Problem 1.

# Read the entire data file into memory using the readLines()-function. Use the
# URL direcly or read the data from the local file that is in the repository.

raw_data <- readLines("http://www.sao.ru/lv/lvgdb/article/suites_dw_Table1.txt")


# Identify the line number L of the separator line between the column names and
# the rest of the data table.

line_start=substr(x = raw_data, start = 0, stop = 2) #substract first to charakters of each line
L<- which(line_start=="--") %>% 
  min() #choose lines that start with "--" and show the first line where that occurs
L

# Save the variable descriptions (i.e. the information in lines 1:(L-2)) in a
# text-file for future reference using the cat()-function

var_descriptions<- cat(raw_data[1:(L-2)], sep="\n",file="variable_descriptions.txt")

# Extract the variable names (i.e. line (L-1)), store the names in a vector.
var_names<- 
  str_split(string = raw_data[L-1], pattern = "\\|") %>%  #split the row wherever "\\|" occurs
  unlist() %>% 
  str_trim()
var_names

# Read the data. One way to do this is to rewrite the data to a new .csv-file
# with comma-separators for instance using cat() again, with the variable names
# from the step above on the first line (see for instance paste() for collapsing
# that vector to a single string with commas as separators).

comma_separated_values <- 
  raw_data %>% 
  gsub("\\|", ",", .) %>% # replace "\\|" with ,
  gsub(" ", "", .) 

comma_separated_values_with_names <- 
  c(paste(var_names, collapse = ","), #put together variable names and data
    comma_separated_values) 

cat(comma_separated_values_with_names, sep = "\n", file = "data_clean.csv") #save in csv file

# Read the finished .csv back into R in the normal way.
data_clean <-read.csv("data_clean.csv")


#PROBLEM 3------
#Graph which shows that smaller galaxies are underrepresented
data_clean %>% 
  slice(15:1000) %>% #exlcuding the first 14 rows with only text data
  group_by(a_26) %>%
  ggplot(aes(x=a_26))+
  geom_bar(fill="blue",width = 0.5) #bar chart shows that small diameters are represented
#Maybe i didnt get the question, but i dont see how smaller objects are underrepresented here

#PROBLEM 4------
#Task 1-----

#read file using url
expansion_data <- readLines("https://www.sao.ru/lv/lvgdb/article/UCNG_Table4.txt")

#extract first to characters of each line
line_start_exp=substr(x = expansion_data, start = 0, stop = 2)

#show first line that starts with "--"
L_exp<- which(line_start_exp=="--") %>% 
  min() #choose lines that start with "--" and show the first line where that occurs
L_exp


# Extract the variable names (i.e. line (L-1)), store the names in a vector.
expansion_var_names<- 
  str_split(string = expansion_data[L_exp-1], pattern = "\\|") %>%  #split the row wherever "\\|" occurs
  unlist() %>% 
  str_trim()
expansion_var_names


expansion_comma_separated_values <- 
  expansion_data %>% 
  gsub("\\|", ",", .) %>% # replace "\\|" with ,
  gsub(" ", "", .) 

expansion_comma_separated_values_with_names <- 
  c(paste(expansion_var_names, collapse = ","), #put together variable names and data
    expansion_comma_separated_values) 

#create csv file
cat(expansion_comma_separated_values_with_names, sep = "\n", file = "expansion_clean.csv") #save in csv file

# Read the finished .csv back into R in the normal way.
expansion_data_clean <-read.csv("expansion_clean.csv")


#join datasets together
combined_data<-left_join(data_clean,expansion_data_clean,by="name")

#scatterplot of velocity against distance
combined_data %>% 
  ggplot(aes(x=cz,y=D))+
  geom_point()













