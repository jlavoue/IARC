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
library(plyr)


# Define UI for application that draws a histogram
ui <- tagList(
  
    navbarPage(
    
    title = div("Monograph131_Exposed workers"),
    
    windowTitle = "Mono131 app II" ,
    
    theme = shinytheme("sandstone"),


    #####  INTRODUCTION  ###########################################################
    
    
    tabPanel("Introduction",
             
             selectInput("dataset", label = "Dataset", choices = ls("package:datasets")),
             verbatimTextOutput("summary"),
             tableOutput("table"),
             
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
             
             hr(),
             
             
             DT::dataTableOutput("ipums.countries")),
             
             column( 4 ,
             
             h4("IMPUMS Acknowledgment section"),
             
             br(),
             
             p("Publications and research reports based on the IPUMS-International database must cite it appropriately. The citation should include the following:"),
             
             br(),
             
             em("Minnesota Population Center. Integrated Public Use Microdata Series, International: Version 7.3 [dataset]. Minneapolis, MN: IPUMS, 2020.
https://doi.org/10.18128/D020.V7.2"),
             
             br(),
             
             p("The author wishes to acknowledge the statistical offices that provided the underlying data making this research possible: National Institute of Statistics, Chile; National Institute of Statistics and Censuses, Costa Rica; National Institute of Statistics and Censuses, Ecuador; National Statistical Office, Greece; Department of Statistics, Malaysia; Census and Statistics Directorate, Panama; National Institute of Statistics, Portugal; National Institute of Statistics, Rwanda; Bureau of Statistics, Uganda; Office of National Statistics, United Kingdom; National Institute of Statistics, Venezuela; General Statistics Office, Vietnam; National Institute of Statistics, Bolivia; National Institute of Statistics and Economic Studies, France; National Statistics Directorate, Guinea; Department of Statistics, Jordan; National Statistical Office, Mongolia; Statistics South Africa, South Africa; Federal Statistical Office, Switzerland; Office of National Statistics, Cuba; National Agency of Statistics and Demography, Senegal; National Statistical Office, Thailand; National Institute of Statistics, Cambodia; Central Agency for Public Mobilization and Statistics, Egypt; Statistical Centre, Iran; Department of Statistics and Censuses, El Salvador; National Institute of Information Development, Nicaragua; National Institute of Statistics, Uruguay; Central Statistics Office, Zambia; National Statistical Service, Armenia; Central Statistical Agency, Ethiopia; National Institute of Statistics, Mozambique; General Directorate of Statistics, Surveys, and Censuses, Paraguay; Ministry of Statistics and Analysis, Belarus; Central Statistics Office, Botswana; National Institute of Statistics, Romania; Central Statistical Office, Trinidad and Tobago; National Institute of Statistics, Honduras; National Statistics Office, Philippines; National Statistical Office, Papua New Guinea; National Statistics Agency, Zimbabwe; National Institute of Statistics, Guatemala; and Statistics Mauritius, Mauritius.")
             
             ))
             
    )    
    )
)
