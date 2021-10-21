###############################
#
#  Analysis of IOPUMS data , ISCO88data
#
#####################################


    library(data.table)
    
    library(readxl)
    
    setwd( "C:/jerome/Dropbox/bureau")


##################################### prevention for big data

      memory.size() ### Checking your memory size
      memory.limit() ## Checking the set limit
      memory.limit(size=56000) ### expanding your memory _ here it goes beyond to your actually memory. This 56000 is proposed for 64Bit. 

###### loading data

    ## this takes 10 minutes on a laptop
    
    mydata <- read.csv( "CIRC/IPUMS/ipumsi_00006.csv/ipumsi_00006.csv")
    
    #### other data
    
    country <- read_xlsx("CIRC/IPUMS/countries.xlsx")
    
    sample <- read_xlsx("CIRC/IPUMS/sample.xlsx")
    
    isco <- read_xlsx("CIRC/IPUMS/isco883D.xlsx")


####### quickly getting rid of the giant files : sum of PEWT by country - year - ISCO88   

mysum <- readRDS("CIRC/IPUMS/mysum.RDS")
mysum2 <- readRDS("CIRC/IPUMS/mysum2.RDS")
mysum3 <- readRDS("CIRC/IPUMS/mysum3.RDS")


#setDT(mydata) 

#mysum <- mydata[, .(n_kpeople = sum(PERWT)) , by = list(COUNTRY,YEAR,ISCO88A) ]

#mysum2 <- mydata[, .(n_kpeople = sum(PERWT)) , by = list(COUNTRY,ISCO88A) ]

#mysum3 <- mydata[, .(n_kpeople = sum(PERWT)) , by = list(ISCO88A) ]


#saveRDS(mysum ,  "CIRC/IPUMS/mysumI88.RDS")
#saveRDS(mysum2 ,  "CIRC/IPUMS/mysumI882.RDS")
#saveRDS(mysum3 ,  "CIRC/IPUMS/mysumI883.RDS")



