# Application: Austrian tourism
# Load libraries
library(tourr)
library(pytourr)

# Check random projections
data(winterActiv)
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

