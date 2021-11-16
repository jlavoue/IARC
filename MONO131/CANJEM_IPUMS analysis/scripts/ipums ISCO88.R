################################################
#
#  Reading and transforming the IPUMS dataset
#
##################################################


###### data was requested for all countries with ISCO68 codes (most recent census when several were available)


    library(data.table)
    
    library(readxl)
    
    setwd( "C:/jerome/Dropbox/bureau")


##################################### prevention for big data

      memory.size() ### Checking your memory size
      memory.limit() ## Checking the set limit
      memory.limit(size=56000) ### expanding your memory _ here it goes beyond to your actually memory. This 56000 is proposed for 64Bit. 

###### loading data

    ## this takes 10 minutes on a laptop
    
    mydata <- read.csv( "CIRC/IPUMS/final extract Nov2021/ipumsi_00009.csv")
    

####### quickly getting rid of the giant files : sum of PEWT by country - year - ISCO88   


setDT(mydata) 

mysum.IARC <- mydata[, .(n_people = sum(PERWT)) , by = list(COUNTRY,YEAR,ISCO88A) ]


###### saving the resulting file

saveRDS( mysum.IARC , "C:/jerome/github/IARC/MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/ipums.raw.RDS")


