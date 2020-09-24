# DSM_Regional_modeling
The scripts in this repository were used to test ideas about modeling soil depth classes by eco-physiographic region and then ensemble regional models. 

Files are as follows: 

CovariatePrep.bat - windows batch file that processes each covariate to common resolution and extent. 

Geographic_area_division_12.13.19.R - Windows R file that splits a shapefile into geographic regions that are approximatley equal in area. 

UCRB make.regression.matrix 1.9.20.Rmd - Windows R markdown file that overlays training data on the covariates and extracts values. This was needed as a seperate file because it made it easier for me to organize, reproject, and harmonize each dataset as these datasets came from multiple, different sources. 

UCRB model.by.area 3.6.20.Rmd - Windows R markdown file (extensively commented) that implements regional modeling. 


