# Replicating the Analysis of Effects of Hurricane Disturbance on Stream Water Concentrations in Bisley, Puetro Rico Streams Before and After Hurricane Hugo

## Repository Purpose
This GitHub repository houses the final project for EDS214. The aim is to replicate Figure 3 from Schaefer et al. (2000), displaying the concentration of five different ions in Bisley, Puetro Rico streams before and after Hurricane Hugo.

## Data Access
### Packages: 
library(tidyverse)

### Data: 
The raw datasets are housed in this GitHub repo in the data folder. The relevant files for the figure are:

RioMameyesPuenteRoto.csv

QuebradaCuenca1-Bisley.csv

QuebradaCuenca2-Bisley.csv

QuebradaCuenca3-Bisley.csv

The data can also be sourced online at [EDI Data Portal](https://portal.edirepository.org/nis/mapbrowse?packageid=knb-lter-luq.20.4923064).

## Repository Structure

The repository contains all of the data, code and figures produced for this project. It has the following structure:

- data: This folder contains the raw input data used for the analysis.
- docs: This folder contains the rendered version of the analysis.
- output: This folder contains the cleaned and processed data set ready to be plotted. 
- paper: This folder contains the code manuscript
- R: This folder contains the R script with the function definiton for moving average.
- 1_clean_data.R: This contains the script that was used to clean and processes the data.
- scratch: This contains the rough draft of the code manuscript.

## Current Contributors
### Author: 
Rachel Miller, UC Santa Barbara [https://github.com/RachelMGitH]

### Contributors:
Amapola Garcia [https://github.com/Amapolaa]
Courtney lorey [https://github.com/cllorey]


## References
McDowell, William H., and USDA Forest Service. International Institute Of Tropical Forestry (IITF). 2024. “Chemistry of Stream Water from the Luquillo Mountains.” Environmental Data Initiative. https://doi.org/10.6073/PASTA/F31349BEBDC304F758718F4798D25458.

Schaefer, Douglas. A., William H. McDowell, Fredrick N. Scatena, and Clyde E. Asbury. 2000. “Effects of Hurricane Disturbance on Stream Water Concentrations and Fluxes in Eight Tropical Forest Watersheds of the Luquillo Experimental Forest, Puerto Rico.” Journal of Tropical Ecology 16 (2): 189–207. https://doi.org/10.1017/s0266467400001358.

