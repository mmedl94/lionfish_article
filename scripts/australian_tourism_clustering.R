library(tourr)
library(lionfish)
library(flexclust)
library(stats)
library(dplyr)

data("ausActiv")
ausActiv <- ausActiv[rowSums(ausActiv) > 0 & rowSums(ausActiv) <= 40, ]
set.seed(1234)

# Figure 11
dist_matrix_f <- dist(t(ausActiv), method="binary")
ward_cluster_f <- hclust(dist_matrix_f, "ward.D2")
plot(ward_cluster_f)

clusters_f <- cutree(ward_cluster_f, k = 15)
plot(ward_cluster_f, main = "Dendrogram of Australian Vacation Activities",
     sub = "", xlab = "", ylab = "Height")
rect_info <- rect.hclust(ward_cluster_f, k = 15, border = 2:16)