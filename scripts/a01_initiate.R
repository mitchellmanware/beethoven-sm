################################################################################
# Derive all time-related objects from initial date range definition.
# --1 chr_dates
# --2 chr_years
# --3 list_dates
# --4 list_dates_julian

################################################################################
# Load libraries and source local functions.
library(amadeus)
source("R/imports.R")

################################################################################
# Import configured variables and inputs.
chr_datestart <- snakemake@params[["start"]]
chr_dateend <- snakemake@params[["end"]]

################################################################################
# Full date range as dates.
chr_dates <- amadeus::generate_date_sequence(
  date_start = chr_datestart,
  date_end = chr_dateend,
  sub_hyphen = FALSE
)

# All included years as integers.
int_years <- unique(lubridate::year(chr_dates))

# Chunks of 100 sequential dates for parallelization. Chunks include only dates
# within the same year to adhere to {amadeus::download_modis} requirements.
list_dates <- split_dates(
  dates = c(chr_dates[1], chr_dates[length(chr_dates)]),
  n = 100,
  year = TRUE
)

# Chunks of 100 sequential dates in Julian format (YYYYJJJ)
list_dates_julian <- lapply(list_dates, function(x) format(as.Date(x), "%Y%j"))

################################################################################
qs2::qs_save(chr_dates, snakemake@output[["chr_dates"]])
qs2::qs_save(int_years, snakemake@output[["int_years"]])
qs2::qs_save(list_dates, snakemake@output[["list_dates"]])
qs2::qs_save(list_dates_julian, snakemake@output[["list_dates_julian"]])
