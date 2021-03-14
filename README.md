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
usage: PrsCAL.v1.1.py [-h] [-bf The plink bed format data]
                      [-Method ldpred or p+t]
                      [-out Define the name of output file]
                      [-rf PRS equation file] [-PRS File name of PRS file]
                      [-PCA The frq file for each of the CHR]
                      [-Pheno Phenotype file with two columns]

The PrsCAl is computational tool for genetic correlation and hertiability
score estimation:

optional arguments:

  -h, --help            show this help message and exit
  
  -bf The plink bed format data, --bf The plink bed format data
                        The genotype data for PRS calucation in plink
                        bed/bin/fam format
                        
  -Method ldpred or p+t, --Method ldpred or p+t
                        For PRS calcualtion should be give ldpred or p+t
                        
  -out Define the name of output file, --out Define the name of output file
                        The name of output file
                        
  -rf PRS equation file, --rf PRS equation file
                        The summary statistics file from ldpred first step
                        
  -PRS File name of PRS file, --PRS File name of PRS file
                        File name of PRS file
                        
  -PCA The frq file for each of the CHR, --PCA The frq file for each of the CHR
                        PCA file should contain IID, PC1, PC2, PC3, PC4, or
                        more, Sex, Age and T2DM
                        
  -Pheno Phenotype file with two columns, --Pheno Phenotype file with two columns
                        Phenotype file with two columns: IID and pheno
                        
                        


