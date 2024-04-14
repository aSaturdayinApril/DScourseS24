if (!require("remotes")) install.packages("remotes")
remotes::install_cran(c("sampleSelection", "tidyverse", "modelsummary"))
if (!require("modelsummary")) install.packages("modelsummary")
library(modelsummary)





setwd("C:/Users/spork/Desktop")
wages_data <- read.csv("wages12.csv")
head(wages_data)



wages_data$college <- factor(wages_data$college)
wages_data$married <- factor(wages_data$married)
wages_data$union <- factor(wages_data$union)



if (!require("modelsummary")) install.packages("modelsummary")

library(modelsummary)
summary_table <- summary(wages_data)
summary_table




missing_rate <- sum(is.na(wages_data$logwage)) / nrow(wages_data)
missing_rate




# Load necessary libraries
if (!require("mice")) install.packages("mice")
if (!require("dplyr")) install.packages("dplyr")
if (!require("broom")) install.packages("broom")

library(mice)
library(dplyr)
library(broom)

imputed_data <- mice(wages_data, method = "pmm", m = 5)  # Impute missing values using Predictive Mean Matching (pmm)
complete_cases_data <- complete(imputed_data, 1)
regression_model <- lm(logwage ~ hgc + union + college + exper + I(exper^2), data = complete_cases_data)
summary(regression_model)




if (!require("dplyr")) install.packages("dplyr")
if (!require("broom")) install.packages("broom")

library(dplyr)
library(broom)

wages_data_imputed <- wages_data %>%
  mutate(logwage_imputed = ifelse(is.na(logwage), mean(logwage, na.rm = TRUE), logwage))
complete_cases_data <- na.omit(wages_data_imputed)
regression_model <- lm(logwage_imputed ~ hgc + union + college + exper + I(exper^2), data = complete_cases_data)
summary(regression_model)








if (!require("sampleSelection")) install.packages("sampleSelection")
library(sampleSelection)
wages_data$valid <- ifelse(!is.na(wages_data$logwage), 1, 0)
wages_data$logwage_recode <- ifelse(is.na(wages_data$logwage), 0, wages_data$logwage)
heckman_model <- selection(selection = valid ~ hgc + union + college + exper + married + kids,
                           outcome = logwage_recode ~ hgc + union + college + exper + I(exper^2),
                           data = wages_data, method = "2step")
summary(heckman_model)







if (!require("modelsummary")) install.packages("modelsummary")
library(modelsummary)
regression_model_1 <- lm(logwage ~ hgc + union + college + exper + I(exper^2), data = complete_cases_data)
regression_model_2 <- lm(logwage_imputed ~ hgc + union + college + exper + I(exper^2), data = complete_cases_data)
heckman_model <- selection(selection = valid ~ hgc + union + college + exper + married + kids,
                           outcome = logwage_recode ~ hgc + union + college + exper + I(exper^2),
                           data = wages_data, method = "2step")


models <- list(regression_model_1, regression_model_2, heckman_model)
Regression_table <- modelsummary(models, stars = TRUE)
View(regression_table)







probit_model <- glm(union ~ hgc + college + exper + married + kids, 
                    data = wages_data, 
                    family = binomial(link = "probit"))
summary(probit_model)








predicted_prob_original <- predict(probit_model, type = "response")
original_avg_prob <- mean(predicted_prob_original)
probit_model_counterfactual <- probit_model
probit_model_counterfactual$coefficients["married"] <- 0
probit_model_counterfactual$coefficients["kids"] <- 0

predicted_prob_counterfactual <- predict(probit_model_counterfactual, type = "response")

counterfactual_avg_prob <- mean(predicted_prob_counterfactual)

comparison <- data.frame(
  Original = original_avg_prob,
  Counterfactual = counterfactual_avg_prob
)

View(comparison)
