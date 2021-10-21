#' ---
#' title: "Merging CANJEM with the IPUMS international census data : Cobalt, Antimony and Tungsten"
#' author: "Jérôme Lavoué"
#' date: "October 20, 2021"
#' output: github_document
#' ---
#' 
#' 

#+ r setup, include=FALSE, cache = FALSE
require("knitr")
require("flextable")
## setting working directory
opts_knit$set(root.dir = rprojroot::find_rstudio_root_file())

#+ libraries and datasets, include = FALSE

    ############# reading relevant datasets
    
    ## CANJEM
    
    cobalt <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/CANJEMCobalt.RDS" )
    
    tungstene <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/CANJEMtungsten.RDS" )
    
    antimony <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/CANJEMantimony.RDS")
    
    
    ## CONVERSION
    
    c68to88 <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/c68to88.RDS" )
    
    
    ## IPUMS
    
    readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/ipums.RDS" )
    
#' **Having a look at CANJEM**
#' 
#' The three files presented below are publicly available from the [CANJEM public app](https://lavoue.shinyapps.io/Shiny_canjem_v3/).
#' 
#' The summary information for cobalt on the CANJEM website has a [perment address](http://canjem.ca/?ag=cobalt)
#' 
#' The table below shows all 3-Digit ISCO68 occupations which had at least 10 jobs and at least one of them exposed.

#+ CANJEM cobalt, echo = FALSE
    
    cobalt <- cobalt[ , c(1,10,3,4,5,2,6,7,8,9)]
    
    knitr::kable(cobalt)
                  

    
    
#' 
#' 
#' Apply a function to each element of a vector
#'
#' @description
#' The map function transform the input, returning a vector the same length
#' as the input. 
#' 
#' * `map()` returns a list or a data frame
#' * `map_lgl()`, `map_int()`, `map_dbl()` and `map_chr()` return 
#'    vectors of the corresponding type (or die trying); 
#' * `map_dfr()` and `map_dfc()` return data frames created by row-binding 
#'    and column-binding respectively. They require dplyr to be installed.


    
        