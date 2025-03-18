library(tourr)
library(flexclust)
library(lionfish)

# perform initial k-means clustering
set.seed(1234)
data(winterActiv)
clusters_full = stepcclust(winterActiv, k=6, nrep=20,  save.data=TRUE)

# Figure 6 A
init_env()
obj1 <- list(type = "heatmap", obj = c("Intra cluster fraction"))
interactive_tour(data=winterActiv,
                 plot_objects = list(obj1),
                 feature_names= colnames(winterActiv),
                 preselection = clusters_full@cluster,
                 n_subsets = 6,
                 display_size = 7)

# Figure 6 B
init_env()
obj1 <- list(type = "heatmap", obj = c("Intra feature fraction"))
interactive_tour(data=winterActiv,
                 plot_objects = list(obj1),
                 feature_names= colnames(winterActiv),
                 preselection = clusters_full@cluster,
                 n_subsets = 6,
                 color_scale = "coolwarm",
                 display_size = 7)


# Figure 7 A
plot(Silhouette(clusters_full))

# Figure 7 B
winterActiv_features <- read.csv("saves/aut_saves/init/feature_selection.csv",
                                 header = FALSE)
winterActiv_feat_subset <- winterActiv[, colnames(winterActiv) %in% winterActiv_features$V1]
clusters_feat_subset = stepcclust(winterActiv_feat_subset, k=6, nrep=20,  save.data=TRUE)
plot(Silhouette(clusters_feat_subset))

tab <- table(clusters_full@cluster, clusters_feat_subset@cluster)
classAgreement(tab)