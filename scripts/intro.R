# Example in introduction
library(tidyverse)
library(mvtnorm)
library(patchwork)
library(colorspace)
library(ggbeeswarm)

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
  annotate("text", x=0.05, y=0.95, label="A", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank())
b5 <- ggplot(blob2_cl, aes(V1, V2, colour=cl)) + 
  geom_point() +
  scale_color_discrete_divergingx(palette="Zissou 1") +
  annotate("text", x=0.05, y=0.95, label="B", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank())
b6 <- ggplot(blob3_cl, aes(V1, V2, colour=cl)) + 
  geom_point() +
  scale_color_discrete_divergingx(palette="Zissou 1") +
  annotate("text", x=0.05, y=0.95, label="C", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank())
b4 + b5 + b6 + plot_layout(ncol=3)

b7 <- ggplot(blob1_cl, aes(V1, fill=cl)) + 
  geom_histogram(breaks = seq(0, 1, 0.1)) +
  scale_fill_discrete_divergingx(palette="Zissou 1") +
  ylim(c(0,37)) +
  annotate("text", x=0.05, y=35, label="A", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank())
b8 <- ggplot(blob2_cl, aes(V1, fill=cl)) + 
  geom_histogram(breaks = seq(0, 1, 0.1)) +
  scale_fill_discrete_divergingx(palette="Zissou 1") +
  ylim(c(0,37)) +
  annotate("text", x=0.05, y=35, label="B", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank())
b9 <- ggplot(blob3_cl, aes(V1, fill=cl)) + 
  geom_histogram(breaks = seq(0, 1, 0.1)) +
  scale_fill_discrete_divergingx(palette="Zissou 1") +
  ylim(c(0,37)) +
  annotate("text", x=0.05, y=35, label="C", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank())
b10 <- ggplot(blob1_cl, aes(V2, fill=cl)) + 
  geom_histogram(breaks = seq(0, 1, 0.1)) +
  scale_fill_discrete_divergingx(palette="Zissou 1") +
  ylim(c(0,37)) +
  annotate("text", x=0.05, y=35, label="D", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank())
b11 <- ggplot(blob2_cl, aes(V2, fill=cl)) + 
  geom_histogram(breaks = seq(0, 1, 0.1)) +
  scale_fill_discrete_divergingx(palette="Zissou 1") +
  ylim(c(0,37)) +
  annotate("text", x=0.05, y=35, label="E", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank())
b12 <- ggplot(blob3_cl, aes(V2, fill=cl)) + 
  geom_histogram(breaks = seq(0, 1, 0.1)) +
  scale_fill_discrete_divergingx(palette="Zissou 1") +
  ylim(c(0,37)) +
  annotate("text", x=0.05, y=35, label="F", size=8) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank())
b7 + b8 + b9 + b10 + b11 + b12 + plot_layout(ncol=3)

# Use facetting to make connection with plot 1 clearer
blob1_cl <- blob1_cl |>
  mutate(data = "A")
blob2_cl <- blob2_cl |>
  mutate(data = "B")
blob3_cl <- blob3_cl |>
  mutate(data = "C")

blob_all <- bind_rows(blob1_cl, blob2_cl, blob3_cl) |>
  pivot_longer(c(V1, V2), names_to = "var", values_to = "value")

ggplot(blob_all, aes(value, fill=cl)) + 
  geom_histogram(breaks = seq(0, 1, 0.1), 
                 colour="white", linewidth=0.2) +
  scale_fill_discrete_divergingx(palette="Zissou 1") +
  ylim(c(0,37)) +
  facet_grid(var~data) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank())

# Generate a figure to show why linear combinations are needed, and subsetting
blob1_cl <- blob1_cl |>
  mutate(vars_in = ifelse(cl %in% c(1,2), "yes", "no"))
#b13 <- ggplot(filter(blob1_cl, cl %in% c(1,2)), 
#              aes(x=V1, y=1, colour=cl)) + 
b13 <- ggplot(blob1_cl, 
                aes(x=V1, y=1, colour=cl, alpha=vars_in)) + 
  geom_quasirandom() +
  #scale_colour_manual(values=c("#3B99B1", "#9FC095")) +
  scale_colour_discrete_divergingx(palette="Zissou 1") +
  scale_alpha_manual("", values=c(0.2, 1)) +
  annotate("text", x=0.05, y=1.4, label="A", size=8) +
  #xlab("linear combination") +
  ylim(c(0.5, 1.5)) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank())

blob2_cl <- blob2_cl |>
  mutate(V1_V2 = 0.7218934*V1 - 0.6920043*V2) |>
  mutate(V1_V2 = (V1_V2 - min(V1_V2))/(max(V1_V2)-min(V1_V2))) |>
  mutate(vars_in = ifelse(cl %in% c(1,2), "yes", "no"))

#b14 <- ggplot(filter(blob2_cl, cl %in% c(1,2)), 
#              aes(x=V1_V2, y=1, colour=cl)) + 
b14 <- ggplot(blob2_cl, 
                aes(x=V1_V2, y=1, colour=cl, alpha=vars_in)) + 
  geom_quasirandom() +
  #scale_colour_manual(values=c("#3B99B1", "#9FC095")) +
  scale_colour_discrete_divergingx(palette="Zissou 1") +
  scale_alpha_manual("", values=c(0.2, 1)) +
  annotate("text", x=0.05, y=1.4, label="B", size=8) +
  xlab("linear combination") +
  ylim(c(0.5, 1.5)) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank())

# Use PC1 for data C
prcomp(blob3_cl[,1:2])
blob3_cl <- blob3_cl |>
  mutate(V1_V2 = (0.6920043*V1 + 0.7218934*V2)/sqrt(2))

b15 <- ggplot(blob3_cl, aes(x=V1_V2, y=1, colour=cl)) + 
  geom_quasirandom() +
  scale_colour_discrete_divergingx(palette="Zissou 1") +
  annotate("text", x=0.05, y=1.4, label="C", size=8) +
  xlab("linear combination") +
  ylim(c(0.5, 1.5)) +
  theme(legend.position = "none", 
        axis.text = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank())
b13 + b14 + b15 + plot_layout(ncol=3)
