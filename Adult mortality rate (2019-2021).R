# Prepare packages and workspace

# For Data Cleaning, Analysis and Visualization
library(tidyverse)
library(psych)
# For Heatmap Correlation
library(reshape2)
# For Regression model and fit
library(modelr)
library(sandwich)
library(lmtest)
library(tseries)

setwd("C:/Users/gabri/Proyectos R/Adult Mortality Rate")

# Upload Data

Adult_mortality <- read.csv("C:/Users/gabri/Proyectos R/Adult Mortality Rate/Adult mortality rate (2019-2021).csv", stringsAsFactors = TRUE)

# Data Cleaning and Preprocessing :

# Quick View of Data and Structure :

# First 6 Observations of the dataset
head(Adult_mortality)

# View of Structure
glimpse(Adult_mortality)

# Check Missing Values
colSums(is.na(Adult_mortality))

# Handling Outliers :

# Quick view of Statistical information about numeric variables
describe(
  Adult_mortality %>%
    select_if(is.numeric)
)

# Boxplots for better visualization of statistical information
ggplot(Adult_mortality, aes(x = "", y = Average_Pop.thousands.people.)) +
  geom_boxplot() +
  labs(title = "Boxplot of Average Population (thousands of people)",
       x = NULL,
       y = "Average Population (thousands)")

ggplot(Adult_mortality, aes(x = "", y = Average_GDP.M..)) +
  geom_boxplot() +
  labs(title = "Boxplot of Average GDP (in millions of dollars)",
       x = NULL,
       y = "Average GDP (M$)")

ggplot(Adult_mortality, aes(x = "", y = Average_GDP_per_capita...)) +
  geom_boxplot() +
  labs(title = "Boxplot of Average GDP per Capita",
       x = NULL,
       y = "Average GDP per Capita")

ggplot(Adult_mortality, aes(x = "", y = Average_HEXP...)) +
  geom_boxplot() +
  labs(title = "Boxplot of Average Health Expenditure Per Capita",
       x = NULL,
       y = "Average Health Expenditure Per Capita ($)")


ggplot(Adult_mortality, aes(x = "", y = AMR_female.per_1000_female_adults.)) +
  geom_boxplot() +
  labs(title = "Boxplot of AMR (per 1000 Female Adults)",
       x = NULL,
       y = "AMR (per 1000 Female Adults)")

ggplot(Adult_mortality, aes(x = "", y = AMR_male.per_1000_male_adults.)) +
  geom_boxplot() +
  labs(title = "Boxplot of AMR (per 1000 Male Adults)",
       x = NULL,
       y = "AMR (per 1000 Male Adults)")

ggplot(Adult_mortality, aes(x = "", y = Average_CDR)) +
  geom_boxplot() +
  labs(title = "Boxplot of Average Crude Mortality Rate",
       x = NULL,
       y = "Average Crude Mortality Rate")


# Data Analysis :

# Some visualizations

# Bar plot for Average GDP per capita grouped by Continent
ggplot(Adult_mortality, aes(x = reorder(Continent, Average_GDP_per_capita...), 
                            y = Average_GDP_per_capita..., 
                            fill = Continent)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  coord_flip() +
  labs(title = "Average GDP per Capita by Continent",
       x = "Continent",
       y = "Average GDP per Capita")

# Bar plot for Average Population grouped by Continent
ggplot(Adult_mortality, aes(x = reorder(Continent, Average_Pop.thousands.people.), 
                            y = Average_Pop.thousands.people., 
                            fill = Continent)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  coord_flip() +
  labs(title = "Average Population by Continent",
       x = "Continent",
       y = "Average Population (thousands)")

# Density plot for Health Expenditure Per Capita grouped by Development Level
ggplot(Adult_mortality, aes(x = Average_HEXP..., fill = Development_level)) +
  geom_density(alpha = 0.6) +
  labs(title = "Health Expenditure Per Capita Density by Development Level",
       x = "Health Expenditure Per Capita",
       fill = "Development Level")

# Density plot for Adult Mortality Rate (Female) grouped by Development Level
ggplot(Adult_mortality, aes(x = AMR_female.per_1000_female_adults., fill = Development_level)) +
  geom_density(alpha = 0.6) +
  labs(title = "Adult Mortality Rate (Female) Density by Development Level",
       x = "AMR Female (per 1000 Female Adults)",
       fill = "Development Level")

# Density plot for Adult Mortality Rate (Male) grouped by Development Level
ggplot(Adult_mortality, aes(x = AMR_male.per_1000_male_adults., fill = Development_level)) +
  geom_density(alpha = 0.6) +
  labs(title = "Adult Mortality Rate (Male) Density by Development Level",
       x = "AMR Male (per 1000 Male Adults)",
       fill = "Development Level")


# Boxplot of Avg Crude Mortality by Continent
ggplot(Adult_mortality, aes(reorder(Continent, Average_CDR), Average_CDR, color = Continent)) +
  geom_boxplot(show.legend = FALSE) +
  coord_flip() +
  labs(title = "Boxplot of Average Crude Mortality Rate by Continent",
       x = "Continent",
       y = "Average Crude Mortality Rate")

# Boxplot of Avg Crude Mortality by Continent
ggplot(Adult_mortality, aes(reorder(Development_level, Average_CDR), Average_CDR, color = Development_level)) +
  geom_boxplot(show.legend = FALSE) +
  coord_flip() +
  labs(title = "Boxplot of Average Crude Mortality Rate by Development_level",
       x = "Development_level",
       y = "Average Crude Mortality Rate")

# Correlation between Variables

# Calculate correlation matrix
correlation <- cor(
  Adult_mortality %>%
    select_if(is.numeric)
)

# Melt correlation matrix for plotting
correlation_data <- melt(correlation)

# Plot correlation heatmap
ggplot(correlation_data, aes(Var1, Var2, fill = value))+
  geom_tile()+
  scale_fill_gradient2(low = "lightblue", high = "#F94C10", mid = "#F8DE22", 
                       midpoint = 0, limit = c(-1,1), 
                       name = "Correlation") +
  theme_minimal() +
  geom_text(aes(label = round(value, 2)))+
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Correlation Heatmap", x = "", y = "")

# Linear Regression Model

# Model Creation

# Create linear regression model
Regresion_model <- lm(Average_CDR ~  Average_GDP.M.. + AMR_male.per_1000_male_adults.+ Development_level+ Continent, data = Adult_mortality)

# Display model summary
summary(Regresion_model)

# Model Fit

# Add predictions and residuals to the data
Ajust <- Adult_mortality %>%
  add_predictions(Regresion_model) %>%
  add_residuals(Regresion_model)

# Plot diagnostic plots
par(mfrow = c(2,2))
plot(Regresion_model)

# Checking the normality of the model:

# Jarque-Bera test for normality
jarque.bera.test(Ajust$resid)

# Summary of residuals
summary(Ajust$resid)

# Checking the Heteroscedasticity of the model :

# Breusch-Pagan test for heteroscedasticity
bptest(Regresion_model)

# Heteroscedasticity-robust coefficient test
coeftest(Regresion_model, vcov = vcovHC(Regresion_model, type = "HC2"))
