###############################
#
#  Analysis of IPUMS data , ISCO88data
#
#####################################


###### WARNING : This script was run only once since the raw data is ~ 25 GiB large.

    library(readxl)
    
###### loading data

    ## this takes 10 minutes on a laptop
    
      #saveRDS(mysum ,  "CIRC/IPUMS/mysumI88.RDS")
      #saveRDS(mysum2 ,  "CIRC/IPUMS/mysumI882.RDS")
      #saveRDS(mysum3 ,  "CIRC/IPUMS/mysumI883.RDS")
    
     ipums <- readRDS("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/mysumI884.RDS")
    
    #### other data
    
    country <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/countries.xlsx")
    
    sample <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/sample.xlsx")
    
    isco <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/isco883D.xlsx")

    industry <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/industry.xlsx")
    
################# adding information to the code variables
    
    names(ipums) <- tolower( names( ipums ))
    
    ipums$country.lab <- country$Label[ match( ipums$country , country$Value)]
    
    ipums$sample.lab <- sample$Label[ match( ipums$sample , sample$Value)]
    
    ipums$isco.lab <- isco$Label[ match( ipums$isco88a , isco$Value)]

    ipums$industry.lab <- industry$Label[ match( ipums$indgen , industry$Value)]
    
## some exploration    
        
#No Nas for ISCO
table(is.na(ipums$isco88a))    

## Sample vs countries / same number of different samples

length( table( ipums$sample) )
length( table( ipums$country) )

# year range 1991 - 2012

table(ipums$year)

## creation of the file for the merging with CANJEM ; total per country per ISCO

## lazy method

ipums$hash <- paste( ipums$country , ipums$isco88a , sep= "-")

mydata <- data.frame( hash = names(table(ipums$hash)) , stringsAsFactors = FALSE )

mydata$n_kpeople <- numeric( length(mydata[,1]) )

for ( i in 1:length(mydata[,1])) { 
  
  mydata$n_kpeople[i] <- sum( ipums$n_kpeople[ ipums$hash == mydata$hash[i] ] )
  
  country <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/countries.xlsx")
 
  isco <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/isco883D.xlsx")
  
  
  }

mydata$country.lab <- country$Label[ match( mydata$country , country$Value)]

mydata$isco.lab <- isco$Label[ match( mydata$isco , isco$Value)]


######### saving the dataset for merging

saveRDS( mydata , "MONO131/CANJEM_IPUMS analysis/intermediate data/ipums.RDS" )
