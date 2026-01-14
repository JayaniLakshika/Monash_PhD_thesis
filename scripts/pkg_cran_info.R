## This script is to obtain CRAN information

library(flextable)
library(officer)
library(dplyr)
library(pkgmeta) ## install.packages("pak") ## pak::pak("robjhyndman/pkgmeta")
library(lubridate)

# Functions for getting downloads
find_cran_packages <- function(name) {
  pkgsearch::ps(name, size = 100) |>
    filter(purrr::map_lgl(
      package_data, ~ grepl(name, .x$Author, fixed = TRUE)
    )) |>
    select(package) |>
    pull(package)
}

# Monthly download counts from packages in <x>
cran_downloads <- function(x) {
  # Compute monthly download counts
  down <- cranlogs::cran_downloads(x, from = "2020-01-01") |>
    as_tibble() |>
    mutate(month = tsibble::yearmonth(date)) |>
    group_by(month) |>
    summarise(count = sum(count), package = x)
  # Strip out initial zeros
  first_nonzero <- down |>
    filter(count > 0) |>
    head(1)
  if (NROW(first_nonzero) > 0) {
    filter(down, month >= first_nonzero$month)
  } else {
    first_nonzero
  }
}

packages <- c(
  find_cran_packages("Jayani P.G. Lakshika"),
  find_cran_packages("Jayani P. Gamage")
)

pkg_data <- pkgmeta:::get_meta_cran(packages,
                                    include_downloads=TRUE) |>
  rename(released = first_download, last_update = date)

