##################
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error

if (length(args)==0) {
  stop("At least one argument must be supplied (input file).\n", call.=FALSE)
} else if (length(args)==1) {
  # default output file
  args[2] = "out.txt"
}
cat ("Loading the input file\n")
date()
f1 <- read.delim(args[1], header=T)

f1 <- na.omit(f1)

f1$Sex <- as.factor(f1$Sex)
f1$T2DM <- as.factor(f1$T2DM)

cat ("Fitting the model \n")
date()
fit <- glm(Pheno~PRS_ref+PC1+PC2+PC3+PC4+Sex+Age+T2DM , data=f1,family=binomial(link="logit"))

cat ("Creating the CI \n")
date()

#CI <- cbind(coef(fit),confint(fit))

###################
P <- coef(summary(fit))[,4][2]
P <- signif(P,3)

F <-exp(signif(coef(summary(fit))[,1][2],3))
F <- signif(F,3)
###
L <- F - 1.96*(signif(coef(summary(fit))[,2][2],3))
U <- F + 1.96*(signif(coef(summary(fit))[,2][2],3))
#####
L <- signif(L,3)
U <- signif(U,3)


#Z <- signif(coef(summary(fit))[,3][2],4) ### z score

p <- as.numeric(args[3])
mean1=mean(f1$RawPRS)

sd1 <- sd(f1$RawPRS)

Z <- qnorm(p,mean=mean1,sd=sd1)


SE <- signif(coef(summary(fit))[,2][2],3)

comb <- cbind(F,L,U,SE,Z,P)


comb <- data.frame(comb)


colnames(comb) <- c("OR", "Lower", "Upper", "SE", "Zscore", "P")

outfile <- sprintf("OR_P_%s",args[2])
write.table(comb, file=outfile, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE, append=FALSE)




cat ("Fitting the model with NO Adjustment\n")
date()
fit <- glm(Pheno~PRS_ref,data=f1,family=binomial(link="logit"))

cat ("Creating the CI \n")
date()

###################


P <- coef(summary(fit))[,4][2]
P <- signif(P,3)

F <-exp(signif(coef(summary(fit))[,1][2],3))
F <- signif(F,3)
###
L <- F - 1.96*(signif(coef(summary(fit))[,2][2],3))
U <- F + 1.96*(signif(coef(summary(fit))[,2][2],3))
#####
L <- signif(L,3)
U <- signif(U,3)

Z <- signif(coef(summary(fit))[,3][2],4) ### z score

SE <- signif(coef(summary(fit))[,2][2],3)

comb <- cbind(F,L,U,Z,P,SE)

comb <- data.frame(comb)
print(comb)

cat ("Done \n")
date()

