#####################################################
#
#
#   CANJEM APP RESULTS FOR COBALT / ANTIMONY / TUNGSTEN
#
############################################################


#' source : [CANJEM public app](https://lavoue.shinyapps.io/Shiny_canjem_v3/)

#' scientific sources [Siemiatycki](https://pubmed.ncbi.nlm.nih.gov/29642096/), [Sauvé et al](https://pubmed.ncbi.nlm.nih.gov/29897403/)


cobalt <- read.delim("MONO131/CANJEM_IPUMS analysis/raw data/fromCanjemapp/CANJEMCobalt.txt")

tungstene <- read.delim("MONO131/CANJEM_IPUMS analysis/raw data/fromCanjemapp/CANJEMtungsten.txt")

antimony <- read.delim("MONO131/CANJEM_IPUMS analysis/raw data/fromCanjemapp/CANJEMantimony.txt")

saveRDS( cobalt , "MONO131/CANJEM_IPUMS analysis/intermediate data/CANJEMCobalt.RDS" )

saveRDS( tungstene , "MONO131/CANJEM_IPUMS analysis/intermediate data/CANJEMtungsten.RDS" )

saveRDS( antimony , "MONO131/CANJEM_IPUMS analysis/intermediate data/CANJEMantimony.RDS")
