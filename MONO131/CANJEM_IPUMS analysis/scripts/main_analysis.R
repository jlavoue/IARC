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
  
#'working population covered in millions
  
#+ workingtotpop , echo = FALSE
  
  sum(ipums$n_people[ ipums$isco88a != 999])/1000000  
  
#'#number of countries

#+ n countries , echo = FALSE
  
  length( unique( ipums$country ) )
  
#' population by country

#+ by country , echo = FALSE  

  mycountry <- ddply( ipums[ ipums$isco88a != 999 , ], .(country), summarize, n.M = round( sum(n_people)/1000000 , 2))
  
  mycountry$country.lab <- country$Label[ match( mycountry$country , country$Value)]

  mycountry <- mycountry[ order( mycountry$n.M , decreasing = TRUE ), c(1,3,2)]
  
  mycountry$year <- ipums$year[ match( mycountry$country , ipums$country)]
  
  knitr::kable( mycountry , row.names = FALSE)

#' **CANJEM only , top 5 occupations in terms of prevalence for each JEM**
#'
#' *COBALT*
  
  
#+ canjem cobalt , echo = FALSE 

     canjem.pop.cobalt.sum <- canjem.pop.cobalt   
  
     canjem.pop.cobalt.sum$isco.lab <- isco$Label[match( canjem.pop.cobalt.sum$ISCO883D , isco$Value)]    
 
     canjem.pop.cobalt.sum <- canjem.pop.cobalt.sum[ order(canjem.pop.cobalt.sum$p , decreasing = TRUE)[1:5] , c( 1 , 27 , 2 , 4 , 22 , 23 , 24) ] 
     
     canjem.pop.cobalt.sum$most.freq.confidence[ ] <- confidence$label[ match( canjem.pop.cobalt.sum$most.freq.confidence , confidence$code)]
     
     canjem.pop.cobalt.sum$most.freq.intensity <- intensity$label[ match( canjem.pop.cobalt.sum$most.freq.intensity , intensity$code )]
     
     canjem.pop.cobalt.sum$most.freq.frequency <- frequency$label[ match( canjem.pop.cobalt.sum$most.freq.frequency , frequency$code)]
     
     names( canjem.pop.cobalt.sum ) <-c( "ISCO88" , "Title" , "n.jobs" , "p" , "confidence" , "intensity" , "frequency")
     
     canjem.pop.cobalt.sum$p <- signif( canjem.pop.cobalt.sum$p , 2 ) 
     
     knitr::kable( canjem.pop.cobalt.sum , row.names = FALSE)
     
#+ canjem antimony , echo = FALSE 

     canjem.pop.antimony.sum <- canjem.pop.antimony
          
     canjem.pop.antimony.sum$isco.lab <- isco$Label[match( canjem.pop.antimony.sum$ISCO883D , isco$Value)]    
     
     canjem.pop.antimony.sum <- canjem.pop.antimony.sum[ order(canjem.pop.antimony.sum$p , decreasing = TRUE)[1:5] , c( 1 , 27 , 2 , 4 , 22 , 23 , 24) ] 
     
     canjem.pop.antimony.sum$most.freq.confidence[ ] <- confidence$label[ match( canjem.pop.antimony.sum$most.freq.confidence , confidence$code)]
     
     canjem.pop.antimony.sum$most.freq.intensity <- intensity$label[ match( canjem.pop.antimony.sum$most.freq.intensity , intensity$code )]
     
     canjem.pop.antimony.sum$most.freq.frequency <- frequency$label[ match( canjem.pop.antimony.sum$most.freq.frequency , frequency$code)]
     
     names( canjem.pop.antimony.sum ) <-c( "ISCO88" , "Title" , "n.jobs" , "p" , "confidence" , "intensity" , "frequency")
     
     canjem.pop.antimony.sum$p <- signif( canjem.pop.antimony.sum$p , 2 ) 
     
     knitr::kable( canjem.pop.antimony.sum , row.names = FALSE)     
     
#+ canjem tungsten , echo = FALSE 
     
     canjem.pop.tungsten.sum <- canjem.pop.tungsten
     
     canjem.pop.tungsten.sum$isco.lab <- isco$Label[match( canjem.pop.tungsten.sum$ISCO883D , isco$Value)]    
     
     canjem.pop.tungsten.sum <- canjem.pop.tungsten.sum[ order(canjem.pop.tungsten.sum$p , decreasing = TRUE)[1:5] , c( 1 , 27 , 2 , 4 , 22 , 23 , 24) ] 
     
     canjem.pop.tungsten.sum$most.freq.confidence[ ] <- confidence$label[ match( canjem.pop.tungsten.sum$most.freq.confidence , confidence$code)]
     
     canjem.pop.tungsten.sum$most.freq.intensity <- intensity$label[ match( canjem.pop.tungsten.sum$most.freq.intensity , intensity$code )]
     
     canjem.pop.tungsten.sum$most.freq.frequency <- frequency$label[ match( canjem.pop.tungsten.sum$most.freq.frequency , frequency$code)]
     
     names( canjem.pop.tungsten.sum ) <-c( "ISCO88" , "Title" , "n.jobs" , "p" , "confidence" , "intensity" , "frequency")
     
     canjem.pop.tungsten.sum$p <- signif( canjem.pop.tungsten.sum$p , 2 ) 
     
     knitr::kable( canjem.pop.tungsten.sum , row.names = FALSE)  
     
     
     
#' **IPUMS analysis : portrait by occupation**
#'
#' *Cobalt*
#' 

#+ occupation cobalt, echo = FALSE

     myisco <- 722
     
     ## making a table summarizing exposure info ( top 5 countries)
     
     occup.tab.cobalt <- data.frame( country = unique( ipums$country[ ipums$isco88a == myisco]  ) , stringsAsFactors = FALSE )
     
     occup.tab.cobalt$country.lab <- country$Label[ match( occup.tab.cobalt$country , country$Value)]
     
     occup.tab.cobalt$n.people <- signif( ipums$n_people[ ipums$isco88a == myisco][ match( occup.tab.cobalt$country , ipums$country[ ipums$isco88a == myisco]  )  ] , 2)
     
     occup.tab.cobalt$perc.people <- signif( 100*occup.tab.cobalt$n.people/ (1000000*mycountry$n.M[ match( occup.tab.cobalt$country , mycountry$country )] ) , 2)
     
     occup.tab.cobalt$estatus <- canjem.pop.cobalt$exposed[ canjem.pop.cobalt$ISCO883D == myisco ]
     
     occup.tab.cobalt$n.unexp <- signif( occup.tab.cobalt$n.people*canjem.pop.cobalt$p.C0[ canjem.pop.cobalt$ISCO883D == myisco ]/100 , 2 )
     
     occup.tab.cobalt$n.low <- signif( occup.tab.cobalt$n.people*canjem.pop.cobalt$p.C1[ canjem.pop.cobalt$ISCO883D == myisco ]/100 , 2 )
     
     occup.tab.cobalt$n.medium <- signif( occup.tab.cobalt$n.people*canjem.pop.cobalt$p.C2[ canjem.pop.cobalt$ISCO883D == myisco ]/100 , 2 )
     
     occup.tab.cobalt$n.high <- signif( occup.tab.cobalt$n.people*canjem.pop.cobalt$p.C3[ canjem.pop.cobalt$ISCO883D == myisco ]/100 , 2 )
     
     occup.tab.cobalt$most.freq.confidence <- ifelse( occup.tab.cobalt$estatus == "pot.exposed", 
                                                      confidence$label[ confidence$code == canjem.pop.cobalt$most.freq.confidence[ canjem.pop.cobalt$ISCO883D == myisco ] ],
                                                      NA)
     
     occup.tab.cobalt$most.freq.frequency <- ifelse( occup.tab.cobalt$estatus == "pot.exposed", 
                                                     frequency$label[ frequency$code == canjem.pop.cobalt$most.freq.frequency[ canjem.pop.cobalt$ISCO883D == myisco ] ],
                                                     NA)
     
     ## showing top 5 high exposed
     
     knitr::kable( occup.tab.cobalt[ order(occup.tab.cobalt$n.high , decreasing = TRUE)[1:5] , c(2:11) ] , row.names = FALSE) 
     
     ## global portrait
     
     occup.overall.cobalt <- data.frame( metric = c("total.n" , "total.perc" , "estatus" , "n.unexp" , "n.low" , "n.medium" , "n.high") , stringsAsFactors = FALSE )
     
     occup.overall.cobalt$value[1] <- sum(occup.tab.cobalt$n.people)
     
     occup.overall.cobalt$value[2] <- signif( 100*occup.overall.cobalt$value[1]/sum( mycountry$n.M * 1000000 ) , 2)
       
     occup.overall.cobalt$value[3] <- occup.tab.cobalt$estatus[1]
       
     occup.overall.cobalt$value[4] <- signif( sum( occup.tab.cobalt$n.unexp) , 2)
       
     occup.overall.cobalt$value[5] <- signif( sum( occup.tab.cobalt$n.low ) , 2)
       
     occup.overall.cobalt$value[6] <- signif( sum( occup.tab.cobalt$n.medium ) , 2)
       
     occup.overall.cobalt$value[7] <- signif( sum( occup.tab.cobalt$n.high ) , 2)
     
     knitr::kable( occup.overall.cobalt , row.names = FALSE) 
     
     
#' *Antimony*
#' 
     
#+ occupation antimony, echo = FALSE
     
     myisco <- 722
     
     ## making a table summarizing exposure info ( top 5 countries)
     
     occup.tab.antimony <- data.frame( country = unique( ipums$country[ ipums$isco88a == myisco]  ) , stringsAsFactors = FALSE )
     
     occup.tab.antimony$country.lab <- country$Label[ match( occup.tab.antimony$country , country$Value)]
     
     occup.tab.antimony$n.people <- signif( ipums$n_people[ ipums$isco88a == myisco][ match( occup.tab.antimony$country , ipums$country[ ipums$isco88a == myisco]  )  ] , 2)
     
     occup.tab.antimony$perc.people <- signif( 100*occup.tab.antimony$n.people/ (1000000*mycountry$n.M[ match( occup.tab.antimony$country , mycountry$country )] ) , 2)
     
     occup.tab.antimony$estatus <- canjem.pop.antimony$exposed[ canjem.pop.antimony$ISCO883D == myisco ]
     
     occup.tab.antimony$n.unexp <- signif( occup.tab.antimony$n.people*canjem.pop.antimony$p.C0[ canjem.pop.antimony$ISCO883D == myisco ]/100 , 2 )
     
     occup.tab.antimony$n.low <- signif( occup.tab.antimony$n.people*canjem.pop.antimony$p.C1[ canjem.pop.antimony$ISCO883D == myisco ]/100 , 2 )
     
     occup.tab.antimony$n.medium <- signif( occup.tab.antimony$n.people*canjem.pop.antimony$p.C2[ canjem.pop.antimony$ISCO883D == myisco ]/100 , 2 )
     
     occup.tab.antimony$n.high <- signif( occup.tab.antimony$n.people*canjem.pop.antimony$p.C3[ canjem.pop.antimony$ISCO883D == myisco ]/100 , 2 )
     
     occup.tab.antimony$most.freq.confidence <- ifelse( occup.tab.antimony$estatus == "pot.exposed", 
                                                        confidence$label[ confidence$code == canjem.pop.antimony$most.freq.confidence[ canjem.pop.antimony$ISCO883D == myisco ] ],
                                                        NA)
     
     occup.tab.antimony$most.freq.frequency <- ifelse( occup.tab.antimony$estatus == "pot.exposed",
                                                       frequency$label[ frequency$code == canjem.pop.antimony$most.freq.frequency[ canjem.pop.antimony$ISCO883D == myisco ] ],
                                                       NA)
     
     ## showing top 5 high exposed
     
     knitr::kable( occup.tab.antimony[ order(occup.tab.antimony$n.high , decreasing = TRUE)[1:5] , c(2:11) ] , row.names = FALSE) 
     
     ## global portrait
     
     occup.overall.antimony <- data.frame( metric = c("total.n" , "total.perc" , "estatus" , "n.unexp" , "n.low" , "n.medium" , "n.high") , stringsAsFactors = FALSE )
     
     occup.overall.antimony$value[1] <- sum(occup.tab.antimony$n.people)
     
     occup.overall.antimony$value[2] <- signif( 100*occup.overall.antimony$value[1]/sum( mycountry$n.M * 1000000 ) , 2)
     
     occup.overall.antimony$value[3] <- occup.tab.antimony$estatus[1]
     
     occup.overall.antimony$value[4] <- signif( sum( occup.tab.antimony$n.unexp) , 2)
     
     occup.overall.antimony$value[5] <- signif( sum( occup.tab.antimony$n.low ) , 2)
     
     occup.overall.antimony$value[6] <- signif( sum( occup.tab.antimony$n.medium ) , 2)
     
     occup.overall.antimony$value[7] <- signif( sum( occup.tab.antimony$n.high ) , 2)
     
     knitr::kable( occup.overall.antimony , row.names = FALSE) 
     

     
#' *Tungsten*
#' 
     
#+ occupation tungsten, echo = FALSE
     
     myisco <- 722
     
     ## making a table summarizing exposure info ( top 5 countries)
     
     occup.tab.tungsten <- data.frame( country = unique( ipums$country[ ipums$isco88a == myisco]  ) , stringsAsFactors = FALSE )
     
     occup.tab.tungsten$country.lab <- country$Label[ match( occup.tab.tungsten$country , country$Value)]
     
     occup.tab.tungsten$n.people <- signif( ipums$n_people[ ipums$isco88a == myisco][ match( occup.tab.tungsten$country , ipums$country[ ipums$isco88a == myisco]  )  ] , 2)
     
     occup.tab.tungsten$perc.people <- signif( 100*occup.tab.tungsten$n.people/ (1000000*mycountry$n.M[ match( occup.tab.tungsten$country , mycountry$country )] ) , 2)
     
     occup.tab.tungsten$estatus <- canjem.pop.tungsten$exposed[ canjem.pop.tungsten$ISCO883D == myisco ]
     
     occup.tab.tungsten$n.unexp <- signif( occup.tab.tungsten$n.people*canjem.pop.tungsten$p.C0[ canjem.pop.tungsten$ISCO883D == myisco ]/100 , 2 )
     
     occup.tab.tungsten$n.low <- signif( occup.tab.tungsten$n.people*canjem.pop.tungsten$p.C1[ canjem.pop.tungsten$ISCO883D == myisco ]/100 , 2 )
     
     occup.tab.tungsten$n.medium <- signif( occup.tab.tungsten$n.people*canjem.pop.tungsten$p.C2[ canjem.pop.tungsten$ISCO883D == myisco ]/100 , 2 )
     
     occup.tab.tungsten$n.high <- signif( occup.tab.tungsten$n.people*canjem.pop.tungsten$p.C3[ canjem.pop.tungsten$ISCO883D == myisco ]/100 , 2 )
     
     occup.tab.tungsten$most.freq.confidence <- ifelse( occup.tab.tungsten$estatus == "pot.exposed", 
                                                        confidence$label[ confidence$code == canjem.pop.tungsten$most.freq.confidence[ canjem.pop.tungsten$ISCO883D == myisco ] ],
                                                        NA)
     
     occup.tab.tungsten$most.freq.frequency <- ifelse( occup.tab.tungsten$estatus == "pot.exposed", 
                                                       frequency$label[ frequency$code == canjem.pop.tungsten$most.freq.frequency[ canjem.pop.tungsten$ISCO883D == myisco ] ],
                                                       NA)
     
     ## showing top 5 high exposed
     
     knitr::kable( occup.tab.tungsten[ order(occup.tab.tungsten$n.high , decreasing = TRUE)[1:5] , c(2:11) ] , row.names = FALSE) 
     
     ## global portrait
     
     occup.overall.tungsten <- data.frame( metric = c("total.n" , "total.perc" , "estatus" , "n.unexp" , "n.low" , "n.medium" , "n.high") , stringsAsFactors = FALSE )
     
     occup.overall.tungsten$value[1] <- sum(occup.tab.tungsten$n.people)
     
     occup.overall.tungsten$value[2] <- signif( 100*occup.overall.tungsten$value[1]/sum( mycountry$n.M * 1000000 ) , 2)
     
     occup.overall.tungsten$value[3] <- occup.tab.tungsten$estatus[1]
     
     occup.overall.tungsten$value[4] <- signif( sum( occup.tab.tungsten$n.unexp) , 2)
     
     occup.overall.tungsten$value[5] <- signif( sum( occup.tab.tungsten$n.low ) , 2)
     
     occup.overall.tungsten$value[6] <- signif( sum( occup.tab.tungsten$n.medium ) , 2)
     
     occup.overall.tungsten$value[7] <- signif( sum( occup.tab.tungsten$n.high ) , 2)
     
     knitr::kable( occup.overall.tungsten , row.names = FALSE) 
     
     
#' **IPUMS analysis : portrait by country**
#'
#' *Cobalt*
#' 
     
#+ country cobalt, echo = FALSE  
#+ 
     selected.country <- 250
       
     country.tab.cobalt <- data.frame( isco88 = unique( ipums$isco88a[ ipums$country == selected.country] )) 
     
     country.tab.cobalt$isco.lab <- isco$Label[ match( country.tab.cobalt$isco88 , isco$Value)]
     
     country.tab.cobalt <- country.tab.cobalt[ !is.element( country.tab.cobalt$isco88 , c(998,999) )   ,  ]
     
     country.tab.cobalt$n.people <- ipums$n_people[ ipums$country == selected.country ][ match( country.tab.cobalt$isco88 ,ipums$isco88a[ ipums$country == selected.country ] )]
     
     country.tab.cobalt$estatus <- canjem.pop.cobalt$exposed[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D)]
     
     country.tab.cobalt$estatus[ is.na(country.tab.cobalt$estatus)] <- "unknown"
     
     country.tab.cobalt$p.exp <- canjem.pop.cobalt$p[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D)]
     
    country.tab.cobalt$n.low <- signif(country.tab.cobalt$n.people*canjem.pop.cobalt$p.C1[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 , 2 )
     
    country.tab.cobalt$n.medium <- signif(country.tab.cobalt$n.people*canjem.pop.cobalt$p.C2[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 , 2 )
     
    country.tab.cobalt$n.high <- signif(country.tab.cobalt$n.people*canjem.pop.cobalt$p.C3[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 , 2 )
     
    country.tab.cobalt$most.freq.confidence <- ifelse(country.tab.cobalt$estatus == "pot.exposed", 
                                                        confidence$label[ confidence$code == canjem.pop.cobalt$most.freq.confidence[ canjem.pop.cobalt$ISCO883D == myisco ] ],
                                                        NA)
     
    country.tab.cobalt$most.freq.frequency <- ifelse( country.tab.cobalt$estatus == "pot.exposed", 
                                                       frequency$label[ frequency$code == canjem.pop.cobalt$most.freq.frequency[ canjem.pop.cobalt$ISCO883D == myisco ] ],
                                                       NA)
     