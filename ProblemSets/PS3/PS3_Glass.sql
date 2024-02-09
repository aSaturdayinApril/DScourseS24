sqlite3 PS3_DG.db

-- Read in the Florida insurance data CSV file
.mode csv
.import FL_insurance_sample.csv temp_table

-- Print out the first 10 rows of the data set
SELECT * FROM temp_table LIMIT 10;

-- List which counties are in the sample
SELECT DISTINCT county FROM temp_table;