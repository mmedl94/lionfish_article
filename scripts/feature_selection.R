# Feature selection based on fractions
library(tidyverse)
library(tourr)
set.seed(446)
n <- 120
d <- tibble(x1 = sample(c(0,1), n, replace=TRUE),
            x2 = sample(c(0,1), n, replace=TRUE),
            x3 = sample(c(0,1), n, replace=TRUE),
            x4 = sample(c(0,1), n, replace=TRUE))
d_km <- kmeans(d, 4)

d <- d |>
  mutate(cl = factor(d_km$cluster))
# animate_xy(d[,1:4], col=d$cl)
d_tab <- d_km$centers |>
  as_tibble() |>
  mutate(cl = paste0("cl", 1:4)) |>
  pivot_longer(x1:x4, names_to = "feature", values_to = "mean")

ggplot(d_tab, aes(x=cl, y=feature, fill=mean)) +
  geom_tile() +
  scale_fill_viridis_c(option="magma")


