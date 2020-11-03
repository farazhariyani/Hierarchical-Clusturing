# import library
library(readxl)

#load dataset
#data <- read_excel(file.choose())  #to choose a file from the system
data <- read_excel("data.xlsx")

summary(data)

# Normalize the data
normalized_data <- scale(data) 

summary(normalized_data)

# Euclidean Distance matrix
d <- dist(normalized_data, method = "euclidean") 

fit <- hclust(d, method = "complete")

# Display dendrogram
plot(fit) 
plot(fit, hang = -1)

groups <- cutree(fit, k = 3) # Cut tree into 3 clusters

rect.hclust(fit, k = 3, border = "red")

membership <- as.matrix(groups)

final <- data.frame(membership, data)

aggregate(data, by = list(final$membership), FUN = mean)

# creating a csv file 
library(readr)
write_csv(final, "HierarchicalClustering.csv")

getwd() #to get path where csv file is stored