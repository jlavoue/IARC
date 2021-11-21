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
library(dplyr)
library(shinybusy)
library(ggthemes)
library(shinyTree)
library(readxl)
library(DT)
#library(plyr)


###################### preliminaries

        
        ############## reading database
        
        ## CANJEM
        
        canjem.pop.cobalt <- readRDS( "./data/canjemcobalt.RDS")
        
        canjem.pop.antimony <- readRDS( "./data/canjemantimony.RDS")
        
        canjem.pop.tungsten <- readRDS( "./data/canjemtungsten.RDS")
        
        ## IPUMS
        
        ipums <- readRDS( "./data/ipums.RDS" )
        
        isco <- read_xlsx("./data/isco883D.xlsx")
        
        country <- read_xlsx("./data/countries.xlsx")
        
        
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
               
               
      ###### ANTIMANY         
               
       
      ######  OVERALL TABLE                 
           
})
