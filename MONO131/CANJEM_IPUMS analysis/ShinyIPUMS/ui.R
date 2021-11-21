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
library(readxl)
library(DT)
#library(plyr)

isco <- read_xlsx("./data/isco883D.xlsx")

country <- read_xlsx("./data/countries.xlsx")



# Define UI for application that draws a histogram
ui <- tagList(
  
    navbarPage(
    
    title = div("Monograph131_Exposed workers"),
    
    windowTitle = "Mono131 app II" ,
    
    theme = shinytheme("sandstone"),


    #####  INTRODUCTION  ###########################################################
    
    
    tabPanel("Introduction",
             
             br(),
             
             p("This application provides a summary of the result of merging 2 separate publicly available sources of information : ", a('CANJEM',href='https://www.canjem.ca',target="_blank"),", a general population job exposure matrix created from past Canadian case-control studies, and ",a('IPUMS international',href='https://international.ipums.org/international/about.shtml',target="_blank"), "a source of international census data provided by the University of Minnesota, National Statistical Offices, international data archives, and other international organizations"), 
             
             p("IPUMS provides census data with 3-digit codes from the", a("  International standard classification", href="https://www.ilo.org/public/english/bureau/stat/isco/isco88/index.htm",target="_blank"),"of occupations (ISCO) 1988 for about 50 countries covering 1991-2012"),
             
             p("On the other hand, CANJEM provides estimates of prevalence, intensity and frequency of exposure for over 250 risk factors over the period from 1930-2005 based on expert assessed exposure in a series of 4 epidemiological studies conducted in Montreal, Canada. CANJEM development is described in ",a('Sauvé et al.',href='https://pubmed.ncbi.nlm.nih.gov/29897403/',target="_blank"),"and",a('Siemiatycki and Lavoué',href='https://pubmed.ncbi.nlm.nih.gov/29642096/',target="_blank"),". CANJEM summaries are publicly accessible from the ",a('CANJEM web application',href='https://lavoue.shinyapps.io/Shiny_canjem_v3/',target="_blank"),"."),
             
             p("IPUMS and CANJEM were merged in order to estimate population of workers exposed to cobalt, antimony, and tungsten internationally."),
             
             p("The IPUMS tab provides an overview of the IPUMS data used, the CANJEM tab shows the information retrieved from the CANJEM application, the three other tabs provide exposure estimates for cobalt, antimony, and tungsten"),
             
             br()
             
    ),
    
    ########    IPUMS ####################################################
    
    tabPanel("IPUMS",
             
             fluidRow( 
               
               column( 8 ,
             
             br(),
             
             p(a('IPUMS international',href='https://international.ipums.org/international/about.shtml',target="_blank"), " provides access to census data for hundreds of countries over a large period of time. For some eras/countries, occupation from the original dataset has been standardized into 3-digit ISCO 1988. For each country with ISCO 1988 informatioon, the most recent census was extracted (extraction date Nov 2021). The table below shows the countries included, the year of census, and the size of the working population"),
             br(),
             
             p("Overall, ",textOutput("ncountries",inline=TRUE)," countries were included, covering a total population of ",textOutput("totalpop",inline=TRUE)," millions and a working population of ",textOutput("workingpop",inline=TRUE)," millions."),
             
             hr(),
             
             
             DT::dataTableOutput("ipums.countries")),
             
             column( 4 ,
             
             h4("IPUMS International Acknowledgment section"),
             
             br(),
             
             p("Publications and research reports based on the IPUMS-International database must cite it appropriately. The citation should include the following:"),
             
             br(),
             
             em("Minnesota Population Center. Integrated Public Use Microdata Series, International: Version 7.3 [dataset]. Minneapolis, MN: IPUMS, 2020.
https://doi.org/10.18128/D020.V7.2"),
             
             br(),
             
             br(),
             
             p("The author wishes to acknowledge the statistical offices that provided the underlying data making this research possible: National Institute of Statistics, Chile; National Institute of Statistics and Censuses, Costa Rica; National Institute of Statistics and Censuses, Ecuador; National Statistical Office, Greece; Department of Statistics, Malaysia; Census and Statistics Directorate, Panama; National Institute of Statistics, Portugal; National Institute of Statistics, Rwanda; Bureau of Statistics, Uganda; Office of National Statistics, United Kingdom; National Institute of Statistics, Venezuela; General Statistics Office, Vietnam; National Institute of Statistics, Bolivia; National Institute of Statistics and Economic Studies, France; National Statistics Directorate, Guinea; Department of Statistics, Jordan; National Statistical Office, Mongolia; Statistics South Africa, South Africa; Federal Statistical Office, Switzerland; Office of National Statistics, Cuba; National Agency of Statistics and Demography, Senegal; National Statistical Office, Thailand; National Institute of Statistics, Cambodia; Central Agency for Public Mobilization and Statistics, Egypt; Statistical Centre, Iran; Department of Statistics and Censuses, El Salvador; National Institute of Information Development, Nicaragua; National Institute of Statistics, Uruguay; Central Statistics Office, Zambia; National Statistical Service, Armenia; Central Statistical Agency, Ethiopia; National Institute of Statistics, Mozambique; General Directorate of Statistics, Surveys, and Censuses, Paraguay; Ministry of Statistics and Analysis, Belarus; Central Statistics Office, Botswana; National Institute of Statistics, Romania; Central Statistical Office, Trinidad and Tobago; National Institute of Statistics, Honduras; National Statistics Office, Philippines; National Statistical Office, Papua New Guinea; National Statistics Agency, Zimbabwe; National Institute of Statistics, Guatemala; and Statistics Mauritius, Mauritius.")
             
             ))
             
    ),
    
    
    
################################     CANJEM DESCRIPTION


tabPanel("CANJEM",
         
         p("CANJEM is a job exposure matrix, i.e. for a given occupation and time period, it provides information on the probability, frequency and intensity of exposure from a list of 258 occupational risk factors."),
         
         br(),
         
         p("CANJEM was built from past individual expert evaluations of occupational exposures in a series of four case control studies of various cancers conducted since the mid-1980s up to 2010 in the greater Montreal area. During these studies over 30 000 jobs from 1930 to 2005 held by close to 10 000 subjects were evaluated by experts who assigned exposures based on descriptions of tasks, processes, work environment, and exposure control measures."),
         
         br(),
         
         p("CANJEM provides information on work activities using standard classifications of occupation and industry. Versions of CANJEM based on occupation include the following systems: Canadian Classification and Dictionary of Occupations (CCDO 1971), National Occupational Classification (Canada, 2011), International Standard Classification of Occupations (ISCO 1968), and Standard Occupational Classification (USA, 2010). Versions of CANJEM based on industry include the following systems: Standard Industrial Classification (Canada, 1980), North American Industry Classification System (2012), and International Standard Industrial Classification of all Economic Activities (UN, 1968). Searching for specific codes from these classifications can be done on a sister website: www.caps-canada.ca."),
         
         br(),
         
         h4("Use of CANJEM for the current application"),
         
         br(),
         
         p("For the current app, we used CANJEM outputs similar to those found on the ",a('CANJEM web application',href='https://lavoue.shinyapps.io/Shiny_canjem_v3/',target="_blank"),". However, ISCO88 is not native to CANJEM, and a crosswalk was build to enable the creation of a CANJEM version for the 3-digit ISCO 88 codes available in the IPUMS data. The crosswalk from ISCO 1968 (native in CANJEM) to 3-digit ISCO 1988 was created through the aggregation of an official conversion from the ",a("ILO website", href="https://www.ilo.org/public/english/bureau/stat/isco/isco88/index.htm",target="_blank"), " and a conversion proposed by ", a("Ganzeboom et al.", href="http://www.harryganzeboom.nl/isco68/index.htm",target="_blank"),"."),
         
         br(),
         
         p("The tables below present all 3-digit ISCO 88 occupations in CANJEM with at least 1% probability of exposure, respectively for cobalt, antimony and tungsten, along with the most frequent confidence, intensity, and frequency of exposure categories across exposed jobs held by CANJEM subjects within each occupation."),
         
         hr(),
         
         
        tabsetPanel( 
         
        ############# COBALT   
             
           tabPanel( strong("COBALT") , 
                          
                     fluidRow( 
                       
                      column( 8 , 
                     
                     h4("agent definition"),
                             
                          br(),
                             
                          p("Comprises cobalt (Co) fumes, dust from cobalt-containing alloys and ores and all other cobalt-containing substances (e.g.,  acetate, oleate, resinate).  Most cobalt has been used for high temperature alloys.  Cobalt is added to tool steels to increase the strength and hardness of those required to operate at high speed and high temperature.  A variety of organic salts of cobalt, such as resinate, oleate and acetate etc. have been used extensively as drying agents for paints, inks and varnishes.  Other cobalt compounds have been used in pottery to improve color.  
"),
                          hr(),
                          
                          DT::dataTableOutput("canjem.cobalt")
                          
                          ))),
############# ANTIMONY             
           tabPanel( strong("ANTIMONY") , 
                     
                     fluidRow( 
                       
                       column( 8 , 
                               
                               h4("agent definition"),
                               
                               br(),
                               
                               p("Comprises antimony (Sb) dust, antimony fumes, dust from antimony-containing alloys and ores and all other antimony-containing substances.  Antimony itself is a lustrous, silvery blue?white, extremely brittle metal.  When alloyed with other metals, it increases hardness, lowers melting points and reduces shrinkage upon freezing.  Most occupational exposures were due to antimony-lead alloys used as type metal, storage battery plates, bullets, tank linings, bearing metals, etc.  Residual soot or ashes may also contain antimony compounds.  
"),
                               hr(),
                               
                               DT::dataTableOutput("canjem.antimony")
                               
                       ))),
############# TUNGSTEN           
           tabPanel( strong("TUNGSTEN") , 
                     
                     fluidRow( 
                       
                       column( 8 , 
                               
                               h4("agent definition"),
                               
                               br(),
                               
                               p("Comprises tungsten (W) dust, tungsten fumes, and dust form tungsten-containing alloys and ores, and all other tungsten-containing substances. Tungsten, a white, heavy metal, is widely distributed in small quantities in nature, but is mostly obtained from scheelite, wolframite and a few other ores.  It has one of the most highest melting point (3400 °C) of all of metals, a property that renders it very useful for lamp filaments, electric contacts, rocket nozzles, and in electronic applications.  The most widely used tungsten compound is the carbide (WC), which contains  equal parts of Tungsten (W) and Carbon (C) atoms, is an extremely fine gray powder that can be pressed into shapes for use in cutting tools (tool bits), abrasives, and wear-resistant machine parts. Tools steels containing up to 18% of Tungsten are generally used in machining steels.
"),
                               hr(),
                               
                               DT::dataTableOutput("canjem.tungsten")
                               
                       )) ))
    
          ),


########################### CANJEM INFORMATIONM BY COUNTRY

          tabPanel("Exposure estimates by COUNTRY",

                  br(),
                  
                  p("This tab provides the result of merging CANJEM with the IPUMS census data for a selected country."),
                  
                  selectInput("country","Select country", choices = country$Label ,
                              selected = "France"),
                  
                  
                  tabsetPanel(
                    

                      tabPanel( "COBALT" , 
                                
                                br(),
                                
                                p( "The first table below provides an overall portrait for the selected country." ),
                                
                                tableOutput("estbycountry.cobalt.overall"),
                                
                                br(),
                                
                                hr(),
                                
                                p("The table below provides details of workers exposed by ISCO 88 3-digit category"),
                                
                                br(),
                                
                                DT::dataTableOutput("estbycountry.cobalt"),
                                
                                hr()
                                

                                
                                ),
                    
                      tabPanel( "ANTIMONY" ),
                    
                      tabPanel( "TUNGSTEN" )
                    
                  )

          ),

########################### CANJEM INFORMATION BY OCCPATION
    
          tabPanel("Exposure estimates by OCCUPATION",
                   
                   
                   tabsetPanel(
                     
                     tabPanel( "COBALT" ),
                     
                     tabPanel( "ANTIMONY" ),
                     
                     tabPanel( "TUNGSTEN" )
                   )
    
    )
))
