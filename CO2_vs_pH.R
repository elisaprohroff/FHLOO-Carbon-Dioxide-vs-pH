################ set working directory ###############################

rm(list = ls())

setwd('C:/Users/e/Desktop/Kirk REU FHLOO Data')

install.packages("cran")
install.packages("zoo")
install.packages('rlang')
install.packages(
  "ggplot2",
  repos = c("http://rstudio.org/_packages",
            "http://cran.rstudio.com")
)

###############load libraries #############################
library(ggplot2)
library(scales)
library(grid)
library(dplyr)
library(lubridate)
library(readxl)
library(tidyr)
library(plotly)
library(dygraphs)
library(xts)          # To make the conversion data-frame / xts format
library(tidyverse)
library(zoo)
#library(cran)

################ Open FHLOO as CSV ######################

FHLOO <- read.csv('FHLOO TXT - Copy.CSV', na.strings=c("-9999","NaN"))


colnames(FHLOO)

#parse date into months?? (group dates into months)


# Read the data, turn nonexistent data to "NaN"
FHLOO <- read.table("FHLOO TXT - Copy.CSV", na.strings=c("-9999","NaN"), header=T, sep=",") %>% head(2154)

colnames(FHLOO)

# Change character string to date&time in POSIXct
FHLOO$Date <- ymd_hms(FHLOO$PDT) 

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Scatter and Bubble Plots ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

pHCO2 <- ggplot(data = FHLOO, aes(x = pH, y = CO2_uAtm, size = SBE37Sal_PSU, color = Fresh)) +
  geom_point(alpha = 0.3) +
  theme_bw()

ggplotly(pHCO2)


