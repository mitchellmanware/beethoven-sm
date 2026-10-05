################################################################################
# Calculate NARR covariates at AQS model fitting locations.

################################################################################
# Load libraries and source local functions.
library(amadeus)
source("R/imports.R")

################################################################################
# Import configured variables and inputs.
chr_dir <- snakemake@params[["chr_dir"]]
int_years <- qs2::qs_read(snakemake@input[["int_years"]])

################################################################################
# Define NARR variables of interest to be included.
chr_iter_narr <- c("air.sfc")

################################################################################
# Download NARR data (.nc files) for all variables across all temporal range.
list_narr <- amadeus::download_narr(
  variables = chr_iter_narr,
  directory_to_save = file.path(chr_dir, "narr"),
  year = int_years,
  acknowledgement = TRUE,
  hash = FALSE
)
print(list_narr)

################################################################################
qs2::qs_save(list_narr, snakemake@output[["list_narr"]])
