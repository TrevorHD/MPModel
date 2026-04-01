# Overview

A case study examining how variation in the factors that influence the dispersal of organisms affects the rate at which their spread occurs. Here, we use a spatially explicit metapopulation model to examine how the spread rate of the wind-dispersed invasive thistle *Carduus nutans* between patches of suitable habitat is affected by variation in wind speeds.

Results indicate that when variation in wind speed exists, these thistles are able to invade unoccupied patches faster than when there is no variation in wind speed. Increased variation in wind speed makes extreme wind events more frequent and increases the likelihood of long-distance dispersal, thus making distant patches accessible when they may not be under less variable wind conditions. This has implications for controlling the spread of invasive species, as better understanding variation within dispersal and the frequency of long-distance dispersal events allows us to better predict how quickly invasives spread.

<br/>

# Files

## Data

**MP_Data_WeatherA** *(.csv)* - Spreadsheet with data on weather conditions (wind speed, temperature, solar radiation, pressure, and precipitation) from a local field site.

**MP_Data_WeatherB** *(.csv)* - Spreadsheet with data on weather conditions (wind speed, temperature, solar radiation, pressure, and precipitation) from a local field site.

## Extras

**MP_Script_Extras** *(.R)* - Script for defining additional growth/dispersal models that were not used in the simulations.

## Figures

**MP_Plots_1** *(.jpeg)* - Plots of simulation results for a series of increasingly distant patches.

**MP_Plots_2** *(.jpeg)* - Plots of simulation results for two separate clusters of patches.

**MP_Plots_3** *(.jpeg)* - Plots of simulation results for a cluster of patches followed by several distant patches.

## Reports

**MP_Report** *(.pdf)* - Report for the case study.

## Scripts

**MP_Script_1** *(.R)* - Script for defining key function used in dispersal/spread simulations.

**MP_Script_2** *(.R)* - Script for running simulations.

**MP_Script_3** *(.R)* - Script for generating figures.

**MP_Script_4** *(.Rmd)* - Script for rendering output to PDF.

**MP_Script_Header** *(.tex)* - Script for storing the markdown info used to generate the report header.

<br/>

# Featured Images

Mean colonisation times for a series of increasingly distant patches in the presence/absence of wind speed variation. Distances in the patch arrangement are given in metres, and patch 1 is the founder patch. Error bars indicate a 95% confidence interval for the estimate of mean colonisation time, and numbers in parentheses indicate the proportion of simulations in which colonisation was achieved in instances where this proportion was less than 1.

<kbd>![](https://github.com/TrevorHD/MPModel/blob/master/Figures/MP_Plots_1.jpeg)</kbd>

Mean colonisation times for two separate clusters of patches. Given the distance between the two clusters of patches, the patches that are extremely distant from the founder patch are much less likely to be colonised, especially when simulating dispersal using only mean wind speeds.

<kbd>![](https://github.com/TrevorHD/MPModel/blob/master/Figures/MP_Plots_2.jpeg)</kbd>

Mean colonisation times for a cluster of patches followed by several distant patches. Colonisation trends resemble those found in the first patch configuration.

<kbd>![](https://github.com/TrevorHD/MPModel/blob/master/Figures/MP_Plots_3.jpeg)</kbd>
