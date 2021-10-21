################################################################
#
# Estimation of coverage of ISCO 68 to 88 vs ISCO 88 to 68
#
#
##################################################################

      library(data.table)
      
      library(readxl)
      
      setwd( "C:/jerome/Dropbox/bureau")
      

######### creating the crosswalks

    ## 68 to 88
      
    isco68to88 <- read_xlsx("Backup Dossiers CRCHUM reseau/CAPS/CORRESPONDANCES/EMPLOIS/CITP-CITP/CITP1968_CITP1988_transcodage.xlsx")
    
    isco68to88$isco883D <- substring( isco68to88$CODE_PONCTUE_DEST , 1 , 3)
    
    isco68to88$isco683D <- substring( isco68to88$CODE_PONCTUE_SOURCE , 1 , 4)
    
    mytab <- data.frame( isco68 = unique( isco68to88$isco683D) , stringsAsFactors = FALSE )
    
    mytab$n.i88 <- numeric( length(mytab[,1] ))
    
    for (i in 1:length(mytab[,1])) mytab$n.i88[i] <- length(unique( isco68to88$isco883D[ isco68to88$isco683D == mytab$isco68[i]] ))
    
    mytab <- mytab[ mytab$n.i88 == 1 , ]
    
    mytab$isco88 <- character( length(mytab[,1] ))
    
    for (i in 1:length(mytab[,1])) mytab$isco88[i] <- isco68to88$isco883D[ isco68to88$isco683D == mytab$isco68[i]][1]
    
    c68to88 <- mytab[ , c(1,3) ]
    
    
    ## 88 to 68
    
    isco88to68 <- read_xlsx("Backup Dossiers CRCHUM reseau/CAPS/CORRESPONDANCES/EMPLOIS/CITP-CITP/CITP1988_CITP1968_transcodage.xlsx")
    
    isco88to68$isco883D <- substring( isco88to68$CODE_PONCTUE_DEST , 1 , 3)
    
    isco88to68$isco683D <- substring( isco88to68$CODE_PONCTUE_SOURCE , 1 , 4)
    
    mytab <- data.frame( isco88 = unique( isco68to88$isco883D) , stringsAsFactors = FALSE )
    
    mytab$n.i68 <- numeric( length(mytab[,1] ))
    
    for (i in 1:length(mytab[,1])) mytab$n.i68[i] <- length(unique( isco68to88$isco683D[ isco68to88$isco883D == mytab$isco88[i]] ))
    
    mytab <- mytab[ mytab$n.i68 == 1 , ]
    
    mytab$isco68 <- character( length(mytab[,1] ))
    
    for (i in 1:length(mytab[,1])) mytab$isco68[i] <- isco68to88$isco683D[ isco68to88$isco883D == mytab$isco88[i]][1]
    
    c88to68 <- mytab[ , c(1,3) ]

    
    
    
    #### only ISCO 68 to ISCO 88 works
    
    
setwd("C:/jerome/Dropbox/bureau/CIRC/Mono131/IPUMS ISCO88")
    
saveRDS( c68to88 , "c68to88.RDS" )

    
    