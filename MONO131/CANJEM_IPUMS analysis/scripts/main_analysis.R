################################
#
#   Vol 131 :  Mixing IPUMS / CANJEM / ISCO
#  
#
###########################################


############# reading relevant datasets


## CANJEM
setwd("C:/jerome/Dropbox/bureau/CIRC/Mono131/IPUMS ISCO88")

cobalt <- readRDS("CANJEMCobalt.RDS" )

tungstene <- readRDS( "CANJEMtungsten.RDS" )

antimony <- readRDS( "CANJEMantimony.RDS")


## CONVERSION
setwd("C:/jerome/Dropbox/bureau/CIRC/Mono131/IPUMS ISCO88")

c68to88 <- readRDS( "c68to88.RDS" )


## IPUMS