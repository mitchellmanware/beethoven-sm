################################################################################
# Download HMS data (.shp files) for all dates.

################################################################################
# Load libraries and source local functions.
library(amadeus)
source("R/imports.R")

################################################################################
# Import configured variables and inputs.
chr_dir <- snakemake@params[["chr_dir"]]
chr_dates <- qs2::qs_read(snakemake@input[["chr_dates"]])

################################################################################
list_dl_hms <- amadeus::download_data(
  dataset_name = "hms",
  directory_to_save = file.path(chr_dir, "hms"),
  date = fl_dates(chr_dates),
  acknowledgement = TRUE,
  hash = FALSE,
  remove_zip = FALSE
)

################################################################################
qs2::qs_save(list_dl_hms, snakemake@output[["list_dl_hms"]])
