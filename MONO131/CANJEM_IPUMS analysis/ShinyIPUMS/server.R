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


    
    #######################  IPUMS tab
    
    
    #### country summary table
    
     output$ipums.countries <- DT::renderDataTable({
    
                                     mycountry <- ddply( ipums[ ipums$isco88a != 999 , ], .(country), summarize, n.M =   sum(n_people)/1000000  )
    
                                     mycountry$country.lab <- country$Label[ match( mycountry$country , country$Value)]
    
                                     mycountry <- mycountry[ order( mycountry$n.M , decreasing = TRUE ), c(1,3,2)]
    
                                     mycountry$year <- ipums$year[ match( mycountry$country , ipums$country)]  
                                     

    
                                     datatable(mycountry, 
                                               rownames = FALSE, 
                                               options = list( autoWidth = TRUE , pageLength = 15 , 
                                                               
                                                               columnDefs = list(                                     list(width = '100px', targets = c(0,2,3)),
                                                                                                                      list(className = 'dt-center', targets = 2:3),
                                                                                                                      list(className = 'dt-left', targets = 0:1)) ),
                                               colnames = c('Country code', 'Country name', 'Millions workers', 'Year of census'),
                                               caption = 'Table 1: Overall portrait of countries included in the IPUMS extracy') %>%
                                             formatRound('n.M', digits = 1)
    
                             
                          })
    
    
})
