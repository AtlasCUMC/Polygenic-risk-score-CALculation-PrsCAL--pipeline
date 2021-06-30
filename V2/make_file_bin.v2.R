############
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least one argument must be supplied (input file).\n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[4] = "out.txt"
  #args[4]=1
}

##################
#f1$New <- .bincode(f1[,2], breaks = quantile(f1[,2], seq(0, 1, by = 0.1)), include.lowest = TRUE)

f1 <- read.csv(args[1], header=T)  #### PRS
f2 <-  read.delim(args[2], header=T) #### Pheno
f3 <-  read.delim(args[3], header=T) #### PCs

###############
f4 <- merge(f1,f2, by.x="IID", by.y="IID")
f5 <- merge(f3,f4, by.x="IID", by.y="IID")



f6 <- f5




####Age###

l1 <- which(f6$Age>=40)

f6 <- f6[l1,]



#control <- f6[which(f6$pheno==0),]


#f6$Stand_PRS <- (f6$PRS-(mean(control$PRS)))/(sd(control$PRS))

f6$Stand_PRS <- f6$PRS 

N <- dim(f6)[1]

f6$ZScore <-scale(f6$Stand_PRS)/sqrt((N-1)/N)

m <- mean(f6$PRS)
s <- sd(f6$PRS)

f6$ZScore <- (f6$PRS-m)/s



######

f6$scoreBin20 <- as.integer(cut(f6$PRS,breaks=quantile(f6$PRS, seq(0,1,0.05), include.lowest=T)))

f6$scoreBin100 <- as.integer(cut(f6$PRS,breaks=quantile(f6$PRS, seq(0,1,0.01), include.lowest=T)))

f6$scoreBin50 <- as.integer(cut(f6$PRS,breaks=quantile(f6$PRS, seq(0,1,0.005), include.lowest=T)))





f6 <-cbind(f6$IID, f6$Age, f6$Sex, f6$Site, f6$PC1, f6$PC2 ,f6$PC3,f6$PC4,f6$PRS,f6$Stand_PRS,f6$ZScore,f6$pheno,f6$scoreBin20,f6$scoreBin100,f6$T2DM)

colnames(f6) <- c("id", "Age", "Sex", "Site", "PC1", "PC2", "PC3" ,"PC4", "PRS", "Stand_PRS", "ZScore", "Pheno", "scoreBin20" , "scoreBin100", "T2DM")




outfile <- sprintf("PRS_Bins_qunatiles_%s",args[4])

write.table(f6, outfile, row.names=F, col.names=T, quote=F, sep="\t", append=F)


#############


