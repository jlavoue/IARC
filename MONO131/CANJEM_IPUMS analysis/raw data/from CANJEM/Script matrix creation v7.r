
######################################################################################################################################
#Fonction de cr?ation des matrice de pr?valence : Version Juillet 2014
## --- MODIFI?E PAR JF JUL03 2015 pour corriger restriction sur Nmin/Nmin.s (~ligne 244)
##	-- + Modification DEC04 2015 pour attribution des p?riodes aux jobs
## MODIFIED JAN25 2016 to add categorical frequency
## MODIFIED MAY10 2016 to add "R12Nexpo" and "R12nouse"
# MODIFIED FEB07 2017 replacing FIRST YEAR JOB and LAST YEAR JOB by YEARIN and YEAROUT
# MODIFILED SEPT 2018 by JL : adding proportion of jobs with FWI>FWI.threshold
#######################################
#entr?e : Une BD de type JDB, une BD de type OccInd, les param?tres suivants
#
# 
# typeR : type de matrice : 'R1expo' R1=expos?, 'R1Nexpo' R1=non expos?, 'R1nouse' R1 non consid?r?, retir? des donn?es incluant workoccind
#           'R12Nexpo' R1+R2=non expos?, 'R12nouse' R1+R2 non consid?r?, retir? des donn?es incluant workoccind
# Nmin : nombre Jobs minimal pour une estimation
# Nmin.s : nombre de sujet minmal pour une estimation
# Dmin : Dose minimale pour inclure un job dans le calcul
# Cmin : Concentration minimale pour inclure un job dans le calcul
# Fmin : Fr?quence minimale pour inclure un job dans le calcul
#
# dimension : vector of variables in the OccInd data.frame to act as stratification variables
#
# agents : list of agents (idchem) of interest
#
# time breaks : vector of year points for making time periods
#
# FWI threshold : used for the calculation of proportion of jobs with FWI >= FWI threshold
#
#############################################################################################
#sortie : 1 matrice de pr?valence avce les cellules comme combinaison des variables s?lectionn?es
#
# 
#
# quantit?es estim?es
# p : pr?valence
# ntot : total de jobs
# nsub : total de sujets
# nexp : jobs exposed
# nexps : sujets expos?s
# n.Ri : nombre de jobs avec fiabilit? i (0 ? 3)
# n.Ci : nombre de jobs avec concentration i (0 ? 3)
# n.Fi : nombre de jobs avec fr?quence i (0 ? i)  # Default = 4
# p.Ri : proportion de jobs avec fiabilit? i (0 ? 3)
# p.Ci : proportion de jobs avec concentration i (0 ? 3)
# p.Fi : proportion de jobs avec fr?quence i (0 ? i) # Default = 4
#
#exposition metrics
#
# Cmoyi  : concentration moyenne pour les ?chelles 123,139,1525,110100
# Dmoyi  : : concentration moyenne pour les ?chelles 123,139,1525,110100
# Cmed    concentration mediane (1525)
# Dmed   dose m?diane
# Fmoy    Fr?quence moyenne
# Fmed    Fr?quenc m?diane
#
#
#
#
#Variables obligatoires dans JDB : ID, JOB, IDCHEM, YEARIN, YEAROUT, R_FINAL, F_FINAL, C_FINAL, C_FINAL_CAT
#
#Variables obligatoires dans workoccind : ID, JOB, YEARIN, YEAROUT
##
############################################################################################################

# 
# ### Add-on JF - AUG14 2014 - Debugging information to go inside function
# 
# ## Load data files
# setwd("C:\\CRCHUM\\CANJEM\\Data files")
# ## Chemical coding
# canjem.jdb <-read.csv('C:\\CRCHUM\\CANJEM\\Data files\\canjem.jdb.123.D.csv',stringsAsFactors=F)
# ## Job information
# canjem.wk <-read.csv('C:\\CRCHUM\\CANJEM\\Data files\\canjem.workoccind.csv',stringsAsFactors=F)
# # Change names of Year in/out variables
# names(canjem.wk) <- gsub("YEARIN",'YEARIN', names(canjem.wk))
# names(canjem.wk) <- gsub("YEAROUT",'YEAROUT', names(canjem.wk))
# names(canjem.jdb) <- gsub("YEARIN",'YEARIN', names(canjem.jdb))
# names(canjem.jdb) <- gsub("YEAROUT",'YEAROUT', names(canjem.jdb))
# # Extract 4-digit CCDO code from 7-digit variable
# canjem.wk$ccdo4d <- substr(gsub("-", "", canjem.wk$CCDP1971), 1, 4)
# canjem.wk$ccdo3d <- substr(gsub("-", "", canjem.wk$CCDP1971), 1, 3)
# ## Agent codes/names
# agents <-read.csv('AGENTS CODES.csv',sep=';',stringsAsFactors=F)
# agents.label <-read.csv('AGENTS LABELS.csv',sep=';',stringsAsFactors=F)
# agents$label<-agents.label$LblEn[match(agents$idchem,agents.label$Code)]
# agent <-c('110016', '460003')
# 
# #### Input for the function itself
# jdb=canjem.jdb
# workoccind=canjem.wk
# vec.dim=c('ccdo4d', 'ccdo3d')
# agents=agent
# Nmin=5
# Nmin.s=5
# Dmin=0.05
# Fmin=0.5
# Cmin=1
# Rmin=1
# time.breaks=c(min(canjem.wk$YEARIN),1950, 1970, 1985, max(canjem.wk$YEAROUT))
# type='R12nouse'
# Fcut = c(0, 2, 12, 40, max(canjem.jdb$F_FINAL)) # As  [0,2)   [2,12)  [12,40) [40,MAX]
# 
# 
# # RUN IT
# mat.samp <- matrix.fun(jdb=canjem.jdb,workoccind=canjem.wk,
# vec.dim=c('ccdo4d'),
# agents=agent
# ,Nmin=1, Nmin.s=1, Dmin=0.05,Fmin=0.5,Cmin=1,type='R1expo',
# time.breaks=c(min(canjem.wk$YEARIN),max(canjem.wk$YEAROUT)))


matrix.fun <- function(jdb,workoccind,vec.dim,agents,type='R1expo',Dmin,Fmin,Cmin,Nmin,Nmin.s,time.breaks,
							Fcut= c(0, 2, 12, 40, max(canjem.jdb$F_FINAL)),
							FWI.threshold = 1)		{


###creating the Y axis : combinations of values of variables of vec.dim

n.dim <-length(vec.dim)

##creating the time periods

period.vec <-character(length(time.breaks)-1)
for (i in 1:(length(time.breaks)-1)) period.vec[i] <-paste(time.breaks[i],time.breaks[i+1]-1*ifelse(i==(length(time.breaks)-1),0,1),sep='-')


######################################################
###creating a base exposure database
########################################################

jdb <-jdb[is.element(jdb$IDCHEM,agents),]

jdb$D_FINAL <-jdb$C_FINAL*jdb$F_FINAL/40

jdb <-jdb[jdb$C_FINAL>=Cmin &
			jdb$D_FINAL>=Dmin &
			jdb$F_FINAL>=Fmin,]

######################################################
### Categorize continuous frequency values (added JAN26 2016)
########################################################

# Note - apparently (from help of "cut" function) "findInterval" is faster
nlevsFreq <- length(Fcut)-1
jdb$F_FINAL_CAT <- factor(findInterval(x=jdb$F_FINAL, vec=Fcut, rightmost.closed = T,  all.inside = T),
						levels=1:nlevsFreq)
# tapply(jdb$F_FINAL, jdb$F_FINAL_CAT, range) # To check that correct categorization has been applied


  
##################################################################################
#Creating a base prevalence database
##################################################################################

bd.prev.1 <-workoccind

bd.prev.1$id.job <-paste(bd.prev.1$ID,bd.prev.1$JOB,sep='-')

bd.prev.1 <-bd.prev.1[,is.element(names(bd.prev.1),c(c('ID','JOB','YEARIN','YEAROUT'),
										vec.dim))]

###formattage des p?riodes


##### retrait des emplois <a l'ext?rieur de la p?riode d?finie par time.breaks

bd.prev.1<-bd.prev.1[bd.prev.1$YEARIN<=max(time.breaks),]
bd.prev.1<-bd.prev.1[bd.prev.1$YEAROUT>=min(time.breaks),]

bd.prev.1$YEAROUT[bd.prev.1$YEAROUT>max(time.breaks)] <-max(time.breaks)
bd.prev.1$YEARIN[bd.prev.1$YEARIN<min(time.breaks)] <-min(time.breaks)

#####ann?es dans chaque p?riode ####on d?cide toujours d'exclure YEAROUT

bd.prev.1$yearspan <- paste(bd.prev.1$YEARIN,bd.prev.1$YEAROUT,sep='-')
  ## Modified approach to attribute periods in the JEM
  ##  Old version with "fun.yrs" was done using loop across periods
  ##  For each job/period combination, two sequences were created each time
  ## NEW APPROACH
  # step 1 - create list of years for each time period
  period.list <- lapply(as.list(period.vec), function(x) {
    seq(from=as.numeric(substr(x, 1, 4)), to=as.numeric(substr(x, 6,9)), 1) })
  # step 2 - new "fun.yrs" function that does all time periods at once for each job
  fun.yrs2 <- function(x,period.list){
    y.in <-as.numeric(substring(x,1,4)) ; y.out <-as.numeric(substring(x,6,9))
    ifelse(y.in==y.out, yrs <- y.in, yrs <-seq(y.in,y.out,by=1))
    res <- as.numeric(unlist(lapply(period.list, function(y) length(which(yrs%in%y)))))
    return(res)}
  #fun.yrs2(bd.prev.1$yearspan[1], period.list) ### TEST IT
  # step 3 - run it using lapply across all jobs
  # 3a) output is a list of length "njobs", each element is a vector of length "period.vec"
  # 3b) Collapse list into a table of dim(njobs, nperiods) using "rbind"
  # 3c) Combine with bd.prev.1 using cbind as in previous versions.
  bd.prev.1 <- cbind(bd.prev.1, 
                     do.call("rbind", lapply(bd.prev.1$yearspan, function(x) fun.yrs2(x, period.list))))
  dimnames(bd.prev.1)[[2]][(1+ncol(bd.prev.1)-length(period.vec)):ncol(bd.prev.1)] <- period.vec


###fabriCATion de la matrice complete de pr?valence

#index de repliCATion

if (type=='R1nouse'|type=='R12nouse') {
  if(type=='R1nouse'){
	##chaque agent possede une longeur de workoccind sp?cifique
	
	bd.prev.2 <-bd.prev.1[0,]
	bd.prev.2$IDCHEM <-numeric(0)
	
	for (i in 1:length(agents))  {
									restrict <-jdb$R_FINAL==1 & jdb$IDCHEM==agents[i]
									r1nouse <-paste(jdb$ID[restrict],jdb$JOB[restrict],sep='-')
									
									restrict.1 <-!is.element(paste(bd.prev.1$ID,bd.prev.1$JOB,sep='-'),r1nouse)
									temp <-bd.prev.1[restrict.1,]
									temp$IDCHEM <-agents[i]
									bd.prev.2<-rbind(bd.prev.2,temp)
									
		
								}
						} else {		
						  
	bd.prev.2 <-bd.prev.1[0,]
	bd.prev.2$IDCHEM <-numeric(0)
	
	for (i in 1:length(agents))  {
									restrict <-(jdb$R_FINAL==1|jdb$R_FINAL==2) & jdb$IDCHEM==agents[i]
									r1nouse <-paste(jdb$ID[restrict],jdb$JOB[restrict],sep='-')
									
									restrict.1 <-!is.element(paste(bd.prev.1$ID,bd.prev.1$JOB,sep='-'),r1nouse)
									temp <-bd.prev.1[restrict.1,]
									temp$IDCHEM <-agents[i]
									bd.prev.2<-rbind(bd.prev.2,temp)
									
		
								}					  
						}
		} else {						  
	
##for anything but R1nouse, same bd.prev.1 for any agent
	
index <-rep(1:length(bd.prev.1$ID),rep(length(agents),length(bd.prev.1$ID)))

bd.prev.2 <-bd.prev.1[index,]

bd.prev.2$IDCHEM <-c(rep(agents,length(bd.prev.1[,1])))

}

####################################creation de la matrice pr?valence ################################################

##creation des snips

bd.prev.2$snip <-paste(bd.prev.2$ID, bd.prev.2$JOB,bd.prev.2$IDCHEM,sep='-')

jdb$snip <-paste(jdb$ID, jdb$JOB,jdb$IDCHEM,sep='-')

##variable d'exposition LOGIK  ###d?pend du type

bd.prev.2$expo.1 <-rep(F,length(bd.prev.2[,1]))

if (type=='R1Nexpo'|type=='R12Nexpo'){ 
      if (type=='R1Nexpo'){
          bd.prev.2$expo.1[is.element(bd.prev.2$snip,jdb$snip[jdb$R_FINAL!=1])] <-T #valable pour R1Nexpo
      }else{
        bd.prev.2$expo.1[is.element(bd.prev.2$snip,jdb$snip[jdb$R_FINAL!=1&jdb$R_FINAL!=2])] <-T #valable pour R12Nexpo
      }

    }else{
        bd.prev.2$expo.1[is.element(bd.prev.2$snip,jdb$snip)] <-T #valable pour R1expo et R1nouse
    }

#Variable de cellule (hors p?riode)

bd.prev.2$cell.noperiod <-bd.prev.2[,match(vec.dim[1],names(bd.prev.2))]

if (n.dim>1) for (i in 2:n.dim) bd.prev.2$cell.noperiod <-paste(bd.prev.2$cell.noperiod,bd.prev.2[,match(vec.dim[i],names(bd.prev.2))],sep='-')

bd.prev.2$cell.noperiod <-paste(bd.prev.2$cell.noperiod,bd.prev.2$IDCHEM,sep='-')

#####ann?es expos?es dans chaque p?riode 

for (i in 1:length(period.vec)) {
	
	bd.prev.2 <-cbind(bd.prev.2,bd.prev.2[,match(period.vec[i],names(bd.prev.2))])
	bd.prev.2[bd.prev.2$expo.1==F,dim(bd.prev.2)[2]] <-0
names(bd.prev.2)[dim(bd.prev.2)[2]] <-paste('EXP',period.vec[i],sep='-') }

##ajout des information sur l'exposition sur chaque snip  ####d?pend du type

######pour R1Nexpo

if (type=='R1Nexpo'|type=='R12Nexpo'){ 
      if (type=='R1Nexpo'){
	  jdb2 <-jdb[jdb$R_FINAL!=1,]	####jdb sans R1
      }else{
        jdb2 <-jdb[jdb$R_FINAL!=1&jdb$R_FINAL!=2,]
      }
	      

bd.prev.2$R_FINAL<-jdb2$R_FINAL[match(bd.prev.2$snip,jdb2$snip)]
bd.prev.2$F_FINAL<-jdb2$F_FINAL[match(bd.prev.2$snip,jdb2$snip)]
bd.prev.2$F_FINAL_CAT<-jdb2$F_FINAL_CAT[match(bd.prev.2$snip,jdb2$snip)]
bd.prev.2$C_FINAL<-jdb2$C_FINAL[match(bd.prev.2$snip,jdb2$snip)]	
bd.prev.2$C_FINAL_CAT<-jdb2$C_FINAL_CAT[match(bd.prev.2$snip,jdb2$snip)]
bd.prev.2$D_FINAL<-jdb2$D_FINAL[match(bd.prev.2$snip,jdb2$snip)]

				} else{  ###pour R1expo et R1nouse tout est d?j? pr?t
				

bd.prev.2$R_FINAL<-jdb$R_FINAL[match(bd.prev.2$snip,jdb$snip)]
bd.prev.2$F_FINAL<-jdb$F_FINAL[match(bd.prev.2$snip,jdb$snip)]
bd.prev.2$F_FINAL_CAT<-jdb$F_FINAL_CAT[match(bd.prev.2$snip,jdb$snip)]
bd.prev.2$C_FINAL<-jdb$C_FINAL[match(bd.prev.2$snip,jdb$snip)]	
bd.prev.2$C_FINAL_CAT<-jdb$C_FINAL_CAT[match(bd.prev.2$snip,jdb$snip)]
bd.prev.2$D_FINAL<-jdb$D_FINAL[match(bd.prev.2$snip,jdb$snip)]

				}								
				
				
######## matrices de r?sultats

###tableau : creation sequentielle pour chaque periode


	mat <-data.frame(cell.noperiod=character(0),period=character(0),idchem=numeric(0),p=numeric(0),ntot=numeric(0),
						nsub=numeric(0),
						nexp=numeric(0),
						nexp.s=numeric(0),
						nyrs=numeric(0),
						n.R0=numeric(0),n.R1=numeric(0),n.R2=numeric(0),n.R3=numeric(0),	#number of jobs per reliability level
						n.C0=numeric(0),n.C1=numeric(0),n.C2=numeric(0),n.C3=numeric(0),	#number of jobs per concentration level
	          matrix(0, ncol=(nlevsFreq+1), nrow=0),                            #number of jobs per frequency level
	          p.R0=numeric(0),p.R1=numeric(0),p.R2=numeric(0),n.R3=numeric(0),	#proportion of jobs per reliability level
						p.C0=numeric(0),p.C1=numeric(0),p.C2=numeric(0),n.C3=numeric(0),	#proportion of jobs per concentration level
	          matrix(0, ncol=(nlevsFreq+1), nrow=0),                            #proportion of jobs per frequency level
						Cmoy.1=numeric(0),Cmoy.3=numeric(0),Cmoy.5=numeric(0),Cmoy.10=numeric(0),  #mean concentration with scales 1-2-3,1-3-9,1-5-25,1-10-100
						Dmoy.1=numeric(0),Dmoy.3=numeric(0),Dmoy.5=numeric(0),Dmoy.10=numeric(0),  #mean concentration with scales 1-2-3,1-3-9,1-5-25,1-10-100
						Cmed.1=numeric(0),Cmed.3=numeric(0),Cmed.5=numeric(0),Cmed.10=numeric(0),
						Dmed.1=numeric(0),Dmed.3=numeric(0),Dmed.5=numeric(0),Dmed.10=numeric(0),
						Fmoy=numeric(0),Fmed=numeric(0), n.FWI.greater = numeric(0) , cell=character(0) ,stringsAsFactors=F)
	
	# Ajout des noms de variables pour fr?quence
	names(mat)[grep("^X", names(mat))][1:(nlevsFreq+1)] <- paste0("n.F", seq(0, nlevsFreq))
	names(mat)[grep("^X", names(mat))][1:(nlevsFreq+1)] <- paste0("p.F", seq(0, nlevsFreq))

	
	for (i in 1:n.dim) {mat<-cbind(mat,character(0))
						names(mat)[dim(mat)[2]]<-vec.dim[i]}				
						
						
						
	for (i in 1:length(period.vec)) {
		
#selecting at first cells with Nmin jobs and Nmin.s subjects

##table of all cells with njobs et nsubjects

restrict <-bd.prev.2[,match(period.vec[i],names(bd.prev.2))]!=0
bla <-data.frame(table(bd.prev.2$cell.noperiod[restrict]),stringsAsFactors=F)
names(bla) <-c('nom','n')
bla$n.s <-tapply(bd.prev.2$ID[restrict],bd.prev.2$cell.noperiod[restrict],function(x){length(unique(x))})

cell.list <-bla$nom[bla$n>=Nmin & bla$n.s>=Nmin.s] # Corrig? JUL 03 2015

n.cell <-length(cell.list)

#initializing the period specific JEM
		mat.temp <-data.frame(cell.noperiod=cell.list,period=character(n.cell),idchem=numeric(n.cell),p=numeric(n.cell),
						ntot=numeric(n.cell),
						nsub=numeric(n.cell),
						nexp=numeric(n.cell),
						nexp.s=numeric(n.cell),
						nyrs=numeric(n.cell),
						n.R0=numeric(n.cell),n.R1=numeric(n.cell),n.R2=numeric(n.cell),n.R3=numeric(n.cell),	#number of jobs per reliability level
						n.C0=numeric(n.cell),n.C1=numeric(n.cell),n.C2=numeric(n.cell),n.C3=numeric(n.cell),	#number of jobs per concentration level
		        matrix(0, ncol=(nlevsFreq+1), nrow=n.cell),                            #number of jobs per frequency level
						p.R0=numeric(n.cell),p.R1=numeric(n.cell),p.R2=numeric(n.cell),p.R3=numeric(n.cell),	#proportion of jobs per reliability level
						p.C0=numeric(n.cell),p.C1=numeric(n.cell),p.C2=numeric(n.cell),p.C3=numeric(n.cell),	#proportion of jobs per concentration level
		        matrix(0, ncol=(nlevsFreq+1), nrow=n.cell),                            #proportion of jobs per frequency level
						Cmoy.1=numeric(n.cell),Cmoy.3=numeric(n.cell),Cmoy.5=numeric(n.cell),Cmoy.10=numeric(n.cell),  #mean concentration with scales 1-2-3,1-3-9,1-5-25,1-10-100
						Dmoy.1=numeric(n.cell),Dmoy.3=numeric(n.cell),Dmoy.5=numeric(n.cell),Dmoy.10=numeric(n.cell),  #mean concentration with scales 1-2-3,1-3-9,1-5-25,1-10-100
						Cmed.1=numeric(n.cell),Cmed.3=numeric(n.cell),Cmed.5=numeric(n.cell),Cmed.10=numeric(n.cell),
						Dmed.1=numeric(n.cell),Dmed.3=numeric(n.cell),Dmed.5=numeric(n.cell),Dmed.10=numeric(n.cell),
						Fmoy=numeric(n.cell),Fmed=numeric(n.cell),
						n.FWI.greater = numeric(n.cell) , stringsAsFactors=F)
		
			# Ajout des noms de variables pour fr?quence
	names(mat.temp)[grep("^X", names(mat.temp))][1:(nlevsFreq+1)] <- paste0("n.F", seq(0, nlevsFreq))
	names(mat.temp)[grep("^X", names(mat.temp))][1:(nlevsFreq+1)] <- paste0("p.F", seq(0, nlevsFreq))
	
	
	for (j in 1:n.dim) {mat.temp<-cbind(mat.temp,character(n.cell))
				names(mat.temp)[dim(mat.temp)[2]]<-vec.dim[j]}


				
#filling the period, idchem and vec.dim identifiCATion variables
						
	mat.temp$period <-rep(period.vec[i],n.cell)
	
	restrict <-is.element(bd.prev.2$cell.noperiod,cell.list)
	
	temp.idchem <-tapply(bd.prev.2$IDCHEM[restrict],bd.prev.2$cell.noperiod[restrict],function(x){x[1]})
	temp.idchem <-data.frame(idchem=unname(temp.idchem),cell=names(temp.idchem),stringsAsFactors=F)
	mat.temp$idchem<-temp.idchem$idchem[match(mat.temp$cell.noperiod,temp.idchem$cell)]
	
	for (j in 1:n.dim) {
		
		temp.dim <-tapply(bd.prev.2[restrict,match(vec.dim[j],names(bd.prev.2))],bd.prev.2$cell.noperiod[restrict],function(x){x[1]})
	temp.dim <-data.frame(dim=unname(temp.dim),cell=names(temp.dim),stringsAsFactors=F)
	mat.temp[,match(vec.dim[j],names(mat.temp))]<-temp.dim$dim[match(mat.temp$cell.noperiod,temp.dim$cell)]
		
	}	

	##filling the exposure metrics		
		
	restrict <-is.element(bd.prev.2$cell.noperiod,cell.list) & bd.prev.2[,match(period.vec[i],names(bd.prev.2))]!=0	

	#nombre de jobs dans bd.prev.2
	temp <-tapply(bd.prev.2$IDCHEM[restrict],bd.prev.2$cell.noperiod[restrict],length)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$ntot<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#nombre de sujets dans bd.prev.2
	temp <-tapply(bd.prev.2$ID[restrict],bd.prev.2$cell.noperiod[restrict],function(x) {length(unique(x))})
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$nsub<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#nombre d'ann?es dans bd.prev.2
	temp <-tapply(bd.prev.2[restrict,match(period.vec[i],names(bd.prev.2))],bd.prev.2$cell[restrict],sum)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$nyrs<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#nombre de jobs expos?s
	temp <-tapply(bd.prev.2$expo.1[restrict],bd.prev.2$cell[restrict],sum)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$nexp<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#nombre de sujet expos?s
	temp <-tapply(bd.prev.2$ID[restrict & bd.prev.2$expo.1==1],bd.prev.2$cell[restrict & bd.prev.2$expo.1==1],function(x) {length(unique(x))})
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$nexp.s<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#prevalence nombre de jobs
	
	mat.temp$p <-100*mat.temp$nexp/mat.temp$ntot

	
	###exposure level metric - mean
	
	#C5
	temp <-tapply(bd.prev.2$C_FINAL[restrict],bd.prev.2$cell[restrict],mean,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Cmoy.5<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#C1
	temp <-tapply(1+log(bd.prev.2$C_FINAL[restrict])/log(5),bd.prev.2$cell[restrict],mean,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Cmoy.1<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#C3
	temp <-tapply(3^(log(bd.prev.2$C_FINAL[restrict])/log(5)),bd.prev.2$cell[restrict],mean,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Cmoy.3<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#C10
	temp <-tapply(10^(log(bd.prev.2$C_FINAL[restrict])/log(5)),bd.prev.2$cell[restrict],mean,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Cmoy.10<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	###exposure level metric - median
	
	#C5
	temp <-tapply(bd.prev.2$C_FINAL[restrict],bd.prev.2$cell[restrict],median,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Cmed.5<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#C1
	temp <-tapply(1+log(bd.prev.2$C_FINAL[restrict])/log(5),bd.prev.2$cell[restrict],median,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Cmed.1<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#C3
	temp <-tapply(3^(log(bd.prev.2$C_FINAL[restrict])/log(5)),bd.prev.2$cell[restrict],median,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Cmed.3<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#C10
	temp <-tapply(10^(log(bd.prev.2$C_FINAL[restrict])/log(5)),bd.prev.2$cell[restrict],median,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Cmed.10<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]

	##exposure dose - mean
	
	#D5
	temp <-tapply(bd.prev.2$C_FINAL[restrict]*bd.prev.2$F_FINAL[restrict]/40,bd.prev.2$cell[restrict],mean,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Dmoy.5<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#D1
	temp <-tapply((1+log(bd.prev.2$C_FINAL[restrict])/log(5))*bd.prev.2$F_FINAL[restrict]/40,bd.prev.2$cell[restrict],mean,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Dmoy.1<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#D3
	temp <-tapply((3^(log(bd.prev.2$C_FINAL[restrict])/log(5)))*bd.prev.2$F_FINAL[restrict]/40,bd.prev.2$cell[restrict],mean,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Dmoy.3<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#D10
	temp <-tapply((10^(log(bd.prev.2$C_FINAL[restrict])/log(5)))*bd.prev.2$F_FINAL[restrict]/40,bd.prev.2$cell[restrict],mean,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Dmoy.10<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	##exposure dose - meddian
	
	#D5
	temp <-tapply(bd.prev.2$C_FINAL[restrict]*bd.prev.2$F_FINAL[restrict]/40,bd.prev.2$cell[restrict],median,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Dmed.5<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#D1
	temp <-tapply((1+log(bd.prev.2$C_FINAL[restrict])/log(5))*bd.prev.2$F_FINAL[restrict]/40,bd.prev.2$cell[restrict],median,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Dmed.1<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#D3
	temp <-tapply((3^(log(bd.prev.2$C_FINAL[restrict])/log(5)))*bd.prev.2$F_FINAL[restrict]/40,bd.prev.2$cell[restrict],median,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Dmed.3<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#D10
	temp <-tapply((10^(log(bd.prev.2$C_FINAL[restrict])/log(5)))*bd.prev.2$F_FINAL[restrict]/40,bd.prev.2$cell[restrict],median,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Dmed.10<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#mean frequency
	
	temp <-tapply(bd.prev.2$F_FINAL[restrict],bd.prev.2$cell[restrict],mean,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Fmoy<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	#median frequency
	
	temp <-tapply(bd.prev.2$F_FINAL[restrict],bd.prev.2$cell[restrict],median,na.rm=T)
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$Fmed<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	
	# number of jobs with FWI greater or equal to FWI.threshold
	

	temp <-tapply(bd.prev.2$C_FINAL[restrict]*bd.prev.2$F_FINAL[restrict]/40,bd.prev.2$cell[restrict],function(x){ 
	          x <- x[!is.na(x)]
	          return(length( x[ x >= FWI.threshold ]))
	  })
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$n.FWI.greater <-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]


	########frequency of exposure CATegories
	
	#concentration
	
	temp <-tapply(bd.prev.2$C_FINAL_CAT[restrict],bd.prev.2$cell[restrict],function(x){length(x[is.na(x)])})
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$n.C0<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	mat.temp$p.C0<-100*mat.temp$n.C0/mat.temp$ntot
	
	temp <-tapply(bd.prev.2$C_FINAL_CAT[restrict],bd.prev.2$cell[restrict],function(x){length(x[!is.na(x)& x==1])})
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$n.C1<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	mat.temp$p.C1<-100*mat.temp$n.C1/mat.temp$ntot
	
	temp <-tapply(bd.prev.2$C_FINAL_CAT[restrict],bd.prev.2$cell[restrict],function(x){length(x[!is.na(x)& x==2])})
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$n.C2<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	mat.temp$p.C2<-100*mat.temp$n.C2/mat.temp$ntot
	
	temp <-tapply(bd.prev.2$C_FINAL_CAT[restrict],bd.prev.2$cell[restrict],function(x){length(x[!is.na(x)& x==3])})
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$n.C3<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	mat.temp$p.C3<-100*mat.temp$n.C3/mat.temp$ntot
	
	#frequency
	# - number of jobs in each rating per cell
  temp <- do.call("rbind", tapply(bd.prev.2$F_FINAL_CAT[restrict],bd.prev.2$cell[restrict],function(x){
	  tbl <- table(x, useNA="always")
	   names(tbl)[is.na(names(tbl))] <- "0"
	   tbl <- tbl[order(names(tbl))] # reorder to have 0 first
	   tbl }))
  # - add into "mat.temp"
  mat.temp[,grep("^n.F[0-9]", names(mat.temp))] <- temp[match(mat.temp$cell.noperiod,rownames(temp)),]
	# proportions 
  temp.p <- t(apply(temp, 1, function(x) 100*x/(sum(x))))
	mat.temp[,grep("^p.F[0-9]", names(mat.temp))] <-temp.p[match(mat.temp$cell.noperiod,rownames(temp.p)),]
	  

	
		#fiability
	
	temp <-tapply(bd.prev.2$R_FINAL[restrict],bd.prev.2$cell[restrict],function(x){length(x[is.na(x)])})
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$n.R0<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	mat.temp$p.R0<-100*mat.temp$n.R0/mat.temp$ntot
	
	temp <-tapply(bd.prev.2$R_FINAL[restrict],bd.prev.2$cell[restrict],function(x){length(x[!is.na(x)& x==1])})
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$n.R1<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	mat.temp$p.R1<-100*mat.temp$n.R1/mat.temp$ntot
	
	temp <-tapply(bd.prev.2$R_FINAL[restrict],bd.prev.2$cell[restrict],function(x){length(x[!is.na(x)& x==2])})
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$n.R2<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	mat.temp$p.R2<-100*mat.temp$n.R2/mat.temp$ntot
	
	temp <-tapply(bd.prev.2$R_FINAL[restrict],bd.prev.2$cell[restrict],function(x){length(x[!is.na(x)& x==3])})
	temp <-data.frame(metric=unname(temp),cell=names(temp),stringsAsFactors=F)
	mat.temp$n.R3<-temp$metric[match(mat.temp$cell.noperiod,temp$cell)]
	mat.temp$p.R3<-100*mat.temp$n.R3/mat.temp$ntot
	
	#adding the FINAL cell variable
	
	mat.temp$cell <-paste(mat.temp$cell.noperiod,mat.temp$period,sep='-')
	
	#joining with mat
	
	mat <-rbind(mat,mat.temp)
	
	}
	

	return(mat)
	
}	
	
#####################################fonction de calcul du nombre d'annees dans une p?riode

fun.yrs <-function(x,period) {
	
	first <-as.numeric(substring(period,1,4))
	last <-as.numeric(substring(period,6,9))
	y.in <-as.numeric(substring(x,1,4))
	y.out <-as.numeric(substring(x,6,9))
	yrs <- integer(1)
	ifelse(y.in==y.out, yrs <- y.in, yrs <-seq(y.in,y.out,by=1))
	res <-length(yrs[is.element(yrs,seq(first,last,by=1))])
	return(as.numeric(res)) }

fun.yrs('1965-1969','1965-1985')
###################################################################################################################
#operational criteria

crit.p <-function(vec1,vec2,limits=c(0,1,5,15,30,50,80,100),delta=c(0.25,1.25,3.75,7.5,12.5,20,25)) {
	
	#inputs : 2 numerical vectors of same length
	#output :  a vector indiCATing the CATegory, and a vector indiCATing TRUE if the criteria is met

		crit.CAT <-cut(pmin(vec1,vec2), breaks=limits,include.lowest=T)
		
		CATs <-names(table(crit.CAT))
		
		res <-rep(FALSE,length(vec1))
		
		for (i in 1:length(CATs)) res[(crit.CAT==CATs[i]) & (abs(vec1-vec2)>=delta[i])] <- TRUE
			
	return(data.frame(crit.CAT,res)) }
