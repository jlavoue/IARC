##################################################
#
#  creation of the hierarchy for NAICS 2002
#
#
###################################################

naics <- read.csv("shinyapp/data/NAICS-SCIAN-2002-Structure-eng.csv", stringsAsFactors = FALSE)      

naics2002 <-list()

naics2002$name <-"NAICS2002"

naics2002$n.levels <-3

naics2002$level.labels <-c("sector_2digit","subsector_3digit","industry_group_4digit")


#####deleting the 5/6 digit categories

naics <-naics[ !is.element( naics$Hierarchical.structure , c("Canadian industry","Industry") )  , ]

### name to display

naics$label.show <-paste( naics$Code , naics$Class.title ,sep=" : ")

naics2002$description <-naics

##TREE


naics.tree <-lapply(naics$label.show[naics$Level==1],function(x) {x})
names(naics.tree) <-naics$label.show[naics$Level==1]


####creation of level 2

list.2dig.show <-naics$label.show[naics$Level==1]
list.2dig <-naics$Code[naics$Level==1]

for (i in 1:length(list.2dig)) {
  
  if ( regexpr( "-" , list.2dig[i] ) != -1 ) relevant.parent.code <- seq( from = substring( list.2dig[i] , 1 , regexpr( "-" , list.2dig[i]) -1 ) ,
                                                                          to = substring( list.2dig[i] , regexpr( "-" , list.2dig[i]) + 1 ),
                                                                          by=1)  
  else relevant.parent.code <- list.2dig[i] 
  
  list.3dig <- naics$Code[ is.element( substring( naics$Code , 1 , 2 ) , relevant.parent.code ) & naics$Level == 2   ]
  
  list.3dig.show <- naics$label.show[ is.element( substring( naics$Code , 1 , 2 ) , relevant.parent.code ) & naics$Level == 2   ]
  
  naics.tree[[i]] <-lapply(list.3dig.show,function(x) {x})
  
  names(naics.tree[[i]]) <-list.3dig.show 
  
  #naics.tree[[i]] <- structure( naics.tree[[i]] , stdisabled=TRUE)
  
  ####creation of level 3
  
  for (j in 1:length(list.3dig)) {
    
    relevant.parent.code <- list.3dig[j]     
    
    list.4dig <-naics$Code[ is.element( substring( naics$Code , 1 , 3 ) , relevant.parent.code ) & naics$Level == 3 ]
    
    list.4dig.show <- naics$label.show[ is.element( substring( naics$Code , 1 , 3 ) , relevant.parent.code ) & naics$Level == 3   ]
    
    naics.tree[[i]][[j]] <-lapply(list.4dig.show,function(x) {x})
    
    names(naics.tree[[i]][[j]]) <-list.4dig.show 
    
    
  }     
  
  
  
}


naics2002$tree <- naics.tree

saveRDS( naics2002 , "shinyapp/data/naics2002.RDS")
