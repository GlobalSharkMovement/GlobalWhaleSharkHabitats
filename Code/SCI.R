###############################################################################
######################### SHIPPING CO-OCCURRENCE INDEX ########################
###############################################################################

# This script is used to load in whale shark habitat suitability maps and overlay them with vessel data to determine the shipping co-occurrence index (SCI) for a given spatial boundary and temporal subset.

# R version : 4.3.2 (2023-10-31)

#### PACKAGES ####
packages <- c('plyr','terra','sf','fields')
lapply(packages, install.packages) # install packages as required

library(plyr) # https://cran.r-project.org/web/packages/plyr/index.html
library(terra) # https://cran.r-project.org/web/packages/terra/index.html
library(sf) # https://cran.r-project.org/web/packages/sf/index.html
library(fields) # https://cran.r-project.org/web/packages/fields/index.html

#### OPTIONS ####

years <- c('2046-2055') # set the temporal subset for analysis : this included '2046-2055' and '2086-2095' in the main analysis
ssps <- c('ssp126') # set the socioeconomic pathways where applicable : this included 'ssp126', 'ssp370' and 'ssp585' in the main analysis
depth <- 0.5 # set the <20 m depth use of the species, example here is 50% of time (0.5) : this varied based on region and bathymetry in the main analysis, see https://doi.org/10.1073/pnas.2117440119 for details 

#### FOLDERS ####

dir <- paste0('.../Example/') # set the directory where the 'Example' folder is stored

#### GLOBAL DATA ####

# Boundaries 
boundaries <- list.files(paste0(dir, 'Boundaries/'), recursive = T, full.names = T) # list boundaries
boundaries <- st_read(boundaries[grepl('.shp', boundaries)]) # load in example boundaries 

# Vessels
vessels <- list.files(paste0(dir, 'VesselTraffic/'), recursive = T, full.names = T) # list shipping data

# Sharks
sharks <- list.files(paste0(dir, 'SharkHabitat/'), recursive = T, full.names = T) # list shark habitat data

#### LOAD HABITATS & CALCULATE SCI ####

finalsci <- list() # create list to save looped output

for(i in 1:length(boundaries$id)){
  
  # i <- 1
  boundary <- boundaries[i,] # select boundary
  ship <- mask(rast(vessels[1]), boundary) # crop shipping data to boundary
  summaries1 <- list() # create list to save looped output

  for(y in 1:length(years)){
      
     # y <- 1
     shark <- sharks[grepl(years[y], sharks)] # select year for analysis
     summaries <- list() # create list to save looped output
      
     for(s in 1:length(ssps)){
        
       # s <- 1
       habitat <- rast(read.csv(shark[grepl(ssps[s], shark)]), crs = '+proj=longlat +datum=WGS84') # select ssp and load habitat map
       base <- rast(read.csv(sharks[grepl('2005-2019', sharks)]), crs = '+proj=longlat +datum=WGS84') # load baseline habitat map 

       habitat <- as.data.frame(mask(habitat, boundary), xy=T) # crop habitat to boundary
       base <- as.data.frame(mask(base, boundary), xy=T) # crop habitat to boundary
       
       habitatLs <- list() # create list to save looped output
       baseLs <- list() # create list to save looped output
        
       for(r in 1:nrow(base)){
          
          # r <- 2
          row <- base[r,] # select cell of current habitat 
          
          coords <- crds(ship) # define coordinates of shipping 
          
          dists <- which.min(as.numeric(rdist.earth(cbind(row$x, row$y), coords, miles = FALSE))) # fine closest shipping cell to habitat

          row$ships <- as.numeric(extract(ship, cbind(coords[dists,1], coords[dists,2]))) # extract number of ships
          row$depth <- depth # add vertical shark metric : https://doi.org/10.1073/pnas.2117440119
             
          row$exp <- row$depth * row$ships # calculate ship exposure : https://doi.org/10.1073/pnas.2117440119
          row$sci <- row$exp * row$HabitatSuitability # calculate ship co-occurrence : https://doi.org/10.1073/pnas.2117440119
          
          baseLs[[r]] <- row # save 
         
          row <- habitat[r,] # select cell of future habitat 
         
          row$ships <- as.numeric(extract(ship, cbind(coords[dists,1], coords[dists,2]))) # extract number of ships
          row$depth <- depth # add vertical shark metric : https://doi.org/10.1073/pnas.2117440119
          
          row$exp <- row$depth * row$ships # calculate ship exposure : https://doi.org/10.1073/pnas.2117440119
          row$sci <- row$exp * row$HabitatSuitability # calculate ship co-occurrence : https://doi.org/10.1073/pnas.2117440119
          
          habitatLs[[r]] <- row # save 
          
        } # end for all rows
        
       habitat <- as.data.frame(ldply(habitatLs)) # summarise looped output
       base <- as.data.frame(ldply(baseLs)) # summarise looped output
        
       meansci <- mean(habitat$sci, na.rm = T) # calculate mean future sci for the boundary 
       meanbase <- mean(base$sci, na.rm = T) # calculate mean baseline sci for the boundary 
        
       summary <- c(paste('ID',boundaries$id[i]), years[y], ssps[s], meanbase, meansci, meansci - meanbase, ((meansci - meanbase) / meanbase) * 100) # combine summary
       summaries[[s]] <- summary # save
        
      } # end for all ssps
      
     summaries <- as.data.frame(ldply(summaries)) # summarise looped output
     summaries1[[y]] <- summaries # save
      
    } # end for all years

  summaries1 <- as.data.frame(ldply(summaries1)) # summarise looped output
  finalsci[[i]] <- summaries1 # save
  
  print(paste('ID',boundaries$id[i],'---', i , 'of', length(boundaries$id), ':', length(boundaries$id) - i, 'to go')) # status message
    
} # end for all boundaries

finalsci <- as.data.frame(ldply(finalsci)) # summarise looped output
colnames(finalsci) <- c('boundary', 'year', 'ssp', 'baseMean', 'futureMean','diffMean', 'percDiff') # set names 

# Final sci dataframe
finalsci[,c(4:7)] <- mapply(as.numeric, finalsci[,c(4:7)]) # format final dataframe

finalsci 

# the final dataframe (object: finalsci) contains the boundary id (colname: boundary), the year (colname: year) and ssp (colname: ssp) categories, the mean ship co-occurrence index (SCI) for baseline habitats (2005-2019, colname: baseMean), future habitats (based on year/ssp columns, colname: furtureMean), the difference between the beaseline and furure SCI (colname: diffMean) and the percentage SCI change from the baseline (colname: percDiff). 

###############################################################################
###############################################################################





