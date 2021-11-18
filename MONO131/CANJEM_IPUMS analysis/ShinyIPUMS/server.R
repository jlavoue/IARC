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
library(plyr)


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
           
           
})
