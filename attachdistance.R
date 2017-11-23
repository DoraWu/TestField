###############################################################################
## Run after Erin's script to attach trip distance from network skims to     ##
## survey trip data and aggregate to get trip frequencies                    ##
###############################################################################

# read network skim matrix
pkskims<-read.csv("G:/Projects/NERPM/testrun/10A/Output/CONGSKIM_A10_AM.csv")
opskims<-read.csv("G:/Projects/NERPM/testrun/10A/Output/CONGSKIM_A10_MD.csv")


# remove NA and unknowns 
trips$pTAZ=ifelse((trips$ProdTAZ=="NA")|(trips$ProdTAZ==999999),NA,as.numeric(trips$ProdTAZ))
trips$aTAZ=ifelse((trips$AttrTAZ=="NA")|(trips$AttrTAZ==999999),NA,as.numeric(trips$AttrTAZ))
destchoice=na.omit(subset(trips,select=c("HOUSEID","TDCASEID","pTAZ","aTAZ","TPurp","INC","WRKR","SIZE","VEH","WTHHFIN","STRTTIME")))


# define time periods
destchoice$TIME="OP"
destchoice$TIME=ifelse(destchoice$STRTTIME>=600&destchoice$STRTTIME<=900,"PK",destchoice$TIME)
destchoice$TIME=ifelse(destchoice$STRTTIME>=1500&destchoice$STRTTIME<=1900,"PK",destchoice$TIME)


# attach distance
for (i in 1:length(destchoice$pTAZ))
 { p=destchoice$pTAZ[i]
   a=destchoice$aTAZ[i]
   if (destchoice$TIME[i]=="PK") 
       destchoice$DISTANCE[i]=pkskims[p,a]
   else
       destchoice$DISTANCE[i]=opskims[p,a]
 }

 
# label trips by their distance group
destchoice$dis_c=50
destchoice$dis_c=ifelse(destchoice$DISTANCE<=49,49,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=48,48,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=47,47,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=46,46,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=45,45,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=44,44,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=43,43,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=42,42,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=41,41,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=40,40,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=39,39,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=38,38,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=37,37,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=36,36,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=35,35,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=34,34,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=33,34,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=33,33,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=32,32,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=31,31,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=30,30,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=29,29,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=28,28,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=27,27,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=26,26,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=25,25,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=24,24,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=23,23,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=22,22,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=21,21,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=20,20,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=19,19,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=18,18,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=17,17,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=16,16,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=15,15,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=14,14,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=13,14,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=13,13,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=12,12,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=11,11,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=10,10,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=9,9,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=8,8,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=7,7,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=6,6,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=5,5,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=4,4,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=3,3,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=2,2,destchoice$dis_c)
destchoice$dis_c=ifelse(destchoice$DISTANCE<=1,1,destchoice$dis_c)


# write out each survey trip in csv
write.table(destchoice,"G:/Projects/NERPM/Trips_output.csv",sep=",",col.names=TRUE,row.names=FALSE)


# aggregate trips and write it out!
tripfreq=aggregate(destchoice$WTHHFIN,by=list(destchoice$TPurp,destchoice$INC,destchoice$WRKR,destchoice$SIZE,destchoice$VEH,destchoice$dis_c),sum)
colnames(tripfreq)=c("TPurp","INC","WRKR","SIZE","VEH","dist_grp")
write.table(tripfreq,"G:/Projects/NERPM/survey_trip_frequencies.csv",sep=",",col.names=TRUE,row.names=FALSE)
