##################################################
#
#  creation of the hierarchy for ISCO 88 3 digits
#
#
###################################################



###### libraries

library(readxl)


##### raw data


isco <- read_xlsx("MONO131/CANJEM_IPUMS analysis/intermediate data/ISCO88_RAMONEU_formatted.xlsx")      

      #naics2002 <-list()
      
      #naics2002$name <-"NAICS2002"
      
      #naics2002$n.levels <-3
      
      #naics2002$level.labels <-c("sector_2digit","subsector_3digit","industry_group_4digit")


#####deleting the 5/6 digit categories

isco <-isco[ isco$Level!=4  , ]


## separate treatment of armed forces

isco <- isco[ !is.element(isco$Code , c(0,1,11)) ,]

## adding "Managers"

isco <- rbind(  data.frame( Order = NA,
                          Level = 1,
                          Code = 1,
                          Parent = NA,
                          Description = "Managers",
                          include = NA,
                          exclude = NA), isco )


isco <- rbind( isco ,  data.frame( Order = NA,
                            Level = 1,
                            Code = 10,
                            Parent = NA,
                            Description = "Armed forces",
                            include = NA,
                            exclude = NA) )



### name to display

isco$label.show <-paste( isco$Code , isco$Description ,sep=" : ")


##TREE


isco.tree <-lapply(isco$label.show[isco$Level==1],function(x) {x})
names(isco.tree) <-isco$label.show[isco$Level==1]


####creation of level 2

list.1dig.show <-isco$label.show[isco$Level==1]

list.1dig <-isco$Code[isco$Level==1]

for (i in 1:9) {
  
  relevant.parent.code <- list.1dig[i] 
  
  list.2dig <- isco$Code[ is.element( substring( isco$Code , 1 , 1 ) , relevant.parent.code ) & isco$Level == 2   ]
  
  list.2dig.show <- isco$label.show[ is.element( substring( isco$Code , 1 , 1 ) , relevant.parent.code ) & isco$Level == 2   ]
  
  isco.tree[[i]] <-lapply(list.2dig.show,function(x) {x})
  
  names(isco.tree[[i]]) <-list.2dig.show 
  
  #isco.tree[[i]] <- structure( isco.tree[[i]] , stdisabled=TRUE)
  
  ####creation of level 3
  
  for (j in 1:length(list.2dig)) {
    
    relevant.parent.code <- list.2dig[j]     
    
    list.3dig <-isco$Code[ is.element( substring( isco$Code , 1 , 2 ) , relevant.parent.code ) & isco$Level == 3 ]
    
    list.3dig.show <- isco$label.show[ is.element( substring( isco$Code , 1 , 2 ) , relevant.parent.code ) & isco$Level == 3   ]
    
    isco.tree[[i]][[j]] <-lapply(list.3dig.show,function(x) {x})
    
    names(isco.tree[[i]][[j]]) <-list.3dig.show 
    

  }     
  
}

isco.tree[[10]] <- lapply("10 : Armed forces",function(x) {x})
names(isco.tree[[10]]) <- "10 : Armed forces"


saveRDS( isco.tree , "MONO131/CANJEM_IPUMS analysis/intermediate data/isco.tree.RDS")
saveRDS( isco.tree , "MONO131/CANJEM_IPUMS analysis/ShinyIPUMS/data/isco.tree.RDS")
