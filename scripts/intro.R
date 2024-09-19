# Example in introduction
library(tidyverse)
library(mvtnorm)
library(patchwork)
library(colorspace)

theme_set(theme_bw(base_size = 14) +
            theme(
              aspect.ratio = 1,
              plot.background = element_rect(fill = 'transparent', colour = NA),
              plot.title.position = "plot",
              plot.title = element_text(size = 24),
              panel.background = element_rect(fill = 'transparent', colour = NA),
              legend.background = element_rect(fill = 'transparent', colour = NA),
              legend.key = element_rect(fill = 'transparent', colour = NA)
            )
)

f_std <- function(x) {(x-min(x))/(max(x)-min(x))}
set.seed(914)
blob1 <- rmvnorm(n=155, mean=c(0,0), 
                 sigma=matrix(c(1, 0, 0, 1), 
                              ncol=2, byrow=TRUE)) |> 
  as_tibble() |>
  mutate_all(f_std)
blob2 <- rmvnorm(n=155, mean=c(0,0), 
                 sigma=matrix(c(1, 0.6, 0.6, 1), 
                              ncol=2, byrow=TRUE)) |> 
  as_tibble() |>
  mutate_all(f_std)
blob3 <- rmvnorm(n=155, mean=c(0,0), 
                 sigma=matrix(c(1, 0.9, 0.9, 1), 
                              ncol=2, byrow=TRUE)) |> 
  as_tibble() |>
  mutate_all(f_std)
b1 <- ggplot(blob1, aes(V1, V2)) + 
  geom_point() +
  theme(axis.text = element_blank(),
        axis.title = element_blank())
b2 <- ggplot(blob2, aes(V1, V2)) + 
  geom_point() +
  theme(axis.text = element_blank(),
        axis.title = element_blank())
b3 <- ggplot(blob3, aes(V1, V2)) + 
  geom_point() +
  theme(axis.text = element_blank(),
        axis.title = element_blank())
b1 + b2 + b3 + plot_layout(ncol=3)


set.seed(855)
b1_km <- kmeans(blob1, 4)
b2_km <- kmeans(blob2, 4)
b3_km <- kmeans(blob3, 4)
blob1_cl <- blob1 |>
  mutate(cl = factor(b1_km$cluster))
blob2_cl <- blob2 |>
  mutate(cl = factor(b2_km$cluster))
blob3_cl <- blob3 |>
  mutate(cl = factor(b3_km$cluster))
b4 <- ggplot(blob1_cl, aes(V1, V2, colour=cl)) + 
  geom_point() +
  scale_color_discrete_divergingx(palette="Zissou 1") +
  annotate("text", x=0.05, y=0.95, label="a", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank())
b5 <- ggplot(blob2_cl, aes(V1, V2, colour=cl)) + 
  geom_point() +
  scale_color_discrete_divergingx(palette="Zissou 1") +
  annotate("text", x=0.05, y=0.95, label="b", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank())
b6 <- ggplot(blob3_cl, aes(V1, V2, colour=cl)) + 
  geom_point() +
  scale_color_discrete_divergingx(palette="Zissou 1") +
  annotate("text", x=0.05, y=0.95, label="c", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank())
b4 + b5 + b6 + plot_layout(ncol=3)

b7 <- ggplot(blob1_cl, aes(V1, fill=cl)) + 
  geom_histogram(breaks = seq(0, 1, 0.1)) +
  scale_fill_discrete_divergingx(palette="Zissou 1") +
  ylim(c(0,37)) +
  annotate("text", x=0.05, y=35, label="a", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank())
b8 <- ggplot(blob2_cl, aes(V1, fill=cl)) + 
  geom_histogram(breaks = seq(0, 1, 0.1)) +
  scale_fill_discrete_divergingx(palette="Zissou 1") +
  ylim(c(0,37)) +
  annotate("text", x=0.05, y=35, label="b", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank())
b9 <- ggplot(blob3_cl, aes(V1, fill=cl)) + 
  geom_histogram(breaks = seq(0, 1, 0.1)) +
  scale_fill_discrete_divergingx(palette="Zissou 1") +
  ylim(c(0,37)) +
  annotate("text", x=0.05, y=35, label="c", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank())
b10 <- ggplot(blob1_cl, aes(V2, fill=cl)) + 
  geom_histogram(breaks = seq(0, 1, 0.1)) +
  scale_fill_discrete_divergingx(palette="Zissou 1") +
  ylim(c(0,37)) +
  annotate("text", x=0.05, y=35, label="d", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank())
b11 <- ggplot(blob2_cl, aes(V2, fill=cl)) + 
  geom_histogram(breaks = seq(0, 1, 0.1)) +
  scale_fill_discrete_divergingx(palette="Zissou 1") +
  ylim(c(0,37)) +
  annotate("text", x=0.05, y=35, label="e", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank())
b12 <- ggplot(blob3_cl, aes(V2, fill=cl)) + 
  geom_histogram(breaks = seq(0, 1, 0.1)) +
  scale_fill_discrete_divergingx(palette="Zissou 1") +
  ylim(c(0,37)) +
  annotate("text", x=0.05, y=35, label="f", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank())
b7 + b8 + b9 + b10 + b11 + b12 + plot_layout(ncol=3)
