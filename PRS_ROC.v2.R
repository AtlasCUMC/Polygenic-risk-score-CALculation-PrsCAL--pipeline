########### Atlas Khan ############
######## 06/11/2019 ############

### R script for AUC curve

###################################################################################

args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("At least two arguments must be supplied (input file and output file name).\n", call.=FALSE)
} else if (length(args)==2) {

####args1=inout
###args2=output
###args3=number of cases
####args4=Number of control
#########################Data import ##############################################

cat ("NOTICE: Loading the required libraries", "\n")

suppressMessages(library(ROCR))
suppressMessages(library(data.table))
suppressMessages(library(auctestr))
suppressMessages(library(MASS))
suppressMessages(library(pROC))
suppressMessages(library(rcompanion))

cat ("NOTICE: Loading the input file!", "\n")

Ldpred_validate <- fread(args[1],header=TRUE)

Ldpred_validate_1 <- Ldpred_validate
Ldpred_validate$Sex <- as.factor(Ldpred_validate$Sex)
Ldpred_validate$Site <- as.factor(Ldpred_validate$Site)
Ldpred_validate$PRS <- Ldpred_validate$Stand_PRS
Ldpred_validate$T2DM <- as.factor(Ldpred_validate$T2DM)

##################



reg <-glm(Pheno~PRS+Age+Sex+Site+PC1+PC2+PC3+PC4+T2DM, data=Ldpred_validate, family=binomial(link="logit"))

R2 <- with(summary(reg), 1 - deviance/null.deviance)

##################

Fam_validate <- Ldpred_validate$Pheno

Sroc <-lm(PRS~Age+Sex+Site+PC1+PC2+PC3+PC4+T2DM, data=Ldpred_validate)

GLM <- glm(Pheno~Age+Site+PC1+PC2+PC3+PC4+PRS+T2DM, family=binomial(link="logit"), data=Ldpred_validate)

########

roc.data <-roc(GLM$y , GLM$fitted.values,ci=T)

print(roc.data)


AdjustedROC <- round(roc.data$auc[1], digits=4)

ROCRpred <- prediction(Ldpred_validate$PRS,Fam_validate)


auc.ROCRpred <- performance(ROCRpred,"auc")


AUC <- round(as.numeric(auc.ROCRpred@y.values),digits=4)

print(paste("AUC:", AUC))

auc_se <- se_auc(AUC,as.numeric(args[3]),as.numeric(args[4]))

print(paste("SE:",auc_se))

CI_lower <- AUC-1.96*auc_se
CI_upper <- AUC+1.96*auc_se

print(paste("CI 95% lower:", CI_lower))

print(paste("CI 95% Upper:", CI_upper))

outfile <- sprintf("PRS_%s.pdf",args[2])
pdf(outfile)
mar.default <- c(5,4,4,2) + 0.1
par(mar = mar.default + c(0, 4, 0, 0))

plot(performance(ROCRpred,'tpr','fpr'), lwd=4,col="blue",cex.lab=1.5, cex=1.5, cex.axis=1.5)
maxauct <- formatC(AUC, digits = 2, format = "f")
maxauct <- paste(c("AUC = "),maxauct,sep="")

maxr2 <- formatC(R2, digits = 3, format = "f")
maxr2 <- paste(c("R-Square = "),maxr2,sep="")


legend("bottomright", c(maxauct,maxr2),lwd=4,lty=1,col = "blue", bty="n")

abline(0, 1, col="black", lwd=2)
dev.off()

####################

reg <-glm(Pheno~PRS+Age+Sex+Site+PC1+PC2+PC3+PC4+T2DM, data=Ldpred_validate, family=binomial(link="logit"))

with(summary(reg), 1 - deviance/null.deviance)


cat ("NOTICE: OR with adjustement \n")

fit <- glm(Pheno~PRS+PC1+PC2+PC3+PC4+Age+Sex+Site+T2DM,data=Ldpred_validate,family=binomial(link="logit"))


print(summary(fit))



cat ("NOTICE: Creating the CI \n")
date()

###################

P <- coef(summary(fit))[,4][2]
P <- signif(P,3)

F <-exp(signif(coef(summary(fit))[,1][2],3))

F <- signif(F,3)

#print(F)

###
L <- F - 1.96*(signif(coef(summary(fit))[,2][2],3))
U <- F + 1.96*(signif(coef(summary(fit))[,2][2],3))
#####
L <- signif(L,3)
U <- signif(U,3)

comb <- cbind(F,L,U,P)

comb <- data.frame(comb)

colnames(comb) <- c("OR", "Lower", "Upper", "P")

print(comb)

cat ("\n NOTICE: OR with NO adjustement \n")

fit <- glm(Pheno~PRS,data=Ldpred_validate,family=binomial(link="logit"))

#print(summary(fit))

cat ("NOTICE: Creating the CI \n")
date()

###################


P <- coef(summary(fit))[,4][2]
P <- signif(P,3)

F <-exp(signif(coef(summary(fit))[,1][2],3))
F <- signif(F,3)


###################

L <- F - 1.96*(signif(coef(summary(fit))[,2][2],3))
U <- F + 1.96*(signif(coef(summary(fit))[,2][2],3))

##################

L <- signif(L,3)
U <- signif(U,3)

combnonAdJ <- cbind(F,L,U,P)

combnonAdJ <- data.frame(combnonAdJ)

colnames(combnonAdJ) <- c("CrudeOR", "CrudeLower", "CrudeUpper", "CrudeP")
print(combnonAdJ)

comAUC <- cbind(round(roc.data$auc[1], digits=4), AUC, length(roc.data$cases), length(roc.data$controls))

comAUC <- data.frame(comAUC)

#print(comAUC)

colnames(comAUC) <- c("AUC","CrudeAUC", "Cases(N)", "Controls(N)")


comb <- cbind(comb,combnonAdJ,comAUC) 


outfile <- sprintf("OR_P_AUC_CrudeAUC_%s",args[2])

write.table(comb, file=outfile, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE, append=FALSE)

#####

cat("\n NOTICE: Analzing by nagelkerke:\n")

g_data2 <- Ldpred_validate

model = glm(Pheno~PRS+PC1+PC2+PC3+PC4+Age+Sex+Site+T2DM, data=data.frame(g_data2),family = binomial(link="logit"))


# summary(model)

n1 <- nagelkerke(model)

cat("NOTICE: PRS variance explained with Covariates:\n")

print(n1$Pseudo.R.squared.for.model.vs.null[3])


model = glm(Pheno~PC1+PC2+PC3+PC4+Age+Sex+Site+T2DM, data=data.frame(g_data2),family = binomial(link="logit"))


n2 <- nagelkerke(model)

cat("NOTICE: Covariates variance explained:\n")
print(n2$Pseudo.R.squared.for.model.vs.null[3])


cat("NOTICE: Variance explained:\n")

print(n1$Pseudo.R.squared.for.model.vs.null[3]-n2$Pseudo.R.squared.for.model.vs.null[3])


All <- n1$Pseudo.R.squared.for.model.vs.null[3]-n2$Pseudo.R.squared.for.model.vs.null[3]

A1 <-100*(All)
cat("NOTICE: Variance explained in (%):\n")
print(A1)


R2 <- data.frame(n1$Pseudo.R.squared.for.model.vs.null[3]-n2$Pseudo.R.squared.for.model.vs.null[3])

R2 <- round(R2,digits=4)

colnames(R2) <- "NagelkerkeR2"

#comb <- cbind(comb,combnonAdJ,comAUC,R2)

comb <- cbind(comb,R2)

outfile <- sprintf("OR_P_AUC_CrudeAUC_%s",args[2])

write.table(comb, file=outfile, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE, append=FALSE)

} else {
cat ("NOTICE: Please need input files" , "\n")
}

