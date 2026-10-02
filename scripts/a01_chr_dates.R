################################################################################
# Generate all dates in date range.

################################################################################
chr_dates <- seq(
  as.Date(snakemake@params[["start"]]),
  as.Date(snakemake@params[["end"]]),
  by = "day"
)

################################################################################
# OUT output/chr_dates.txt
writeLines(chr_dates, snakemake@output[["chr_dates"]])
