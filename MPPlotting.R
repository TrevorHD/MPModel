##### Plot dispersal kernels with and without variation in wind speeds ------------------------------------
plot(density(na.omit(WALD(10000000, H = 1.41, means = TRUE)), from = 0, to = 50, bw = 0.05))
lines(density(na.omit(WALD(10000000, H = 1.41, means = FALSE)), from = 0, to = 50, bw = 0.05), col = "red")





##### Plot mean time of initial occupancy for first layout ------------------------------------------------

# Combine simulation data
PlotData <- sim.plot(SimData1a, SimData1b)

# Prepare graphics device
jpeg(filename = "Figure1.jpeg", width = 1300, height = 800, units = "px")

# Create blank page
grid.newpage()
plot.new()

# Set grid layout and activate it
gly <- grid.layout(800, 1300)
pushViewport(viewport(layout = gly))

# Plot patch locations
pushViewport(viewport(layout = gly, layout.pos.row = 1:250, layout.pos.col = 40:1300))
par(fig = gridFIG())
plot(inits.1()$x, inits.1()$y, xlim = c(0, 200), ylim = c(-10, 10),
     axes = FALSE, ann = FALSE, frame = TRUE, pch = 16, cex = 2)
axis(3, cex.axis = 1.5)
axis(2, at = c(-10, 0, 10), cex.axis = 1.5)
grid.text(x = c(0.081, 0.094, 0.113, 0.146, 0.197, 0.275, 0.395, 0.512, 0.701, 0.941), 
          y = rep(0.46, 10), label = as.character(1:10), gp = gpar(fontsize = 20))
popViewport()

# Plot mean initial occupancy times
print(PDBars(), vp = viewport(layout = gly, layout.pos.row = 210:800, layout.pos.col = 20:1280))

# Record colonisation frequency for patches where colonisation sometimes fails
props <- round((PlotData$N/100)[PlotData$N/100 < 1], 2)
grid.text(x = 0.873, y = 0.149, label = paste0("(", props, ")"), gp = gpar(fontsize = 18))

# Deactivate grid layout; finalise graphics save
popViewport()
dev.off()





##### Plot mean time of initial occupancy for second layout -----------------------------------------------

# Combine simulation data
PlotData <- sim.plot(SimData2a, SimData2b)

# Prepare graphics device
jpeg(filename = "Figure2.jpeg", width = 1300, height = 800, units = "px")

# Create blank page
grid.newpage()
plot.new()

# Set grid layout and activate it
gly <- grid.layout(800, 1300)
pushViewport(viewport(layout = gly))

# Plot patch locations
pushViewport(viewport(layout = gly, layout.pos.row = 1:250, layout.pos.col = 40:1300))
par(fig = gridFIG())
plot(inits.2()$x, inits.2()$y, xlim = c(0, 200), ylim = c(-10, 10),
     axes = FALSE, ann = FALSE, frame = TRUE, pch = 16, cex = 2)
axis(3, cex.axis = 1.5)
axis(2, at = c(-10, 0, 10), cex.axis = 1.5)
grid.text(x = c(0.094, 0.117, 0.146, 0.183, 0.223, 0.276, 0.771, 0.810, 0.877, 0.908), 
          y = c(0.352, 0.489, 0.373, 0.481, 0.609, 0.439, 0.479, 0.523, 0.392, 0.461), 
          label = as.character(1:10), gp = gpar(fontsize = 20))
popViewport()

# Plot mean initial occupancy times
print(PDBars(), vp = viewport(layout = gly, layout.pos.row = 210:800, layout.pos.col = 20:1280))

# Record colonisation frequency for patches where colonisation sometimes fails
props <- round((PlotData$N/100)[PlotData$N/100 < 1], 2)
grid.text(x = c(0.599, 0.691, 0.783, 0.873), y = 0.149, 
          label = paste0("(", props, ")"), gp = gpar(fontsize = 18))

# Deactivate grid layout; finalise graphics save
popViewport()
dev.off()





##### Plot mean time of initial occupancy for third layout ------------------------------------------------

# Combine simulation data
PlotData <- sim.plot(SimData3a, SimData3b)

# Prepare graphics device
jpeg(filename = "Figure3.jpeg", width = 1300, height = 800, units = "px")

# Create blank page
grid.newpage()
plot.new()

# Set grid layout and activate it
gly <- grid.layout(800, 1300)
pushViewport(viewport(layout = gly))

# Plot patch locations
pushViewport(viewport(layout = gly, layout.pos.row = 1:250, layout.pos.col = 40:1300))
par(fig = gridFIG())
plot(inits.3()$x, inits.3()$y, xlim = c(0, 200), ylim = c(-10, 10),
     axes = FALSE, ann = FALSE, frame = TRUE, pch = 16, cex = 2)
axis(3, cex.axis = 1.5)
axis(2, at = c(-10, 0, 10), cex.axis = 1.5)
grid.text(x = c(0.103, 0.130, 0.134, 0.156, 0.181, 0.190, 0.216, 0.422, 0.611, 0.872), 
          y = c(0.437, 0.377, 0.644, 0.459, 0.595, 0.404, 0.481, 0.359, 0.501, 0.643), 
          label = as.character(1:10), gp = gpar(fontsize = 20))
popViewport()

# Plot mean initial occupancy times
print(PDBars(), vp = viewport(layout = gly, layout.pos.row = 210:800, layout.pos.col = 20:1280))

# Record colonisation frequency for patches where colonisation sometimes fails
props <- round((PlotData$N/100)[PlotData$N/100 < 1], 2)
grid.text(x = 0.873, y = 0.149, label = paste0("(", props, ")"), gp = gpar(fontsize = 18))

# Deactivate grid layout; finalise graphics save
popViewport()
dev.off()

