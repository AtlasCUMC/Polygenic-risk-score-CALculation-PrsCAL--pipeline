# Polygenic-risk-score-CALculation-PrsCAL-pipeline


Polygenic risk score CALculation (PrsCAL) is polygenic score calculation pipeline based on LDpred (https://github.com/bvilhjal/ldpred). PrsCAL can be used only for the Step 3 of LDpred. For Step 1 and 2 please use LDpred and the details are here (https://github.com/bvilhjal/ldpred).

PrsCAL using various R scripts to calculate all summary statistics for PRS.

# Useful links

LDpred (https://github.com/bvilhjal/ldpred)

# Usage

First download the PrsCAL from our github page:

git clone https://github.com/AtlasCUMC/Polygenic-risk-score-CALculation-PrsCAL--pipeline

then 

cd Polygenic-risk-score-CALculation-PrsCAL--pipeline

python PrsCAL.v1.1.py --help 

********************************************************************* 
* Atlas Khan
* Kiryluk Lab (http://www.columbiamedicine.org/divisions/kiryluk/) 
* Prs CALculation Tool (PrsCAL)
* Version 1.0.0 
* (C) 2021 Nephrology Dept of Medicine 
* Columbia University Medical Center
 *********************************************************************
usage: PrsCAL.v1.1.py [-h] [-bf The plink bed/bim/fam format data]
                      [-Method ldpred/p+t/stat] [-out Output file name]
                      [-rf PRS equation file]
                      [-PRS PRS file names from First Step PrsCAL]
                      [-PCA The frq file for each of the CHR]
                      [-Pheno Phenotype file with two columns]

The PrsCAL is a computational tool for calculation of polygenic score:

optional arguments:

  -h, --help            show this help message and exit
  
  -bf The plink bed/bim/fam format data, --bf The plink bed/bim/fam format data
                        The genotype data for PRS calucation in plink
                        bed/bim/fam format
                        
  -Method ldpred/p+t/stat, --Method ldpred/p+t/stat
                        For PRS calcualtion and summary statistics: Should be
                        give ldpred or p+t or stat
                        
  -out Output file name, --out Output file name
                        The name of output file
                        
  -rf PRS equation file, --rf PRS equation file
                        PRS equation file from ldpred Step 1 and Step2, please
                        see LDpred webiste for details
                        
  -PRS PRS file names from First Step PrsCAL, --PRS PRS file names from First Step PrsCAL
                        PRS file name with two columns: Column 1=IID and
                        Columna PRS
                        
-PCA PCA file, --PCA PCA file
                        PCA file should contain IID, PC1, PC2, PC3, PC4, or
                        more, Sex, Age and T2DM. Currently PrsCAL only adjust
                        for these covariates
                        
  -Pheno Phenotype file with two columns, --Pheno Phenotype file with two columns
                        Phenotype file with two columns: IID and pheno, for
                        CASE=1 and Control=0

                        

Currently PrsCAL has two functions:

1. PrsCAL can be used to calculate PRS for equation you get from first Two Steps from LDpred

2. PrsCAL can be also used for PRS summary statistics such odds ratios per statdation divitions, p-values, area under curve, percentile, such as Top 20% vs 80% percent etc.....



# Step 1. PrsCAL calculation 

This Step can be do only one time 1.

Example:
##
python PrsCAL.v1.1.py  -Method p+t (or ldpred) -bf PLINK_format -rf TEST (p+t or ldpred)  -out TEST

#####
# Step 2. PrsCAL calculation

When run Step 1 or already you run the Step 1, PrsCAL can be used to caclulcate all summary statistics for PRS

### 1. Not adjusted for Site

python PrsCAL.v1.1.py  -Method stat -PRS TEST (get from PrsCAL step 1)  -Pheno Phenotype file with two columns (IID, PRS; seprated by commas) -PCA PCA file (With columns, PC1 PC2 PC3 PC4, or more, Age, Sex; Seprated by tab)

### 1. Adjusted for Site

python PrsCAL.v1.2.py  -Method stat -PRS TEST (get from PrsCAL step 1)  -Pheno Phenotype file with two columns (IID, PRS; seprated by commas) -PCA PCA file (With columns, PC1, PC2, PC3, PC4, or more, Age, Sex, Site; Seprated by tab)



### Author

Atlas Khan, Kiryluk Lab, Department of Medicine (Division Nephrology),Columbia University Medical Centre, New York, USA.

Email: ak4046@cumc.columbia.edu and atlas.akhan@gmail.com










