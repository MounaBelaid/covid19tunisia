#' ----------------------------------------
#' Script to startup the a YOUR_PKG_NAME package
#' using usethis
#' ----------------------------------------

library(usethis)

# create_tidy_package(glue::glue"{here::here()/../PKGNAME})

# setup package
use_code_of_conduct()
use_data_raw()
# use_LICENSE_FUNCTION()

# imports packages
use_package("magrittr")
use_package("tibble")
use_package("PKG_TO_IMPORT")

# suggests packages
use_package("PKG_TO_SUGGEST", type = "Suggests")


# add other elements
use_news_md()
use_vignette("VIGNETTE_FILENAME", "VIGNETTE TITLE")


#-----------------------------
# Cleanup before release ####
#-----------------------------

# tweaks to the description before release
use_tidy_description()
use_tidy_versions()

# Are there things you should cleanup in this package?
styler::style_dir("R")
styler::style_dir("data-raw") #can comment out if not including local data
goodpractice::gp()

# make a pkgdown website!
pkgdown::build_site()

# for release - checks!
devtools::check_win_release()
devtools::release_checks()
devtools::spell_check()
devtools::check_rhub()

#-------------
# Release ####
#-------------
devtools::release()