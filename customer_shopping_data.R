# Install and load packages
required_packages <- c("tidyverse", "lubridate", "ggplot2", "gridExtra")

install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# Install and load the packages
sapply(required_packages, install_if_missing)

# Import needed Libraries
library(tidyverse)
library(lubridate)
library(ggplot2)
library(gridExtra)

# Reading the Data
df <- read.csv("C:/Users/Shakir Ullah Shakir/Downloads/customer_shopping_data.csv")
df
# Exploring the Data
dim(df)
head(df)
tail(df)
str(df)
summary(df)
sum(is.na(df))
sum(duplicated(df))

# Cleaning the Data
colnames(df)
df$invoice_date <- dmy(df$invoice_date)

df$year <- year(df$invoice_date)
df$month <- month(df$invoice_date)
head(df)
str(df)

# Analysis and Visualization

# Gender
Gender <- df %>%
  count(gender) %>%
  rename(count = n)

ggplot(Gender, aes(x = "", y = count, fill = gender)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  scale_fill_manual(values = c("#FFB6D9", "#99DBF5")) +
  labs(title = "Male VS Female") +
  theme_void() +
  theme(legend.position = "right")

# Gender with Category
Genderwithcategory <- df %>%
  group_by(gender, category) %>%
  count() %>%
  ungroup()

ggplot(df, aes(x = category, fill = gender)) +
  geom_bar(position = "dodge") +
  scale_fill_manual(values = c("#FFB6D9", "#99DBF5")) +
  labs(title = "Count of Category by Gender", x = "Category", y = "Count") +
  theme_minimal()

# Gender with average age
Genderwithavgage <- df %>%
  group_by(gender) %>%
  summarise(age = mean(age))

ggplot(Genderwithavgage, aes(x = gender, y = age, fill = gender)) +
  geom_bar(stat = "identity", width = 0.5) +
  scale_fill_manual(values = c("#FFB6D9", "#99DBF5")) +
  labs(title = "Gender VS Average of Age", x = "Gender", y = "Average Age") +
  theme_minimal() +
  theme(legend.position = "none")

# Gender with Price
Genderwithprice <- df %>%
  group_by(gender) %>%
  summarise(price = sum(price))

ggplot(Genderwithprice, aes(x = gender, y = price, fill = gender)) +
  geom_bar(stat = "identity", width = 0.5) +
  scale_fill_manual(values = c("#FFB6D9", "#99DBF5")) +
  labs(title = "Price by Gender", x = "Gender", y = "Total Price") +
  theme_minimal() +
  theme(legend.position = "none")

# Age
age <- df %>%
  count(age) %>%
  rename(count = n)

ggplot(age, aes(x = age, y = count)) +
  geom_bar(stat = "identity", fill = 'darkred') +
  labs(title = "Count of Age", x = "Age", y = "Count") +
  theme_minimal()

# Age with Quantity
AgewithQuantity <- df %>%
  group_by(age) %>%
  summarise(quantity = sum(quantity))

ggplot(AgewithQuantity, aes(x = age, y = quantity)) +
  geom_bar(stat = "identity", fill = 'darkred') +
  labs(title = "Number of Quantity VS Age", x = "Age", y = "Total Quantity") +
  theme_minimal()

# Category with Quantity
Categorywithquantity <- df %>%
  group_by(category) %>%
  summarise(quantity = sum(quantity))

ggplot(Categorywithquantity, aes(x = category, y = quantity)) +
  geom_bar(stat = "identity", fill = 'darkred') +
  labs(title = "Category VS Quantity", x = "Category", y = "Total Quantity") +
  theme_minimal()

ggplot(Categorywithquantity, aes(x = "", y = quantity, fill = category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Category VS Quantity", x = "Category", y = "Total Quantity") +
  theme_void() +
  theme(legend.position = "right")

# Category with Price
CategorywithPrice <- df %>%
  group_by(category) %>%
  summarise(price = sum(price))

ggplot(CategorywithPrice, aes(x = "", y = price, fill = category)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Category VS Price") +
  theme_void() +
  theme(legend.position = "right")

# Price with years
Pricewithyears <- df %>%
  group_by(year) %>%
  summarise(price = sum(price))

ggplot(Pricewithyears, aes(x = "", y = price, fill = as.factor(year))) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(title = "Price VS Years") +
  theme_void() +
  theme(legend.position = "right")

# Payment Method
payment_method <- df %>%
  count(payment_method) %>%
  rename(count = n)

ggplot(payment_method, aes(x = payment_method, y = count, fill = payment_method)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("#FFB6D9", "#99DBF5", "darkred")) +
  labs(title = "Payment Method VS Count", x = "Payment Method", y = "Count") +
  theme_minimal() +
  theme(legend.position = "none")

# Shopping Mall
shopping_mall <- df %>%
  count(shopping_mall) %>%
  rename(count = n)

ggplot(shopping_mall, aes(x = shopping_mall, y = count)) +
  geom_bar(stat = "identity", fill = 'darkred') +
  labs(title = "Shopping Mall VS Quantity Sell", x = "Shopping Mall", y = "Quantity Sell") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Orders with Years
years_gender <- df %>%
  group_by(year, gender) %>%
  count()

ggplot(years_gender, aes(x = year, y = n, fill = gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("#FFB6D9", "#99DBF5")) +
  labs(title = "Orders in Years", x = "Year", y = "Order Frequency") +
  theme_minimal()


# Convert month to a factor with ordered levels
df$month <- factor(df$month, levels = as.character(1:12), labels = month.name)

# Group by month and gender, and count the occurrences
months_gender <- df %>%
  group_by(month, gender) %>%
  count() %>%
  rename(count = n)

# Plot the data
ggplot(months_gender, aes(x = month, y = count, fill = gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("#FFB6D9", "#99DBF5")) +
  labs(title = "Orders in Months", x = "Month", y = "Order Frequency") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Correlation Heatmap
numeric_df <- df %>%
  select(where(is.numeric))

cor_matrix <- cor(numeric_df)

ggplot(data = as.data.frame(as.table(cor_matrix)), aes(Var1, Var2, fill = Freq)) +
  geom_tile() +
  geom_text(aes(label = round(Freq, 2)), color = "white") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0) +
  labs(title = "Correlation Matrix") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



