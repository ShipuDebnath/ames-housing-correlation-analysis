library(tidyverse)
library(MASS)
Assoc <- function (corr) {
  if(abs(corr)<= 1) {
    data = mvrnorm(n = 1000, mu = c(0, 0), 
                   Sigma = matrix(c(1, corr, corr, 1),
                    nrow = 2), empirical = TRUE)
    X = data[, 1]
    Y = data[, 2]
    XY = as.data.frame(cbind(X, Y))
  ggplot(XY) + geom_point(aes(x = X, y = Y, colours = "#1ba16b")) + 
    labs(title = paste("Corrleation = ", cor(X,Y))) + 
    theme_light() + guides(color = "none")
  } else{print("ERROR: correlation cannot be greater then 1 or less than -1")}
}
Assoc(-1)
Assoc(-.8)
Assoc(-.5)
Assoc(-.3)
Assoc(-.1)
Assoc(0)
Assoc(0.02)
Assoc(0.5)
Assoc(0.25)
Assoc(0.65)
Assoc(0.9)
Assoc(1)
Assoc(2)
install.packages("AmesHousing")
library(AmesHousing)
library(dplyr)
AmesIowa <- make_ames()
View(AmesIowa)
AmesIowa2 <- AmesIowa %>%
  dplyr::select(., "Sale_Price", "Lot_Area", "Gr_Liv_Area", 
                "Full_Bath", "Half_Bath", "Fireplaces", "Garage_Cars")
View(AmesIowa2)
AmesIowa2 %>% mutate(., BathRooms = Full_Bath + (Half_Bath * 0.5)) %>%
  dplyr::select(., -contains("_Bath")) -> AmesIowa3
View(AmesIowa3)
summary(AmesIowa3)
install.packages("GGally", "ggcorplot", "scales")
library(GGally)
library(ggcorrplot)
library(scales)
round(cor(AmesIowa3), 3)
ggcorrplot(cor(AmesIowa3), lab = TRUE)
ggpairs(AmesIowa3)
ggplot(AmesIowa3, aes(x = Gr_Liv_Area, y = Sale_Price)) +
  geom_point() +
  geom_smooth(method=lm, se= FALSE) +
  scale_y_continuous(labels = dollar_format()) +
  labs(x = "Home Living Area Size (sq. feet)",
       y = "Price Home Sold for") +
  theme_light()