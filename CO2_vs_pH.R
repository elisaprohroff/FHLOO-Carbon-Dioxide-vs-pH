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

FHLOO <- read.csv('NANOOS_FHLOO(1).CSV', na.strings=c("-9999","NaN"))


colnames(FHLOO)

#parse date into months?? (group dates into months)


# Read the data, turn nonexistent data to "NaN"
FHLOO <- read.table("NANOOS_FHLOO(1).CSV", na.strings=c("-9999","NaN"), header=T, sep=",") 

colnames(FHLOO)

# Change character string to date&time in POSIXct
FHLOO$Date <- ymd_hms(FHLOO$PDT) 

#~~~~~~~~~~~~~~~~~~~ Create Bins for Salinity ~~~~~~~~~~~~~~~~~~~~~~~

# Initialize empty variable first
FHLOO$Salinity <- NA

#Fill in values (Only 2 Categories)
#FHLOO1$Salinity <- ifelse(FHLOO$SBE37Sal_PSU >= 30, "HighSal", "LowSal")

#Create 3 different thresholds for salinity and separate into high, med, and low
FHLOO$Salinity <- cut(FHLOO$SBE37Sal_PSU, breaks = c(-Inf, 27, 30, Inf),
                       labels = c("LowSal", "MedSal", "HighSal"))

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Scatter and Bubble Plots ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#pdf('rplot.pdf')
pHCO2 <- ggplot(data = FHLOO, aes(x = pH, y = CO2_uAtm, color = Salinity)) +
  geom_point(alpha = 0.4, size = 1.5) +
  theme_bw()

ggplotly(pHCO2)
#dev.off()

