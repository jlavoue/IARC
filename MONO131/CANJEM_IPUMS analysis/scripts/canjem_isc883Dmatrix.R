#' ---
#' title: "Creation of the ISCO-3D CANJEM for Cobalt, Antimony and Tungsten"
#' author: "Jérôme Lavoué"
#' date: "November 2nd, 2021"
#' output: github_document
#' ---
#' 
#' 

#+ r setup, include=FALSE, cache = FALSE

require("knitr")
library(stringr)

library(usethis)
library(here)
library(httr)
library(magrittr)

## setting working directory
opts_knit$set(root.dir = rprojroot::find_rstudio_root_file())


#' *This script 1. creates CANJEM ISCO88_3D for Cobalt, Antimony and Tungsten according to various constraints and 2.evaluates each job in the CANJEM databases as "exposed", "unexposed" , "unknown". *

#+ libraries and datasets, include = FALSE
       
       usethis::edit_r_environ()
       
       req <- content(GET(
         "https://api.github.com/repos/jlavoue/MontrealCaseControlStudies/CANJEMV1/contents/matrix creation/Script matrix creation v7.r",
         add_headers(Authorization = "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")
       ), as = "parsed")
       
       tmp <- tempfile()
       r1 <- GET(req$download_url, write_disk(tmp))
       load(tmp)
       
       
       
       
       
       

      # Source R script from Github : CANJEM creation function
      script <-
        GET(
          url = "https://api.github.com/repos/jlavoue/MontrealCaseControlStudies/CANJEMV1/contents/matrix creation/Script matrix creation v7.r",
          authenticate("jlavoue", "Myaex7O2yN&%"),     # Instead of PAT, could use password
          accept("application/vnd.github.v3.raw")
        ) %>%
        content(as = "text")
      
      # Evaluate and parse to global environment
      eval(parse(text = script))
      
      # Source R script from Github : CANJEM creation function
      script <-
        GET(
          url = "https://api.github.com/repos/jlavoue/MontrealCaseControlStudies/CANJEMV1/contents/matrix creation/Script matrix creation v7.R",
          authenticate("jerome.lavoue@umontreal.ca", "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"),     # Instead of PAT, could use password
          accept("application/vnd.github.v3.raw")
        ) %>%
        content(as = "text")
      
      # Evaluate and parse to global environment
      eval(parse(text = script)
      ### loading canjem workoccind
      
      canjem.wk <- read.csv(" https://raw.githubusercontent.com/MontrealCaseControlStudies/CANJEMV1/raw/master/workoccind/canjem.workoccind.csv")
      https://raw.githubusercontent.com/MontrealCaseControlStudies/CANJEMV1/master/matrix%20creation/Script%20matrix%20creation%20v7.r?token=ACOAI3B6DG7BM3HBAWKJSELBQEI6Q
      