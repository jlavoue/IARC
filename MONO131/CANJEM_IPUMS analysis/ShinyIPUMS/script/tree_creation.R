##################################################
#
#  creation of the hierarchy for agents for shinty tree
#
#
###################################################

library(devtools)
install_github("shinyTree/shinyTree")
        
        setwd( "C:/jerome/Dropbox/bureau/RStudio/CWED/CWED mockup")
        setwd( "D:/Dropbox/bureau/RStudio/CWED/CWED mockup")
        
        
        ref.table <- readRDS(  "shinyapp/data/agent_ref_table.RDS")
        
        
        ref.table <-ref.table[ ref.table$Exclude!=1 ,]
        
        ## standard names for later
        
        ref.table$agent.id <- ref.table$agent
        
        ref.table$agent.labelEn <- ref.table$agent
        
        ref.table$family.label <- ref.table$ChemicalFamily
        
        ref.table$family.id <- ref.table$ChemicalFamily
        
        ## only ine level of hierarchy : families
        
        agents.family <-data.frame(id=unique(ref.table$family.id ),
                                     stringsAsFactors = FALSE)
        
        agents.family$labelEn <- agents.family$id
        
        ## initialisation of agent tree
        
        agent.tree  <- lapply( agents.family$labelEn, function(x) {x} )
        
        names(agent.tree) <- agents.family$labelEn
        
        ## going across each family
        
        for (i in 1:length(agents.family$id)) {
          
          
          restrict.family <- is.element( ref.table$agent.id , ref.table$agent.id[ ref.table$family.id == agents.family$id[i]])
          
          agent.tree[[i]] <-lapply( ref.table$agent.labelEn[ restrict.family ], function(x) {x})
          
          names(agent.tree[[i]]) <- ref.table$agent.labelEn[ restrict.family ]
          
          #attr(agent.tree[[i]],"stdisabled=TRUE") <- TRUE
          
          agent.tree[[i]] <- structure( agent.tree[[i]] , stdisabled=TRUE)
          
          for ( j in 1:length(names(agent.tree[[i]]))) agent.tree[[i]][[j]] <- structure(names(agent.tree[[i]])[j],sttype="default",sticon="glyphicon glyphicon-leaf")
        }
        
        
        saveRDS( agent.tree , "shinyapp/data/agent_tree.RDS")

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
        
        
##################################################
#
#  creation of the hierarchy for NOCS 2006
#
#
###################################################
        
        nocs <- read.csv("shinyapp/data/noc-s-cnp-s-2006-structure-eng.csv", stringsAsFactors = FALSE)
        
        
        nocs2006 <-list()
        
        nocs2006$name <-"NOCS2006"
        
        nocs2006$n.levels <-4
        
        nocs2006$level.labels <-c("Broad occupational category_1digit" , "Major group_2digit","Minor group_3digit","Unit group_4digit")
        
        
       ### name to display
        
        nocs$label.show <-paste( nocs$Code , nocs$Class.title ,sep=" : ")
        
        nocs2006$description <-nocs
        
        ##TREE
        
        
        nocs.tree <-lapply(nocs$label.show[nocs$Level==1],function(x) {x})
        names(nocs.tree) <-nocs$label.show[nocs$Level==1]
        
        
        ####creation of level 2
        
        list.1dig.show <-nocs$label.show[nocs$Level==1]
        
        list.1dig <-nocs$Code[nocs$Level==1]
        
        for (i in 1:length(list.1dig)) {
          
          relevant.parent.code <- list.1dig[i] 
          
          list.2dig <- nocs$Code[ is.element( substring( nocs$Code , 1 , 1 ) , relevant.parent.code ) & nocs$Level == 2   ]
          
          list.2dig.show <- nocs$label.show[ is.element( substring( nocs$Code , 1 , 1 ) , relevant.parent.code ) & nocs$Level == 2   ]
          
          nocs.tree[[i]] <-lapply(list.2dig.show,function(x) {x})
          
          names(nocs.tree[[i]]) <-list.2dig.show 
          
          #nocs.tree[[i]] <- structure( nocs.tree[[i]] , stdisabled=TRUE)
          
          ####creation of level 3
          
          for (j in 1:length(list.2dig)) {
            
            relevant.parent.code <- list.2dig[j]     
            
            list.3dig <-nocs$Code[ is.element( substring( nocs$Code , 1 , 2 ) , relevant.parent.code ) & nocs$Level == 3 ]
            
            list.3dig.show <- nocs$label.show[ is.element( substring( nocs$Code , 1 , 2 ) , relevant.parent.code ) & nocs$Level == 3   ]
            
            nocs.tree[[i]][[j]] <-lapply(list.3dig.show,function(x) {x})
            
            names(nocs.tree[[i]][[j]]) <-list.3dig.show 
           
            ####creation of level 4
            
            for (k in 1:length(list.3dig)) {
              
              relevant.parent.code <- list.3dig[k]     
              
              list.4dig <-nocs$Code[ is.element( substring( nocs$Code , 1 , 3 ) , relevant.parent.code ) & nocs$Level == 4 ]
              
              list.4dig.show <- nocs$label.show[ is.element( substring( nocs$Code , 1 , 3 ) , relevant.parent.code ) & nocs$Level == 4   ]
              
              nocs.tree[[i]][[j]][[k]] <-lapply(list.4dig.show,function(x) {x})
              
              names(nocs.tree[[i]][[j]][[k]]) <-list.4dig.show             
             
            }
            
          }     
          
          
          
        }
        
        
        nocs2006$tree <- nocs.tree
        
        saveRDS( nocs2006 , "shinyapp/data/nocs2006.RDS")
        
        