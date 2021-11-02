#' ---
#' title: "Merging CANJEM with the IPUMS international census data : Cobalt, Antimony and Tungsten"
#' author: "Jérôme Lavoué"
#' date: "October 30, 2021"
#' output: github_document
#' ---
#' 
#' 

#' **NOTE : October 30th, This avenue of analysis appears closed:  it is necessary to obtain a version of CANJEM based on ISCO88. Reason : ISCO 68 codes in the app leading to the same ISCO88 : how to count workers then ? ** 


#+ r setup, include=FALSE, cache = FALSE
require("knitr")
library(stringr)
## setting working directory
opts_knit$set(root.dir = rprojroot::find_rstudio_root_file())

#+ libraries and datasets, include = FALSE

    ############# reading relevant datasets
    
    ## CANJEM
    
    cobalt <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/CANJEMCobalt.RDS" )
    cobalt$Activity.code <- str_trim( cobalt$Activity.code,  side = "both")
    
    tungsten <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/CANJEMtungsten.RDS" )
    tungsten$Activity.code <- str_trim( tungsten$Activity.code,  side = "both")
    
    antimony <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/CANJEMantimony.RDS")
    antimony$Activity.code <- str_trim( antimony$Activity.code,  side = "both")
    
    
    ## CONVERSION
    
    c68to88 <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/c68to88.RDS" )
    
    
    ## IPUMS
    
    readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/ipums.RDS" )
    
#' **Having a look at CANJEM : COBALT**
#' 
#' The three files presented below are publicly available from the [CANJEM public app](https://lavoue.shinyapps.io/Shiny_canjem_v3/).
#' 
#' The summary information for cobalt on the CANJEM website has a [perment address](http://canjem.ca/?ag=cobalt)
#' 
#' The tables below shows all 3-Digit ISCO68 occupations which had at least 10 jobs and at least one of them exposed to, respectively, cobalt compounds, antimony compounds, and tungsten compounds.
#'
#'
#' *ISCO88 3 digit occupations with exposure to cobalt compounds*.     
#' 
#'  
        
#+ CANJEM cobalt, echo = FALSE
    
    cobalt <- cobalt[ , c(1,10,3,4,5,2,6,7,8,9)]
    
    knitr::kable(cobalt)
    
#' *ISCO88 3 digit occupations with exposure to antimony compounds*.     
#' 
#'      
                  
#+ CANJEM antimony, echo = FALSE
    
    antimony <- antimony[ , c(1,10,3,4,5,2,6,7,8,9)]
    
    knitr::kable(antimony )
#'
#'
#'*ISCO88 3 digit occupations with exposure to tungsten compounds*.
#'
#'
    
        
#+ CANJEM tungsten, echo = FALSE
    
    tungsten <- tungsten[ , c(1,10,3,4,5,2,6,7,8,9)]
    
    knitr::kable(tungsten)
    
    

#' ** Linking CANJEM occupations to ISCO 88 codes using the crosswwalks**

#+ linkaege , include = FALSE
#+ 

  cobalt$ISCO88 <- c68to88$isco88[ match( cobalt$Activity.code , c68to88$isco68 ) ]        
  
  antimony$ISCO88 <- c68to88$isco88[ match( antimony$Activity.code , c68to88$isco68 ) ]        
  
  tungsten$ISCO88 <- c68to88$isco88[ match( tungsten$Activity.code , c68to88$isco68 ) ]        
  
    
#' **This avenue of analysis appears closed:  it is necessary to obtain a version of CANJEM based on ISCO88. Reason : ISCO 68 codes in the app leading to the same ISCO88 : how to count workers then ? **        