
<!-- README.md is generated from README.Rmd. Please edit that file -->

# (PART) Creating a Covid19R Package

# Building a New Data Package

So, you want to create an R data package if covid19 data for the
project? Great\! You’re welcome to create your own from scratch, or,
we’ve created a [package
template](https://github.com/Covid19R/covid19_package_template) for you
to use - particularly useful to first-time package creators\! For either
case, let’s go through the steps you’ll need to follow, including some
best practices, from start to letting us know it works, all the way to
CRAN submission\!\!

## Before your start:

  - Choose a dataset\! We’d advise just going with one for simplicity -
    particularly if this is your first time. If you’re interested in
    contributing, but don’t know where to start, we’re trying to keep
    track of data sources
    [here](https://github.com/Covid19R/covid19R/issues/1). Please feel
    free to add more sources here as well, if you know of some\!

  - Use [this package
    template](https://github.com/Covid19R/covid19_package_template) to
    create your own github repo or start a repo with a package you’re
    creating from scratch. You can create it under your own user
    account, or, contact us if you would like to start the repo in the
    covid19R organization by [filing an
    issue](https://github.com/Covid19R/covid19R/issues).

  - Regardles, file [an issue to let us and others know what you are
    working on](https://github.com/Covid19R/covid19R/issues) with the
    pre-made Start a new package template\! We want to support you,
    cheer you on, and provide any help you need\!

  - Keep a running documentation of
    [usethis](https://usethis.r-lib.org/index.html) calls that you use
    to create the library in
    [setupcode.R](https://github.com/Covid19R/covid19_package_template/blob/master/setupcode.R)

  - Take the steps listed here, and file an issue in your own repo,
    replacing each `-` with a `- [ ]` in order to create a checklist for
    creation and release\! Also, that way, you can use the actual readme
    portion of this file as your README.Rmd\!

## How should I divide the data?

You might be interested in making a package that brings in multiple
different data sets for a given area. Or, the data source you’re
accessing contains multiple different types of data, or data at
different levels of spatial organization. Should you deploy these as one
big long data set or multiple data sets.

There can be different reasons for taking either path. In general, we
advise you to think about, how will an end-user use a single data set?
Assume that they have minimal information about your dataset initially
(I mean, hopefully they won’t, but nuanced dataset details can be
difficult to grasp at first), but want to create a clean, clear,
accurate analysis or visualization. For example, the NY Times reports
both state and county level data and multiple data types. In
[covid19nytimes](https://github.com/Covid19R/covid19nytimes), we deploy
one state-level datas et and one county-level data set. This minimizes
confusion and possible mistakes (summing county-level data = state level
data, and if both were in one data set, mistakes could be made in
over-aggregating and getting 2X the number of cases). Within each data
set, however, multiple data types are reported, as they can be filtered
or shown together, even.

Other data sets will provide some more complexity. In the [JHU
data](https://github.com/Covid19R/coronavirus), for example, information
for some countries is reported at the Province level, and for some
countries, it’s at the country level. However, it’s **one** global
dataset, and so the whole set is returned together. However, the
`location_type` column clearly shows what is aggregated, what is not,
and using a simple `tidyr::separate()` country and province-level data
can be split for easier aggregation and display.

In essence, how the raw data is structured will inform you how to split
or not split the final tidy data.

## Packages to use to help yourself out

If this is your first time writing a package, there are a few packages
that will help you greatly to develop your package. I’ll also presume
you’re doing this within RStudio, which has a variety of tools to make
your lives easier in building and deploying packages.

  - [devtools](https://devtools.r-lib.org/): This package is written to
    help you write packages. Period. We’ll reference a variety of tools
    that it supplies.

  - [usethis](https://usethis.r-lib.org/index.html): This package has a
    variety of tools to setup elements of your package using standard
    techniques.

  - [testthat](https://testthat.r-lib.org/): This package will allow you
    to write tests and/or use the tests we are providing to ensure that
    your package will be compliant with the standards for the covid19R
    project.

  - [styler](https://styler.r-lib.org/): use this to make your code
    cleaner and more readable

  - [roxygen2](https://roxygen2.r-lib.org/): This is the package we’ll
    be using for all documentation.

## Files to edit on start:

OK, you’re ready and raring to go. We’re going to write this as if you
are using the
[template](https://github.com/Covid19R/covid19_package_template). Adapt
as needed if you are rolling your own.

  - .Rbuildignore: Sub in your r project name. Edit as needed.

  - DESCRIPTION: see all caps notes. For the LICENSE, see how the data
    is licensed. If it uses a [standard license for
    R](https://www.r-project.org/Licenses/), use \[the appropriate
    usethis license function\] to add to your description and put it in
    [setupcode.R](https://github.com/Covid19R/covid19_package_template/blob/master/setupcode.R).
    If not, keep the file LICENSE and edit the LICENSE file with either
    a link to the dataset license or the text of it.

## The meat of your task for the library

All packages in the covid19R have, at minimum, two functions. One
function returns all of the information about the dataset in the
package. The second function refreshes a dataset to the most current
version. If there are multiple datasets per package, only one of the
get\_info functions is needed. However, each dataset should have its own
refresh function. This is for two reasons. First, each dataset might
require different code to parse it. Second, the covid19R data harvesting
scripts use the names of your datasets to dynamically call the refresh
functions. Along the way, there are a few other R helper files to setup
in R.

  - R/utils.R - put helper functions that you don’t want exposed to the
    user here. Note, we’ve seeded it with what you need to get a pipe
    from magrittr, as, we’re assuming you’re likely going to use this.
    If you’re a base-R coder, feel free to delete it from here and move
    on (and remove from the imports in DESCRIPTION).

  - R/get\_info\_YOURPACKAGENAME - This function will return all of the
    salient info about each dataset that your package returns. We’ve set
    it up in the
    [template](https://github.com/Covid19R/covid19_package_template)
    using `tibble::tribble()` for ease of editing and adding new
    datasets (and imported tibble), but you are welcome to change this
    if you wish to reduce dependencies. The comments in the file lay out
    the information you need to provide, from dataset name to package
    name, to where the data comes from.

Three columns ask for info from our [controlled
vocabulary](https://covid19r.github.io/documentation/standardized-vocabulary.html)
- data types, location types, and spatial extent of dataset. If you have
multiple entries for any of these, separate entries by a comma. This
will make it easier for end-users to search through information about
all datasets and find yours\! If you have new types you need to add to
our controlled vocabulary, [file an
issue](https://github.com/Covid19R/covid19R/issues) with the appropriate
template, and we’ll add it\! We want to bring in all types of data\!

Remember, each dataset that your package provides needs one complete set
of information.

  - R/refresh\_YOURPACKAGENAME - This is where you put your package
    dataset refresh methods. It should return a tidy dataset in the
    format discussed below. In general, functions for individual
    datasets should be named `refresh_YOURPACKAGENAME()` if you have
    just one dataset in this package and
    `refresh_YOURPACKAGENAME_MOREINFO()` if you have more than one. For
    example, `refresh_covid19france()` is a good for a package named
    covid19france package, if it only have one dataset. In the
    covid19nytimes package, there are two datasets, so, there is a
    `refresh_covid19nytimes_states()` and
    `refresh_covid19nytimes_counties()` function.  
      
    Broadly, this function should scrape data from a source, and then
    reformat it into the Covid19R Project long format. In this format,
    every measurement is a single row. The minimal data specification
    for columns is as follows (and see also our
    [documentation](https://covid19r.github.io/documentation/data-format-standard.html)).
    You can have columns in addition to this (e.g., lat, long, race,
    sex, income, etc.), but you **must** include these in order to be a
    valid data set. We will test for them\!

  - date - The date in YYYY-MM-DD form

  - location - The name of the location as provided by the data source.
    Nested locations are combined and separated by a `,`, and can be
    split by `tidyr::separate()`, if you wish.

  - location\_type - The type of location using the covid19R controlled
    vocabulary. Nested locations are indicated by multiple location
    types being combined with a `_`

  - location\_code - A standardized location code using a national or
    international standard.  

  - location\_code\_type The type of standardized location code being
    used according to the covid19R controlled vocabulary.  

  - data\_type - the type of data in that given row.  

  - value - number of cases of each data type

For different types, we employ a standardized vocabulary which you must
conform to. See
[here](https://covid19r.github.io/documentation/standardized-vocabulary.html)
for documentation. If you have a data type, location type, or location
standard that we do not have, great\! We are always looking to expand\!
[Submit an issue](https://github.com/Covid19R/covid19R/issues) and
request that we add the new type\!

  - R/globals.R - As you edit your functions, you’ll have a lot of
    column names you’ll refer to. There are column names from our data
    standard. Column names for the dataset as your import and transform
    it. And perhaps more. In order to pass CRAN checks, these need to be
    declared as globals. Open up the `globals.R` file and add them.
    You’ll see we’ve already put in the standard columns as an
    example. If you have no idea what we’re talking about, do a build
    check, and you’ll see a number of global declaration errors. That’s
    what we’re talking about\!

## If you would like a local dataset to accompany this package

It is often helpful to have a demo dataset to work with for a new user,
rather than for them to have to refresh the whole thing. Also, sometimes
data source standard change, and you will want to compare the new
incoming data to what it previously looked like. For that reason, in the
`data-raw` directory, we have provided a file `DATASET.R` which you can
edit to use for each dataset you scrape to save a frozen version that
can be deployed with your package. As it will be static and not
updating, we recommend labelling it `*_demo`, as we have shown in the
example. This is not required, but recommended. If you are not going to
do this, feel free to delete the `data-raw` directory as well as
`R/data.R`.

## Documenting your functions and data

  - We have left roxygen2 skeletons \[in the template\]
    (<https://github.com/Covid19R/covid19_package_template>) for you
    with the main functions. Fill them out\! Make sure any additional
    public functions you generate are filled out as well\! If you have
    created a demo dataset, use the provided `R/data.R` file to document
    it.

  - Once your documentation is in place, build it using roxygen2 (or the
    dropdown in the RStudio Build tab). Fix any errors, and then
    continue\!

## Vignettes

  - We highly recommend writing a package vignette or two. We have
    included a line in the
    [setup.R](https://github.com/Covid19R/covid19_package_template/blob/master/setupcode.R)
    to get you going. Your vignette should introduce the dataset(s),
    what is in it/them, and provide a compelling visualization. Make
    sure that the visualization has a date on it so that anyone looking
    at it can see what it is current to.

## Tests

We have provided two example tests using `testthat` which provide bare
minimum checks in the directory `tests` and associated subdirectories.
Edit and use these to make sure whatever incoming data from your source
meets your expectations, particularly as you get this package ready to
push to the public. Run the tests using the Tests option in the Build
tab in RStudio.

## Files to edit and things to do for release to the public

  - Readme.Rmd: We have provided a skeleton of your readme within this
    file. Use it and fill it in as needed. Feel free to modify as you’d
    like.

  - News.md: Sub in your R project name for the first release

  - Make a [pkgdown](https://pkgdown.r-lib.org/) site\! This can be as
    simple as running `pkgdown::build_site()`, pushing the update, and
    making sure your repo settings are set to put up the website. Add
    the URL to your README and your github repo

  - Take a look at
    [setupcode.R](https://github.com/Covid19R/covid19_package_template/blob/master/setupcode.R)
    in the preparing for release section. We’ve included a number of
    checks for you to run to make sure the code follows best practices,
    is well styled, and for you to check against r-hub and other sources
    to make sure it works beyond just your computer\! These will help
    you have a much better package that is more likely to go through any
    release process faster - particularly if you submit to CRAN\!

## Making your package a part of the Covid19R Project

OK\! You’re there\! It works, and your build is more or less clean (at
least, only notes). Close your issue about developing a new package and…
[file a new issue to onboard this
package](https://github.com/Covid19R/covid19R/issues) with the
onboarding template\! We’ll take a look, test it out, and if it’s ready,
we’ll add it in\! Nice work\! (and if it’s not, we’ll help you fix it)

## Submitting to CRAN

  - Use RStudio to build check your package until there are no errors,
    warnings, or notes, even\! Run the suite of devtools checks provided
    in
    [setupcode.R](https://github.com/Covid19R/covid19_package_template/blob/master/setupcode.R).
    If you pass everything, use devtools to submit (it’s in the
    [setupcode](https://github.com/Covid19R/covid19_package_template/blob/master/setupcode.R)),
    as it will ask you additional questions.

  - Make sure your cran-comments.md file is up to date with info from
    your final check\!

-----

# YOUR\_PACKAGE\_NAME

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-orange.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN
status](https://www.r-pkg.org/badges/version/YOUR_PACKAGE)](https://CRAN.R-project.org/package=YOUR_PACKAGE)
[![Travis build
status](https://travis-ci.org/Covid19R/YOUR_PACKAGE.svg?branch=master)](https://travis-ci.org/USER_OR_ORG/YOUR_PACKAGE)
<!-- badges: end -->

The YOUR\_PACKAGE package harvests the data made freely available by the
XXX. See USEFUL\_URL\_ABOUT\_DATA for more.

## Installation

ONLY INCLUDE IF SUBMITTED TO/ON CRAN You can install the released
version of covid19nytimes from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("YOUR_PACKAGE")
```

Or the latest development version from
[github](https://github.com/USER_OR_ORG/YOUR_PACKAGE)

``` r
devtools::install_github("USER_OR_ORG/YOUR_PACKAGE")
```

## Data

The package has the data from XXXXXX. The package comes with static data
that was downloaded at the time of the last package update.

``` r
library(YOUR_LIBRARY_NAME)

head(DATA) %>% knitr::kable()
```

## Getting the Most Up to Date Data

To get the most updated data, run the following functions

## Columns

The data follows the [covid19R standard for tidy Covid-19
data](https://covid19r.github.io/documentation/data-format-standard.html).
The data columns are as follows:

  - date - The date in YYYY-MM-DD form
  - location - The name of the location as provided by the data source.
    Nested locations are combined and separated by a `,`, and can be
    split by `tidyr::separate()`, if you wish.
  - location\_type - The type of location using the [Covid19R Controlled
    Vocabulary](https://covid19r.github.io/documentation/standardized-vocabulary.html).
    Nested locations are indicated by multiple location types being
    combined with a `_`
  - location\_code - A standardized location code using a national or
    international standard. MORE HERE
  - location\_code\_type The type of standardized location code being
    used according to the covid19R controlled vocabulary. Here we use
    `XXX`
  - data\_type - the type of data in that given row from the [Covid19R
    Controlled
    Vocabulary](https://covid19r.github.io/documentation/standardized-vocabulary.html).
    What is here?
  - value - number of cases of each data type
  - OTHER COLUMNS - WHAT THEY MEAN

## Sample visualization
