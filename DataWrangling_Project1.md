# DataWrangling_Project1


### Data-Wrangling-Exercise-1-Basic-Data-Manipulation-
The dataset for this exercise was obtained from https://drive.google.com/file/d/0B9vKjeWdQHa5OE5UQ1k4TWJlelU/view    
The following steps needs to completed to finish the exercise    

#### Load the dataset
Save the data set as a CSV file called refine_original.csv and load  the dataset 

```r
data_dir <- "/Users/jeevarehakrishnaraj/Desktop/Springboard/Project 1/JP"
comp_data <- read.csv(file.path(data_dir,"refine_original.csv"),header = TRUE)
```

#### Clean up brand names
Clean up the 'company' column so all of the misspellings of the brand names are standardized. For example, you can transform the values in the column to be: philips, akzo, van houten and unilever (all lowercase)

```r
comp_data$company <- tolower(comp_data$company)
comp_data$company <- str_replace(comp_data$company, "ph.*","philips")
comp_data$company <- str_replace(comp_data$company, "ak.*","akzo")
comp_data$company <- str_replace(comp_data$company, "f.*","philips")
comp_data$company <- str_replace(comp_data$company, "un.*","unilever")
comp_data$company <- str_replace(comp_data$company, "va.*","van houten")
```

#### Separate product code and number    
Separate the product code and product number into separate columns i.e. add two new columns called product_code and product_number, containing the product code and number respectively

```r
newcomp_data <- separate(data = comp_data, col = Product.code...number, into = c("product_code", "product_number"), sep = "-") 
```

#### Add product categories  
You learn that the product codes actually represent the following product categories: p = Smartphone v = TV x = Laptop q = Tablet In order to make the data more readable, add a column with the product category for each record.    

```r
compfunction <- function(x){
  switch(x, p = "Smartphone",v = "TV", x= "Laptop", q = "Tablet")
}

pickproduct <- function(x){
  ifelse(x == 'p', 'Smartphone', ifelse(x=='v','TV',ifelse(x=='x','Laptop',ifelse(x == 'q','Tablet',NA))))
}
```

#### Add full address for geocoding & Create dummy variables for company and product category
You'd like to view the customer information on a map. In order to do that, the addresses need to be in a form that can be easily geocoded. Create a new column full_address that concatenates the three address fields (address, city, country), separated by commas.   

Both the company name and product category are categorical variables i.e. they take only a fixed set of values. In order to use them in further analysis you need to create dummy variables. Create dummy binary variables for each of them with the prefix company_ and product_ i.e., Add four binary (1 or 0) columns for company: company_philips, company_akzo, company_van_houten and company_unilever. Add four binary (1 or 0) columns for product category: product_smartphone, product_tv, product_laptop and product_tablet.

```r
newcomp_data <- newcomp_data %>% mutate(product_category = pickproduct(product_code), full_address = paste(address, city, country, sep=", "),company_philips = ifelse(company == 'phillips', 1, 0),company_akzo = ifelse(company == 'akzo', 1, 0),company_van_houten = ifelse(company == 'van houten', 1, 0),company_unilever = ifelse(company == 'unilever', 1, 0),product_smartphone = ifelse(product_code == 'p', 1, 0),product_tv = ifelse(product_code == 'v', 1, 0),product_laptop = ifelse(product_code == 'x', 1, 0),product_tablet = ifelse(product_code == 'q', 1, 0))
```

#### Submit the project on Github
Include your code, the original data as a CSV file refine_original.csv, and the cleaned up data as a CSV file called refine_clean.csv.

```r
write.csv(x = newcomp_data,file.path(data_dir, file = "refine_clean.csv"))
```
