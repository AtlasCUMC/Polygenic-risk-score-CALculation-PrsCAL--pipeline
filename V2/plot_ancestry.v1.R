


f <- read.delim(args[1],header=TRUE)

f1 <- f[which(f$pop=="EUR"),]

f2 <- f[which(f$pop=="AFR"),]

f3 <- f[which(f$pop=="AMR"),]


f4 <- f[which(f$pop=="EAS"),]

f5 <- f[which(f$pop=="SAS"),]

#print(head(f5))

#661 AFR
 #   347 AMR
  #  504 EAS
   # 503 EUR
    #  1 pop
    #489 SAS


f1 <- f1[,c(1,2)]
Population <- rep("EUR", dim(f1)[1])
f1 <- cbind(f1,Population)
print(head(f1))

f2 <- f2[,c(1,2)]
Population <- rep("AFR",dim(f2)[1])
f2 <- cbind(f2,Population)

print(head(f2))

f3 <- f3[,c(1,2)]
Population <- rep("AMR", dim(f3)[1])
f3 <- cbind(f3,Population)

print(head(f3))
f4 <- f4[,c(1,2)]
Population <- rep("EAS", dim(f4)[1])
f4 <- cbind(f4,Population)

print(head(f4))
f5 <- f5[,c(1,2)]
Population <- rep("SAS", dim(f5)[1])
f5 <- cbind(f5,Population)
print(head(f5))

f_all <- rbind(f1,f2,f3,f4,f5)

outfile <- sprintf("PheRSScore_density_Raw_PRS_score_%s.pdf",args[2])
pdf(outfile)


p2 <- ggplot(data=f_all, aes(x=SCORE1_SUM, group=Population, fill=Population)) +
    geom_density(adjust=1.5, alpha=.4) +
    labs(title="",x="Genome-wide polygenic score", y = "Density") +
    theme_classic()
p2


dev.off()

#####

f1 <- f[which(f$pop=="EUR"),]

f2 <- f[which(f$pop=="AFR"),]

f3 <- f[which(f$pop=="AMR"),]


f4 <- f[which(f$pop=="EAS"),]

f5 <- f[which(f$pop=="SAS"),]


f1 <- f1[,c(1,14)]
Population <- rep("EUR", dim(f1)[1])
f1 <- cbind(f1,Population)

f2 <- f2[,c(1,14)]
Population <- rep("AFR",dim(f2)[1])
f2 <- cbind(f2,Population)


f3 <- f3[,c(1,14)]
Population <- rep("AMR", dim(f3)[1])
f3 <- cbind(f3,Population)

f4 <- f4[,c(1,14)]
Population <- rep("EAS", dim(f4)[1])
f4 <- cbind(f4,Population)

f5 <- f5[,c(1,14)]
Population <- rep("SAS", dim(f5)[1])
f5 <- cbind(f5,Population)

f_all <- rbind(f1,f2,f3,f4,f5)



outfile <- sprintf("PheRSScore_density_adjusted_score_%s.pdf",args[2])
pdf(outfile)


p2 <- ggplot(data=f_all, aes(x=adjusted_score, group=Population, fill=Population)) +
    geom_density(adjust=1.5, alpha=.4) +
    labs(title="",x="Genome-wide polygenic score", y = "Density") +
    theme_classic()
p2
dev.off()

