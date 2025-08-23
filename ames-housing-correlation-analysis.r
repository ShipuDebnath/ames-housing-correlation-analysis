# Ames Housing Correlation and Price Analysis
# Purpose: Visualize correlations with a custom function and analyze Ames housing data
# Author: Shipu Debnath
# Date: August 22, 2025

# Install and load required packages
if (!requireNamespace("AmesHousing", quietly = TRUE)) install.packages("AmesHousing")
if (!requireNamespace("GGally", quietly = TRUE)) install.packages("GGally")
if (!requireNamespace("ggcorrplot", quietly = TRUE)) install.packages("ggcorrplot")
if (!requireNamespace("scales", quietly = TRUE)) install.packages("scales")

library(tidyverse)      # Data manipulation and visualization
library(MASS)           # Multivariate normal distribution for simulations
library(AmesHousing)    # Ames Housing Dataset
library(dplyr)          # Data manipulation
library(GGally)         # Correlation plots
library(ggcorrplot)     # Correlation matrix visualization
library(scales)         # Formatting (e.g., dollar signs)

# Custom function to visualize correlation
Assoc <- function(corr) {
  if (abs(corr) <= 1) {
    # Generate simulated bivariate normal data
    data <- mvrnorm(n = 1000, mu = c(0, 0), 
                    Sigma = matrix(c(1, corr, corr, 1), nrow = 2), 
                    empirical = TRUE)
    X <- data[, 1]
    Y <- data[, 2]
    XY <- as.data.frame(cbind(X, Y))
    
    # Create scatter plot
    p <- ggplot(XY, aes(x = X, y = Y, color = "#1ba16b")) + 
      geom_point() + 
      labs(title = paste("Correlation =", round(cor(X, Y), 2))) + 
      theme_light() + 
      guides(color = "none")  # Remove legend for color
    print(p)
    ggsave(paste0("plots/correlation_", corr, ".png"), p, width = 6, height = 5)
  } else {
    print("ERROR: Correlation cannot be greater than 1 or less than -1")
  }
}

# Test the function with various correlation values
corr_values <- c(-1, -0.8, -0.5, -0.3, -0.1, 0, 0.02, 0.25, 0.5, 0.65, 0.9, 1, 2)
for (corr in corr_values) Assoc(corr)

# Load and inspect Ames Housing Dataset
ames_raw <- make_ames()
# View(ames_raw)  # Remove for GitHub, use head() instead
head(ames_raw)

# Select relevant variables and create derived BathRooms
ames_processed <- ames_raw %>%
  dplyr::select(Sale_Price, Lot_Area, Gr_Liv_Area, Full_Bath, Half_Bath, 
                Fireplaces, Garage_Cars) %>%
  mutate(BathRooms = Full_Bath + (Half_Bath * 0.5)) %>%
  dplyr::select(-Full_Bath, -Half_Bath) %>%  # Remove original bath columns
  na.omit()  # Remove rows with missing values

# Summary statistics
summary(ames_processed)

# Compute and visualize correlation matrix
cor_matrix <- round(cor(ames_processed), 3)
ggcorrplot(cor_matrix, lab = TRUE, title = "Correlation Matrix of Ames Housing Variables")
ggsave("plots/correlation_matrix.png", width = 8, height = 6)

# Pairwise correlation plot
ggpairs(ames_processed, title = "Pairwise Relationships in Ames Housing Data")
ggsave("plots/pairwise_correlations.png", width = 10, height 10)

# Scatter plot with regression line for Gr_Liv_Area vs. Sale_Price
scatter_plot <- ggplot(ames_processed, aes(x = Gr_Liv_Area, y = Sale_Price)) +
  geom_point(color = "#1ba16b") +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  scale_y_continuous(labels = dollar_format()) +
  labs(title = "Sale Price vs. Living Area in Ames, Iowa",
       x = "Home Living Area Size (sq. feet)",
       y = "Price Home Sold For ($)") +
  theme_light()
print(scatter_plot)
ggsave("plots/sale_price_vs_living_area.png", scatter_plot, width = 8, height 6)
