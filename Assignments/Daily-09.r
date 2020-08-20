---
title: "Daily-09"
author: "Devina"
date: "8/19/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r}
install.packages("dplyr")
library(dplyr)
install.packages("tidyr")
library(tidyr)
install.packages("sf")
library(sf)
install.packages("stars")
library(stars)
install.packages("units")
library(units)
install.packages("raster")
library(raster)
install.packages("mapview")
library(mapview)
install.packages("leaflet")
library(leaflet)
install.packages("gdalUtilities")
library(gdalUtilities)
```
```{r}


```

```{r}
install.packages("whitebox",repos = "http://R-Forge.R-project.org")
```
```{r}
install.packages("remotes")
remotes::install_github("ropensci/getlandsat")
remotes::install_github("ropensci/USAboundaries")
remotes::install_github("ropensci/USAboundariesData")
remotes::install_github("ropensci/rnaturalearthdata")

```

```{r}
sf::sf_extSoftVersion()
```

