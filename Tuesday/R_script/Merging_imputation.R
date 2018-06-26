rm(list=ls())


# source("https://bioconductor.org/biocLite.R")
# biocLite("pcaMethods")

library(pcaMethods)
library(imputeLCMD)
library(impute)
library(dplyr)


##### Load the data

covar=read.table('Covariates.txt', sep='\t')
expo=read.table('Exposures.txt', sep='\t')
methyl=readRDS('Methylation.rds')
metab=read.table('Metabolites.txt', sep='\t')
proteins=read.table('Proteins.txt', sep='\t')
transcripts=readRDS('Transcripts.rds')


##### Merge covariates and exposures

covar_expo=merge(covar, expo, by='subjectidp')
rownames(covar_expo)=covar_expo$subjectidp


##### Remove elements with "C" (just using A and B observations)

covar_expo<-covar_expo[substr(rownames(covar_expo),4,4)%in%c('A','B'),]
methyl <- methyl[substr(rownames(methyl),4,4)%in%c('A','B'),]
metab <- metab[substr(rownames(metab),4,4)%in%c('A','B'),]
proteins <- proteins[substr(rownames(proteins),4,4)%in%c('A','B'),]
transcripts <- transcripts[substr(rownames(transcripts),4,4)%in%c('A','B'),]


##### Create the folder where the files will be

dir.create('Merged_datasets')


############### Methylation ###############

methyl=methyl[,1:1000] # example script on a small subset


##### Check the proportions of missing values

missingbyrow=apply(methyl, 1, FUN=function(x){sum(is.na(x))})/ncol(methyl)
missingbycol=apply(methyl, 2, FUN=function(x){sum(is.na(x))})/nrow(methyl)
methyl=methyl[missingbyrow<0.2, missingbycol<0.2] # remove rows and columns with more than 20% missing


##### M-value transformation

methyl_transformed=log2(methyl/(1-methyl))


##### Methylation imputation

methyl_imputed=impute.QRILC(methyl_transformed)
methyl_imputed <- as.data.frame(methyl_imputed[[1]])


##### Merging with covariates and exposures

methyl_merged=merge(covar_expo, methyl_imputed, by='row.names')
rownames(methyl_merged)=methyl_merged$subjectidp
saveRDS(methyl_merged, 'Merged_datasets/Merged_methylation.rds')


############### Metabolites ###############

##### Check the proportions of missing values

missingbyrow=apply(metab, 1, FUN=function(x){sum(is.na(x))})/ncol(metab)

hist(missingbyrow, col='navy', border='white', las=1,
     main='Histogram of missing values by obs.')
# all obs. are kept, they are all below 55%

missingbycol=apply(metab, 2, FUN=function(x){sum(is.na(x))})/nrow(metab)
metab=metab[, missingbycol<0.4] 
# columns with more than 40% missing
# missing values in metabolites are sometimes "non-detected" values (too small values)

##### log-transformation

metab_transformed=log(metab)

##### Imputation

### Using the imputeLCMD package:

metab_imputed=impute.QRILC(metab_transformed)
metab_imputed <- as.data.frame(metab_imputed[[1]])

### Using knn imputation:

#metab_imputed=impute.knn(as.matrix(metab_transformed))$data

##### Merging with covariates and exposures

metab_merged=merge(covar_expo, metab_imputed, by='row.names')
rownames(metab_merged)=metab_merged$subjectidp
saveRDS(metab_merged, 'Merged_datasets/Merged_metabolites.rds')


############### Transcripts ###############

##### Check missing values

sum(is.na(transcripts))
# no NA in the data, data has already been imputed
# data has already been log-transformed too


##### Merging with covariates and exposures

transcripts_merged=merge(covar_expo, transcripts, by='row.names')
rownames(transcripts_merged)=transcripts_merged$subjectidp
saveRDS(transcripts_merged, 'Merged_datasets/Merged_transcripts.rds')


############### Proteins ###############

##### Log-transformation of the proteins

proteins=log(proteins)


##### Merging with covariates and exposures

proteins_merged=merge(covar_expo, proteins, by='row.names')
rownames(proteins_merged)=proteins_merged$subjectidp
saveRDS(proteins_merged, 'Merged_datasets/Merged_proteins.rds')



