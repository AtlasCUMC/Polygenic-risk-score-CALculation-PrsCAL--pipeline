##################
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error

if (length(args)==0) {
  stop("At least one argument must be supplied (input file).\n", call.=FALSE)
} else if (length(args)==2) {
}

cat ("Loading the input file\n")
date()
f1 <- read.delim(args[1], header=T)

f1 <- na.omit(f1)

f1$Sex <- as.factor(f1$Sex)
f1$Site <- as.factor(f1$Site)
f1$T2DM <- as.factor(f1$T2DM)
#f1$APOL1Risk <- as.factor(f1$APOL1Risk)

cat ("Fitting the model \n")
date()
Fiberbits_model_1 <- glm(Pheno~PRS_ref+PC1+PC2+PC3+PC4+Sex+Site+Age+T2DM , data=f1,family=binomial(link="logit"))

date()

library(caret)

threshold=0.5
predicted_values<-ifelse(predict(Fiberbits_model_1,type="response")>threshold,1,0)
actual_values<-Fiberbits_model_1$y
conf_matrix<-table(predicted_values,actual_values)

print(conf_matrix)

#Sn <- (sensitivity(conf_matrix))
#Sp <- (specificity(conf_matrix))

Sn <- conf_matrix[2,2]/(conf_matrix[2,2]+conf_matrix[1,2]) 
Sp <- conf_matrix[1,1]/(conf_matrix[1,1]+conf_matrix[2,1])

cat ("Sensitivity \n")
print(Sn)
#SE_Sn <- sqrt(Sn-(1-Sn)/conf_matrix[2,2])

SE_Sn <- sqrt(((1-Sn)*Sn)/(conf_matrix[1,2]+conf_matrix[2,2]))

cat ("SE of Sensitivity \n")

print(SE_Sn)

CI <- Sn-1.96*SE_Sn

#print(CI)

cat ("Specificity \n")

print(Sp)

SE_Sp <- sqrt(((1-Sp)*Sp)/(conf_matrix[1,1]+conf_matrix[2,1]))
cat ("SE of Specificity \n")
print(SE_Sp)

#CI <- Sp-1.96*SE_Sp
#print(CI)
#CI <- cbind(coef(fit),confint(fit))

####################
#PPV = (Sn * Pr) / [ (Sn * Pr) + ((1 – Sp) * (1 – Pr)) ] and NPV = (Sp * (1 – Pr)) / [ (Sp * (1 – Pr)) + (( 1 – Sn) * Pr ) ]

Pr=(as.numeric(args[2]))/100

print(Pr)

PPV <- (Sn*Pr)/((Sn*Pr)+((1-Sp)*(1-Pr)))

cat ("PPV \n")
print(PPV)

NPV <- (Sp*(1-Pr))/(((1-Sn)*Pr) + (Sp*(1-Pr)))

cat ("NPV\n")

print(NPV)

###################
cat ("Done \n")
date()

