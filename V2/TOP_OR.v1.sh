#!/bin/bash	
f1="$1" #Input
f2="$2" ##Out

f3="$3" ##Percentage of the data
f4="$4" #top 20
f5="$5"
f6="$6"
f7="$7"

if [[ $# -eq 6 ]]
  then
   echo  "NOTICE: OR for Top 20%:"
   echo -e id "\t" Age "\t"Sex "\t"PC1"\t"PC2"\t"PC3"\t"PC4"\t"PRS_ref"\t"PRS"\t"Pheno"\t" scoreBin "\t" T2DM > header
   sed 1d ${f1} | awk '{if ($12=='$f3' || $12=='$f4' || $12=='$f5' || $12=='$f6') print $1 "\t" $2 "\t" $3  "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" 1 "\t" $8 "\t" $11 "\t" $12 "\t" $14}' > ${f2}_temp1
   sed 1d ${f1} | awk '{if ($12!='$f3'&& $12!='$f4' && $12!='$f5' && $12!='$f6') print $1 "\t" $2 "\t" $3  "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" 0 "\t" $8 "\t" $11 "\t" $12 "\t" $14 }'  > ${f2}_temp2
   cat header ${f2}_temp1 ${f2}_temp2  > Final_${f2}
   rm ${f2}_temp1 ${f2}_temp2  header

   Rscript PRS_OR.v1.R Final_${f2} Final_${f2} 0.80

   #For top 5 should be used two 20 20

  elif [[ $# -eq 5 ]]
  then
   echo  "NOTICE: OR for Top 15%:"
   echo -e id "\t" Age "\t"Sex"\t"PC1"\t"PC2"\t"PC3"\t"PC4"\t"PRS_ref"\t"PRS"\t"Pheno"\t" scoreBin "\t" T2DM > header
   sed 1d ${f1} | awk '{if ($12=='$f3' || $12=='$f4' || $12=='$f5') print $1 "\t" $2 "\t" $3  "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" 1 "\t" $8 "\t" $11 "\t" $12 "\t" $14 }' > ${f2}_temp1
   sed 1d ${f1} | awk '{if ($12!='$f3'&& $12!='$f4' && $12!='$f5') print $1 "\t" $2 "\t" $3  "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" 0 "\t" $8 "\t" $11 "\t" $13 "\t" $14  }'  > ${f2}_temp2
   cat header ${f2}_temp1 ${f2}_temp2  > Final_${f2}
   rm ${f2}_temp1 ${f2}_temp2  header

   Rscript PRS_OR.v1.R Final_${f2} Final_${f2}

   elif [[ $# -eq 7 ]]
  then
   echo  "NOTICE: OR for Top 25%:"
   echo -e id "\t" Age "\t"Sex"\t"PC1"\t"PC2"\t"PC3"\t"PC4"\t"PRS_ref"\t"PRS"\t"Pheno"\t" scoreBin "\t" T2DM  > header
   sed 1d ${f1} | awk '{if ($12=='$f3' || $12=='$f4' || $12=='$f5' || $12=='$f6' || $12=='$f7') print $1 "\t" $2 "\t" $3 "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" 1 "\t" $8 "\t" $11 "\t" $12 "\t" $14 }' > ${f2}_temp1
   sed 1d ${f1} | awk '{if ($12!='$f3' && $12!='$f4' && $12!='$f5' && $12!='$f6' && $12!='$f7') print $1 "\t" $2 "\t" $3  "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" 0 "\t" $8 "\t" $11 "\t" $12 "\t" $14  }'  > ${f2}_temp2
   cat header ${f2}_temp1 ${f2}_temp2  > Final_${f2}
   rm ${f2}_temp1 ${f2}_temp2  header

   Rscript PRS_OR.v1.R Final_${f2} Final_${f2}




elif [[ $# -eq 4 ]]
  then
	 echo  "NOTICE: OR for Top 10% should be 20 19 and for top 5% should be 20 20:"
   echo -e id "\t" Age "\t"Sex"\t"PC1"\t"PC2"\t"PC3"\t"PC4"\t"PRS_ref"\t"PRS"\t"Pheno"\t" scoreBin "\t" T2DM > header
   sed 1d ${f1} | awk '{if ($12=='$f3' || $12=='$f4') print $1 "\t" $2 "\t" $3  "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" 1 "\t" $8 "\t" $11 "\t" $12  "\t" $14 }' > ${f2}_temp1
   sed 1d ${f1} | awk '{if ($12!='$f3'&& $12!='$f4' ) print $1 "\t" $2 "\t" $3  "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" 0 "\t" $8 "\t" $11 "\t" $12  "\t" $14 }'  > ${f2}_temp2
   cat header ${f2}_temp1 ${f2}_temp2  > Final_${f2}
   rm ${f2}_temp1 ${f2}_temp2  header
   Rscript PRS_OR.v1.R Final_${f2} Final_${f2} 0.90

elif [[ $# -eq 3 ]]
  then
	  echo "NOTICE: OR for Top 1%:"
   echo -e id "\t" Age "\t"Sex"\t"PC1"\t"PC2"\t"PC3"\t"PC4"\t"PRS_ref"\t"PRS"\t"Pheno"\t" scoreBin "\t" T2DM  > header
   sed 1d ${f1} | awk '{if ($13=='$f3') print $1 "\t" $2 "\t" $3  "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" 1 "\t" $8 "\t" $11  "\t" $13 "\t" $14 }' > ${f2}_temp1
   sed 1d ${f1} | awk '{if ($13!='$f3') print $1 "\t" $2 "\t" $3  "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" 0 "\t" $8 "\t" $11  "\t" $13 "\t" $14 }'  > ${f2}_temp2
   cat header ${f2}_temp1 ${f2}_temp2  > Final_${f2}
   rm ${f2}_temp1 ${f2}_temp2  header
  Rscript PRS_OR.v1.R Final_${f2} Final_${f2} 0.99

elif [[ $# -eq 8 ]]
  then
          echo "NOTICE: OR for Top 2%:"

   echo -e id "\t" Age "\t"Sex"\t"PC1"\t"PC2"\t"PC3"\t"PC4"\t"PRS_ref"\t"PRS"\t"Pheno"\t" scoreBin "\t" T2DM  > header
   sed 1d ${f1} | awk '{if ($13=='$f3' || $13=='$f4') print $1 "\t" $2 "\t" $3  "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" 1 "\t" $8 "\t" $11  "\t" $13 "\t" $14}' > ${f2}_temp1
   sed 1d ${f1} | awk '{if ($13!='$f3' && $13!='$f4') print $1 "\t" $2 "\t" $3  "\t" $4 "\t" $5 "\t" $6 "\t" $7 "\t" 0 "\t" $8 "\t" $11  "\t" $13 "\t" $14 }'  > ${f2}_temp2
   cat header ${f2}_temp1 ${f2}_temp2  > Final_${f2}
   rm ${f2}_temp1 ${f2}_temp2  header
  Rscript PRS_OR.v1.R Final_${f2} Final_${f2} 0.98

else
 echo  "Test not done well"
fi

