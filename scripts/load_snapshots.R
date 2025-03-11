library(lionfish)
library(dplyr)

remotes::install_github("mmedl94/lionfish", force = TRUE)

# set working directory to path/to/lionfish_article/
setwd("..")
init_env()
# load Austrian Vacation Activities dataset
data(winterActiv)
winterActiv_features <- read.csv("saves/aut_saves/init/feature_selection.csv",
                                 header = FALSE)
winterActiv <- winterActiv[, colnames(winterActiv) %in% winterActiv_features$V1]

# define cluster vector
cluster_names <- paste("Cluster", 1:9)

# load Australian Vacation Activities dataset
data(ausActiv)
ausActiv <- ausActiv[rowSums(ausActiv) > 0 & rowSums(ausActiv) <= 40, ]
ausActiv_features <- read.csv("saves/aus_saves/init/feature_selection.csv",
                                 header = FALSE)
ausActiv <- ausActiv[, colnames(ausActiv) %in% ausActiv_features$V1]
ausActiv <- ausActiv[, ausActiv_features$V1]

# load risk dataset
data(risk)
dup <- duplicated(risk)
risk <- risk[!dup,]

# if the display is too large or too small please adjust the display size
# argument

# Figure 8 + figure 9
load_interactive_tour(winterActiv, "/saves/aut_saves/init",
                      preselection_names = cluster_names[1:6],
                      hover_cutoff=20,
                      display_size = 5)

# Figure 10
load_interactive_tour(winterActiv, "/saves/aut_saves/before",
                      preselection_names = cluster_names[1:6],
                      hover_cutoff=20,
                      display_size = 5)

# Figure 11
load_interactive_tour(winterActiv, "/saves/aut_saves/after",
                      preselection_names = cluster_names[1:7],
                      hover_cutoff=20,
                      display_size = 5)

# Figure 13
load_interactive_tour(ausActiv, "/saves/aus_saves/before",
                      preselection_names = cluster_names[1:6],
                      hover_cutoff=20,
                      display_size = 5)

# Figure 14
load_interactive_tour(ausActiv, "/saves/aus_saves/after",
                      preselection_names = cluster_names[1:9],
                      hover_cutoff=20,
                      display_size = 5)

# Figure 15
load_interactive_tour(risk, "/saves/risk_saves/final_projection_risk",
                      preselection_names = cluster_names[1:5],
                      hover_cutoff=20,
                      display_size = 5)

# Figure 17
load_interactive_tour(risk, "/saves/risk_saves/regrouped_risk",
                      preselection_names = cluster_names[1:5],
                      hover_cutoff=20,
                      display_size = 6)
