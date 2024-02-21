##Web Scrape##
if (!require("rvest")) {
  install.packages("rvest")
}
library(rvest)

url <- "https://en.wikipedia.org/wiki/1850_United_States_census"

html_content <- read_html(url)

table_node <- html_nodes(html_content, "#mw-content-text > div.mw-content-ltr.mw-parser-output > table:nth-child(29)")

table_df <- html_table(table_node)

if (length(table_df) > 1) {
  table_df <- table_df[[1]]
}

table_df_1 <- table_df[[1]]
View(table_df_1)


##API##

if (!require("quantmod")) install.packages("quantmod")

# Function to check if dividends are available for a ticker
check_dividends <- function(ticker) {
  dividends <- tryCatch(getDividends(ticker), error = function(e) NULL)
  return(!is.null(dividends) && nrow(dividends) > 0)
}

# Assuming SP5t already contains the SP500tickers column with ticker symbols

# Apply the function to each ticker in the dataframe
SP5t$Has_Dividends <- sapply(SP5t$SP500tickers, check_dividends)

# View the dataframe to see which tickers have dividend information
View(SP5t)
