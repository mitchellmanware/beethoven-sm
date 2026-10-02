################################################################################
# Generate all dates in date range.

################################################################################
cat("R version:", R.version.string, "\n")
cat("amadeus version:", as.character(packageVersion("amadeus")), "\n")
cat("system:", Sys.info()[["nodename"]], "\n")

################################################################################
chr_dates <- amadeus::generate_date_sequence(
  date_start = snakemake@params[["start"]],
  date_end = snakemake@params[["end"]],
  sub_hyphen = FALSE
)

################################################################################
# OUT output/chr_dates.qs
qs2::qs_save(chr_dates, snakemake@output[["chr_dates"]])
