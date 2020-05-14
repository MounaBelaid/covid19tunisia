#---------------------------
# Code to update NY Times Datasets
#---------------------------

setwd(here::here())
source("./R/refresh_YOURPACKAGENAME.R")

YOURPACKAGENAME_demo <- refresh_YOURPACKAGENAME()

#check it
head(YOURPACKAGENAME_demo)

#test with testthat

#deploy data
usethis::use_data(YOURPACKAGENAME_demo, overwrite = TRUE)
