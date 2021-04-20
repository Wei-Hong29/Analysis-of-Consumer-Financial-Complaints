

rm(list = ls())


library(ggplot2)
library(lubridate)
library(wesanderson)
#setwd('C:/Users/User/Downloads/FIT3152/Assignment 1')



#draw custom sample of 40,000 rows from data set for analysis
set.seed(28055322) # 28055322 = your student ID 
bankcomplaints <-read.csv("bankcomplaints.csv") 
bankcomplaints <-bankcomplaints [sample(nrow(bankcomplaints), 40000), ] # 40000 rows





################       Part a - Pre-processing      ######################

### DATA QUALITY CHECK 
#*Note that only notable checks are shown here, 
#*Note checks that show no irregularity, or where the column may be useful and so are included are not shown here.

#check for whether it can be excluded


unique(bankcomplaints$Product)
#Result: only 1 unique category shown hence can be excluded

unique(bankcomplaints$Sub.issue)
#Result: only Null value is shown, excluding this row


#check for redundant//dupliate data, to ensure data quality
unique(bankcomplaints)
#Result: all rows are unique, data quality in this aspect is good and hence no data transformation are needed





### DATA TRANSFORMATION, AND EXTRACTION


#exclude column 2 and 5, which are colums for [product] and [sub.issue]
#column  3,6,7,11,12,15, may or may not be useful and hece are placed at the back of the dataset
bankcomplaints = bankcomplaints[c(18, 1, 14, 4, 8, 9, 10, 13, 16, 17, 3, 6, 7,11, 12, 15)]

#ensure date data are stored in date format
bankcomplaints$Date.received = as.Date(bankcomplaints$Date.received,format = "%d/%m/%Y")
bankcomplaints$Date.sent.to.company = as.Date(bankcomplaints$Date.received,format = "%d/%m/%Y")
#############################################################







################       Part b - Complaint Parameter Analysis       ######################

#list of unique issues
issuesunique <- data.frame(unique(bankcomplaints$Issue))


#plot histogram for most common issues with all companies included
qplot(Issue, data = bankcomplaints)+ theme(axis.text.x = element_text(angle = 90)) + coord_flip()

#histogram separated by customer tags
qplot(Issue, data = bankcomplaints, facets = Tags~.)+ facet_wrap(~Tags) +theme(axis.text.x = element_text(angle = 90)) + coord_flip()




#statistical test: [Older Americans] have less issue with "problems with my funds being low"
olderamericans = bankcomplaints[(bankcomplaints$Tag == 'Older American'),]
olderamericansfundslow= olderamericans[(olderamericans$Issue == "Problems caused by my funds being low"),]

countolderamericans = nrow(olderamericans)
countolderamericansfundslow = nrow(olderamericansfundslow)
countolderamericanswithnolowfundsissue = countolderamericans - countolderamericansfundslow

countnonoldamericans = nrow(bankcomplaints) - row(olderamericans)
datawithissueoflowfund= bankcomplaints[(bankcomplaints$Issue == "Problems caused by my funds being low"),]
countnonoldamericanswithlowfunds = nrow(datawithissueoflowfund) - countolderamericansfundslow
countnonoldamericanswithnolowfundsissue = countnonoldamericans - countnonoldamericanswithlowfunds

chitestmatrix = matrix(c(countolderamericansfundslow, countnonoldamericanswithlowfunds,countolderamericanswithnolowfundsissue,countnonoldamericanswithnolowfundsissue),nrow =2, ncol =2)
#perform chi squared test for being older american is associated with having less problems with "funds being low", compared to non-older americams
chisq.test(chitestmatrix, correct=FALSE)


#histogram seperated by sub.product
qplot(Issue, data = bankcomplaints, facets = Sub.product~.)+ facet_wrap(~Sub.product) +theme(axis.text.x = element_text(angle = 90)) + coord_flip()
  


#############################################################


################       Part c - Activity and Complaint Over Time Analysis     ######################

#initialize, for counting frequency of the issue, each row has a count of 1 complaint, hence each row are set as 1
bankcomplaints$count = 1

#get unique issues from dataset
issueunique <-data.frame(unique(bankcomplaints$Issue))

#seperate dataset into different variables, grouped by issues
issueone <- bankcomplaints[(bankcomplaints$Issue==issuesunique[1,1]),]
issuetwo <- bankcomplaints[(bankcomplaints$Issue==issuesunique[2,1]),]
issuethree <- bankcomplaints[(bankcomplaints$Issue==issuesunique[3,1]),]
issuefour <- bankcomplaints[(bankcomplaints$Issue==issuesunique[4,1]),]
issuefive <- bankcomplaints[(bankcomplaints$Issue==issuesunique[5,1]),]



###get earliest and latest start date for plotting time series

timereceviedmax <- bankcomplaints[which.max(bankcomplaints$Date.received),]
timereceviedmax <- timereceviedmax$Date.received
timereceviedmax


timereceviedmin <- bankcomplaints[which.min(bankcomplaints$Date.received),]
timereceviedmin <- timereceviedmin$Date.received
timereceviedmin




###plot time series graph for all issues
#NOTE: because we are not using only using time series with "ts()" for the whole complaint data, the other 5 issue's plot commands are commented out.
#NOTE: time used here is based on the date complaint is received

#overall time series for the whole data, for number of complaints over time
vvv <- aggregate(bankcomplaints[c(17)],bankcomplaints[3],sum)
whole_issue_frequency <- ts(vvv$count, frequency = 12,start = c(2012,3) , end = c(2017,12))
plot(decompose(whole_issue_frequency))




#issue 1
v <- aggregate(issueone[c(17)],issueone[3],sum)
first_issue_frequency <- ts(v$count, frequency = 12, start = c(2012,3), end = c(2017,12))
#plot(decompose(first_issue_frequency))


#issue 2
vtwo <- aggregate(issuetwo[c(17)],issuetwo[3],sum)
second_issue_frequency <- ts(vtwo$count, frequency = 12,start = c(2012,3), end = c(2017,12))
#plot(decompose(second_issue_frequency))


#issue 3
vthree <- aggregate(issuethree[c(17)],issuethree[3],sum)
third_issue_frequency <- ts(vthree$count, frequency = 12,start = c(2012,3), end = c(2017,12))
#plot(decompose(third_issue_frequency))


#issue 4
vfour <- aggregate(issuefour[c(17)],issuefour[3],sum)
fourth_issue_frequency <- ts(vfour$count, frequency = 12,start = c(2012,3), end = c(2017,12))
#plot(decompose(fourth_issue_frequency))


#issue 5
vfive <- aggregate(issuefive[c(17)],issuefive[3],sum)
fifth_issue_frequency <- ts(vfive$count, frequency = 12,start = c(2012,3), end = c(2017,12))
#plot(decompose(fifth_issue_frequency))







#plot.ts(cbind(whole_issue_frequency, first_issue_frequency, second_issue_frequency, third_issue_frequency, fourth_issue_frequency,fifth_issue_frequency))
#seprated in 3 and 3 plots, because 6 plots together is not very readable
plot.ts(cbind(whole_issue_frequency, first_issue_frequency, second_issue_frequency))
plot.ts(cbind(third_issue_frequency, fourth_issue_frequency,fifth_issue_frequency))


#############################################################

################       Part c latter part- 1.	Heat map for the 5 companies with most complaints over time      ######################

bankcomplaints$MonthSent = month(bankcomplaints$Date.sent.to.company)

#choose top 5 companies with most complaints for heat map
#top 5 is not chosen because top 10 is not notable
numberoftopchosen <- 5
choosingcompaniesforheatmap = aggregate(bankcomplaints[c(17)],bankcomplaints[5],sum)
choosingcompaniesforheatmap$Rank = rank(-choosingcompaniesforheatmap$count)
chosencompanies = head(choosingcompaniesforheatmap[order(choosingcompaniesforheatmap$Rank),],numberoftopchosen)

#select only the top 10 companies with most complaints, from original dataset, for analysis
analysingcompanies = bankcomplaints[(bankcomplaints$Company %in% chosencompanies$Company ),]

#extract company, month, and count
extracteddata = analysingcompanies[c(5, 18, 17)]




#count frequency for each month for each company, regardless of year
attach(extracteddata)
companyaggreteddata = as.data.frame(as.table(by(count, list(Company, MonthSent), sum)))
detach(extracteddata)

colnames(companyaggreteddata) = c("Company", "MonthSent", "count")

#remove null rows
#companyaggreteddata <- companyaggreteddata[(!is.null(companyaggreteddata$count))]
companyaggreteddata <- companyaggreteddata[(companyaggreteddata$Company %in% chosencompanies$Company),]


#plot heat map
g = ggplot (data = companyaggreteddata , aes (x = MonthSent, y = Company))
g = g + geom_tile(aes(fill = count))
g = g + ggtitle("Frequency of Complaints by Month") 

pal <- wes_palette("Zissou1", 100, type = "continuous")
g = g + scale_fill_gradientn(colours = pal)
g





#############################################################

