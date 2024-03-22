# Set working directory
setwd("C:/Users/spork/Desktop") 

# Load required package
if (!require("readr")) install.packages("readr")
library(readr)

# Import CSV file
wages <- read_csv("wages.csv")  # Replace "wages.csv" with the actual filename


if (!require("mice")) install.packages("mice")
if (!require("modelsummary")) install.packages("modelsummary")
library(mice)
library(modelsummary)

wages <- wages[complete.cases(wages[, c("hgc", "tenure")]), ]


summary_table <- summary(lm(logwage ~ hgc + college + tenure + age + married, data = wages))
summary_table

## imputation method 1##
wages1 <- wages[complete.cases(wages$logwage), ]
regression_model_wages1 <- lm(logwage ~ hgc + college + tenure + I(tenure^2) + age + married, data = wages1)
summary(regression_model_wages1)



## imputation method 1##
imputed_data <- mice(wages, method = "mean")
wages2 <- complete(imputed_data)
regression_model_wages2 <- lm(logwage ~ hgc + college + tenure + I(tenure^2) + age + married, data = wages2)
summary(regression_model_wages2)



## imputation method 3##
regression_model_complete <- lm(logwage ~ hgc + college + tenure + I(tenure^2) + age + married, data = wages1)
wages$predicted_logwage <- predict(regression_model_complete, newdata = wages)
wage3 <- wages
wage3$logwage[is.na(wage3$logwage)] <- wage3$predicted_logwage[is.na(wage3$logwage)]
wage3 <- wage3[, -which(names(wage3) == "predicted_logwage")]


## Perform multiple imputation using mice ##
imputed_data <- mice(wages, method = "pmm", m = 5)  # Change "pmm" to your desired imputation method
fit_models <- with(imputed_data, lm(logwage ~ hgc + college + tenure + I(tenure^2) + age + married))
pooled_results <- pool(fit_models)
wage4 <- data.frame(pooled_results)
summary(wage4)




# Create a list of regression models
regression_models <- list(
  "wages1" = regression_model_wages1,
  "wages2" = regression_model_wages2,
  "wage3" = regression_model_complete,  
  "wage4" = pooled_results
)
# Create a regression table
regression_table <- msummary(regression_models)
# Display the regression table
regression_table




