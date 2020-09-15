## ############################## ##
##
## Script Name: Functions for preparing the data for the app
##
##
## Contact (if different from above):
##
## Date Created: 2020-09-10
##
## Date Modified: 2020-09-10
##
## Licence: JNCC
##
##
## Abstract: Script to prepare the S2 and bare peat layers for use in the Bare Peat Mapper app.
##
##
##
## R version 3.6.1 (2019-07-05)
## Dependencies:
## purrr_0.3.4       stringr_1.4.0     dplyr_0.8.5
## gdalUtils_2.0.3.2 raster_3.0-7      sp_1.3-1
##
## ############################## ##


## Preparing raster layers

library(raster)
library(sp)
library(gdalUtils)
library(dplyr)
library(stringr)
library(purrr)

#set gdal to find the python scripts on your local machine - will be where QGIS is installed
gdalUtils::gdal_setInstallation()

# list all imagery and bare layers
allimg <- list.files(paste0('Data'),full.names=T,recursive=T)
#iterate through list
purrr::map(allimg,.f=function(img){
  # if bare peat then only reproject to wgs84 using bilinear interpolation
  if(stringr::str_detect(basename(img),'barepeat')){
    gdalUtils::gdalwarp(srcfile = img, dstfile = gsub('.tif',img,replacement='WGS84.tif'), s_srs = 'EPSG:27700',t_srs ='EPSG:4326', r = 'bilinear', overwrite = T, verbose = T)
  } else{ # if S2 data then reproject to wgs84 and resample to 25m using bilinear interpolation
    t.resol <- c(0.0003557190497098270754,0.0003557190497098270754)
    gdalUtils::gdalwarp(srcfile = img, dstfile = gsub('.tif',img,replacement='WGS84.tif'), r = 'bilinear', tr=t.resol,  s_srs = 'EPSG:27700',t_srs ='EPSG:4326', overwrite = T, verbose = T)
  }
})


## calculating bare peat totals
allimg <- list.files(paste0('Data'),full.names=T,recursive=T, pattern='barepeat')
date_cover <- NULL
date_cover <-purrr::map_df(allimg, .f=function(tif){
  bareimg <- raster::raster(tif)
  #add all percentage covers
  barecov <-cellStats(bareimg,'sum')
  #get total cover by filling all non masked cells with 100% cover
  bareimg[!is.na(bareimg)] <- 1
  allcov <-cellStats(bareimg,'sum')
  totcov <- barecov/allcov *100
  #get site info
  site <- tif %>% str_split('/') %>% unlist() %>% purrr::pluck(3)
  #get date info
  date <- tif %>% dirname() %>% list.files(pattern="SEN2") %>% basename() %>% stringr::str_extract("\\d{8}") %>% lubridate::ymd()
  #all data
  site_dat <- data.frame(site=site,date=date,barecover=totcov) %>% mutate_all(as.character)
  site_dat
  })

write.csv(date_cover, 'Data/sitecovertotals.csv')


