#####################################################
#
#
#   CANJEM APP RESULTS FOR COBALT / ANTIMONY / TUNGSTEN
#
############################################################


#' source : [CANJEM public app](https://lavoue.shinyapps.io/Shiny_canjem_v3/)

#' scientific sources [Siemiatycki](https://pubmed.ncbi.nlm.nih.gov/29642096/), [Sauvé et al](https://pubmed.ncbi.nlm.nih.gov/29897403/)

setwd("C:/jerome/Dropbox/bureau/CIRC/Mono131/IPUMS ISCO88")

cobalt <- read.delim("CANJEMCobalt.txt")

tungstene <- read.delim("CANJEMtungsten.txt")

antimony <- read.delim("CANJEMantimony.txt")

saveRDS( cobalt , "CANJEMCobalt.RDS" )

saveRDS( tungstene , "CANJEMtungsten.RDS" )

saveRDS( antimony , "CANJEMantimony.RDS")
