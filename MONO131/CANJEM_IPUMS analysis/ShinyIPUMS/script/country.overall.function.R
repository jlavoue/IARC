################################################################################
#
# function which creates an overall  country tab for any metal
#
###############################################################################

## requires the following files

##ipums
##isco
##canjem.pop.cobalt
##canjem.pop.antimony
##canjem.pop


fun.countrytab <- function( country.code = 250 , metal = "cobalt") {
  

  selected.country <- country.code
  
  if (metal == "cobalt") canjem.pop <- canjem.pop.cobalt
  if (metal == "antimony") canjem.pop <- canjem.pop.antimony
  if (metal == "tungsten") canjem.pop <- canjem.pop.tungsten
  
  country.tab <- data.frame( isco88 = unique( ipums$isco88a[ ipums$country == selected.country] )) 
  
  country.tab$isco.lab <- isco$Label[ match( country.tab$isco88 , isco$Value)]
  
  # elimination of unknown and not in universe
  country.tab <- country.tab[ !is.element( country.tab$isco88 , c(998,999) )   ,  ]
  
  country.tab$n.people <-   ipums$n_people[ ipums$country == selected.country ][ match( country.tab$isco88 ,ipums$isco88a[ ipums$country == selected.country ] )]  
  
  country.tab$estatus <- canjem.pop$exposed[ match( country.tab$isco88 , canjem.pop$ISCO883D)]
  
  country.tab$estatus[ is.na(country.tab$estatus)] <- "unknown"
  
  country.tab$n.exp <- canjem.pop$p[ match( country.tab$isco88 , canjem.pop$ISCO883D)] * country.tab$n.people/100
  
  country.tab$n.exp[ country.tab$estatus == "unexposed" ] <- 0
  
  country.tab$n.low <-  country.tab$n.people*canjem.pop$p.C1[ match( country.tab$isco88 , canjem.pop$ISCO883D) ]/100 
  
  country.tab$n.low[ country.tab$estatus == "unexposed" ] <- 0
  
  country.tab$n.medium <-  country.tab$n.people*canjem.pop$p.C2[ match( country.tab$isco88 , canjem.pop$ISCO883D) ]/100 
  
  country.tab$n.medium[ country.tab$estatus == "unexposed" ] <- 0
  
  country.tab$n.high <-  country.tab$n.people*canjem.pop$p.C3[ match( country.tab$isco88 , canjem.pop$ISCO883D) ]/100 
  
  country.tab$n.high[ country.tab$estatus == "unexposed" ] <- 0
  
  country.tab$most.freq.confidence <- ifelse(country.tab$estatus == "pot.exposed", 
                                                      confidence$label[ match( canjem.pop$most.freq.confidence[ match( country.tab$isco88 , canjem.pop$ISCO883D) ] , confidence$code ) ],
                                                      NA)
  
  country.tab$n.lessthan2h <-  country.tab$n.people*canjem.pop$p.F1[ match( country.tab$isco88 , canjem.pop$ISCO883D) ]/100 
  
  country.tab$n.lessthan2h[ country.tab$estatus == "unexposed" ] <- 0
  
  country.tab$n.2_12h <-  country.tab$n.people*canjem.pop$p.F2[ match( country.tab$isco88 , canjem.pop$ISCO883D) ]/100 
  
  country.tab$n.2_12h[ country.tab$estatus == "unexposed" ] <- 0
  
  country.tab$n.12_39h <-  country.tab$n.people*canjem.pop$p.F3[ match( country.tab$isco88 , canjem.pop$ISCO883D) ]/100 
  
  country.tab$n.12_39h[ country.tab$estatus == "unexposed" ] <- 0
  
  country.tab$n.40handover <-  country.tab$n.people*canjem.pop$p.F4[ match( country.tab$isco88 , canjem.pop$ISCO883D) ]/100 
  
  country.tab$n.40handover[ country.tab$estatus == "unexposed" ] <- 0
  

  ## global portrait
  
  country.overall <- data.frame( metric = c("total.n" , "n.exp" , "n.unexp" ,"n.unknown" , "n.low" , "n.medium" , "n.high" , "n.lessthan2h" , "n.2_12h" , "n.12_39h" , "n.40handover") , stringsAsFactors = FALSE )
  
  country.overall$value[1] <-   sum(country.tab$n.people)  
  
  country.overall$value[2] <-   sum(country.tab$n.exp[ country.tab$estatus == "pot.exposed"])   
  
  country.overall$value[3] <-   sum(country.tab$n.people[ country.tab$estatus=="unexposed" ]) + 
                                                  sum(country.tab$n.people[ country.tab$estatus == "pot.exposed"])-
                                                  sum(country.tab$n.exp[ country.tab$estatus == "pot.exposed"])   
  
  country.overall$value[4] <-   sum(country.tab$n.people[ country.tab$estatus == "unknown"])
  
  country.overall$value[5] <-   sum( country.tab$n.low , na.rm = TRUE )  
  
  country.overall$value[6] <-   sum( country.tab$n.medium , na.rm = TRUE  )  
  
  country.overall$value[7] <-   sum( country.tab$n.high , na.rm = TRUE  )  
  
  country.overall$value[8] <-   sum( country.tab$n.lessthan2h , na.rm = TRUE  )  
  
  country.overall$value[9] <-   sum( country.tab$n.2_12h , na.rm = TRUE  )  
  
  country.overall$value[10] <-   sum( country.tab$n.12_39h , na.rm = TRUE  )  
  
  country.overall$value[11] <-   sum( country.tab$n.40handover , na.rm = TRUE  ) 
  
  return(country.overall)
  
  
}