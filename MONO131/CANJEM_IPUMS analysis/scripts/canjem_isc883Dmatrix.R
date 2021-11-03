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


## setting working directory
opts_knit$set(root.dir = rprojroot::find_rstudio_root_file())


#'*This script 1. creates CANJEM ISCO88_3D for Cobalt, Antimony and Tungsten according to various constraints and 2.evaluates each job in the CANJEM databases as "exposed", "unexposed" , "unknown".*

#+ libraries and datasets, include = FALSE
       
  canjem.wk <- read.csv("MONO131/CANJEM_IPUMS analysis/raw data/from CANJEM/canjem.workoccind.csv")   
  
  canjem.jdb <- read.csv("MONO131/CANJEM_IPUMS analysis/raw data/from CANJEM/canjem.jdb.123.D.csv")   
  
  canjem.agents <- read.csv("MONO131/CANJEM_IPUMS analysis/raw data/from CANJEM/CANJEM agents.csv")
  
  canjem.agents.def <- read.csv("MONO131/CANJEM_IPUMS analysis/raw data/from CANJEM/CANJEM agents definitions.csv")
  
  source("MONO131/CANJEM_IPUMS analysis/raw data/from CANJEM/script matrix creation v7.R")

#+ creation of the JEM, include = FALSE    
  
  # adding the ISCO88 codes
  
  mycrosswalk <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/isco68to88V1.RDS")
  
  canjem.wk$ISCO883D <- mycrosswalk$isco88.ganz[ match( canjem.wk$CITP1968 , mycrosswalk$isco68)]
  
  canjem.wk$ISCO883D.status <- mycrosswalk$diff.status[ match( canjem.wk$CITP1968 , mycrosswalk$isco68)]
  
  
#' The table below describes the state of the ISCO68 to ISCO683D crosswalk, which compared the CAPS official crosswalk to the Ganzeboom crosswalk  
  
#+ corsswalk summary, echo = FALSE    
  
  knitr::kable(data.frame(table(canjem.wk$ISCO883D.status)))
  
  #mymatrix <- matrix.fun( jdb = canjem.jdb[ is.element( canjem.jdb$IDCHEM , agents) ,],
  #                        workoccind = canjem.wk,
   #                       vec.dim = ,
    #                      agents =  c("512799","515199","517499"),
     #                     type='R1expo',
      #                    Dmin,
       #                   Fmin,
        #                  Cmin,
         #                 Nmin,
          #                Nmin.s,
           #               time.breaks,
            #              Fcut= c(0, 2, 12, 40, max(canjem.jdb$F_FINAL)),
             #             FWI.threshold = 1)	
  #
  
  