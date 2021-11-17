#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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

#########################################
####  PRELIMINARY SCRIPTS
##################################################


##### MONO131 Analysis of IPUMS census data and merging with CANJEM

       
          ############## reading databases

          #cehd <- readRDS("./data/cehdM131.RDS")


          ############  hidin warning messages
          
          tags$style(type="text/css",
                     ".shiny-output-error { visibility: hidden; }",
                     ".shiny-output-error:before { visibility: hidden; }")

      

###########################################
#      
#      UI DEFINITION
#
#
##############################################
      ui <- tagList(
        #tags$head(
        #  tags$style("#img-id{ position: fixed; right: 10px; top: 5px; height: 50px; width: 300px; }")
        #),
        navbarPage(
          title = div(
           # div(
           #    img(id="img-id", src = "./myimg.png")
           # ),
            "Monograph131_Exposed workers"),
          
           windowTitle = "Mono131 app II" ,
          
          theme = shinytheme("sandstone"),
             

             tabPanel("Introduction",
                      
                      br(),
                      
                      p("This application provides a summary of the result of merging 2 separate publicly available sources of information : ", a('CANJEM',href='https://www.canjem.ca',target="_blank"),", a general population job exposure matrix created from past Canadian case-control studies, and ",a('IPUMS international',href='https://international.ipums.org/international/about.shtml',target="_blank"), "a source of international census data provided by the University of Minnesota, National Statistical Offices, international data archives, and other international organizations"), 
                      
                      p("IPUMS provides census data with 3-digit codes from the", a("  International standard classification", href="https://www.ilo.org/public/english/bureau/stat/isco/isco88/index.htm",target="_blank"),"of occupations (ISCO) 1988 for about 50 countries covering 1991-2012"),
                      
                      p("On the other hand, CANJEM provides estimates of prevalence, intensity and frequency of exposure for over 250 risk factors over the period from 1930-2005 based on expert assessed exposure in a series of 4 epidemiological studies conducted in Montreal, Canada. CANJEM development is described in ",a('Sauvé et al.',href='https://pubmed.ncbi.nlm.nih.gov/29897403/',target="_blank"),"and",a('Siemiatycki and Lavoué',href='https://pubmed.ncbi.nlm.nih.gov/29642096/',target="_blank"),". CANJEM summaries are publicly accessible from the ",a('CANJEM web application',href='https://lavoue.shinyapps.io/Shiny_canjem_v3/',target="_blank"),"."),
                      
                      p("IPUMS and CANJEM were merged in order to estimate population of workers exposed to cobalt, antimony, and tungsten internationally."),
                      
                      p("The IPUMS tab provides an overview of the IPUMS data used, the CANJEM tab shows the information retrieved from the CANJEM application, the three other tabs provide exposure estimates for cobalt, antimony, and tungsten"),
                      
                      br()

                      ),
             
             tabPanel("Cobalt",
                      
                      br(),
                      
                      p("The OSHA substance code is 0730 : cobal metal, dust and fume as CO, but also tungsten carbide containing >2% CO, as CO"),
                      
                      br(),
                      
                      tabsetPanel(type = "tabs",
                                  
                                  tabPanel( "CANJEM information",
                                            
                                            br(),
                                            
                                            br(),
                                            
                                            fluidRow( 
                                              
                                              column( 2 ,
                                                      
                                                      br(),
                                                      
                                                      h5("Overview of selection")),
                                              
                                              column( 10 ,
                                                      
                                                      h5("Overview of selection")
                                              )
                                              )),
                                  
                                  
                                  tabPanel( "Analysis by occupation across countries",
                                            
                                            br(),
                                            
                                            br(),
                                            
                                            fluidRow( 
                                              
                                              column( 3 ,
                                                      
                                                      "test",
                                              
                                                      br(),
                                                      
                                                      sliderInput(
                                                        inputId = "co.which.year",
                                                        label = " select year range",
                                                        min = 2005,
                                                        max = 2020,
                                                        value = c(2005,2020),
                                                        sep=""),
                                                      
                                                      br(),
                                              
                                                      sliderInput(
                                                        inputId = "co.which.duration",
                                                        label = " select duration range (min.)",
                                                        min = 10,
                                                        max = 720,
                                                        value = c(10,720),
                                                        sep=""),
                                                      
                                                      br(),
                                                      
                                                      radioButtons(inputId = "co.industry.res.overall", 
                                                                   label = "Select NAICS 2017 resolution", 
                                                                   choiceNames = c("3 digits","4 digits","5 digits"), 
                                                                   choiceValues=c( "3d","4d","5d" ),
                                                                   selected = "5d", inline = FALSE,
                                                                   width = NULL ),
                                                      br(),
                                                      
                                                      h5("test")
                                                      
                                                      ),
                                              
                                              column( 8 , 
                                                      
                                                      br(),
                                                      
                                                      "test"
                                                      
                                                      ) )
                                  
 
                      ),
                      
                      tabPanel( "Analysis by country across occupations",
                                
                                br(),
                                
                                br(),
                                
                                fluidRow( 
                                  
                                  column( 3 ,
                                          
                                          "test",
                                          
                                          br(),
                                          
                                          sliderInput(
                                            inputId = "co.which.year",
                                            label = " select year range",
                                            min = 2005,
                                            max = 2020,
                                            value = c(2005,2020),
                                            sep=""),
                                          
                                          br(),
                                          
                                          sliderInput(
                                            inputId = "co.which.duration",
                                            label = " select duration range (min.)",
                                            min = 10,
                                            max = 720,
                                            value = c(10,720),
                                            sep=""),
                                          
                                          br(),
                                          
                                          radioButtons(inputId = "co.industry.res.overall", 
                                                       label = "Select NAICS 2017 resolution", 
                                                       choiceNames = c("3 digits","4 digits","5 digits"), 
                                                       choiceValues=c( "3d","4d","5d" ),
                                                       selected = "5d", inline = FALSE,
                                                       width = NULL ),
                                          br(),
                                          
                                          h5("test")
                                          
                                  ),
                                  
                                  column( 8 , 
                                          
                                          br(),
                                          
                                          "test"
                                          
                                  ) )
                                
                                
                      )
                      
                        
             
                      )
                      
            ),
             
          
            tabPanel("Antimony",
                     
                     br(),
                     
                     p("The OSHA substance code is 0230 : antimony and compounds as sb"),
                     
                     br(),
                     
                     tabsetPanel(type = "tabs",
                                 
                                 tabPanel( "CANJEM information",
                                           
                                           br(),
                                           
                                           br(),
                                           
                                           fluidRow( 
                                             
                                             column( 2 ,
                                                     
                                                     radioButtons(inputId= "sb.meas.type" , label = "Select measurements", 
                                                                  choiceNames=c( "All" , "Detected only" ),
                                                                  choiceValues=c( "all" , "det" )),
                                                     br(),
                                                     
                                                     h5("Overview of selection (",textOutput("size_year.sb",inline=TRUE)," records )")),
                                             
                                             column( 10 ,
                                                     
                                                     "test"
                                             )
                                           )),
                                 
                                 
                                 tabPanel( "Analysis by occupation across countries",
                                           
                                           br(),
                                           
                                           br(),
                                           
                                           fluidRow( 
                                             
                                             column( 3 ,
                                                     
                                                     "test",
                                                     
                                                     br(),
                                                     
                                                     sliderInput(
                                                       inputId = "co.which.year",
                                                       label = " select year range",
                                                       min = 2005,
                                                       max = 2020,
                                                       value = c(2005,2020),
                                                       sep=""),
                                                     
                                                     br(),
                                                     
                                                     sliderInput(
                                                       inputId = "co.which.duration",
                                                       label = " select duration range (min.)",
                                                       min = 10,
                                                       max = 720,
                                                       value = c(10,720),
                                                       sep=""),
                                                     
                                                     br(),
                                                     
                                                     radioButtons(inputId = "co.industry.res.overall", 
                                                                  label = "Select NAICS 2017 resolution", 
                                                                  choiceNames = c("3 digits","4 digits","5 digits"), 
                                                                  choiceValues=c( "3d","4d","5d" ),
                                                                  selected = "5d", inline = FALSE,
                                                                  width = NULL ),
                                                     br(),
                                                     
                                                     h5("test")
                                                     
                                             ),
                                             
                                             column( 8 , 
                                                     
                                                     br(),
                                                     
                                                     "test"
                                                     
                                             ) )
                                           
                                           
                                 ),
                                 
                                 
                                 tabPanel( "Analysis by occupation across countries",
                                           
                                           br(),
                                           
                                           br(),
                                           
                                           fluidRow( 
                                             
                                             column( 3 ,
                                                     
                                                     "test",
                                                     
                                                     br(),
                                                     
                                                     sliderInput(
                                                       inputId = "co.which.year",
                                                       label = " select year range",
                                                       min = 2005,
                                                       max = 2020,
                                                       value = c(2005,2020),
                                                       sep=""),
                                                     
                                                     br(),
                                                     
                                                     sliderInput(
                                                       inputId = "co.which.duration",
                                                       label = " select duration range (min.)",
                                                       min = 10,
                                                       max = 720,
                                                       value = c(10,720),
                                                       sep=""),
                                                     
                                                     br(),
                                                     
                                                     radioButtons(inputId = "co.industry.res.overall", 
                                                                  label = "Select NAICS 2017 resolution", 
                                                                  choiceNames = c("3 digits","4 digits","5 digits"), 
                                                                  choiceValues=c( "3d","4d","5d" ),
                                                                  selected = "5d", inline = FALSE,
                                                                  width = NULL ),
                                                     br(),
                                                     
                                                     h5("test")
                                                     
                                             ),
                                             
                                             column( 8 , 
                                                     
                                                     br(),
                                                     
                                                     "test"
                                                     
                                             ) )
                                           
                                           
                                 )               
                                 
                                 
                                 
                     )
                     
            ),
          
          tabPanel("Tungsten",
                   
                   br(),
                   
                   p("The OSHA substance code is 0230 : antimony and compounds as sb"),
                   
                   br(),
                   
                   tabsetPanel(type = "tabs",
                               
                               tabPanel( "CANJEM information",
                                         
                                         br(),
                                         
                                         br(),
                                         
                                         fluidRow( 
                                           
                                           column( 2 ,
                                                   
                                                   radioButtons(inputId= "sb.meas.type" , label = "Select measurements", 
                                                                choiceNames=c( "All" , "Detected only" ),
                                                                choiceValues=c( "all" , "det" )),
                                                   br(),
                                                   
                                                   h5("Overview of selection (",textOutput("size_year.sb",inline=TRUE)," records )")),
                                           
                                           column( 10 ,
                                                   
                                                   "test"
                                           )
                                         )),
                               
                               
                               tabPanel( "Analysis by occupation across countries",
                                         
                                         br(),
                                         
                                         br(),
                                         
                                         fluidRow( 
                                           
                                           column( 3 ,
                                                   
                                                   "test",
                                                   
                                                   br(),
                                                   
                                                   sliderInput(
                                                     inputId = "co.which.year",
                                                     label = " select year range",
                                                     min = 2005,
                                                     max = 2020,
                                                     value = c(2005,2020),
                                                     sep=""),
                                                   
                                                   br(),
                                                   
                                                   sliderInput(
                                                     inputId = "co.which.duration",
                                                     label = " select duration range (min.)",
                                                     min = 10,
                                                     max = 720,
                                                     value = c(10,720),
                                                     sep=""),
                                                   
                                                   br(),
                                                   
                                                   radioButtons(inputId = "co.industry.res.overall", 
                                                                label = "Select NAICS 2017 resolution", 
                                                                choiceNames = c("3 digits","4 digits","5 digits"), 
                                                                choiceValues=c( "3d","4d","5d" ),
                                                                selected = "5d", inline = FALSE,
                                                                width = NULL ),
                                                   br(),
                                                   
                                                   h5("test")
                                                   
                                           ),
                                           
                                           column( 8 , 
                                                   
                                                   br(),
                                                   
                                                   "test"
                                                   
                                           ) )
                                         
                                         
                               ),
                               
                               
                               tabPanel( "Analysis by occupation across countries",
                                         
                                         br(),
                                         
                                         br(),
                                         
                                         fluidRow( 
                                           
                                           column( 3 ,
                                                   
                                                   "test",
                                                   
                                                   br(),
                                                   
                                                   sliderInput(
                                                     inputId = "co.which.year",
                                                     label = " select year range",
                                                     min = 2005,
                                                     max = 2020,
                                                     value = c(2005,2020),
                                                     sep=""),
                                                   
                                                   br(),
                                                   
                                                   sliderInput(
                                                     inputId = "co.which.duration",
                                                     label = " select duration range (min.)",
                                                     min = 10,
                                                     max = 720,
                                                     value = c(10,720),
                                                     sep=""),
                                                   
                                                   br(),
                                                   
                                                   radioButtons(inputId = "co.industry.res.overall", 
                                                                label = "Select NAICS 2017 resolution", 
                                                                choiceNames = c("3 digits","4 digits","5 digits"), 
                                                                choiceValues=c( "3d","4d","5d" ),
                                                                selected = "5d", inline = FALSE,
                                                                width = NULL ),
                                                   br(),
                                                   
                                                   h5("test")
                                                   
                                           ),
                                           
                                           column( 8 , 
                                                   
                                                   br(),
                                                   
                                                   "test"
                                                   
                                           ) )
                                         
                                         
                               )               
                               
                               
                               
                   )
                   
          )          
          
          
            
             
             
             )
  
  
)
