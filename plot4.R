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

## Plot 4
png("plot4.png")
par(mfrow = c(2, 2))
## topleft
with(data, plot(Date_time, Global_active_power, type = 'n', xlab = NA,
                ylab = "Global Active Power"))
with(data, lines(Date_time, Global_active_power))
## topright
with(data, plot(Date_time, Voltage, type = 'n', xlab = 'datetime',
                ylab = "Voltage"))
with(data, lines(Date_time, Voltage))
## downleft
with(data, plot(Date_time, Sub_metering_1, type = 'n', xlab = NA,
                ylab = "Energy sub metering"))
with(data, lines(Date_time, Sub_metering_1))
with(data, lines(Date_time, Sub_metering_2, col = "red"))
with(data, lines(Date_time, Sub_metering_3, col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = c(1, 1, 1), bty = "n")
## downright
with(data, plot(Date_time, Global_reactive_power, type = 'n', xlab = 'datetime',
                ylab = "Global_reactive_power"))
with(data, lines(Date_time, Global_reactive_power))
dev.off()