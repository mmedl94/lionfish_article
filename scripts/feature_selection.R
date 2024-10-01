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

summed_counts <- d %>%
  group_by(cl) %>%
  summarise(across(x1:x4, sum))

# Calculate the row sums for each cluster
col_sums <- colSums(select(summed_counts, x1:x4))

# Divide each value in the columns x1 to x4 by its respective row sum
summed_counts_normalized <- summed_counts %>%
  mutate(across(x1:x4, ~ .x / col_sums))

summed_counts_long <- summed_counts_normalized %>%
  pivot_longer(cols = x1:x4, names_to = "feature", values_to = "mean")

# Plot heatmap
ggplot(summed_counts_long, aes(x=cl, y=feature, fill=mean)) +
  geom_tile() +
  scale_fill_viridis_c(option="magma")

# In figure 1 (intra cluster fraction) we can see that all observations in
# cluster 4 had a x4 value of 1.
# Figure 2 (intra feature fraction) reveals that cluster 1 had more positive x4
# values. In fact, cluster 1 has the largest accumulation of x4. We cannot see
# this in figure 1, but I consider this important information.

# Compare distributions
# How many observations in each cluster?
d |> count(cl) 
# 33,37,31,19
d_tab_wide <- d_tab |> 
  pivot_wider(names_from = feature, values_from = mean)
d_tab_wide_fnorm <- d_tab_wide |> 
  mutate_if(is.numeric, function(x) x/sum(x)) |>
  pivot_longer(x1:x4, names_to = "feature", values_to = "mean")

ggplot(d_tab_wide_fnorm, aes(x=cl, y=feature, fill=mean)) +
  geom_tile() +
  scale_fill_viridis_c(option="magma")
