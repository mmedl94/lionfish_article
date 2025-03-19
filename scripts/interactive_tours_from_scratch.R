library(tourr)
library(lionfish)
library(flexclust)
library(stats)
library(dplyr)
library(data.table)

# set working directory to path/to/lionfish_article/
setwd("..")

init_env()

######## Austrian Tourism ########

set.seed(1234)
data(winterActiv)
clusters_full = stepcclust(winterActiv, k=6, nrep=20,  save.data=TRUE)
winterActiv_features <- read.csv("saves/aut_saves/init/feature_selection.csv",
                                 header = FALSE)
winterActiv_feat_subset <- winterActiv[, colnames(winterActiv) %in% winterActiv_features$V1]
clusters_feat_subset = stepcclust(winterActiv_feat_subset, k=6, nrep=20,  save.data=TRUE)

features_to_keep <- c("alpine.skiing", "going.to.a.spa", "using.health.facilities",
                      "hiking", "going.for.walks","excursions",
                      "going.out.in.the.evening", "going.to.discos.bars",
                      "shopping", "sight.seeing", "museums", "pool.sauna")
winterActiv_feat_subset <- winterActiv[, features_to_keep]

lda_tour_history_2d <- save_history(winterActiv_feat_subset, 
                                    tour_path = guided_tour(lda_pp(clusters_feat_subset@cluster),d=2))
lda_tour_history_1d <- save_history(winterActiv_feat_subset, 
                                    tour_path = guided_tour(lda_pp(clusters_feat_subset@cluster),d=1))

half_range <- max(sqrt(rowSums(winterActiv_feat_subset^2)))
col_names <- colnames(winterActiv_feat_subset)

obj1 <- list(type = "2d_tour", obj = lda_tour_history_2d)
obj2 <- list(type = "heatmap", obj = c("total fraction"))
obj3 <- list(type = "1d_tour", obj = lda_tour_history_1d)
obj4 <- list(type = "mosaic", obj = c("subgroups_on_y"))

interactive_tour(data=winterActiv_feat_subset,
                 plot_objects = list(obj1, obj2, obj3, obj4),
                 feature_names=col_names,
                 half_range=2,
                 n_plot_cols=2,
                 preselection = clusters_feat_subset@cluster,
                 display_size = 5)

######## Australian Tourism ########

data("ausActiv")

ausActiv <- ausActiv[rowSums(ausActiv) > 0 & rowSums(ausActiv) <= 40, ]
feature_selection <- read.csv("saves/aus_saves/before/feature_selection.csv", header = FALSE)
feature_selection <- feature_selection %>%
  filter(V2 == 1) %>%
  pull(V1)

ausActiv_feat_subset <- ausActiv[, feature_selection]

# The subset selection might deviate slightly depending on seed
# The original subset selection can be loaded form saves

clusters <- stepcclust(ausActiv_feat_subset, k=6, nrep=20,  save.data=TRUE)
subsets <- clusters@cluster

subset_selection <- read.csv("saves/aus_saves/before/subset_selection.csv", header = TRUE)
subsets <- subset_selection[order(subset_selection$observation_index), ]$subset

lda_tour_history_2d <- save_history(ausActiv_feat_subset,
                                    tour_path = guided_tour(lda_pp(subsets),d=2))

lda_tour_history_1d <- save_history(ausActiv_feat_subset,
                                    tour_path = guided_tour(lda_pp(subsets),d=1))

half_range <- 2
col_names <- colnames(ausActiv_feat_subset)

obj1 <- list(type = "2d_tour", obj = lda_tour_history_2d)
obj2 <- list(type = "1d_tour", obj = lda_tour_history_1d)
obj3 <- list(type = "mosaic", obj = c("subgroups_on_y"))
obj4 <- list(type = "heatmap", obj = c("Intra cluster fraction"))

interactive_tour(data=ausActiv_feat_subset,
                 feature_names = col_names,
                 plot_objects = list(obj1, obj2, obj3, obj4),
                 half_range=half_range,
                 preselection = subsets,
                 n_plot_cols = 2,
                 n_subsets = 10,
                 display_size = 5,
                 hover_cutoff = 50)


######## Risk ########

data("risk")

data <- data.table(risk)
data <- apply(data, 2, function(x) (x-mean(x))/sd(x))

set.seed(1145)
r_km <- kmeans(data, centers=5,
               iter.max = 500, nstart = 5)

r_km_d <- as_tibble(data) |>
  mutate(cl = factor(r_km$cluster))
r_km_d <- as.data.table(r_km_d)

for (i in 1:7) {
  r_km_d[, paste0("cluster", i) := as.integer(cl == i)+1]
}

clusters <- r_km_d$cl

guided_tour_history <- save_history(data,
                                    tour_path = guided_tour(lda_pp(clusters)))

half_range <- max(sqrt(rowSums(data^2)))
feature_names <- colnames(data)
cluster_names <- paste("Cluster", 1:5)

# swap clusters to be more colorblind friendly
clusters_swapped <- clusters
clusters_swapped <- case_when(
  clusters == 3 ~ 5,
  clusters == 5 ~ 3,
  clusters == 1 ~ 2,
  clusters == 2 ~ 1,
  TRUE ~ clusters
)
#clusters_swapped <- as.numeric(clusters_swapped)
#clusters_swapped[clusters == 3] <- 99  # Temporarily change 3s to a unique value
#clusters_swapped[clusters == 4] <- 3
#clusters_swapped[clusters_swapped == 99] <- 4

obj1 <- list(type="2d_tour", obj=guided_tour_history)


interactive_tour(data=data.matrix(data),
                 plot_objects=list(obj1),
                 feature_names=feature_names,
                 half_range=half_range,
                 n_plot_cols=2,
                 preselection=clusters_swapped,
                 preselection_names=cluster_names,
                 n_subsets=5,
                 display_size=9)

