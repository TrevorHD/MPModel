##### Simulate logistic growth, random wind dispersal, mean wind speed ------------------------------------

# Initialise data frame to hold results from multiple simulations
SimData <- data.frame(rep(NA, 10))

# Run 100 30-year simulations
for(k in 1:100){
  
  # Initialise data; use inits.1 or replace with inits.2 or inits.3
  patches <- inits.1()
  
  # Populate data over 30 time steps
  for(i in 1:30){
    
    # Set carrying capacity, discrete and continuous growth rates
    K <- 5000
    GR <- 1.7
    expGR <- log(GR)
    
    # Add new column for time t
    patches <- data.frame(cbind(patches, rep(NA, 10)))
    
    # Rename new column
    colnames(patches)[i + 3] <- paste0("N", i)
    
    # Calculate population of each patch at time t1
    for(j in 1:10){
      
      # Determine which patches are the "others"
      others <- c(1:10)[-j]
      
      # Sum immigration from all other patches
      adds <- sum(mapply(immi.L, to = j, from = others, t = i - 1, 
                         N = patches[j, i + 2], K = K, type = "MeanWindSamp"))
      
      # Calculate final t1 population for the given patch
      patches[j, i + 3] <- floor(patches[j, i + 2]*exp(expGR*(1 - (patches[j, i + 2]/K))) + adds)}}
  
  # For each run, calculate the earliest time a patch becomes occupied
  for(h in 1:10){
    SimData[h, k] <- 31 - length(patches[h, 3:33][patches[h, 3:33] > 0])}}





##### Simulate logistic growth, random wind dispersal, variable wind speeds -------------------------------

# Initialise data frame to hold results from multiple simulations
SimData <- data.frame(rep(NA, 10))

# Run 100 30-year simulations
for(k in 1:100){
  
  # Initialise data; use inits.1 or replace with inits.2 or inits.3
  patches <- inits.1()
  
  # Populate data over 30 time steps
  for(i in 1:30){
    
    # Set carrying capacity, discrete and continuous growth rates
    K <- 5000
    GR <- 1.7
    expGR <- log(GR)
    
    # Add new column for time t
    patches <- data.frame(cbind(patches, rep(NA, 10)))
    
    # Rename new column
    colnames(patches)[i + 3] <- paste0("N", i)
    
    # Calculate population of each patch at time t1
    for(j in 1:10){
      
      # Determine which patches are the "others"
      others <- c(1:10)[-j]
      
      # Sum immigration from all other patches
      adds <- sum(mapply(immi.L, to = j, from = others, t = i - 1, 
                         N = patches[j, i + 2], K = K, type = "VaryWindSamp"))
      
      # Calculate final t1 population for the given patch
      patches[j, i + 3] <- floor(patches[j, i + 2]*exp(expGR*(1 - (patches[j, i + 2]/K))) + adds)}}
  
  # For each run, calculate the earliest time a patch becomes occupied
  for(h in 1:10){
    SimData[h, k] <- 31 - length(patches[h, 3:33][patches[h, 3:33] > 0])}}





##### Results from selected simulations -------------------------------------------------------------------

# The corresponding simulations above must be run manually, one at a time

# Use layout from inits.1 with types MeanWindSamp (a) and VaryWindSamp (b)
SimData1a <- SimData
SimData1b <- SimData

# Use layout from inits.2 with types MeanWindSamp (a) and VaryWindSamp (b)
SimData2a <- SimData
SimData2b <- SimData

# Use layout from inits.3 with types MeanWindSamp (a) and VaryWindSamp (b)
SimData3a <- SimData
SimData3b <- SimData





##### Clean up global environment -------------------------------------------------------------------------

# Remove variables that will no longer be used
remove(h, i, j, k, K, adds, GR, expGR, others)

