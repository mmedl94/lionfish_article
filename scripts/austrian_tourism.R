# Application: Austrian tourism
# Load libraries
library(tourr)
library(lionfish)
library(gridExtra)
library(patchwork)

# Check random projections
data(t1i)
winterActiv_std <- apply(winterActiv, 2, scale)
set.seed(630)
t1 <- save_history(winterActiv, max=20)
t1i <- interpolate(t1)
animate_xy(winterActiv_std, planned_tour(t1), half_range=10)
render_gif(winterActiv_std, 
           planned_tour(t1), 
           display_xy(axes="off", half_range=10), 
           gif_file = "images/winterActiv.gif",
           width = 400, height = 400)

# Save projections to illustrate the binary nature
proj <- matrix(t1i[,,3], nrow=27, ncol=2)
proj <- matrix(t1i[,,60], nrow=27, ncol=2)
proj <- matrix(t1i[,,30], nrow=27, ncol=2)
p <- render_proj(winterActiv_std, proj)
ggplot() +
  geom_point(data=p$data_prj, aes(x=P1, y=P2)) +
  #xlim(-1,1) + ylim(-1, 1) +
  theme_bw() +
  theme(aspect.ratio=1,
        axis.text=element_blank(),
        axis.title=element_blank(),
        axis.ticks=element_blank(),
        panel.grid=element_blank())

# Load necessary packages
library(ggplot2)
library(patchwork)
matrix(t1i[,,1], nrow=27, ncol=2)

proj1 <- matrix(t1i[,,1], nrow=27, ncol=2)
proj2 <- matrix(t1i[,,3], nrow=27, ncol=2)
proj3 <- matrix(t1i[,,10], nrow=27, ncol=2)
proj4 <- matrix(t1i[,,30], nrow=27, ncol=2)

p1 <- render_proj(winterActiv_std, proj1)
plot1 <- ggplot() +
  geom_point(data=p1$data_prj, aes(x=P1, y=P2)) +
  theme_bw() +
  theme(aspect.ratio=1,
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        panel.grid=element_blank()) +
  labs(x = "Alpine skiing", y = "Cross country skiing")

p2 <- render_proj(winterActiv_std, proj2)
plot2 <- ggplot() +
  geom_point(data=p2$data_prj, aes(x=P1, y=P2)) +
  theme_bw() +
  theme(aspect.ratio=1,
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        panel.grid=element_blank()) +
  labs(x = "Projection 1", y = "Projection 2")

p3 <- render_proj(winterActiv_std, proj3)
plot3 <- ggplot() +
  geom_point(data=p3$data_prj, aes(x=P1, y=P2)) +
  theme_bw() +
  theme(aspect.ratio=1,
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        panel.grid=element_blank()) +
  labs(x = "Projection 1", y = "Projection 2")

p4 <- render_proj(winterActiv_std, proj4)
plot4 <- ggplot() +
  geom_point(data=p4$data_prj, aes(x=P1, y=P2)) +
  theme_bw() +
  theme(aspect.ratio=1,
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        panel.grid=element_blank()) +
  labs(x = "Projection 1", y = "Projection 2")

combined_plot <- (plot1 | plot2 | plot3 | plot4) +
  plot_layout(ncol = 2, nrow = 2) + 
  plot_annotation(tag_levels = 'A') &
  theme(
    plot.tag = element_text(size = 22, face = "bold"),  # Adjust the size of the annotation tags
    axis.title.x = element_text(size = 16),  # Adjust the size of the x-axis labels
    axis.title.y = element_text(size = 16),  # Adjust the size of the y-axis labels
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    panel.grid = element_blank(),
    plot.margin = margin(5, 5, 5, 5)
  )

ggsave("fig5.pdf", combined_plot, width = 10, height = 8)

