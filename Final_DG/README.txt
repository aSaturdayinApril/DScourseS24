Overview:
The Dividend Stock Filter project aims to aid investors in identifying potential investment opportunities by filtering dividend stocks. By applying customizable filters, users can narrow down the universe of dividend-paying stocks to those meeting specific criteria.

Features:
- Filtering Options: Choose from a variety of criteria, including dividend yield, payout ratio, financial data, and more.
- Detailed Stock Information: Access detailed information about each filtered stock, including dividend history and financial metrics.
- Export Functionality: Export filtered results to CSV or Excel format for further analysis or record-keeping.

Installation:
Prerequisites:
- R or RStudio
- API key for AlphaVantage.com
- Subscription to stockanalysis.com or Div.csv file

How to Use:
1. Download Data: Obtain data from stockanalysis.com or use the provided Div.csv file.
2. Run R Code: Utilize the segmented R code provided in the project:
   - Part 1: Imports dataset and performs data cleaning.
   - Part 2: Fetches dividend and quote data, adding financial data for multiple stock tickers, and segments the existing dataframe "Div" into two separate top-25 lists.
     *Note: Part 2 may take some time to execute.*
   - Part 3 and 3.5: Integrates earnings data into the top-25 lists due to API limitations.
   - Part 4: Removes tickers with many instances of negative profits and generates a scatterplot of the two data frames.
   - Part 5: Further filters, leaving only the most valuable tickers.

Data Frames Used:
- Div: Base data pulled from stockanalysis.com.
- StackHere, Merge, Ecalc, PN: Temporary data frames used in calculating financial information.
- Columns: Symbol, DivYield, Payout Ratio
- DivFreq: Holds stocks with the highest dividend count
- DivYield: Holds stocks with the highest dividend yield
- Final: Contains the final stock selections

Columns Used:
- Date: Contains either an ex-dividend date or stock quote date.
- Dividends: The dividend amount.
- Symbol: The stock ticker.
- DivCount: A count of the number of times a dividend has been paid.
- DivYield: The dividend yield.
- Pos, Neg, Even: Number of times a firm has reported positive, negative, or break-even profits.
- T: Total financial reporting periods a firm has.
- NRatio: A ratio indicating how often a firm reports negative profits.
