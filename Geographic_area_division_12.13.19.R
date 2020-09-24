---
title: "R Notebook"
output: html_notebook
---

#Create geographic (not physiographic) divisions of the UCRB.
#Load necessary libraries

```{r}
# If you get a warning: "error: JAVA_HOME cannot be determined from the Registry", download and install the 64-bit version of Java. 
# install.packages(c('sf', 'rnaturalearth', 'rnaturalearthdata'), dep = T)
library(rgdal)
library(spcosa)
library(rgeos)
library(raster)
library(tidyverse)
library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(maps)
library(tools)
library(ggspatial)
library(rgdal)
library(maptools)
library(ggpubr)
#devtools::install_github("tidyverse/ggplot2")
```

#Set working directory
```{r}
setwd("Z:/UCRB/Boundaries")
```




# Read in shapefiles (for whatever reason this doens't work with the original UCRB boundary shapefile, probably because it seems like the data has to be projected and not in geographic coordinates) 
```{r}
ucrb <- readOGR(".", "CO_River_watershed_Meade_NAD83_EcoL3_dissolve")
# convert to SpatialPolygons class
ucrb.poly <- SpatialPolygons(ucrb@polygons)
```


# Generate 9 compact geographical strata to equal the number of MLRA's
# https://cran.r-project.org/web/packages/spcosa/vignettes/spcosa.html
# cellSize of 1000 = 1000 m, or 1 km. 
```{r}
ucrb.9 <- stratify(ucrb.poly, nStrata = 9, nTry = 1, cellSize = 1000)
plot(ucrb.9)

# Convert geographical strata to raster so that I can overlay points
# First convert to SpatialPixelsDataFrame
u9spdf <- as(ucrb.9@cells, 'SpatialPixelsDataFrame')
# Create dataframe of stratumID (id for every pixel)
u9df <- data.frame(stratumId = ucrb.9@stratumId)
#fill SpatialPixelsDataFrame data slot with dataframe
u9spdf@data <- u9df
# Convert to raster and give it the right projection
u9.r <- raster(u9spdf)
projection(u9.r) <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
#Write to file
#writeRaster(u9.r, "./GeoStrat9.tif")
```

# Generate 8 compact geographical strata to equal the number of ecoregions 
```{r}
ucrb.8 <- stratify(ucrb.poly, nStrata = 8, nTry = 1, cellSize = 1000)
plot(ucrb.8)
# Convert geographical strata to raster so that I can overlay points
# First convert to SpatialPixelsDataFrame
u8spdf <- as(ucrb.8@cells, 'SpatialPixelsDataFrame')
# Create dataframe of stratumID (id for every pixel)
u8df <- data.frame(stratumId = ucrb.8@stratumId)
#fill SpatialPixelsDataFrame data slot with dataframe
u8spdf@data <- u8df
# Convert to raster and give it the right projection
u8.r <- raster(u8spdf)
projection(u8.r) <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
#Write to file
#writeRaster(u8.r, "./GeoStrat8.tif")
```

# Generate 4 compact geographical strata to equal the number of major landforms
```{r}
ucrb.4 <- stratify(ucrb.poly, nStrata = 4, nTry = 1, cellSize = 1000)
plot(ucrb.4)
# Convert geographical strata to raster so that I can overlay points
# First convert to SpatialPixelsDataFrame
u4spdf <- as(ucrb.4@cells, 'SpatialPixelsDataFrame')
# Create dataframe of stratumID (id for every pixel)
u4df <- data.frame(stratumId = ucrb.4@stratumId)
#fill SpatialPixelsDataFrame data slot with dataframe
u4spdf@data <- u4df
# Convert to raster and give it the right projection
u4.r <- raster(u4spdf)
projection(u4.r) <- "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=23 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs"
#Write to file
#writeRaster(u4.r, "./GeoStrat4.tif")
```

# Plotting for paper.
# Background data
# Get country boundaries 
```{r}
world <- ne_countries(scale = "medium", returnclass = "sf")
world.a <- st_transform(world, '+init=epsg:5070')

# Get a shapefile of US states, then create points at the center of each state (for plotting labels)
states <- st_as_sf(map("state", plot = FALSE, fill = TRUE))
states <- cbind(states, st_coordinates(st_centroid(states)))

# Capitilize state names and reproject
states$ID <- toTitleCase(states$ID)
states.a <- st_transform(states,'+init=epsg:5070')

# Subest to only intermountain weat
imwnames <- c("Utah", "Nevada", "Colorado", "Arizona", "New Mexico", "Wyoming")
imw <-states.a[states.a$ID %in% imwnames,] 

#st_write(imw, "./imw.shp")
```


# Convert compactstrata to polygons then to spatialpolygonsdataframe
```{r}
s9 <- as(ucrb.9@cells, "SpatialPolygons")
s8 <- as(ucrb.8@cells, "SpatialPolygons")
s4 <- as(ucrb.4@cells, "SpatialPolygons")

s9df <- as(s9, "SpatialPolygonsDataFrame")
s8df <- as(s8, "SpatialPolygonsDataFrame")
s4df <- as(s4, "SpatialPolygonsDataFrame")

# Assign the correct prediction
crs(s9df) <- crs(ucrb)
crs(s8df) <- crs(ucrb)
crs(s4df) <- crs(ucrb)

# Convert to simple features
s9_sf <- st_as_sf(s9df)
s8_sf <- st_as_sf(s8df)
s4_sf <- st_as_sf(s4df)

# Assign the right stratum
s9_sf$stratumID <- ucrb.9@stratumId 
s8_sf$stratumID <- ucrb.8@stratumId 
s4_sf$stratumID <- ucrb.4@stratumId 

# Convert to stratumID factor so that everything plots correctly
s9_sf$stratumID <- as.factor(as.character(s9_sf$stratumID))
s8_sf$stratumID <- as.factor(as.character(s8_sf$stratumID))
s4_sf$stratumID <- as.factor(as.character(s4_sf$stratumID))

# relevel so that they start from 1 instead of 0
levels(s9_sf$stratumID) <- c(1:9)
levels(s8_sf$stratumID) <- c(1:8)
levels(s4_sf$stratumID) <- c(1:4)

#save.image('Z:/UCRB/Models/Geographic_area_division_11_18_20.RData')
```

# Plotting
```{r}
# Colors for plotting
cols = c("#F8766D","#D39200","#93AA00","#00BA38","#00C19F","#00B9E3", "#619CFF","#DB72FB","#FF61C3")
# 9 areas
gs9 <- ggplot() +
        geom_sf(data = imw, fill = NA) +
        geom_sf(data = s9_sf, aes(fill=stratumID, color=stratumID)) +
        xlab("Longitude") + ylab("Latitude") +
        guides(fill=guide_legend(title="Area")) +
        theme(plot.margin=grid::unit(c(1,1,1,1), "mm")) +
        theme_bw() + 
        scale_color_manual(values=cols, aesthetics = c("colour", "fill")) + 
        guides(color=FALSE)

# 8 areas
gs8 <- ggplot() +
        geom_sf(data = imw, fill = NA) +
        geom_sf(data = s8_sf, aes(fill=stratumID, color=stratumID)) +
        xlab("Longitude") + ylab("Latitude") +
        guides(fill=guide_legend(title="Area")) +
        theme_bw() +
        theme(plot.margin=grid::unit(c(1,1,1,1), "mm")) + 
        scale_color_manual(values=cols, aesthetics = c("colour", "fill")) + 
        guides(fill=FALSE)

# 4 areas
gs4 <- ggplot() +
        geom_sf(data = imw, fill = NA) +
        geom_sf(data = s4_sf, aes(fill=stratumID, color=stratumID)) +
        xlab("Longitude") + ylab("Latitude") +
        guides(fill=guide_legend(title="Area")) +
        theme_bw() +
        theme(plot.margin=grid::unit(c(1,1,1,1), "mm")) + 
        scale_color_manual(values = cols, aesthetics = c("colour", "fill")) + 
        guides(color=FALSE)


gar <- ggarrange(gs9, gs8, gs4,
               labels = c("A", "B", "C"),
               ncol = 3, nrow = 1, 
               common.legend = TRUE, legend = "bottom")

ggsave("./geographicAreas_2.png")
```
