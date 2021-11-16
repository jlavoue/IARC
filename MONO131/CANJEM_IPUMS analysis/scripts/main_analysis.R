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
    
    ### preping the inames for intensity / frequency / reliability
    
    confidence <- data.frame( code = 1:3 , label = c("possible","probable","definite") , stringsAsFactors = FALSE)
    
    intensity <- data.frame( code = 1:3 , label = c("low","medium","high")  , stringsAsFactors = FALSE )
    
    frequency <- data.frame( code = 1:4 , label = c("<2h","2-12h","12-39h","40h+") , stringsAsFactors = FALSE)
    
#' **Descriptive analysis of the IPUMS file**  

#+ descriptive , echo = FALSE
 
     
#'population covered in millions

#+ totpop , echo = FALSE
          
  sum(ipums$n_people)/1000000
  
#'#number of countries

#+ n countries , echo = FALSE
  
  length( unique( ipums$country ) )
  
#' population by country

#+ by country , echo = FALSE  

  mycountry <- ddply( ipums, .(country), summarize, n.M = round( sum(n_people)/1000000 , 2))
  
  mycountry$country.lab <- country$Label[ match( mycountry$country , country$Value)]

  mycountry <- mycountry[ order( mycountry$n.M , decreasing = TRUE ), c(1,3,2)]
  
  knitr::kable( mycountry , row.names = FALSE)

#' **CANJEM only , top 5 occupations in terms of prevalence for each JEM**
#'
#' *COBALT*
  
  
#+ canjem cobalt , echo = FALSE 

     canjem.pop.cobalt$isco.lab <- isco$Label[match( canjem.pop.cobalt$ISCO883D , isco$Value)]    
 
     canjem.pop.cobalt <- canjem.pop.cobalt[ order(canjem.pop.cobalt$p , decreasing = TRUE)[1:5] , c( 1 , 27 , 2 , 4 , 22 , 23 , 24) ] 
     
     canjem.pop.cobalt$most.freq.confidence[ ] <- confidence$label[ match( canjem.pop.cobalt$most.freq.confidence , confidence$code)]
     
     canjem.pop.cobalt$most.freq.intensity <- intensity$label[ match( canjem.pop.cobalt$most.freq.intensity , intensity$code )]
     
     canjem.pop.cobalt$most.freq.frequency <- frequency$label[ match( canjem.pop.cobalt$most.freq.frequency , frequency$code)]
     
     names( canjem.pop.cobalt ) <-c( "ISCO88" , "Title" , "n.jobs" , "p" , "confodence" , "intensity" , "frequency")
     
     canjem.pop.cobalt$p <- signif( canjem.pop.cobalt$p , 2 ) 
     
     knitr::kable( canjem.pop.cobalt , row.names = FALSE)
     
#+ canjem antimony , echo = FALSE 
     
     canjem.pop.antimony$isco.lab <- isco$Label[match( canjem.pop.antimony$ISCO883D , isco$Value)]    
     
     canjem.pop.antimony <- canjem.pop.antimony[ order(canjem.pop.antimony$p , decreasing = TRUE)[1:5] , c( 1 , 27 , 2 , 4 , 22 , 23 , 24) ] 
     
     canjem.pop.antimony$most.freq.confidence[ ] <- confidence$label[ match( canjem.pop.antimony$most.freq.confidence , confidence$code)]
     
     canjem.pop.antimony$most.freq.intensity <- intensity$label[ match( canjem.pop.antimony$most.freq.intensity , intensity$code )]
     
     canjem.pop.antimony$most.freq.frequency <- frequency$label[ match( canjem.pop.antimony$most.freq.frequency , frequency$code)]
     
     names( canjem.pop.antimony ) <-c( "ISCO88" , "Title" , "n.jobs" , "p" , "confodence" , "intensity" , "frequency")
     
     canjem.pop.antimony$p <- signif( canjem.pop.antimony$p , 2 ) 
     
     knitr::kable( canjem.pop.antimony , row.names = FALSE)     
     
#+ canjem tungsten , echo = FALSE 
     
     canjem.pop.tungsten$isco.lab <- isco$Label[match( canjem.pop.tungsten$ISCO883D , isco$Value)]    
     
     canjem.pop.tungsten <- canjem.pop.tungsten[ order(canjem.pop.tungsten$p , decreasing = TRUE)[1:5] , c( 1 , 27 , 2 , 4 , 22 , 23 , 24) ] 
     
     canjem.pop.tungsten$most.freq.confidence[ ] <- confidence$label[ match( canjem.pop.tungsten$most.freq.confidence , confidence$code)]
     
     canjem.pop.tungsten$most.freq.intensity <- intensity$label[ match( canjem.pop.tungsten$most.freq.intensity , intensity$code )]
     
     canjem.pop.tungsten$most.freq.frequency <- frequency$label[ match( canjem.pop.tungsten$most.freq.frequency , frequency$code)]
     
     names( canjem.pop.tungsten ) <-c( "ISCO88" , "Title" , "n.jobs" , "p" , "confodence" , "intensity" , "frequency")
     
     canjem.pop.tungsten$p <- signif( canjem.pop.tungsten$p , 2 ) 
     
     knitr::kable( canjem.pop.tungsten , row.names = FALSE)  
     
     
     
#' **IPUMS analysis : portrait by country**
#'

     
     