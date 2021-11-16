#' ---
#' title: "Merging CANJEM with the IPUMS international census data : Cobalt, Antimony and Tungsten - global descriptive analysis"
#' author: "Jérôme Lavoué"
#' date: "October 20, 2021"
#' output: github_document
#' ---
#' 
#' 

#+ r setup, include=FALSE, cache = FALSE
require("knitr")
library(stringr)
## setting working directory
opts_knit$set(root.dir = rprojroot::find_rstudio_root_file())

#+ libraries and datasets, include = FALSE

    library(readxl)
    library(plyr)
    
    ############# reading relevant datasets
    
    ## CANJEM
    
    canjem.pop.cobalt <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/canjemcobalt.RDS")
    
    canjem.pop.antimony <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/canjemantimony.RDS")
    
    canjem.pop.tungsten <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/canjemtungsten.RDS")
    
    ## IPUMS
    
    ipums <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/ipums.RDS" )
    
    isco <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/isco883D.xlsx")
    
    country <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/countries.xlsx")
    

 ################ descriptive analysis - IPIMS file   
        
sum(ipums$n_kpeople)/1000000

mycountry <- ddply( ipums, .(country), summarize, n.M = round( sum(n_kpeople)/1000000 , 0))

mycountry$country.lab <- country$Label[ match( mycountry$country , country$Value)]



        