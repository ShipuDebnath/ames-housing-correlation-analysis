# Ames Housing Correlation Analysis

## Overview
This project analyzes the Ames Housing Dataset to explore correlations between sale prices and home features (e.g., living area, lot size) using R. It includes a custom function to visualize simulated data with varying correlation coefficients and detailed visualizations of the dataset.

## Dependencies
- R (>= 4.0)
- Packages: `tidyverse`, `MASS`, `AmesHousing`, `dplyr`, `GGally`, `ggcorrplot`, `scales`
- Install: `install.packages(c("tidyverse", "MASS", "AmesHousing", "dplyr", "GGally", "ggcorrplot", "scales"))`

## Data
- Source: Ames Housing Dataset (`make_ames()` from `AmesHousing` package)

## Usage
1. Clone the repository: `git clone https://github.com/ShipuDebnath/ames-housing-correlation-analysis.git`
2. Open R and set the working directory to the repo folder.
3. Run the script: `source("scripts/ames-housing-correlation-analysis.R")`
4. Outputs:
   - Correlation plots in `plots/` (e.g., `correlation_matrix.png`, `sale_price_vs_living_area.png`)
   - Individual correlation visualizations (e.g., `correlation_0.5.png`)

## Key Findings
- Strong positive correlation between `Gr_Liv_Area` and `Sale_Price`.
- Custom `Assoc` function demonstrates correlation effects from -1 to 1.

## Author
Shipu Debnath  
MS Student in Geography, Texas Tech University  
[LinkedIn](https://linkedin.com/in/shipudebnath/) | [Google Scholar](https://scholar.google.com/citations?user=WyP6KUUAAAAJ&hl=en)

## License
MIT License
