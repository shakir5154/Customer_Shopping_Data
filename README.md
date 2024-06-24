# Istanbul Shopping Data Analysis

## Project Overview

Welcome to the shopping world of Istanbul! This project aims to analyze shopping data collected from 10 different shopping malls in Istanbul between 2021 and 2023. The dataset includes information on various aspects such as customer demographics, product categories, payment methods, and shopping trends. The goal is to uncover insights into the shopping habits and patterns of Istanbul's diverse population.

## Dataset Information

The dataset includes the following attributes:

- **invoice_no**: Invoice number (Nominal)
- **customer_id**: Customer number (Nominal)
- **gender**: Customer's gender (String)
- **age**: Customer's age (Positive Integer)
- **category**: Category of the purchased product (String)
- **quantity**: Quantity of each product per transaction (Numeric)
- **price**: Unit price of the product in Turkish Liras (TL) (Numeric)
- **payment_method**: Payment method used (cash, credit card, or debit card) (String)
- **invoice_date**: Date of the transaction (Date)
- **shopping_mall**: Name of the shopping mall (String)

## Project Structure

The project is structured as follows:

- `data/`: Contains the dataset.
- `scripts/`: Contains R scripts for data analysis and visualization.
- `README.md`: Project overview and instructions.

## Getting Started

### Prerequisites

Ensure you have the following R packages installed:

= tidyverse
- lubridate
- ggplot2
= gridExtra

You can install these packages using the following code:

```r
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
