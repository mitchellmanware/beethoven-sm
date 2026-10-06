################################################################################
# Download NARR data (.nc files) for all variables and all years.

################################################################################
# Load libraries and source local functions.
library(amadeus)

################################################################################
# Import configured variables and inputs.
chr_config_dir <- snakemake@params[["chr_config_dir"]]
int_init_years <- qs2::qs_read(snakemake@input[["int_init_years"]])

################################################################################
# Define NARR variables of interest to be included.
chr_iter_narr <- c("air.sfc", "weasd")

################################################################################
list_dl_narr <- amadeus::download_data(
  dataset_name = "narr",
  variables = chr_iter_narr,
  directory_to_save = file.path(chr_config_dir, "narr"),
  year = int_init_years,
  acknowledgement = TRUE,
  hash = FALSE
)

################################################################################
qs2::qs_save(chr_iter_narr, snakemake@output[["chr_iter_narr"]])
qs2::qs_save(list_dl_narr, snakemake@output[["list_dl_narr"]])
