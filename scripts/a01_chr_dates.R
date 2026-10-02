################################################################################
# Generate all dates in date range.

################################################################################
chr_dates <- amadeus::generate_date_sequence(
  start = snakemake@params[["start"]],
  end = snakemake@params[["end"]],
  subhyphen = FALSE
)

################################################################################
# OUT output/chr_dates.txt
writeLines(chr_dates, snakemake@output[["chr_dates"]])
