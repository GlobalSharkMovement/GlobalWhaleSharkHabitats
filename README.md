# Climate-driven global redistribution of an ocean giant predicts increased threat from shipping
[![DOI](https://zenodo.org/badge/798262494.svg)](https://zenodo.org/doi/10.5281/zenodo.13170642)

This repository contains derived and example data alongside novel code used in Womersley et al., (published in Nature Climate Change, 2024) where we explore climate change responses of whale shark habitats and potential co-occurrence with shipping traffic globally. For this we used a whale shark satellite-tracking dataset spanning 15 years, including tagging sites in all major oceans they inhabit (348 individuals collectively tracked for over 15,000 days) together with oceanographic variables and global climate models from the Coupled Model Intercomparison Phase 6 (CMIP6). Species distribution models were developed to (i) generate a first order approximation of global habitat suitability and (ii) project the distribution of whale sharks in two future decades under three mitigation scenarios. These were then used to (iii) assess habitat changes and horizontal co-occurrence with shipping traffic.

**Open source data used in the study are freely avaiable online at:**

Environmental data are available at https://data.marine.copernicus.eu/products. CMIP6 data are available at https://esgf-ui.ceda.ac.uk/cog/search/cmip6-ceda/. Shipping data are available upon request to Global Fishing Watch (https://www.globalfishingwatch.org). Ocean Biodiversity Information System (OBIS) and SharkBook whale shark observation data are available at https://obis.org (open) and https://www.sharkbook.ai/ (upon request), respectively. AquaMaps data are available at https://www.aquamaps.org. Exclusive Economic Zone (EEZ) boundary data are available at https://www.marineregions.org/downloads.php. Large Marine Ecosystem (LME) boundary data are available at https://github.com/datasets/lme-large-marine-ecosystems/. Land boundary data are available at https://www.naturalearthdata.com. International Union for Conservation of Nature (IUCN) boundary data are available at https://www.iucnredlist.org/ja/species/19488/2365291. 

**This repository contains:**

### Current

The [Current](/Current) folder contains derived data on present day predictions of whale shark habitat suitability (0 - 1) based on satellite telemetry data of shark movements, Generalised Additive Models, and climatologies for the years 2005 - 2019.
 
Whale shark habitat suitability predictions are given for each month (suffix refers to the month, i.e. '_2' is a prediction for February), an average across months (suffix '_avg'), and each region in the study. Predictions are at the ocean basin scale, but based on tracking data from within one of seven ocean regions. The regional abbreviation is given in the file name (i.e. ATLN is the north Atlantic subset). Shapefiles of regional boundaries are in the [Boundaries](/Boundaries) folder (see below) and to create global maps these boundaries can be used to crop data from each region before joining them together. 

Files are in the '.csv' format and contain gridded data at the 0.25 × 0.25° cell resolution scale, where each row represents a single cell, with 'Longitude' and 'Latitude' columns giving the position of the cell centre. The 'HabitatSuitability' column gives the whale shark habitat suitability (0 - 1) value for each cell. 

### Future

The [Future](/Future) folder contains derived data on change in whale shark habitat suitability values (-1 - +1) from the 2005 - 2019 baseline for two decadal averages (2046 - 2055 and 2086 - 2095) and three scenarios (ssp126, ssp370 and ssp585) based on CMIP6 climatologies. 

Change in whale shark habitat suitability was projected for each decade, ssp and region which are given in the file name (i.e. ATLN_2046-2055_ssp126 contains data from the north Atlantic subset of tracked sharks projected into the years 2046 - 2055 under scenario ssp126). Projections are at the ocean basin scale, but based on tracking data from within one of seven ocean regions. Shapefiles of regional boundaries are in the [Boundaries](/Boundaries) folder (see below). 

Files are in the '.csv' format and contain gridded data at the 0.25 × 0.25° cell resolution scale, where each row represents a single cell, with 'Longitude' and 'Latitude' columns giving the position of the cell centre. The 'HabitatChange' column gives the change in whale shark habitat suitability (-1 - +1) from the baseline value for each cell. 

### Boundaries

The [Boundaries](/Boundaries) folder contains shapefiles for each of the regional boundaries used in the study. ATLN, north Atlantic; ATLS, south Atlantic; INDE, east Indian Ocean; INDNW, northwest Indian Ocean; INDSW, southwest Indian Ocean; PACE, east Pacific; PACW, west Pacific. 

### Code

The [Code](/Code) folder contains an R script ([SCI.R](Code/SCI.R)) and associated example datasets (within the [Example](/Code/Example) sub-folder). The script is used to load in whale shark habitat suitability maps and overlay them with vessel data to determine the shipping co-occurrence index (SCI) for a given spatial boundary and temporal subset; the code is written in R version 4.3.2 (2023-10-31) and annotations are provided for each step.

##
