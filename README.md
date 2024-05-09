# Adult-Mortality-Rate-EDA

This repository contains an Exploratory Data Analysis (EDA) on adult mortality, conducted using R Studio. The data used is sourced from reliable datasets and has undergone thorough cleaning and preprocessing for analysis. The EDA includes detailed visualizations, descriptive statistics, and potentially predictive models to better understand the factors associated with adult mortality. This project aims to provide valuable insights and information on this crucial topic, with the goal of contributing to knowledge and discussions in the field of public health and epidemiology.

## Introduction

In today’s world, understanding and predicting mortality rates in different countries is of paramount importance for public health officials, policymakers, and researchers. Mortality rates are not only indicators of a country’s health status but also reflect the effectiveness of its healthcare systems, socio-economic conditions, and various other factors.

The global COVID-19 pandemic has underscored the critical need for accurate mortality rate predictions to effectively allocate resources, implement preventive measures, and devise policies aimed at minimizing the impact of future health crises. However, mortality rates are influenced by a multitude of complex factors, including demographics, healthcare infrastructure, lifestyle choices, and environmental conditions.

In this context, the development of regression models to predict mortality rates in countries becomes a significant endeavor. By leveraging historical data and incorporating relevant predictors, such as population demographics, economic indicators, and healthcare expenditures, we can strive to create robust regression models capable of providing valuable insights into mortality trends and facilitating proactive interventions.

The ultimate goal of this research is to build a regression model that accurately predicts mortality rates in different countries. Such a model could empower decision-makers with actionable insights to enhance public health policies, allocate resources efficiently, and ultimately improve the well-being and longevity of populations worldwide.

## The Data

**Dataset Overview: Adult Mortality Rate (2019-2021)**

The dataset provides comprehensive information on adult mortality rates across different countries from 2019 to 2021. Below is a summary table detailing key variables and their descriptions:

**Adult mortality rate (2019-2021).csv**

| Variable              | Description                                                                                           |
|-----------------------|-------------------------------------------------------------------------------------------------------|
| Countries             | Country of study.                                                                                     |
| Continent             | Continent location of the country.                                                                    |
| Average_Population    | Average population of the country under study for 2019-2021 in thousands.                              |
| Average_GDP           | Average GDP of the country under study for 2019-2021 in millions of dollars.                           |
| Average_GDP_per_capita | Average GDP per capita of the country under study for 2019-2021 in dollars.                          |
| Average_HEXP          | Health Expenditure Per Capita in the country under study in dollars.                                   |
| Development_level     | Level of development of the state under study (calculated by GDP per capita of the country).          |
| AMR_female            | Average mortality of adult women in the country under study (per 1000 adult women per year) for 2019-2023. |
| AMR_male              | Average mortality of adult men in the country under study (per 1000 adult men per year) for 2019-2023. |
| Average_CDR           | Average crude mortality rate for 2019–2021 in the country under study.                                 |
