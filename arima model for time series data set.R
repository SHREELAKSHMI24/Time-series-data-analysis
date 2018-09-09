rm(list=ls())
# setting the working directory
getwd()
setwd("H:/MY R WORK/2")
getwd()

#reading the csv file 
data = read.csv("file:///C:/Users/madara/Desktop/azd.csv",header = T)

#installing the various libraries
library('ggplot2')
library('forecast')
library('tseries')
library('xts')


#removing the unwanted variables in the data set
data$mandiName = NULL
data$unitArrivals = NULL
data$itemName = NULL
data$priceUnit = NULL
data$state = NULL

#checking the data type
class(data)

#after knowind that data is in form of data.frame, converting it to time series
#here I am using ts function 
tsdata = ts(data,start = c(2005,4,11), end = c(2018,8,31), frequency = 12)

#getting the summary and plot of the time series data set
summary(tsdata)
plot(tsdata)

#to reduce inflation in data set here I am using diff function
difdata = diff(tsdata ,12)
plot(difdata, type = 'l')

#after reducing inflation,fitting the time series data into model
#here arima model is used to predict the future values
ardata = arima(tsdata[,3], order=c(1,0,0))
summary(ardata)
plot(ardata)


#after fitting model getting the future values using forecast function
#h detemines the number of values to be determined
fordata = forecast(ardata,h=1)
summary(fordata)
print(fordata)
summary(fordata$mean)

