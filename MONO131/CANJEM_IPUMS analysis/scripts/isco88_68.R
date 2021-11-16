################################################################
#
# Estimation of coverage of ISCO 68 to 88 vs ISCO 88 to 68
#
#
##################################################################

      library(data.table)
      
      library(readxl)

      library(writexl)

      library(haven)
      
######### creating the crosswalks

    ## 68 to 88
      
    isco68to88 <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/Isco8868conversion/CITP1968_CITP1988_transcodage.xlsx")
    
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
    
    isco88to68 <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/Isco8868conversion/CITP1988_CITP1968_transcodage.xlsx")
    
    isco88to68$isco883D <- substring( isco88to68$CODE_PONCTUE_DEST , 1 , 3)
    
    isco88to68$isco683D <- substring( isco88to68$CODE_PONCTUE_SOURCE , 1 , 4)
    
    mytab <- data.frame( isco88 = unique( isco68to88$isco883D) , stringsAsFactors = FALSE )
    
    mytab$n.i68 <- numeric( length(mytab[,1] ))
    
    for (i in 1:length(mytab[,1])) mytab$n.i68[i] <- length(unique( isco68to88$isco683D[ isco68to88$isco883D == mytab$isco88[i]] ))
    
    mytab <- mytab[ mytab$n.i68 == 1 , ]
    
    mytab$isco68 <- character( length(mytab[,1] ))
    
    for (i in 1:length(mytab[,1])) mytab$isco68[i] <- isco68to88$isco683D[ isco68to88$isco883D == mytab$isco88[i]][1]
    
    c88to68 <- mytab[ , c(1,3) ]

    
    
    
    #### only ISCO 68 to ISCO 88 works, and not superbly
    
    

saveRDS( c68to88 , "MONO131/CANJEM_IPUMS analysis/intermediate data/c68to88.RDS" )

    
    ### trying ISCO68 4D to ISCO883D

    isco684Dto88 <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/Isco8868conversion/CITP1968_CITP1988_transcodage.xlsx")
    
    isco684Dto88$isco883D <- substring( isco684Dto88$CODE_PONCTUE_DEST , 1 , 3)
    
    mytab <- data.frame( isco68 = unique( isco684Dto88$CODE_PONCTUE_SOURCE ) , stringsAsFactors = FALSE )
    
    mytab$n.i88 <- numeric( length(mytab[,1] ))
    
    for (i in 1:length(mytab[,1])) mytab$n.i88[i] <- length(unique( isco684Dto88$isco883D[ isco684Dto88$CODE_PONCTUE_SOURCE == mytab$isco68[i]] ))
    
    mytabl.miss <- mytab[ mytab$n.i88 != 1 , ]
    
    mytab <- mytab[ mytab$n.i88 == 1 , ]
    
    mytab$isco88 <- character( length(mytab[,1] ))
    
    for (i in 1:length(mytab[,1])) mytab$isco88[i] <- isco684Dto88$isco883D[ isco684Dto88$CODE_PONCTUE_SOURCE == mytab$isco68[i]][1]
    
    c684Dto88 <- mytab[ , c(1,3) ]
    
    

    ## Coverage of the CANJEM population
    
    canjem.wk <- read.csv('MONO131/CANJEM_IPUMS analysis/raw data/from CANJEM/canjem.workoccind.csv',stringsAsFactors=FALSE)
    
    100*length(canjem.wk[ is.element( canjem.wk$CITP1968 , c684Dto88$isco68 ), 1]) / length(canjem.wk[,1])
    
    
    ## http://www.harryganzeboom.nl/isco68/index.htm
    
    #citation
    #Ganzeboom, Harry B.G.;Treiman, Donald J., “International Stratification and Mobility File: Conversion Tools.” Amsterdam: Department of Social Research Methodology, http://home.fsw.vu.nl/hbg.ganzeboom/ismf. <Date of last revision>
    
    
    isco6888.g <- read.table( "MONO131/CANJEM_IPUMS analysis/raw data/fromGanzeboom/isco6888.txt" , 
                         header = FALSE, sep = "=", dec = ".")
    
    names( isco6888.g ) <- c("isco68","isco88")
    
    isco6888.g$isco68.f <- paste( substring( isco6888.g$isco68 , 5 , 5 ) , "-" , substring( isco6888.g$isco68 , 6 , 7 ) , "." , substring( isco6888.g$isco68 , 8 , 8 ) , "0" , sep="")
    
    isco6888.g$isco88.f <- substring( isco6888.g$isco88 , 1 , 4 )
    
    isco6888.g$isco88.3D <- substring( isco6888.g$isco88.f , 1 , 3)
    
    mytab <- data.frame( isco68 = unique( isco6888.g$isco68.f ) , stringsAsFactors = FALSE )
    
    mytab$n.i88 <- numeric( length(mytab[,1] ))
    
    for (i in 1:length(mytab[,1])) mytab$n.i88[i] <- length(unique( isco6888.g$isco88.3D[ isco6888.g$isco68.f == mytab$isco68[i]] ))
    
    mytabl.miss <- mytab[ mytab$n.i88 != 1 , ]
    
    mytab <- mytab[ mytab$n.i88 == 1 , ]
    
    isco6888.g.univocal <- isco6888.g[ is.element( isco6888.g$isco68.f , mytab$isco68) , ]
    
    isco6888.g.multivocal <- isco6888.g[ ! is.element( isco6888.g$isco68.f , mytab$isco68) , ]
    
    ## editorial decision
    
    #8-35.00 <- 821
    
    #6-29.00 <- 920
    
    #5-10.00 <- 131
    
    isco6888.g.multivocal <- isco6888.g.multivocal[ is.element( isco6888.g.multivocal$isco88.3D , c("821","920","131")),]
    
    isco6888.g.univocal <- rbind( isco6888.g.univocal,isco6888.g.multivocal)
 
            #creating a an ISCO68 3D version
    
            isco6888.g.3D <- isco6888.g.univocal[ substring( isco6888.g.univocal$isco68.f , 6 , 6) == 0 , ]
            
            isco6888.g.3D$isco88.3D <- substring( isco6888.g.3D$isco88.f , 1 , 3 )
            
            isco6888.g.3D$isco68.3D <- substring( isco6888.g.3D$isco68.f , 1 , 4)
    
    ### assigning ISCO88 3D to CANJEM, creating a crosswalk file
    
    mycrosswalk <- data.frame( table( canjem.wk$CITP1968 ) , stringsAsFactors = FALSE )
    
    names( mycrosswalk ) <- c( "isco68" , "n" )
    
    ####### assigning ISCO88 3D using the CAPS officical crosswalk
    
    mycrosswalk$isco88.caps <- c684Dto88$isco88[ match( mycrosswalk$isco68 , c684Dto88$isco68)]

    ####### assigning ISCO88 3D using the GANZEBOOM data
    
    #step1 using 5 digits
    
    mystatus <- rep( "unknown" , length( mycrosswalk[,1] ) )
    
    mycrosswalk$isco88.ganz <- substring( isco6888.g.univocal$isco88.f[ match( mycrosswalk$isco68 , isco6888.g.univocal$isco68.f)] , 1 , 3)
    
    mystatus[ !is.na(mycrosswalk$isco88.ganz) ] <- "Ganz.5D"
    
    #step2 using 3 digits
    
    mycrosswalk$isco88.ganz[ mystatus == "unknown" ] <- isco6888.g.3D$isco88.3D[ match( substring( mycrosswalk$isco68[ mystatus == "unknown" ] , 1 , 4) ,  isco6888.g.3D$isco68.3D)]

    mystatus[ !is.na(mycrosswalk$isco88.ganz) & mystatus == "unknown" ] <- "Ganz.3D"
    
    mycrosswalk$ganz.status <- mystatus
    
    ### comparability of 2 codes
    
    mycrosswalk$diff.status <- "XXX"
    
    mycrosswalk$diff.status[ is.na( mycrosswalk$isco88.caps) & is.na( mycrosswalk$isco88.ganz)] <- "Both missing"
    mycrosswalk$diff.status[ !is.na( mycrosswalk$isco88.caps) & is.na( mycrosswalk$isco88.ganz)] <- "Ganz missing"
    mycrosswalk$diff.status[ is.na( mycrosswalk$isco88.caps) & !is.na( mycrosswalk$isco88.ganz)] <- "CAPS missing"
    
    mycrosswalk$diff.status[ !is.na( mycrosswalk$isco88.caps) & !is.na( mycrosswalk$isco88.ganz) & mycrosswalk$isco88.caps == mycrosswalk$isco88.ganz] <- "EQUAL"
    mycrosswalk$diff.status[ !is.na( mycrosswalk$isco88.caps) & !is.na( mycrosswalk$isco88.ganz) & mycrosswalk$isco88.caps != mycrosswalk$isco88.ganz] <- "UNEQUAL"
    

    
    
    ### exploring the results
    
    table(mycrosswalk$diff.status)
    
    sum( mycrosswalk$n[ mycrosswalk$diff.status=="UNEQUAL" ])
    
    length(unique( mycrosswalk$isco68[ mycrosswalk$diff.status=="UNEQUAL" ]))
    
    problem.isco <- mycrosswalk[ mycrosswalk$diff.status=="Both missing"  | 
                                   mycrosswalk$diff.status=="UNEQUAL"   , ]
    canjem.status <- mycrosswalk$diff.status[ match( canjem.wk$CITP1968 , mycrosswalk$isco68 )]
    
    data.frame( table( canjem.status ) )
    
    sum( table( canjem.status ) )
    
    #### saving the final crosswalk
    
    mycrosswalk$isco883d <- mycrosswalk$isco88.ganz
    
    mycrosswalk$isco883d[ is.na(mycrosswalk$isco883d) ] <- mycrosswalk$isco88.caps[ is.na(mycrosswalk$isco883d) ]
    
    ##priority for caps
    
    mycrosswalk$isco883d[ mycrosswalk$diff.status == "UNEQUAL" ] <-  mycrosswalk$isco88.caps[  mycrosswalk$diff.status == "UNEQUAL"  ]
    
    ##### looking at the names in IPUMS
    
    isco <- read_xlsx("MONO131/CANJEM_IPUMS analysis/raw data/fromIPUMS/isco883D.xlsx")
    
    # no code containing a zero at the end, except military
    
    # in the crosswalk : codes 410 (office employee), 310, 840 : exclusion
    
    mycrosswalk$diff.status [ is.element( mycrosswalk$isco883d, c("410","310","840")) ] <- "Low resolution"
    
    mycrosswalk$isco883d[ is.element( mycrosswalk$isco883d, c("410","310","840")) ] <- NA
    

    ### the military
    
    mycrosswalk$isco883d[mycrosswalk$isco68=="0-00.00"] <- "10"
    
    mycrosswalk$diff.status[mycrosswalk$isco68=="0-00.00"] <- "IPUMS Military"
    
    
    ### ISCO88 751 (foremen) does not exist : exclusion
    

    mycrosswalk$diff.status[mycrosswalk$isco883d=="751"] <- "supervisors"
    
    mycrosswalk$isco883d[mycrosswalk$isco883d=="751"] <- NA
    
    ###### saving files
    
    saveRDS( mycrosswalk , "MONO131/CANJEM_IPUMS analysis/intermediate data/isco68to88V1.RDS")
    
    write_xlsx( mycrosswalk , "MONO131/CANJEM_IPUMS analysis/intermediate data/isco68to88V1.xlsx")
    