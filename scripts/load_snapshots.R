library(lionfish)
library(dplyr)

# set working directory to path/to/lionfish_article/
setwd("..")
init_env()
# load Austrian Vacation Activities dataset
data("winterActiv")
winterActiv_features <- read.csv("saves/aut_saves/init/feature_selection.csv",
                                 header = FALSE)
winterActiv <- winterActiv[, colnames(winterActiv) %in% winterActiv_features$V1]


# load Australian Vacation Activities dataset
data("ausActiv")
ausActiv <- ausActiv[rowSums(ausActiv) > 0 & rowSums(ausActiv) <= 40, ]
ausActiv_features <- read.csv("saves/aus_saves/init/feature_selection.csv",
                                 header = FALSE)
ausActiv <- ausActiv[, colnames(ausActiv) %in% ausActiv_features$V1]
ausActiv <- ausActiv[, ausActiv_features$V1]

# if the display is too large or too small please adjust the display size
# argument

# Figure 7 + figure 8
load_interactive_tour(winterActiv, "/saves/aut_saves/init",
                      display_size = 5)

# Figure 9
load_interactive_tour(winterActiv, "/saves/aut_saves/before",
                      display_size = 5)

# Figure 10
load_interactive_tour(winterActiv, "/saves/aut_saves/after",
                      display_size = 5)

# Figure 12 + 13
load_interactive_tour(ausActiv, "/saves/aus_saves/before",
                      display_size = 5)

# Figure 14
load_interactive_tour(ausActiv, "/saves/aus_saves/after",
                      display_size = 5)