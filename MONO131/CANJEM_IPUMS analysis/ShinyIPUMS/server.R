#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(utils)
library(shinythemes)
library(ggplot2)
library(shinycssloaders)
library(plyr)
library(shinybusy)
library(ggthemes)
library(shinyTree)
library(readxl)
library(DT)
library(shinyTree)


###################### preliminaries

        
        ############## reading database
        
        ## CANJEM
        
        canjem.pop.cobalt <- readRDS( "./data/CANJEMCobalt.RDS")
        
        canjem.pop.antimony <- readRDS( "./data/CANJEMantimony.RDS")
        
        canjem.pop.tungsten <- readRDS( "./data/CANJEMtungsten.RDS")
        
        ## IPUMS
        
        ipums <- readRDS( "./data/ipums.RDS" )
        
        isco <- read_xlsx("./data/isco883D.xlsx")
        
        country <- read_xlsx("./data/countries.xlsx")
        
        
        ### tree
        
        isco.tree <- readRDS("./data/isco.tree.RDS")
        
        ## other
        
        overall.final.cobalt <- readRDS("./data/overall.final.cobalt.RDS") 
        overall.final.antimony <- readRDS("./data/overall.final.antimony.RDS") 
        overall.final.tungsten <- readRDS("./data/overall.final.tungsten.RDS") 
        
        ######## sourcing stuff
        
        
        ####### preliminary preparations
        
        ### prepping the names for intensity / frequency / reliability
        
        confidence <- data.frame( code = 1:3 , label = c("possible","probable","definite") , stringsAsFactors = FALSE)
        
        intensity <- data.frame( code = 1:3 , label = c("low","medium","high")  , stringsAsFactors = FALSE )
        
        frequency <- data.frame( code = 1:4 , label = c("<2h","2-12h","12-39h","40h+") , stringsAsFactors = FALSE)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {


    
#########################################  IPUMS TAB
    
          ####### some numbers
        
          output$totalpop <- renderText({
            
            return( signif( sum(ipums$n_people)/1000000 , 3) )
            
          })
      
        
          output$workingpop <- renderText({
        
            return( signif( sum(ipums$n_people[ ipums$isco88a != 999])/1000000, 3) ) 
        
          })
        
          output$ncountries <- renderText({
            
            return( length( unique( ipums$country ) ) )
            
          }) 
        
          
          #### country summary table
          
           output$ipums.countries <- DT::renderDataTable({
          
                                           mycountry <- ddply( ipums[ ipums$isco88a != 999 , ], .(country), summarize, n.M =   sum(n_people)/1000000  )
          
                                           mycountry$country.lab <- country$Label[ match( mycountry$country , country$Value)]
          
                                           mycountry <- mycountry[ order( mycountry$n.M , decreasing = TRUE ), c(1,3,2)]
          
                                           mycountry$year <- ipums$year[ match( mycountry$country , ipums$country)]  
                                           
      
          
                                           datatable(mycountry, 
                                                     rownames = FALSE, 
                                                     options = list( autoWidth = TRUE , pageLength = 15 , 
                                                                     
                                                                     columnDefs = list(                                     list(width = '300px', targets = 1),
                                                                                                                            list(className = 'dt-center', targets = 2:3),
                                                                                                                            list(className = 'dt-left', targets = 0:1)) ),
                                                     colnames = c('Country code', 'Country name', 'Millions workers', 'Year of census'),
                                                     caption = 'Overall portrait of countries included in the IPUMS extracy') %>%
                                                   formatRound('n.M', digits = 1)
          
                                   
                                })
     
     
#########################################  CANJEM TAB     
    
    ##### COBALT          
               output$canjem.cobalt <- DT::renderDataTable({        
               
                             canjem.pop.cobalt.sum <- canjem.pop.cobalt   
                             
                             canjem.pop.cobalt.sum$isco.lab <- isco$Label[match( canjem.pop.cobalt.sum$ISCO883D , isco$Value)]    
                             
                             canjem.pop.cobalt.sum <- canjem.pop.cobalt.sum[ order(canjem.pop.cobalt.sum$p , decreasing = TRUE) , c( 1 , 27 , 2 , 4 , 22 , 23 , 24) ] 
                             
                             canjem.pop.cobalt.sum$most.freq.confidence[ ] <- confidence$label[ match( canjem.pop.cobalt.sum$most.freq.confidence , confidence$code)]
                             
                             canjem.pop.cobalt.sum$most.freq.intensity <- intensity$label[ match( canjem.pop.cobalt.sum$most.freq.intensity , intensity$code )]
                             
                             canjem.pop.cobalt.sum$most.freq.frequency <- frequency$label[ match( canjem.pop.cobalt.sum$most.freq.frequency , frequency$code)]
                             
                             names( canjem.pop.cobalt.sum ) <-c( "ISCO88" , "Title" , "n.jobs" , "p" , "Confidence" , "Intensity" , "Frequency")
                             
                             canjem.pop.cobalt.sum <- canjem.pop.cobalt.sum[ canjem.pop.cobalt.sum$p >= 1 & !is.na(canjem.pop.cobalt.sum$p) , ]
                             
                             datatable(canjem.pop.cobalt.sum, 
                                       rownames = FALSE, 
                                       options = list( autoWidth = TRUE , pageLength = 10 , 
                                                       
                                                       columnDefs = list(                                     list(width = '200px', targets = "1_all"),
                                                                                                              list(className = 'dt-center', targets = 2:6),
                                                                                                              list(className = 'dt-left', targets = 0:1)) ),
                                     
                                       caption = 'CANJEM summary for cobalt') %>%
                                            formatRound('n.jobs', digits = 0)%>%
                                            formatRound('p', digits = 1)
               
               })
               
               
    ##### ANTIMONY
               
               output$canjem.antimony <- DT::renderDataTable({        
                 
                 canjem.pop.antimony.sum <- canjem.pop.antimony   
                 
                 canjem.pop.antimony.sum$isco.lab <- isco$Label[match( canjem.pop.antimony.sum$ISCO883D , isco$Value)]    
                 
                 canjem.pop.antimony.sum <- canjem.pop.antimony.sum[ order(canjem.pop.antimony.sum$p , decreasing = TRUE) , c( 1 , 27 , 2 , 4 , 22 , 23 , 24) ] 
                 
                 canjem.pop.antimony.sum$most.freq.confidence[ ] <- confidence$label[ match( canjem.pop.antimony.sum$most.freq.confidence , confidence$code)]
                 
                 canjem.pop.antimony.sum$most.freq.intensity <- intensity$label[ match( canjem.pop.antimony.sum$most.freq.intensity , intensity$code )]
                 
                 canjem.pop.antimony.sum$most.freq.frequency <- frequency$label[ match( canjem.pop.antimony.sum$most.freq.frequency , frequency$code)]
                 
                 names( canjem.pop.antimony.sum ) <-c( "ISCO88" , "Title" , "n.jobs" , "p" , "Confidence" , "Intensity" , "Frequency")
                 
                 canjem.pop.antimony.sum <- canjem.pop.antimony.sum[ canjem.pop.antimony.sum$p >= 1 & !is.na(canjem.pop.antimony.sum$p) , ]
                 
                 datatable(canjem.pop.antimony.sum, 
                           rownames = FALSE, 
                           options = list( autoWidth = TRUE , pageLength = 10 , 
                                           
                                           columnDefs = list(                                     list(width = '200px', targets = "1_all"),
                                                                                                  list(className = 'dt-center', targets = 2:6),
                                                                                                  list(className = 'dt-left', targets = 0:1)) ),
                           
                           caption = 'CANJEM summary for antimony') %>%
                   formatRound('n.jobs', digits = 0)%>%
                   formatRound('p', digits = 1)
                 
               })  
               
               
               
    ##### TUNGSTEN
               
               output$canjem.tungsten <- DT::renderDataTable({        
                 
                 canjem.pop.tungsten.sum <- canjem.pop.tungsten   
                 
                 canjem.pop.tungsten.sum$isco.lab <- isco$Label[match( canjem.pop.tungsten.sum$ISCO883D , isco$Value)]    
                 
                 canjem.pop.tungsten.sum <- canjem.pop.tungsten.sum[ order(canjem.pop.tungsten.sum$p , decreasing = TRUE) , c( 1 , 27 , 2 , 4 , 22 , 23 , 24) ] 
                 
                 canjem.pop.tungsten.sum$most.freq.confidence[ ] <- confidence$label[ match( canjem.pop.tungsten.sum$most.freq.confidence , confidence$code)]
                 
                 canjem.pop.tungsten.sum$most.freq.intensity <- intensity$label[ match( canjem.pop.tungsten.sum$most.freq.intensity , intensity$code )]
                 
                 canjem.pop.tungsten.sum$most.freq.frequency <- frequency$label[ match( canjem.pop.tungsten.sum$most.freq.frequency , frequency$code)]
                 
                 names( canjem.pop.tungsten.sum ) <-c( "ISCO88" , "Title" , "n.jobs" , "p" , "Confidence" , "Intensity" , "Frequency")
                 
                 canjem.pop.tungsten.sum <- canjem.pop.tungsten.sum[ canjem.pop.tungsten.sum$p >= 1 & !is.na(canjem.pop.tungsten.sum$p) , ]
                 
                 datatable(canjem.pop.tungsten.sum, 
                           rownames = FALSE, 
                           options = list( autoWidth = TRUE , pageLength = 10 , 
                                           
                                           columnDefs = list(                                     list(width = '200px', targets = "1_all"),
                                                                                                  list(className = 'dt-center', targets = 2:6),
                                                                                                  list(className = 'dt-left', targets = 0:1)) ),
                           
                           caption = 'CANJEM summary for tungsten') %>%
                   formatRound('n.jobs', digits = 0)%>%
                   formatRound('p', digits = 1)
                 
               })
           
               
               
############################### ESTIMATES BY COUNTRY               
               
               
      ###### COBALT
               
               
            ########## creation of the base table   
               
            estbycountry.cobalt.prep <- reactive({
              
                    selected.country <- country$Value[ country$Label == input$country ]
                    
                    country.tab.cobalt <- data.frame( isco88 = unique( ipums$isco88a[ ipums$country == selected.country] )) 
                    
                    country.tab.cobalt$isco.lab <- isco$Label[ match( country.tab.cobalt$isco88 , isco$Value)]
                    
                    country.tab.cobalt <- country.tab.cobalt[ !is.element( country.tab.cobalt$isco88 , c(998,999) )   ,  ]
                    
                    country.tab.cobalt$n.people <-   ipums$n_people[ ipums$country == selected.country ][ match( country.tab.cobalt$isco88 ,ipums$isco88a[ ipums$country == selected.country ] )]  
                    
                    country.tab.cobalt$estatus <- canjem.pop.cobalt$exposed[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D)]
                    
                    country.tab.cobalt$estatus[ is.na(country.tab.cobalt$estatus)] <- "unknown"
                    
                    country.tab.cobalt$p.exp <- canjem.pop.cobalt$p[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D)]
                    
                    country.tab.cobalt$p.exp[ country.tab.cobalt$estatus == "unexposed" ] <- 0
                    
                    country.tab.cobalt$n.low <-  country.tab.cobalt$n.people*canjem.pop.cobalt$p.C1[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 
                    
                    country.tab.cobalt$n.low[ country.tab.cobalt$estatus == "unexposed" ] <- 0
                    
                    country.tab.cobalt$n.medium <-  country.tab.cobalt$n.people*canjem.pop.cobalt$p.C2[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 
                    
                    country.tab.cobalt$n.medium[ country.tab.cobalt$estatus == "unexposed" ] <- 0
                    
                    country.tab.cobalt$n.high <-  country.tab.cobalt$n.people*canjem.pop.cobalt$p.C3[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 
                    
                    country.tab.cobalt$n.high[ country.tab.cobalt$estatus == "unexposed" ] <- 0
                    
                    country.tab.cobalt$most.freq.confidence <- ifelse(country.tab.cobalt$estatus == "pot.exposed", 
                                                                      confidence$label[ match( canjem.pop.cobalt$most.freq.confidence[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ] , confidence$code ) ],
                                                                      NA)
                    
                    country.tab.cobalt$n.lessthan2h <-  country.tab.cobalt$n.people*canjem.pop.cobalt$p.F1[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 
                    
                    country.tab.cobalt$n.lessthan2h[ country.tab.cobalt$estatus == "unexposed" ] <- 0
                    
                    country.tab.cobalt$n.2_12h <-  country.tab.cobalt$n.people*canjem.pop.cobalt$p.F2[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 
                    
                    country.tab.cobalt$n.2_12h[ country.tab.cobalt$estatus == "unexposed" ] <- 0
                    
                    country.tab.cobalt$n.12_39h <-  country.tab.cobalt$n.people*canjem.pop.cobalt$p.F3[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 
                    
                    country.tab.cobalt$n.12_39h[ country.tab.cobalt$estatus == "unexposed" ] <- 0
                    
                    country.tab.cobalt$n.40handover <-  country.tab.cobalt$n.people*canjem.pop.cobalt$p.F4[ match( country.tab.cobalt$isco88 , canjem.pop.cobalt$ISCO883D) ]/100 
                    
                    country.tab.cobalt$n.40handover[ country.tab.cobalt$estatus == "unexposed" ] <- 0  
                    
                    
                    return(country.tab.cobalt[ order(country.tab.cobalt$p.ex , decreasing = TRUE ) , ])
              
              
            })  
               
            ######### overall table
               
            output$estbycountry.cobalt.overall <-  renderTable({    
              
              
              country.tab.cobalt <- estbycountry.cobalt.prep()
              
              
              country.overall.cobalt <- data.frame( metric = c("total.n" , "P.exp" , "P.unexp" ,"P.unknown" , "n.low" , "n.medium" , "n.high" , "n.lessthan2h" , "n.2_12h" , "n.12_39h" , "n.40handover") , stringsAsFactors = FALSE )
              
              country.overall.cobalt$value[1] <-  sum(country.tab.cobalt$n.people)
              
              country.overall.cobalt$value[2] <-   100*sum(country.tab.cobalt$n.people[ country.tab.cobalt$estatus == "pot.exposed"] * country.tab.cobalt$p.exp[ country.tab.cobalt$estatus == "pot.exposed"]/100)/country.overall.cobalt$value[1]   
              
              country.overall.cobalt$value[3] <-   100* ( sum(country.tab.cobalt$n.people[ country.tab.cobalt$estatus=="unexposed" ]) + 
                                                            sum(country.tab.cobalt$n.people[ country.tab.cobalt$estatus == "pot.exposed"])-
                                                            sum(country.tab.cobalt$n.people[ country.tab.cobalt$estatus == "pot.exposed"] * country.tab.cobalt$p.exp[ country.tab.cobalt$estatus == "pot.exposed"]/100)) / country.overall.cobalt$value[1]   
              
              country.overall.cobalt$value[4] <-   100*sum(country.tab.cobalt$n.people[ country.tab.cobalt$estatus == "unknown"])/country.overall.cobalt$value[1]   
              
              country.overall.cobalt$value[5] <-   sum( country.tab.cobalt$n.low , na.rm = TRUE )  
              
              country.overall.cobalt$value[6] <-   sum( country.tab.cobalt$n.medium , na.rm = TRUE  )  
              
              country.overall.cobalt$value[7] <-   sum( country.tab.cobalt$n.high , na.rm = TRUE  )  
              
              country.overall.cobalt$value[8] <-   sum( country.tab.cobalt$n.lessthan2h , na.rm = TRUE  )  
              
              country.overall.cobalt$value[9] <-   sum( country.tab.cobalt$n.2_12h , na.rm = TRUE  )  
              
              country.overall.cobalt$value[10] <-   sum( country.tab.cobalt$n.12_39h , na.rm = TRUE  )  
              
              country.overall.cobalt$value[11] <-   sum( country.tab.cobalt$n.40handover , na.rm = TRUE  ) 
              
              
              ## number formatting
              
              test <- data.frame( metric = country.overall.cobalt$metric ,
                                  
                                  value = character(11) )
              
              
              
              test$value[1] <-  paste(formatC( country.overall.cobalt$value[1], digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
              
              test$value[2] <- paste( signif( country.overall.cobalt$value[2] , 2 ) , "%" , sep="" )
              test$value[3] <- paste( signif( country.overall.cobalt$value[3] , 2 ) , "%" , sep="" )
              test$value[4] <- paste( signif( country.overall.cobalt$value[4] , 2 ) , "%" , sep="" )
              
              test$value[5] <-  paste(formatC( round(country.overall.cobalt$value[5]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
              test$value[6] <-  paste(formatC( round(country.overall.cobalt$value[6]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
              test$value[7] <-  paste(formatC( round(country.overall.cobalt$value[7]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
              test$value[8] <-  paste(formatC( round(country.overall.cobalt$value[8]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
              test$value[9] <-  paste(formatC( round(country.overall.cobalt$value[9]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
              test$value[10] <-  paste(formatC( round(country.overall.cobalt$value[10]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
              test$value[11] <-  paste(formatC( round(country.overall.cobalt$value[11]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
              test$metric <- c("Number of workers" , "Proportion exposed(%)" , "Proportion unexposed(%)" ,"Proportion unknown(%)" , "Number exposed to low intensity" , "Number exposed to medium intensity" , "Number exposed to high intensity" , "Number exposed less than 2h per week" , "Number exposed 2-12h per week" , "Number exposed 12-39 per week" , "Number exposed 40h per week")
              
              
              return(test)
            
            })                 
               
            ######## by country table   
               
             output$estbycountry.cobalt <-  DT::renderDataTable({ 
        
             country.tab.cobalt <- estbycountry.cobalt.prep()
        
              datatable(country.tab.cobalt,
                        rownames = FALSE, 
                        
                        colnames = c( "Code" , "Label" , "N.workers" , "Expo_status" , "Prop_exp (%)" , "N low exp" , "N medium exp" , "N high exp" , 
                                      "Confidence" , "<2h" , "2-12h" , "12-39h" , "40h+"),
                        
                        options = list( autoWidth = TRUE , pageLength = 10 , 
                                        
                                        columnDefs = list(                                     list(width = '200px', targets = "1_all"),
                                                                                               list(className = 'dt-center', targets = 2:12),
                                                                                               list(className = 'dt-left', targets = 0:1)) ),
                        
                        caption = 'Population exposed to Cobalt by 3-Digit ISCO') %>%
                formatRound('n.people', digits = 0)%>%
                formatRound('p.exp', digits = 1)%>%
                formatRound('n.low', digits = 0)%>%
                formatRound('n.medium', digits = 0)%>%
                formatRound('n.high', digits = 0)%>%
                formatRound('n.lessthan2h', digits = 0)%>%
                formatRound('n.2_12h', digits = 0)%>%
                formatRound('n.12_39h', digits = 0)%>%
                formatRound('n.40handover', digits = 0)
              
            })
                     
               
      ###### ANTIMONY
               
             ########## creation of the base table   
             
             estbycountry.antimony.prep <- reactive({
               
               selected.country <- country$Value[ country$Label == input$country ]
               
               country.tab.antimony <- data.frame( isco88 = unique( ipums$isco88a[ ipums$country == selected.country] )) 
               
               country.tab.antimony$isco.lab <- isco$Label[ match( country.tab.antimony$isco88 , isco$Value)]
               
               country.tab.antimony <- country.tab.antimony[ !is.element( country.tab.antimony$isco88 , c(998,999) )   ,  ]
               
               country.tab.antimony$n.people <-   ipums$n_people[ ipums$country == selected.country ][ match( country.tab.antimony$isco88 ,ipums$isco88a[ ipums$country == selected.country ] )]  
               
               country.tab.antimony$estatus <- canjem.pop.antimony$exposed[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D)]
               
               country.tab.antimony$estatus[ is.na(country.tab.antimony$estatus)] <- "unknown"
               
               country.tab.antimony$p.exp <- canjem.pop.antimony$p[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D)]
               
               country.tab.antimony$p.exp[ country.tab.antimony$estatus == "unexposed" ] <- 0
               
               country.tab.antimony$n.low <-  country.tab.antimony$n.people*canjem.pop.antimony$p.C1[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 
               
               country.tab.antimony$n.low[ country.tab.antimony$estatus == "unexposed" ] <- 0
               
               country.tab.antimony$n.medium <-  country.tab.antimony$n.people*canjem.pop.antimony$p.C2[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 
               
               country.tab.antimony$n.medium[ country.tab.antimony$estatus == "unexposed" ] <- 0
               
               country.tab.antimony$n.high <-  country.tab.antimony$n.people*canjem.pop.antimony$p.C3[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 
               
               country.tab.antimony$n.high[ country.tab.antimony$estatus == "unexposed" ] <- 0
               
               country.tab.antimony$most.freq.confidence <- ifelse(country.tab.antimony$estatus == "pot.exposed", 
                                                                 confidence$label[ match( canjem.pop.antimony$most.freq.confidence[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ] , confidence$code ) ],
                                                                 NA)
               
               country.tab.antimony$n.lessthan2h <-  country.tab.antimony$n.people*canjem.pop.antimony$p.F1[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 
               
               country.tab.antimony$n.lessthan2h[ country.tab.antimony$estatus == "unexposed" ] <- 0
               
               country.tab.antimony$n.2_12h <-  country.tab.antimony$n.people*canjem.pop.antimony$p.F2[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 
               
               country.tab.antimony$n.2_12h[ country.tab.antimony$estatus == "unexposed" ] <- 0
               
               country.tab.antimony$n.12_39h <-  country.tab.antimony$n.people*canjem.pop.antimony$p.F3[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 
               
               country.tab.antimony$n.12_39h[ country.tab.antimony$estatus == "unexposed" ] <- 0
               
               country.tab.antimony$n.40handover <-  country.tab.antimony$n.people*canjem.pop.antimony$p.F4[ match( country.tab.antimony$isco88 , canjem.pop.antimony$ISCO883D) ]/100 
               
               country.tab.antimony$n.40handover[ country.tab.antimony$estatus == "unexposed" ] <- 0  
               
               
               return(country.tab.antimony[ order(country.tab.antimony$p.ex , decreasing = TRUE ) , ])
               
               
             })  
             
             ######### overall table
             
             output$estbycountry.antimony.overall <-  renderTable({    
               
               
               country.tab.antimony <- estbycountry.antimony.prep()
               
               
               country.overall.antimony <- data.frame( metric = c("total.n" , "P.exp" , "P.unexp" ,"P.unknown" , "n.low" , "n.medium" , "n.high" , "n.lessthan2h" , "n.2_12h" , "n.12_39h" , "n.40handover") , stringsAsFactors = FALSE )
               
               country.overall.antimony$value[1] <-  sum(country.tab.antimony$n.people)
               
               country.overall.antimony$value[2] <-   100*sum(country.tab.antimony$n.people[ country.tab.antimony$estatus == "pot.exposed"] * country.tab.antimony$p.exp[ country.tab.antimony$estatus == "pot.exposed"]/100)/country.overall.antimony$value[1]   
               
               country.overall.antimony$value[3] <-   100* ( sum(country.tab.antimony$n.people[ country.tab.antimony$estatus=="unexposed" ]) + 
                                                             sum(country.tab.antimony$n.people[ country.tab.antimony$estatus == "pot.exposed"])-
                                                             sum(country.tab.antimony$n.people[ country.tab.antimony$estatus == "pot.exposed"] * country.tab.antimony$p.exp[ country.tab.antimony$estatus == "pot.exposed"]/100)) / country.overall.antimony$value[1]   
               
               country.overall.antimony$value[4] <-   100*sum(country.tab.antimony$n.people[ country.tab.antimony$estatus == "unknown"])/country.overall.antimony$value[1]   
               
               country.overall.antimony$value[5] <-   sum( country.tab.antimony$n.low , na.rm = TRUE )  
               
               country.overall.antimony$value[6] <-   sum( country.tab.antimony$n.medium , na.rm = TRUE  )  
               
               country.overall.antimony$value[7] <-   sum( country.tab.antimony$n.high , na.rm = TRUE  )  
               
               country.overall.antimony$value[8] <-   sum( country.tab.antimony$n.lessthan2h , na.rm = TRUE  )  
               
               country.overall.antimony$value[9] <-   sum( country.tab.antimony$n.2_12h , na.rm = TRUE  )  
               
               country.overall.antimony$value[10] <-   sum( country.tab.antimony$n.12_39h , na.rm = TRUE  )  
               
               country.overall.antimony$value[11] <-   sum( country.tab.antimony$n.40handover , na.rm = TRUE  ) 
               
               
               ## number formatting
               
               test <- data.frame( metric = country.overall.antimony$metric ,
                                   
                                   value = character(11) )
               
               
               
               test$value[1] <-  paste(formatC( country.overall.antimony$value[1], digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               
               test$value[2] <- paste( signif( country.overall.antimony$value[2] , 2 ) , "%" , sep="" )
               test$value[3] <- paste( signif( country.overall.antimony$value[3] , 2 ) , "%" , sep="" )
               test$value[4] <- paste( signif( country.overall.antimony$value[4] , 2 ) , "%" , sep="" )
               
               test$value[5] <-  paste(formatC( round(country.overall.antimony$value[5]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$value[6] <-  paste(formatC( round(country.overall.antimony$value[6]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$value[7] <-  paste(formatC( round(country.overall.antimony$value[7]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$value[8] <-  paste(formatC( round(country.overall.antimony$value[8]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$value[9] <-  paste(formatC( round(country.overall.antimony$value[9]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$value[10] <-  paste(formatC( round(country.overall.antimony$value[10]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$value[11] <-  paste(formatC( round(country.overall.antimony$value[11]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$metric <- c("Number of workers" , "Proportion exposed(%)" , "Proportion unexposed(%)" ,"Proportion unknown(%)" , "Number exposed to low intensity" , "Number exposed to medium intensity" , "Number exposed to high intensity" , "Number exposed less than 2h per week" , "Number exposed 2-12h per week" , "Number exposed 12-39 per week" , "Number exposed 40h per week")
               
               
               return(test)
               
             })                 
             
             ######## by country table   
             
             output$estbycountry.antimony <-  DT::renderDataTable({ 
               
               country.tab.antimony <- estbycountry.antimony.prep()
               
               datatable(country.tab.antimony,
                         rownames = FALSE, 
                         
                         colnames = c( "Code" , "Label" , "N.workers" , "Expo_status" , "Prop_exp (%)" , "N low exp" , "N medium exp" , "N high exp" , 
                                       "Confidence" , "<2h" , "2-12h" , "12-39h" , "40h+"),
                         
                         options = list( autoWidth = TRUE , pageLength = 10 , 
                                         
                                         columnDefs = list(                                     list(width = '200px', targets = "1_all"),
                                                                                                list(className = 'dt-center', targets = 2:12),
                                                                                                list(className = 'dt-left', targets = 0:1)) ),
                         
                         caption = 'Population exposed to antimony by 3-Digit ISCO') %>%
                 formatRound('n.people', digits = 0)%>%
                 formatRound('p.exp', digits = 1)%>%
                 formatRound('n.low', digits = 0)%>%
                 formatRound('n.medium', digits = 0)%>%
                 formatRound('n.high', digits = 0)%>%
                 formatRound('n.lessthan2h', digits = 0)%>%
                 formatRound('n.2_12h', digits = 0)%>%
                 formatRound('n.12_39h', digits = 0)%>%
                 formatRound('n.40handover', digits = 0)
               
             })
             
             
             
 
                    
      ###### TNUGSTEN         
               
             ########## creation of the base table   
             
             estbycountry.tungsten.prep <- reactive({
               
               selected.country <- country$Value[ country$Label == input$country ]
               
               country.tab.tungsten <- data.frame( isco88 = unique( ipums$isco88a[ ipums$country == selected.country] )) 
               
               country.tab.tungsten$isco.lab <- isco$Label[ match( country.tab.tungsten$isco88 , isco$Value)]
               
               country.tab.tungsten <- country.tab.tungsten[ !is.element( country.tab.tungsten$isco88 , c(998,999) )   ,  ]
               
               country.tab.tungsten$n.people <-   ipums$n_people[ ipums$country == selected.country ][ match( country.tab.tungsten$isco88 ,ipums$isco88a[ ipums$country == selected.country ] )]  
               
               country.tab.tungsten$estatus <- canjem.pop.tungsten$exposed[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D)]
               
               country.tab.tungsten$estatus[ is.na(country.tab.tungsten$estatus)] <- "unknown"
               
               country.tab.tungsten$p.exp <- canjem.pop.tungsten$p[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D)]
               
               country.tab.tungsten$p.exp[ country.tab.tungsten$estatus == "unexposed" ] <- 0
               
               country.tab.tungsten$n.low <-  country.tab.tungsten$n.people*canjem.pop.tungsten$p.C1[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 
               
               country.tab.tungsten$n.low[ country.tab.tungsten$estatus == "unexposed" ] <- 0
               
               country.tab.tungsten$n.medium <-  country.tab.tungsten$n.people*canjem.pop.tungsten$p.C2[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 
               
               country.tab.tungsten$n.medium[ country.tab.tungsten$estatus == "unexposed" ] <- 0
               
               country.tab.tungsten$n.high <-  country.tab.tungsten$n.people*canjem.pop.tungsten$p.C3[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 
               
               country.tab.tungsten$n.high[ country.tab.tungsten$estatus == "unexposed" ] <- 0
               
               country.tab.tungsten$most.freq.confidence <- ifelse(country.tab.tungsten$estatus == "pot.exposed", 
                                                                 confidence$label[ match( canjem.pop.tungsten$most.freq.confidence[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ] , confidence$code ) ],
                                                                 NA)
               
               country.tab.tungsten$n.lessthan2h <-  country.tab.tungsten$n.people*canjem.pop.tungsten$p.F1[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 
               
               country.tab.tungsten$n.lessthan2h[ country.tab.tungsten$estatus == "unexposed" ] <- 0
               
               country.tab.tungsten$n.2_12h <-  country.tab.tungsten$n.people*canjem.pop.tungsten$p.F2[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 
               
               country.tab.tungsten$n.2_12h[ country.tab.tungsten$estatus == "unexposed" ] <- 0
               
               country.tab.tungsten$n.12_39h <-  country.tab.tungsten$n.people*canjem.pop.tungsten$p.F3[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 
               
               country.tab.tungsten$n.12_39h[ country.tab.tungsten$estatus == "unexposed" ] <- 0
               
               country.tab.tungsten$n.40handover <-  country.tab.tungsten$n.people*canjem.pop.tungsten$p.F4[ match( country.tab.tungsten$isco88 , canjem.pop.tungsten$ISCO883D) ]/100 
               
               country.tab.tungsten$n.40handover[ country.tab.tungsten$estatus == "unexposed" ] <- 0  
               
               
               return(country.tab.tungsten[ order(country.tab.tungsten$p.ex , decreasing = TRUE ) , ])
               
               
             })  
             
             ######### overall table
             
             output$estbycountry.tungsten.overall <-  renderTable({    
               
               
               country.tab.tungsten <- estbycountry.tungsten.prep()
               
               
               country.overall.tungsten <- data.frame( metric = c("total.n" , "P.exp" , "P.unexp" ,"P.unknown" , "n.low" , "n.medium" , "n.high" , "n.lessthan2h" , "n.2_12h" , "n.12_39h" , "n.40handover") , stringsAsFactors = FALSE )
               
               country.overall.tungsten$value[1] <-  sum(country.tab.tungsten$n.people)
               
               country.overall.tungsten$value[2] <-   100*sum(country.tab.tungsten$n.people[ country.tab.tungsten$estatus == "pot.exposed"] * country.tab.tungsten$p.exp[ country.tab.tungsten$estatus == "pot.exposed"]/100)/country.overall.tungsten$value[1]   
               
               country.overall.tungsten$value[3] <-   100* ( sum(country.tab.tungsten$n.people[ country.tab.tungsten$estatus=="unexposed" ]) + 
                                                             sum(country.tab.tungsten$n.people[ country.tab.tungsten$estatus == "pot.exposed"])-
                                                             sum(country.tab.tungsten$n.people[ country.tab.tungsten$estatus == "pot.exposed"] * country.tab.tungsten$p.exp[ country.tab.tungsten$estatus == "pot.exposed"]/100)) / country.overall.tungsten$value[1]   
               
               country.overall.tungsten$value[4] <-   100*sum(country.tab.tungsten$n.people[ country.tab.tungsten$estatus == "unknown"])/country.overall.tungsten$value[1]   
               
               country.overall.tungsten$value[5] <-   sum( country.tab.tungsten$n.low , na.rm = TRUE )  
               
               country.overall.tungsten$value[6] <-   sum( country.tab.tungsten$n.medium , na.rm = TRUE  )  
               
               country.overall.tungsten$value[7] <-   sum( country.tab.tungsten$n.high , na.rm = TRUE  )  
               
               country.overall.tungsten$value[8] <-   sum( country.tab.tungsten$n.lessthan2h , na.rm = TRUE  )  
               
               country.overall.tungsten$value[9] <-   sum( country.tab.tungsten$n.2_12h , na.rm = TRUE  )  
               
               country.overall.tungsten$value[10] <-   sum( country.tab.tungsten$n.12_39h , na.rm = TRUE  )  
               
               country.overall.tungsten$value[11] <-   sum( country.tab.tungsten$n.40handover , na.rm = TRUE  ) 
               
               
               ## number formatting
               
               test <- data.frame( metric = country.overall.tungsten$metric ,
                                   
                                   value = character(11) )
               
               
               
               test$value[1] <-  paste(formatC( country.overall.tungsten$value[1], digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               
               test$value[2] <- paste( signif( country.overall.tungsten$value[2] , 2 ) , "%" , sep="" )
               test$value[3] <- paste( signif( country.overall.tungsten$value[3] , 2 ) , "%" , sep="" )
               test$value[4] <- paste( signif( country.overall.tungsten$value[4] , 2 ) , "%" , sep="" )
               
               test$value[5] <-  paste(formatC( round(country.overall.tungsten$value[5]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$value[6] <-  paste(formatC( round(country.overall.tungsten$value[6]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$value[7] <-  paste(formatC( round(country.overall.tungsten$value[7]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$value[8] <-  paste(formatC( round(country.overall.tungsten$value[8]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$value[9] <-  paste(formatC( round(country.overall.tungsten$value[9]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$value[10] <-  paste(formatC( round(country.overall.tungsten$value[10]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$value[11] <-  paste(formatC( round(country.overall.tungsten$value[11]), digits=9, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
               test$metric <- c("Number of workers" , "Proportion exposed(%)" , "Proportion unexposed(%)" ,"Proportion unknown(%)" , "Number exposed to low intensity" , "Number exposed to medium intensity" , "Number exposed to high intensity" , "Number exposed less than 2h per week" , "Number exposed 2-12h per week" , "Number exposed 12-39 per week" , "Number exposed 40h per week")
               
               
               return(test)
               
             })                 
             
             ######## by country table   
             
             output$estbycountry.tungsten <-  DT::renderDataTable({ 
               
               country.tab.tungsten <- estbycountry.tungsten.prep()
               
               datatable(country.tab.tungsten,
                         rownames = FALSE, 
                         
                         colnames = c( "Code" , "Label" , "N.workers" , "Expo_status" , "Prop_exp (%)" , "N low exp" , "N medium exp" , "N high exp" , 
                                       "Confidence" , "<2h" , "2-12h" , "12-39h" , "40h+"),
                         
                         options = list( autoWidth = TRUE , pageLength = 10 , 
                                         
                                         columnDefs = list(                                     list(width = '200px', targets = "1_all"),
                                                                                                list(className = 'dt-center', targets = 2:12),
                                                                                                list(className = 'dt-left', targets = 0:1)) ),
                         
                         caption = 'Population exposed to tungsten by 3-Digit ISCO') %>%
                 formatRound('n.people', digits = 0)%>%
                 formatRound('p.exp', digits = 1)%>%
                 formatRound('n.low', digits = 0)%>%
                 formatRound('n.medium', digits = 0)%>%
                 formatRound('n.high', digits = 0)%>%
                 formatRound('n.lessthan2h', digits = 0)%>%
                 formatRound('n.2_12h', digits = 0)%>%
                 formatRound('n.12_39h', digits = 0)%>%
                 formatRound('n.40handover', digits = 0)
               
             })
             
################################################# ESTIMATES BY ISCO
             
      ###### DATA SELECTION - MANAGEMENT OF TREES
             
             ####isco tree
             
             output$isco_tree_by_isco <- renderTree({
               
               isco.tree
               
             })              
             ###selected isco 
             
             isco.choice_by_isco <-reactive({
               
               tree.in <- input$isco_tree_by_isco
               
               isco.selected <-unlist(get_selected(tree.in)) 
               
               result <- substring( isco.selected , 1 , regexpr( ":" , isco.selected) - 2 )
               
               return(result)
               
             })      
             
             ##### selected isco name
             
             output$isconame_by_isco <- renderText({ 
               
               iscotofind <- isco.choice_by_isco()
               
               result <- isco$Label[ isco$Value==iscotofind]
               
               return(result)
               
             }) 
             
             ### if no isco selected
             
             output$by_isco_noiscoselected <- reactive({
               
               isco <- isco.choice_by_isco()
               
               result <-  length(isco)==0
               
               return(result)
             })
             
             outputOptions(output, 'by_isco_noiscoselected', suspendWhenHidden=FALSE) 
             
             
           



     ##########################  REACTIVE TABLE BY COUNTRY
             
             
          mycountry.prep <- reactive({
            
            mycountry <- ddply( ipums[ ipums$isco88a != 999 , ], .(country), summarize, n.M =   sum(n_people)/1000000  )
            
            mycountry$country.lab <- country$Label[ match( mycountry$country , country$Value)]
            
            mycountry <- mycountry[ order( mycountry$n.M , decreasing = TRUE ), c(1,3,2)]
            
            mycountry$year <- ipums$year[ match( mycountry$country , ipums$country)]  
            
            return(mycountry)
            
          })
          
             

          estbyoccupation.cobalt.prep <- reactive({
            
                      #selected.occupation <- isco.choice_by_isco()
            
                      selected.occupation <-  isco.choice_by_isco()
                      
                      myisco <- selected.occupation
                      
                      mycountry <- mycountry.prep()
                      
                      ## making a table summarizing exposure info ( top 5 countries)
                      
                      occup.tab.cobalt <- data.frame( country = unique( ipums$country[ ipums$isco88a == myisco]  ) , stringsAsFactors = FALSE )
                      
                      occup.tab.cobalt$country.lab <- country$Label[ match( occup.tab.cobalt$country , country$Value)]
                      
                      occup.tab.cobalt$n.people <-   ipums$n_people[ ipums$isco88a == myisco][ match( occup.tab.cobalt$country , ipums$country[ ipums$isco88a == myisco]  )  ]  
                      
                      occup.tab.cobalt$perc.people <-   100*occup.tab.cobalt$n.people/ (1000000*mycountry$n.M[ match( occup.tab.cobalt$country , mycountry$country )] )  
                      
                      occup.tab.cobalt$estatus <- canjem.pop.cobalt$exposed[ canjem.pop.cobalt$ISCO883D == myisco ]
                      
                      occup.tab.cobalt$n.unexp <-   occup.tab.cobalt$n.people*canjem.pop.cobalt$p.C0[ canjem.pop.cobalt$ISCO883D == myisco ]/100 
                      
                      occup.tab.cobalt$n.low <-   occup.tab.cobalt$n.people*canjem.pop.cobalt$p.C1[ canjem.pop.cobalt$ISCO883D == myisco ]/100 
                      
                      occup.tab.cobalt$n.medium <-   occup.tab.cobalt$n.people*canjem.pop.cobalt$p.C2[ canjem.pop.cobalt$ISCO883D == myisco ]/100 
                      
                      occup.tab.cobalt$n.high <-   occup.tab.cobalt$n.people*canjem.pop.cobalt$p.C3[ canjem.pop.cobalt$ISCO883D == myisco ]/100 
                      
                      occup.tab.cobalt$most.freq.confidence <- ifelse( occup.tab.cobalt$estatus == "pot.exposed", 
                                                                       confidence$label[ confidence$code == canjem.pop.cobalt$most.freq.confidence[ canjem.pop.cobalt$ISCO883D == myisco ] ],
                                                                       NA)
                      
                      occup.tab.cobalt$most.freq.frequency <- ifelse( occup.tab.cobalt$estatus == "pot.exposed", 
                                                                      frequency$label[ frequency$code == canjem.pop.cobalt$most.freq.frequency[ canjem.pop.cobalt$ISCO883D == myisco ] ],
                                                                      NA)
                      return(occup.tab.cobalt)
                      
          })

          
   estbyoccupation.antimony.prep <- reactive({
            
            #selected.occupation <- isco.choice_by_isco()
            
            selected.occupation <-  isco.choice_by_isco()
            
            myisco <- selected.occupation
            
            mycountry <- mycountry.prep()
            
            ## making a table summarizing exposure info ( top 5 countries)
            
            occup.tab.antimony <- data.frame( country = unique( ipums$country[ ipums$isco88a == myisco]  ) , stringsAsFactors = FALSE )
            
            occup.tab.antimony$country.lab <- country$Label[ match( occup.tab.antimony$country , country$Value)]
            
            occup.tab.antimony$n.people <-   ipums$n_people[ ipums$isco88a == myisco][ match( occup.tab.antimony$country , ipums$country[ ipums$isco88a == myisco]  )  ]  
            
            occup.tab.antimony$perc.people <-   100*occup.tab.antimony$n.people/ (1000000*mycountry$n.M[ match( occup.tab.antimony$country , mycountry$country )] )  
            
            occup.tab.antimony$estatus <- canjem.pop.antimony$exposed[ canjem.pop.antimony$ISCO883D == myisco ]
            
            occup.tab.antimony$n.unexp <-   occup.tab.antimony$n.people*canjem.pop.antimony$p.C0[ canjem.pop.antimony$ISCO883D == myisco ]/100 
            
            occup.tab.antimony$n.low <-   occup.tab.antimony$n.people*canjem.pop.antimony$p.C1[ canjem.pop.antimony$ISCO883D == myisco ]/100 
            
            occup.tab.antimony$n.medium <-   occup.tab.antimony$n.people*canjem.pop.antimony$p.C2[ canjem.pop.antimony$ISCO883D == myisco ]/100 
            
            occup.tab.antimony$n.high <-   occup.tab.antimony$n.people*canjem.pop.antimony$p.C3[ canjem.pop.antimony$ISCO883D == myisco ]/100 
            
            occup.tab.antimony$most.freq.confidence <- ifelse( occup.tab.antimony$estatus == "pot.exposed", 
                                                             confidence$label[ confidence$code == canjem.pop.antimony$most.freq.confidence[ canjem.pop.antimony$ISCO883D == myisco ] ],
                                                             NA)
            
            occup.tab.antimony$most.freq.frequency <- ifelse( occup.tab.antimony$estatus == "pot.exposed", 
                                                            frequency$label[ frequency$code == canjem.pop.antimony$most.freq.frequency[ canjem.pop.antimony$ISCO883D == myisco ] ],
                                                            NA)
            return(occup.tab.antimony)
            
          })
          

 estbyoccupation.tungsten.prep <- reactive({
     
           #selected.occupation <- isco.choice_by_isco()
           
           selected.occupation <-  isco.choice_by_isco()
           
           myisco <- selected.occupation
           
           mycountry <- mycountry.prep()
           
           ## making a table summarizing exposure info ( top 5 countries)
           
           occup.tab.tungsten <- data.frame( country = unique( ipums$country[ ipums$isco88a == myisco]  ) , stringsAsFactors = FALSE )
           
           occup.tab.tungsten$country.lab <- country$Label[ match( occup.tab.tungsten$country , country$Value)]
           
           occup.tab.tungsten$n.people <-   ipums$n_people[ ipums$isco88a == myisco][ match( occup.tab.tungsten$country , ipums$country[ ipums$isco88a == myisco]  )  ]  
           
           occup.tab.tungsten$perc.people <-   100*occup.tab.tungsten$n.people/ (1000000*mycountry$n.M[ match( occup.tab.tungsten$country , mycountry$country )] )  
           
           occup.tab.tungsten$estatus <- canjem.pop.tungsten$exposed[ canjem.pop.tungsten$ISCO883D == myisco ]
           
           occup.tab.tungsten$n.unexp <-   occup.tab.tungsten$n.people*canjem.pop.tungsten$p.C0[ canjem.pop.tungsten$ISCO883D == myisco ]/100 
           
           occup.tab.tungsten$n.low <-   occup.tab.tungsten$n.people*canjem.pop.tungsten$p.C1[ canjem.pop.tungsten$ISCO883D == myisco ]/100 
           
           occup.tab.tungsten$n.medium <-   occup.tab.tungsten$n.people*canjem.pop.tungsten$p.C2[ canjem.pop.tungsten$ISCO883D == myisco ]/100 
           
           occup.tab.tungsten$n.high <-   occup.tab.tungsten$n.people*canjem.pop.tungsten$p.C3[ canjem.pop.tungsten$ISCO883D == myisco ]/100 
           
           occup.tab.tungsten$most.freq.confidence <- ifelse( occup.tab.tungsten$estatus == "pot.exposed", 
                                                            confidence$label[ confidence$code == canjem.pop.tungsten$most.freq.confidence[ canjem.pop.tungsten$ISCO883D == myisco ] ],
                                                            NA)
           
           occup.tab.tungsten$most.freq.frequency <- ifelse( occup.tab.tungsten$estatus == "pot.exposed", 
                                                           frequency$label[ frequency$code == canjem.pop.tungsten$most.freq.frequency[ canjem.pop.tungsten$ISCO883D == myisco ] ],
                                                           NA)
           return(occup.tab.tungsten)
           
   })
   
          
          
          
     ######################### OVERALL TABLE for one occupation

     output$estbyisco.cobalt.overall <-  renderTable({    
             
            occup.tab.cobalt <- estbyoccupation.cobalt.prep()
            
            mycountry <- mycountry.prep()
            
            
            occup.overall.cobalt <- data.frame( metric = c("total.n" , "total.perc" , "estatus" , "n.unexp" , "n.low" , "n.medium" , "n.high") , stringsAsFactors = FALSE )
            
            occup.overall.cobalt$value[1] <-   sum(occup.tab.cobalt$n.people)  
            
            occup.overall.cobalt$value[2] <-   100*occup.overall.cobalt$value[1]/sum( mycountry$n.M * 1000000 )  
            
            occup.overall.cobalt$value[3] <- occup.tab.cobalt$estatus[1]
            
            occup.overall.cobalt$value[4] <-   sum( occup.tab.cobalt$n.unexp)  
            
            occup.overall.cobalt$value[5] <-   sum( occup.tab.cobalt$n.low )  
            
            occup.overall.cobalt$value[6] <-   sum( occup.tab.cobalt$n.medium )  
            
            occup.overall.cobalt$value[7] <-   sum( occup.tab.cobalt$n.high )  

            ## number formatting
            
            test <- data.frame( metric = occup.overall.cobalt$metric ,
                                
                                value = character(7) )
            
            
            
            test$value[1] <-  paste(formatC( as.numeric( occup.overall.cobalt$value[1]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
            
            test$value[2] <-  paste( signif( as.numeric( occup.overall.cobalt$value[2]) , 2), " %", sep="")
            
            test$value[3] <-  occup.overall.cobalt$value[3]
            
            if (test$value[3]=="pot.exposed") test$value[3] <-"Potentially exposed" 
            
            test$value[4] <- paste(formatC( as.numeric( occup.overall.cobalt$value[4]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
            test$value[5] <-  paste(formatC( as.numeric( occup.overall.cobalt$value[5]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
            test$value[6] <-  paste(formatC( as.numeric( occup.overall.cobalt$value[6]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
            test$value[7] <-  paste(formatC( as.numeric( occup.overall.cobalt$value[7]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
           
            test$metric <- c("Number of workers in this occupation" , "Proportion of included population(%)" , "Exposure status" ,"Number of unexposed workers" , "Number exposed to low intensity" , "Number exposed to medium intensity" , "Number exposed to high intensity" )
            
            
            return(test)
             
           })
     
output$estbyisco.antimony.overall <-  renderTable({    
       
             occup.tab.antimony <- estbyoccupation.antimony.prep()
             
             mycountry <- mycountry.prep()
             
             
             occup.overall.antimony <- data.frame( metric = c("total.n" , "total.perc" , "estatus" , "n.unexp" , "n.low" , "n.medium" , "n.high") , stringsAsFactors = FALSE )
             
             occup.overall.antimony$value[1] <-   sum(occup.tab.antimony$n.people)  
             
             occup.overall.antimony$value[2] <-   100*occup.overall.antimony$value[1]/sum( mycountry$n.M * 1000000 )  
             
             occup.overall.antimony$value[3] <- occup.tab.antimony$estatus[1]
             
             occup.overall.antimony$value[4] <-   sum( occup.tab.antimony$n.unexp)  
             
             occup.overall.antimony$value[5] <-   sum( occup.tab.antimony$n.low )  
             
             occup.overall.antimony$value[6] <-   sum( occup.tab.antimony$n.medium )  
             
             occup.overall.antimony$value[7] <-   sum( occup.tab.antimony$n.high )  
             
             ## number formatting
             
             test <- data.frame( metric = occup.overall.antimony$metric ,
                                 
                                 value = character(7) )
             
             
             
             test$value[1] <-  paste(formatC( as.numeric( occup.overall.antimony$value[1]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
             
             test$value[2] <-  paste( signif( as.numeric( occup.overall.antimony$value[2]) , 2), " %", sep="")
             
             test$value[3] <-  occup.overall.antimony$value[3]
             
             if (test$value[3]=="pot.exposed") test$value[3] <-"Potentially exposed" 
             
             test$value[4] <- paste(formatC( as.numeric( occup.overall.antimony$value[4]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
             test$value[5] <-  paste(formatC( as.numeric( occup.overall.antimony$value[5]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
             test$value[6] <-  paste(formatC( as.numeric( occup.overall.antimony$value[6]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
             test$value[7] <-  paste(formatC( as.numeric( occup.overall.antimony$value[7]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
             
             test$metric <- c("Number of workers in this occupation" , "Proportion of included population(%)" , "Exposure status" ,"Number of unexposed workers" , "Number exposed to low intensity" , "Number exposed to medium intensity" , "Number exposed to high intensity" )
             
             
             return(test)
       
     })
     

output$estbyisco.tungsten.overall <-  renderTable({    
  
          occup.tab.tungsten <- estbyoccupation.tungsten.prep()
          
          mycountry <- mycountry.prep()
          
          
          occup.overall.tungsten <- data.frame( metric = c("total.n" , "total.perc" , "estatus" , "n.unexp" , "n.low" , "n.medium" , "n.high") , stringsAsFactors = FALSE )
          
          occup.overall.tungsten$value[1] <-   sum(occup.tab.tungsten$n.people)  
          
          occup.overall.tungsten$value[2] <-   100*occup.overall.tungsten$value[1]/sum( mycountry$n.M * 1000000 )  
          
          occup.overall.tungsten$value[3] <- occup.tab.tungsten$estatus[1]
          
          occup.overall.tungsten$value[4] <-   sum( occup.tab.tungsten$n.unexp)  
          
          occup.overall.tungsten$value[5] <-   sum( occup.tab.tungsten$n.low )  
          
          occup.overall.tungsten$value[6] <-   sum( occup.tab.tungsten$n.medium )  
          
          occup.overall.tungsten$value[7] <-   sum( occup.tab.tungsten$n.high )  
          
          ## number formatting
          
          test <- data.frame( metric = occup.overall.tungsten$metric ,
                              
                              value = character(7) )
          
          
          
          test$value[1] <-  paste(formatC( as.numeric( occup.overall.tungsten$value[1]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
          
          test$value[2] <-  paste( signif( as.numeric( occup.overall.tungsten$value[2]) , 2), " %", sep="")
          
          test$value[3] <-  occup.overall.tungsten$value[3]
          
          if (test$value[3]=="pot.exposed") test$value[3] <-"Potentially exposed" 
          
          test$value[4] <- paste(formatC( as.numeric( occup.overall.tungsten$value[4]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
          test$value[5] <-  paste(formatC( as.numeric( occup.overall.tungsten$value[5]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
          test$value[6] <-  paste(formatC( as.numeric( occup.overall.tungsten$value[6]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
          test$value[7] <-  paste(formatC( as.numeric( occup.overall.tungsten$value[7]), digits=7, decimal.mark=",",big.mark=" ",small.mark=".", small.interval=3)," ",sep="")
          
          test$metric <- c("Number of workers in this occupation" , "Proportion of included population(%)" , "Exposure status" ,"Number of unexposed workers" , "Number exposed to low intensity" , "Number exposed to medium intensity" , "Number exposed to high intensity" )
          
  
  return(test)
  
})
    

         
     ############################ Table by COUNTRY
          
  output$estbyisco.cobalt <-  DT::renderDataTable({ 
            
            occup.tab.cobalt <- estbyoccupation.cobalt.prep()
            
            datatable(occup.tab.cobalt[,2:11],
                      rownames = FALSE, 
                      
                      colnames = c( "Label" , "N.workers" , "Prop of pop(%)" , "Exposure status" , "N.unexp", "N.low" , "N.medium" , "N.high" , 
                                    "Confidence" , "Frequency"),
                      
                      options = list( autoWidth = TRUE , pageLength = 10 , 
                                      
                                      columnDefs = list(                                     list(width = '200px', targets = "_all"),
                                                                                             list(className = 'dt-center', targets = 2:9),
                                                                                             list(className = 'dt-left', targets = 0:1)) ),
                      
                      caption = 'Population exposed to cobalt by country') %>%
              formatRound('n.people', digits = 0)%>%
              formatRound('perc.people', digits = 1)%>%
              formatRound('n.low', digits = 0)%>%
              formatRound('n.medium', digits = 0)%>%
              formatRound('n.high', digits = 0)%>%
              formatRound('n.unexp', digits = 0)
            
          })
          
          
 output$estbyisco.antimony <-  DT::renderDataTable({ 
            
                  occup.tab.antimony <- estbyoccupation.antimony.prep()
                  
                  datatable(occup.tab.antimony[,2:11],
                            rownames = FALSE, 
                            
                            colnames = c( "Label" , "N.workers" , "Prop of pop(%)" , "Exposure status" , "N.unexp", "N.low" , "N.medium" , "N.high" , 
                                          "Confidence" , "Frequency"),
                            
                            options = list( autoWidth = TRUE , pageLength = 10 , 
                                            
                                            columnDefs = list(                                     list(width = '200px', targets = "_all"),
                                                                                                   list(className = 'dt-center', targets = 2:9),
                                                                                                   list(className = 'dt-left', targets = 0:1)) ),
                            
                            caption = 'Population exposed to antimony by country') %>%
                    formatRound('n.people', digits = 0)%>%
                    formatRound('perc.people', digits = 1)%>%
                    formatRound('n.low', digits = 0)%>%
                    formatRound('n.medium', digits = 0)%>%
                    formatRound('n.high', digits = 0)%>%
                    formatRound('n.unexp', digits = 0)
            
          })        
          
 
 output$estbyisco.tungsten <-  DT::renderDataTable({ 
   
             occup.tab.tungsten <- estbyoccupation.tungsten.prep()
             
             datatable(occup.tab.tungsten[,2:11],
                       rownames = FALSE, 
                       
                       colnames = c( "Label" , "N.workers" , "Prop of pop(%)" , "Exposure status" , "N.unexp", "N.low" , "N.medium" , "N.high" , 
                                     "Confidence" , "Frequency"),
                       
                       options = list( autoWidth = TRUE , pageLength = 10 , 
                                       
                                       columnDefs = list(                                     list(width = '200px', targets = "_all"),
                                                                                              list(className = 'dt-center', targets = 2:9),
                                                                                              list(className = 'dt-left', targets = 0:1)) ),
                       
                       caption = 'Population exposed to tungsten by country') %>%
               formatRound('n.people', digits = 0)%>%
               formatRound('perc.people', digits = 1)%>%
               formatRound('n.low', digits = 0)%>%
               formatRound('n.medium', digits = 0)%>%
               formatRound('n.high', digits = 0)%>%
               formatRound('n.unexp', digits = 0)
   
 })      
 
##########################################   OVERALL TABLES
          
          
          output$overall <-  renderTable({     
          
            result <- data.frame( metric = overall.final.cobalt$metric)
            
            result$cobalt <- overall.final.cobalt$value
            
            result$antimony <- overall.final.antimony$value
            
            result$tungsten <- overall.final.tungsten$value
            
            result$metric <- c("Number of workers (M)" , "Number of exposed workers (K)" , "Number of unexposed workers (M)" ,"Number of workers with unknown status (M)" ," Number exposed to low intensity (K)" , "Number exposed to medium intensity (K)" , "Number exposed to high intensity (K)", "Number exposed <2h (K)" , "Number exposed 2-12h (K)" , "Number exposed 12-39h (K)" , "Number exposed 40h+ (K)" )
            
            result[ c(2,5:11)  , 2:4] <- result[ c(2,5:11)  , 2:4]*1000
            
            result <- result[ c(1,4,3,2,5:11) ,]
            
            return(result)
            
            
          }, digits = 1)
          
         
})