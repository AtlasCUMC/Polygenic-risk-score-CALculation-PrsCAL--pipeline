#!/usr/bin/env python

import time

now = time.strftime("%c")

print ("********************************************************************* \n* Atlas Khan\n* Kiryluk Lab (http://www.columbiamedicine.org/divisions/kiryluk/) \n* Prs CALculation Tool (PrsCAL)\n* Version 1.0.0 \n* (C) 2021 Nephrology Dept of Medicine \n* Columbia University Medical Center\n *********************************************************************")
start_time = time.time()

import sys, argparse, os
import subprocess


prog_name = 'PrsCAL.v1.1.py'



def main():
    parser = argparse.ArgumentParser(description='The PrsCAL is a computational tool for calculation of polygenic score:', prog = prog_name)
    parser.add_argument('-bf', '--bf',  required = False, default=None, metavar = 'The plink bed/bim/fam format data', type = str, help ='The genotype data for PRS calucation in plink bed/bim/fam format')
    parser.add_argument('-Method', '--Method',  required = False, default=None, metavar = 'ldpred/p+t/stat', type = str, help ='For PRS calcualtion and summary statistics: Should be give ldpred or p+t or stat')
    parser.add_argument('-out', '--out', required = False, default='PrsCAL_output', metavar = 'Output file name', type = str, help ='The name of output file')
    parser.add_argument('-rf', '--rf', required = False, default=None, metavar = 'PRS equation file', type = str, help ='PRS equation file from ldpred Step 1 and Step2, please see LDpred webiste for details')
    
    parser.add_argument('-PRS', '--PRS',required = False, default=None, metavar = 'PRS file names from First Step PrsCAL', type=str, help ='PRS file name with two columns: Column 1=IID and Columna PRS')
    parser.add_argument('-PCA', '--PCA', required=False, default=None, metavar = 'PCA file', type=str, help ='PCA file should contain IID, PC1, PC2, PC3, PC4, or more, Sex, Age and T2DM. Currently PrsCAL only adjust for these covariates')
    parser.add_argument('-Pheno', '--Pheno',required=False,default=None, metavar = 'Phenotype file with two columns', type=str, help ='Phenotype file with two columns: IID and pheno, for CASE=1 and Control=0')

    args = parser.parse_args()
    bf=args.bf
    out=args.out
    rf=args.rf
    Method=args.Method
    PRS=args.PRS
    PCA=args.PCA
    Pheno=args.Pheno

#########
    try: 
        if Method == None:
            print ("PrsCAL begin the analysis at %s"  % now )
            os.system('''python PrsCAL.v1.1.py --help''')
            sys.exit()
    except IOError:
            print "NOTICE: The Method argument is required such as ldpred/p+t/stat"
            os.system('''python PrsCAL.v1.1.py --help''')
            sys.exit()
#######


    if (Method=="ldpred"):
        print ("PrsCAl using ldpred method for PRS calculation")
        def ldpred_score(bf,rf,out):
            os.system(''' ldpred score --gf '''+bf+''' --rf '''+rf+''' --out '''+out+''' --only-score --rf-format LDPRED ''')
        ldpred_score(bf,rf,out)
        
    elif (Method=="p+t"):
        print ("NOTICE: PrsCAl using p+t method for PRS calculation")
        def ldpred_score(bf,rf,out):
            os.system('''ldpred score --gf '''+bf+'''  --rf '''+rf+''' --out '''+out+''' --only-score --rf-format P+T ''')
        ldpred_score(bf,rf,out)
    
    elif (Method=="stat"):
        print ("NOTICE: PrsCAl doing the statistical analysis")

        def ldpred_score(PRS,Pheno,PCA,out):
            command = 'Rscript'
            path2script='make_file_bin.v1.R'
            args1=PRS
            args2=Pheno
            args3=PCA
            args4=out

            cmd=[command,path2script,args1,args2,args3,args4]
            subprocess.call(cmd,universal_newlines=True)
            
            #######

            command = 'Rscript'
            path2script='PRS_ROC.v1.R'

            args1='''PRS_Bins_qunatiles_'''+out+''''''
            args2='''PRS_ROC_'''+out+''''''

            cmd=[command,path2script,args1,args2]
            subprocess.call(cmd,universal_newlines=True)
            #os.system('''Rscript PRS_ROC.v4.R PRS_Bins_qunatiles_'''+out+''' PRS_ROC_'''+out+''' 1 1 ''')
            
            ######### Top Percentyile####

            os.system('''bash TOP_OR.v1.sh PRS_Bins_qunatiles_'''+out+''' '''+out+'''_Top20 20 19 18 17 ''')
            os.system('''bash TOP_OR.v1.sh PRS_Bins_qunatiles_'''+out+''' '''+out+'''_Top10 20 19 ''')
            os.system('''bash TOP_OR.v1.sh PRS_Bins_qunatiles_'''+out+''' '''+out+'''_Top5 20 20 ''')
            os.system('''bash TOP_OR.v1.sh PRS_Bins_qunatiles_'''+out+''' '''+out+'''_Top2 100 99 100 100 100 100 ''')
            os.system('''bash TOP_OR.v1.sh PRS_Bins_qunatiles_'''+out+''' '''+out+'''_Top1 100 ''')

        ldpred_score(PRS,Pheno,PCA,out)     
    else:
        print (" Notice: Please choose the right model/analysis step")
        os.system('''python PrsCAL.v1.1.py --help''')
        sys.exit()

if __name__ == '__main__':
    main()

print (" NOTICE: PrsCAL finished analysis at %s"  % now )
print("--- %s seconds ---" % (time.time() - start_time))
print ("____________ Good bye ______________")
