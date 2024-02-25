if (!require("dplyr")) 
  install.packages("dplyr")
library(dplyr)

# Step 1: Remove rows with 0 in "CITYPOP" from both dataframes
data <- data[data$CITYPOP != 0, ]
data2 <- data2[data2$CITYPOP != 0, ]

# Step 2: Group by "CITY" and count distinct entries in "OCC1950", store in new column "OCCCOUNT"
data <- data %>%
  group_by(CITY) %>%
  mutate(OCCCOUNT = n_distinct(OCC1950))

data2 <- data2 %>%
  group_by(CITY) %>%
  mutate(OCCCOUNT = n_distinct(OCC1950))

# Step 3: Remove rows with duplicate entries in "CITY" column
data <- data[!duplicated(data$CITY), ]
data2 <- data2[!duplicated(data2$CITY), ]

# Step 4: Create a plot with City Population on the X-axis and Occupation Count on the Y-Axis
ggplot(data, aes(x = CITYPOP, y = OCCCOUNT)) +
  geom_point() +
  labs(x = "City Population", y = "Occupation Count") +
  ggtitle("Occupation Count vs. City Population")
