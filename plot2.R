## Load library
library(lubridate)
library(dplyr)

## Read data
data <- read.table("household_power_consumption.txt", nrows = 60*24*50,
                   stringsAsFactors = FALSE, na.strings = "?", sep = ";",
                   header = TRUE)
data <- data %>% filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
        mutate(Date_time = dmy_hms(paste(Date, Time))) %>%
        select(-Date, -Time)
data <- data[,c(8, 1:7)]

## Plot 2
par(mfrow = c(1, 1))
with(data, plot(Date_time, Global_active_power, type = 'n', xlab = NA,
                ylab = "Global Active Power (kilowatts)"))
with(data, lines(Date_time, Global_active_power))
dev.copy(png, 'plot2.png')
dev.off()