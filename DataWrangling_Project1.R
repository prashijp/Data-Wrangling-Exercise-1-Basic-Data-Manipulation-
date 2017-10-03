
# Load the data in RStudio
data_dir <- "/Users/jeevarehakrishnaraj/Desktop/Springboard/Project 1/JP"
comp_data <- read.csv(file.path(data_dir,"refine_original.csv"),header = TRUE)

# Clean up brand names
comp_data$company <- tolower(comp_data$company)
comp_data$company <- str_replace(comp_data$company, "ph.*","philips")
comp_data$company <- str_replace(comp_data$company, "ak.*","akzo")
comp_data$company <- str_replace(comp_data$company, "f.*","philips")
comp_data$company <- str_replace(comp_data$company, "un.*","unilever")
comp_data$company <- str_replace(comp_data$company, "va.*","van houten")

# Separate product code and number
newcomp_data <- separate(data = comp_data, col = Product.code...number, into = c("product_code", "product_number"), sep = "-") 


# Add product codes to represent product categories
compfunction <- function(x){
  switch(x, p = "Smartphone",v = "TV", x= "Laptop", q = "Tablet")
}

pickproduct <- function(x){
  ifelse(x == 'p', 'Smartphone', ifelse(x=='v','TV',ifelse(x=='x','Laptop',ifelse(x == 'q','Tablet',NA))))
}

# Add full address for geocoding & Create dummy variables for company and product category
newcomp_data <- newcomp_data %>% mutate(product_category = pickproduct(product_code), full_address = paste(address, city, country, sep=", "),company_philips = ifelse(company == 'phillips', 1, 0),company_akzo = ifelse(company == 'akzo', 1, 0),company_van_houten = ifelse(company == 'van houten', 1, 0),company_unilever = ifelse(company == 'unilever', 1, 0),product_smartphone = ifelse(product_code == 'p', 1, 0),product_tv = ifelse(product_code == 'v', 1, 0),product_laptop = ifelse(product_code == 'x', 1, 0),product_tablet = ifelse(product_code == 'q', 1, 0))

# Submit the project 
write.csv(x = newcomp_data,file.path(data_dir, file = "refine_clean.csv"))
