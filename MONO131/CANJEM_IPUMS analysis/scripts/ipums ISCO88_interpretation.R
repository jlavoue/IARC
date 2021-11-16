###############################
#
#  Adding information to the compressed IPUMS dataset
#
#####################################


###### WARNING : This script was run only once since the raw data is ~ 25 GiB large.

    library(readxl)
    
###### loading data

     ipums <- readRDS("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/ipums.raw.RDS")
    
    #### other data
    
    country <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/countries.xlsx")
    
    sample <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/sample.xlsx")
    
    isco <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/isco883D.xlsx")

    industry <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/industry.xlsx")
    
################# adding information to the code variables
    
    names(ipums) <- tolower( names( ipums ))
    
    ipums$country.lab <- country$Label[ match( ipums$country , country$Value)]
    
    ipums$isco.lab <- isco$Label[ match( ipums$isco88a , isco$Value)]

    


## creation of the file for the merging with CANJEM ; total per country per ISCO



saveRDS( ipums , "MONO131/CANJEM_IPUMS analysis/intermediate data/ipums.RDS" )
