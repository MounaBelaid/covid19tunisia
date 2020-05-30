raw_cols <-
  c(
    "date",
    "location",
    "location_type",
    "location_code",
    "location_code_type",
    "data_type",
    "value")

test_that("original cols we care about are still there", {
  raw <- readr::read_csv(
    url
  )

  expect_length(
    setdiff(raw_cols, names(raw)),
    0L
  )
})


