# Overview

Dispersal is an important factor in how organisms spread across space through time, and variation in the factors that influence dispersal affects the rate at which spread occurs. Here, we use a spatially explicit metapopulation model to examine how the spread rate of the wind-dispersed invasive thistle *Carduus nutans* is affected by variation in wind speeds. Results indicate that when variation in wind speed exists, these thistles are able to invade unoccupied areas faster than when there is no variation in wind speed. Increased variation in wind speed makes extreme wind events more frequent and increases the likelihood of long-distance dispersal, thus making distant habitats accessible when they may not be under less variable wind conditions. This has implications for controlling the spread of invasive species, as better understanding variation within dispersal and the frequency of long-distance dispersal events allows us to better predict how quickly invasives spread.

<br/>

# Files

## Scripts

**MPFunctions** *(.R)* - A script that defines all functions used in simulations and plotting.

**MPSimulations** *(.R)* - Runs simulations of the metapopulation model. For the dispersal aspect of the model, two kernels are used: one in which there is no variation in wind speed and another in which wind speeds are sampled from a distribution wind speeds obtained from weather data.

**MPPlotting** *(.R)* - Plots results from the metapopulation model simulations, namely how mean initial patch occupancy time varies between patches and presence/absence of wind speed variation.

**MPExtras** *(.R)* - Metapopulation models with extra dispersal kernels that were not used in the simulations.

**MPInfo** *(.Rmd)* - R Markdown used to create a detailed description of what this project is.

## Figures

**Figure1** *(.jpeg)* - Simulation results for patch configuration 1.

**Figure2** *(.jpeg)* - Simulation results for patch configuration 2.

**Figure3** *(.jpeg)* - Simulation results for patch configuration 3.

## Other

**MPInfo** *(.pdf)* - A more detailed description of what this project is and how it works.

**Header** *(.tex)* A TeX file with header specifications.

<br/>

# Featured Images

The images below display mean colonisation times for three different configurations of discrete habitat patches in the presence/absence of wind speed variation. Distances in the patch arrangement are given in metres, and patch 1 is the founder patch. Error bars indicate a 95% confidence interval for the estimate of mean colonisation time, and numbers in parentheses indicate the proportion of simulations in which colonisation was achieved in instances where this proportion was less than 1.

<kbd>![](https://github.com/TrevorHD/MPModel/blob/master/Figures/Figure1.jpeg)</kbd>

<kbd>![](https://github.com/TrevorHD/MPModel/blob/master/Figures/Figure2.jpeg)</kbd>

<kbd>![](https://github.com/TrevorHD/MPModel/blob/master/Figures/Figure3.jpeg)</kbd>
