################################################################################
# Placeholder script for collecting download lists.

################################################################################
# Load libraries and source local functions.
library(amadeus)

################################################################################
# Import download lists.
list_aqs <- qs2::qs_read(snakemake@input[["list_aqs"]])
list_narr <- qs2::qs_read(snakemake@input[["list_narr"]])
list_hms <- qs2::qs_read(snakemake@input[["list_hms"]])

################################################################################
list_collect <- list(
  aqs = list_aqs,
  narr = list_narr,
  hms = list_hms
)

################################################################################
qs2::qs_save(list_collect, snakemake@output[["list_collect"]])
