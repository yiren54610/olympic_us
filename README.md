# Analyzing Women’s Team of USA’s Performances in the Olympic Games

## UPDATE:
An analytical piece on the 2024 Paris Olympics has been created.  
Data includes competitors’ information by sport and medal counts from 1984 to 2020.

## Goal:
The goal of this analysis is to compare percentages of medals obtained, average medal counts per person, and total numbers.

## Programming Languages:
- Python – Beautiful Soup and Pandas  
- Regex  
- HTML  
- Spreadsheets  
- RStudio

## Process Summary

### 1. Set Benchmarks
I identified the benchmarks I wanted to use to compare gender performances.  
I made it clear from the beginning that I wanted to gather data on total medals by sport events and the total population of competitors in each event historically.

### 2. Identify Credible Sources
I researched available datasets through Wikipedia and narrowed down my sources to:
- Olympedia.com
- Olympics.com
- TeamUSA.com

### 3. Scrape Data Using Python & BeautifulSoup
I first experimented with the 1984 Olympics at Olympedia.com ([link to source](https://www.olympedia.org/countries/USA/editions/21)).  
Then, I created a list of URLs for the Summer Olympics pages only and wrote a loop to extract data from each year, saving the data in a CSV file.

Since Olympedia only registered data up to the 2020 Tokyo Olympics, I turned to the Team USA website to manually copy data for the 2024 Olympics.  
I categorized different events of the same sport under one variable (e.g., gymnastics and artistic gymnastics under the same category).

### 4. Clean the Data
I cleaned the CSV file of the raw data and used a pivot table in a spreadsheet to create two separate tables:
- **Table 1:** Historical percentage of female contribution to the total medals from 1984 to 2020
- **Table 2:** Gender percentage, total medals, and competitor population for each sport in 2024

### 5. Load Data into RStudio
I loaded the CSV files into RStudio and converted Table 2 into a long dataframe.

### 6. Plot Charts
To represent the historical trend of female contributions, I used Table 1 to plot a bar chart.  
To compare gender performances across different benchmarks, I used scatter plots to represent:
- Percentage of medal contributions
- Medal counts per person
- Total medals obtained by gender and sport

### 7. Write the Analysis
I wrote the analysis and created an HTML page to display the charts.

## Discussion
Due to time limitations, this project only used 2024 data. A longitudinal analysis should be conducted to complement the lack of detailed chronological analysis.
