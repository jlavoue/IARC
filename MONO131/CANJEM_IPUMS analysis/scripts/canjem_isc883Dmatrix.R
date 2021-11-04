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

  library(plyr)
       
  canjem.wk <- read.csv("MONO131/CANJEM_IPUMS analysis/raw data/from CANJEM/canjem.workoccind.csv")   
  
  canjem.jdb <- read.csv("MONO131/CANJEM_IPUMS analysis/raw data/from CANJEM/canjem.jdb.123.D.csv")   
  
  canjem.agents <- read.csv("MONO131/CANJEM_IPUMS analysis/raw data/from CANJEM/CANJEM agents.csv")
  
  canjem.agents.def <- read.csv("MONO131/CANJEM_IPUMS analysis/raw data/from CANJEM/CANJEM agents definitions.csv")
  
  source("MONO131/CANJEM_IPUMS analysis/raw data/from CANJEM/script matrix creation v7.R")

#+ loading the crosswalk, include = FALSE    
  
  # adding the ISCO88 codes
  
  mycrosswalk <- readRDS( "MONO131/CANJEM_IPUMS analysis/intermediate data/isco68to88V1.RDS")
  
  canjem.wk$ISCO883D <- mycrosswalk$isco883d[ match( canjem.wk$CITP1968 , mycrosswalk$isco68)]
  
  canjem.wk$ISCO883D.status <- mycrosswalk$diff.status[ match( canjem.wk$CITP1968 , mycrosswalk$isco68)]
  

#' The table below describes the state of the ISCO68 to ISCO683D crosswalk as applied to the CANJEM population. "low resolution" was excluded because the ISCO codes in the crosswalk were 2-digit codes  
  
#+ corsswalk summary, echo = FALSE    
  
  knitr::kable(data.frame(table(canjem.wk$ISCO883D.status)))
  
#+ creation of the JEM, include = FALSE 
  

  canjem.wk$id.job <-paste(canjem.wk$ID,canjem.wk$JOB,sep="-")
  canjem.jdb$id.job <-paste(canjem.jdb$ID,canjem.jdb$JOB,sep="-")
  
  myconstraints <- list( Dmin = 0.05,
                          Fmin = 0.5,
                          Cmin = 1,
                          Nmin = 10,
                          Nmin.s = 3,
                          time.breaks = c(1921,2005),
                         agents = c("512799","515199","517499"))
  

  myfun <- function( constraints ) { 
    

      result <- matrix.fun( jdb = canjem.jdb[ is.element( canjem.jdb$IDCHEM , constraints$agents ) ,],
                          workoccind = canjem.wk[ canjem.wk$ISCO883D.status != "Low resolution" , ],
                          vec.dim = "ISCO883D" ,
                          agents =  constraints$agents,
                          type='R1expo',
                          Dmin = constraints$Dmin,
                          Fmin = constraints$Fmin,
                          Cmin = constraints$Cmin,
                          Nmin = constraints$Nmin,
                          Nmin.s = constraints$Nmin.s,
                          time.breaks = constraints$time.breaks,
                          Fcut= c(0, 2, 12, 40, max(canjem.jdb$F_FINAL)),
                          FWI.threshold = 1)	
  
  
      result$most.freq.confidence <- ddply(result ,~ cell , function(x){c(3:1)[which.max(c(x$n.R3[1],x$n.R2[1],x$n.R1[1]))]})$V1
      
      result$most.freq.intensity <- ddply(result ,~ cell , function(x){c(3:1)[which.max(c(x$n.C3[1],x$n.C2[1],x$n.C1[1]))]})$V1
      
      result$most.freq.frequency <- ddply(result ,~ cell , function(x){c(4:1)[which.max(c(x$n.F4,x$n.F3[1],x$n.F2[1],x$n.F1[1]))]})$V1
      
      result$most.freq.confidence[ result$p==0] <- NA
      result$most.freq.intensity[ result$p==0] <- NA
      result$most.freq.frequency[ result$p==0] <- NA
      
      result <- result[ , c( 3:8 , 23:35 , 55 , 57:59 )  ]
      
      return(result)
      
  }
  
  result <- myfun( myconstraints )

#+ applying canjem to pop, include = FALSE
  
   canjem.pop <- data.frame( table( canjem.wk$ISCO883D) , stringsAsFactors = FALSE)
   
   names(canjem.pop) <- c("ISCO883D" , "n")
   
   canjem.pop.cobalt <- merge( canjem.pop , result[ result$idchem=="512799" , ] , by = "ISCO883D" , all = TRUE)
   
   canjem.pop.antimony <- merge( canjem.pop , result[ result$idchem=="515199" , ] , by = "ISCO883D" , all = TRUE)
   
   canjem.pop.tungsten <- merge( canjem.pop , result[ result$idchem=="517499" , ] , by = "ISCO883D" , all = TRUE)
   
   canjem.pop.cobalt$CANJEMOK <- !is.na( canjem.pop.cobalt$p)
   
   canjem.pop.antimony$CANJEMOK <- !is.na( canjem.pop.antimony$p)
   
   canjem.pop.tungsten$CANJEMOK <- !is.na( canjem.pop.tungsten$p)
   
   ## pot.exposed / unexposed / unknown
   
   canjem.pop.cobalt$exposed <- "unknown"
   
   canjem.pop.cobalt$exposed[ canjem.pop.cobalt$CANJEMOK & canjem.pop.cobalt$p >= 5 ] <- "pot.exposed"
   
   canjem.pop.cobalt$exposed[ canjem.pop.cobalt$CANJEMOK & canjem.pop.cobalt$p <5 ] <- "unexposed"
   
   canjem.pop.antimony$exposed <- "unknown"
   
   canjem.pop.antimony$exposed[ canjem.pop.antimony$CANJEMOK & canjem.pop.antimony$p >= 5 ] <- "pot.exposed"
   
   canjem.pop.antimony$exposed[ canjem.pop.antimony$CANJEMOK & canjem.pop.antimony$p <5 ] <- "unexposed"
   
   canjem.pop.tungsten$exposed <- "unknown"
   
   canjem.pop.tungsten$exposed[ canjem.pop.tungsten$CANJEMOK & canjem.pop.tungsten$p >= 5 ] <- "pot.exposed"
   
   canjem.pop.tungsten$exposed[ canjem.pop.tungsten$CANJEMOK & canjem.pop.tungsten$p <5 ] <- "unexposed"
  
   # saving files
   
   saveRDS( canjem.pop.cobalt , "MONO131/CANJEM_IPUMS analysis/intermediate data/canjemcobalt.RDS")
   
   saveRDS( canjem.pop.antimony , "MONO131/CANJEM_IPUMS analysis/intermediate data/canjemantimony.RDS")
   
   saveRDS( canjem.pop.tungsten , "MONO131/CANJEM_IPUMS analysis/intermediate data/canjemtungsten.RDS")
   
#' the table below describes the exposure status of the CANBJEM population : potentially expoosed if occupation as a probability of exposure >=5%, unexposed if p<5, and "unknown" in case of no CANJEM cell.
#' 
  
   #+ description of exposure status, include = FALSE
   
     
   canjem.status.cobalt <- canjem.pop.cobalt$exposed[ match( canjem.wk$ISCO883D , canjem.pop.cobalt$ISCO883D )]
  