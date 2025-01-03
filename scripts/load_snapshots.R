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

# load risk dataset
data("risk")
dup <- duplicated(risk)
risk <- risk[!dup,]

# if the display is too large or too small please adjust the display size
# argument

# Figure 8 + figure 9
load_interactive_tour(winterActiv, "/saves/aut_saves/init",
                      display_size = 5)

# Figure 10
load_interactive_tour(winterActiv, "/saves/aut_saves/before",
                      display_size = 5)

# Figure 11
load_interactive_tour(winterActiv, "/saves/aut_saves/after",
                      display_size = 5)

# Figure 13 + 14
load_interactive_tour(ausActiv, "/saves/aus_saves/before",
                      display_size = 5)

# Figure 15
load_interactive_tour(ausActiv, "/saves/aus_saves/after",
                      display_size = 5)

# Figure 16
load_interactive_tour(risk, "/saves/risk_saves/final_projeciton_risk",
                      display_size = 5)

# Figure 18
load_interactive_tour(risk, "/saves/risk_saves/regrouped_risk",
                      display_size = 5)