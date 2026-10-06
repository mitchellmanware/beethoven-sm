################################################################################
# Download AQS data (.csv files) for all dates.

################################################################################
# Load libraries and source local functions.
library(amadeus)

################################################################################
# Import configured variables and inputs.
chr_dir <- snakemake@params[["chr_dir"]]
int_years <- qs2::qs_read(snakemake@input[["int_years"]])

################################################################################
list_aqs <- amadeus::download_data(
  dataset_name = "aqs",
  directory_to_save = file.path(chr_dir, "aqs"),
  year = int_years,
  acknowledgement = TRUE,
  hash = FALSE,
  remove_zip = FALSE
)

################################################################################
qs2::qs_save(list_aqs, snakemake@output[["list_aqs"]])
