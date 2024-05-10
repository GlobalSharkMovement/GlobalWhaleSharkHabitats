#### CURRENT ####

The 'Current' folder contains derived data on present day predictions of whale shark habitat suitability (0 - 1) based on satellite telemetry data of shark movements, Generalised Additive Models, and climatologies for the years 2005 - 2019.
 
Whale shark habitat suitability predictions are given for each month (suffix refers to the month, i.e. '_2' is a prediction for February), an average across months (suffix '_avg'), and each region in the study. Predictions are at the ocean basin scale, but based on tracking data from within one of seven ocean regions. The regional abbreviation is given in the file name (i.e. ATLN is the north Atlantic subset). Shapefiles of regional boundaries are in the 'Boundaries' folder (see below) and to create global maps these boundaries can be used to crop data from each region before joining them together. 

Files are in the '.csv' format and contain gridded data at the 0.25 × 0.25° cell resolution scale, where each row represents a single cell, with 'Longitude' and 'Latitude' columns giving the position of the cell centre. The 'HabitatSuitability' column gives the whale shark habitat suitability (0 - 1) value for each cell. 

#### FUTURE ####

The 'Future' folder contains derived data on change in whale shark habitat suitability values (-1 - +1) from the 2005 - 2019 baseline for two decadal averages (2046 - 2055 and 2086 - 2095) and three scenarios (ssp126, ssp370 and ssp585) based on CMIP6 climatologies. 

Change in whale shark habitat sutiability was projected for each decade, ssp and region which are given in the file name (i.e. ATLN_2046-2055_ssp126 contains data from the north Atlantic subset of tracked sharks projected into the years 2046 - 2055 under scenario ssp126). Projections are at the ocean basin scale, but based on tracking data from within one of seven ocean regions. Shapefiles of regional boundaries are in the 'Boundaries' folder (see below). 

Files are in the '.csv' format and contain gridded data at the 0.25 × 0.25° cell resolution scale, where each row represents a single cell, with 'Longitude' and 'Latitude' columns giving the position of the cell centre. The 'HabitatChange' column gives the change in whale shark habitat suitability (-1 - +1) from the baseline value for each cell. 

#### BOUNDARIES ####

The 'Boundaries' folder contains shapefiles for each of the regional boundaries used in the study. ATLN, north Atlantic; ATLS, south Atlantic; INDE, each Indian Ocean; INDNW, northwest Indian Ocean; INDSW, southwest Indian Ocean; PACE, east Pacific; PACW, west Pacific. 

For more dertails on the methods or specific definitions please see the paper: 
