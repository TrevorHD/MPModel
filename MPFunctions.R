##### Load necessary libraries ----------------------------------------------------------------------------

# Load packages
library(SuppDists)
library(tidyverse)
library(grid)
library(gridBase)





##### Set up wind dispersal function ----------------------------------------------------------------------

# Load in raw weather data
ws.data1 <- read.csv(file.choose())
ws.data2 <- read.csv(file.choose())

# Create vector of all wind speed observations
ws.values <- c(ws.data1$Wind1, ws.data2$Wind1)

# Assume no seed release occurs for wind speeds of zero, so remove zero values
ws.values <- ws.values[ws.values > 0]

# Create empirical PDF of wind speeds
ws.PDF <- density(ws.values, from = min(ws.values), to = max(ws.values), bw = 0.05)

# Function generating a dispersal kernel using WALD model (Katul et al. 2005)
# Code adapted from Skarpaas and Shea (2007)
WALD <- function(n, H, means){
  
  # Initialise physical constants
  K <- 0.4      # von Karman constant
  C0 <- 3.125   # Kolmogorov constant
  
  # Initialise other fixed quantities
  Aw <- 1.3     # Ratio of sigmaw to ustar
  h <- 0.15     # Grass cover height
  d <- 0.7*h    # Zero-plane displacement
  z0 <- 0.1*h   # Roughness length
  zm <- 1       # Wind speed measurement height
  
  # Let n be the number of simulation replications
  # Let H be the seed release height
  
  # Sample from distribution of empirical wind speeds
  if(means == FALSE){
    Um <- rnorm(n, sample(ws.values, size = n, replace = TRUE), ws.PDF$bw)}
  
  # Use mean wind speed
  if(means == TRUE){
    Um <- mean(ws.values)}
  
  # Use mean terminal velocity
  f <- 0.35
  
  # Calculate ustar, the friction velocity
  ustar <- K*Um*(log((zm - d)/z0))^(-1)
  
  # Set up integrand for wind speed between vegetation surface and drop height H
  integrand <- function(z){
    (1/K)*(log((z - d)/z0))}
  
  # Integrate to obtain U
  U <- (ustar/H)*integrate(integrand, lower = d + z0, upper = H)$value
  
  # Calculate instability parameter
  sigma <- 2*(Aw^2)*sqrt((K*(H - d)*ustar)/(C0*U))
  
  # Calculate scale parameter lambda
  lambda <- (H/sigma)^2
  
  # Calculate location parameter nu
  nu <- H*U/f
  
  # Generate inverse Gaussian distribution
  return(rinvGauss(n, nu = nu, lambda = lambda))}





##### Set up immigration functions ------------------------------------------------------------------------

# Function to immigration (i.e. dispersal) to one patch from another patch
# Assumes exponential growth and no variation in wind speeds
immi.E <- function(to, from, t){
  
  # Calculate distance between "to" and "from" patches
  dist <- sqrt((patches$x[to] - patches$x[from])^2 + (patches$y[to] - patches$y[from])^2)
  
  # Calculate expected number of immigrants
  indv <- patches[from, t + 3]*1*pinvGauss(dist, nu = 2.54, lambda = 8.80, lower = FALSE)
  
  # Fix estimation error from invGauss function that yields negative values at near-zero probabilities
  indv <- ifelse(indv < 0, 0, indv)
  return(indv)}

# Function to immigration to one patch from another patch
# Assumes logistic growth and accomodates different dispersal patterns
immi.L <- function(to, from, t, N, K, type){
  
  # Calculate distance between "to" and "from" patches
  dist <- sqrt((patches$x[to] - patches$x[from])^2 + (patches$y[to] - patches$y[from])^2)
  
  # Calculate expected number of immigrants given mean wind speed
  if(type == "MeanWind"){
    indv <- patches[from, t + 3]*1*pinvGauss(dist, nu = 2.54, lambda = 8.80, lower = FALSE)*(1 - N/K)
    indv <- ifelse(indv < 0, 0, indv)}
  
  # Calculate expected number of immigrants from Wald distribution given varying wind speeds
  if(type == "MeanWindSamp"){
    if(patches[from, t + 3] != 0){
      rand <- as.numeric(na.omit(WALD(patches[from, t + 3], H = 1.41, means = TRUE)))} else {rand <- 0}
    indv <- length(rand[rand > dist])*(1 - N/K)}
  
  # Calculate expected number of immigrants from Wald distribution given varying wind speeds
  if(type == "VaryWindSamp"){
    if(patches[from, t + 3] != 0){
      rand <- as.numeric(na.omit(WALD(patches[from, t + 3], H = 1.41, means = FALSE)))} else {rand <- 0}
    indv <- length(rand[rand > dist])*(1 - N/K)}
  
  # Calculate expected number of immigrants from Wald distribution given varying wind speeds
  # Include secondary insect dispersal after seed is dispersed by wind
  if(type == "VaryWindSampSec"){
    if(patches[from, t + 3] != 0){
      rand <- as.numeric(na.omit(WALD(patches[from, t + 3], H = 1.41)))} else {rand <- 0}
    rand <- rand + rnorm(length(rand), mean = 0, sd = 4)
    rand <- rand[rand > 0]
    indv <- length(rand[rand > dist])*(1 - N/K)}
  
  # Return expected number of individuals
  return(indv)}





##### Set up initial conditions functions -----------------------------------------------------------------

# Set or reset initial patch conditions (i.e. number of individuals)
# X- and Y- coordinates are predefined; can be changed by editing function
inits.1 <- function(){
  patch <- data.frame(cbind(c(0, 3, 7, 15, 27, 45, 73, 100, 144, 200), 
                            c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)), 
                            c(10, 0, 0, 0, 0, 0, 0, 0, 0, 0))
  names(patch) <- c("x", "y", "N0")
  return(patch)}

inits.2 <- function(){
  patch <- data.frame(cbind(c(3, 8, 15, 23, 33, 45, 160, 169, 185, 192), 
                            c(-5, 1, -4, 1, 7, -1, 1, 3, -3, 0)), 
                            c(10, 0, 0, 0, 0, 0, 0, 0, 0, 0))
  names(patch) <- c("x", "y", "N0")
  return(patch)}

inits.3 <- function(){
  patch <- data.frame(cbind(c(5, 11, 12, 17, 23, 25, 31, 79, 123, 184), 
                            c(-1, -4, 2, 0, 6, -3, 1, -5, 2, 8)), 
                            c(10, 0, 0, 0, 0, 0, 0, 0, 0, 0))
  names(patch) <- c("x", "y", "N0")
  return(patch)}





##### Set up function to prepare simulation data for plotting --------------------------------------------

sim.plot <- function(SDA, SDB){

  # Bind data from both simulations into a signle data frame
  SD2 <- rbind(SDA, SDB)

  # Create empty data frame to populate with plot data
  PlotData <- data.frame(matrix(rep(NA, 70), nrow = 10, byrow = TRUE))
  colnames(PlotData) <- c("Patch", "Group", "N", "Mean", "SD", "SE", "CI")

  # Populate data frame with plot data
  for(i in 1:nrow(SD2)){
  
    # Patch numbers and indicator for mean/varying wind speeds
    PlotData[i, 1] <- ifelse(i <= 10, i, i - 10)
    PlotData[i, 2] <- ifelse(i <= 10, "Mean Wind Speed", "Varying Wind Speeds")
  
    # Number of instances where a patch was occupied before the simulation ended
    PlotData[i, 3] <- length(SD2[i, ][SD2[i, ] <= 30])
  
    # Mean, SD, SE, and 95% CI of initial occupancy time
    # Excludes entries where occupancy never occurred
    PlotData[i, 4] <- ifelse(PlotData[i, 3] == 30, mean(as.numeric(SD2[i, ])), 
                             ifelse(PlotData[i, 3] == 0, 30, mean(as.numeric(SD2[i, ][SD2[i, ] <= 30]))))
    PlotData[i, 5] <- ifelse(PlotData[i, 3] == 30, sd(as.numeric(SD2[i, ])), 
                             ifelse(PlotData[i, 3] == 0, NA, sd(as.numeric(SD2[i, ][SD2[i, ] <= 30]))))
    PlotData[i, 6] <- ifelse(PlotData[i, 3] == 0, NA, PlotData[i, 5]/sqrt(PlotData[i, 3]))
    PlotData[i, 7] <- PlotData[i, 6]*qnorm(0.975)}
  
  # Return data frame for plotting
  return(PlotData)}





##### Set up function to plot simulation data using global variables --------------------------------------

# Function for barplot of mean initial occupancy time
PDBars <- function(){
  ggplot(PlotData, aes(x = Patch, y = Mean, fill = Group)) + 
    geom_bar(stat = "identity", position = "dodge") +
    geom_errorbar(aes(ymin = Mean - CI, ymax = Mean + CI), width = 0.5, position = position_dodge(.9)) +
    scale_x_continuous(breaks = 2:10, limits = c(1.5, 10.5)) +
    scale_fill_manual(values = c("gray48", "gray78")) +
    xlab("Patch Number") +
    ylab("Mean Initial Occupancy Time (Years)") +
    ylim(0, 30) +
    theme(panel.grid.major.x = element_blank(),
          panel.grid.major.y = element_line(),
          panel.grid.minor.x = element_blank(),
          panel.grid.minor.y = element_line(),
          axis.text.x = element_text(size = 23, margin = margin(t = 4, r = 0, b = 0, l = 0)),
          axis.text.y = element_text(size = 23, margin = margin(t = 0, r = 4, b = 0, l = 0)),
          axis.title.x = element_text(size = 28, margin = margin(t = 16, r = 0, b = 0, l = 6)),
          axis.title.y = element_text(size = 28, margin = margin(t = 80, r = 16, b = 0, l = 0)),
          axis.ticks.x = element_blank(),
          axis.ticks.y = element_blank(),
          legend.background = element_blank(),
          legend.position = c(0.12, 0.88),
          legend.text = element_text(size = 20),
          legend.title = element_blank(),
          legend.key.size = unit(3, "line")) -> graph
  return(graph)}

