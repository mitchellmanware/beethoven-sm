################################################################################
# Generate all dates in date range.

################################################################################
chr_dates <- amadeus::generate_date_sequence(
  date_start = snakemake@params[["start"]],
  date_end = snakemake@params[["end"]],
  sub_hyphen = FALSE
)

################################################################################
# OUT output/chr_dates.qs
qs2::qs_save(chr_dates, snakemake@output[["chr_dates"]])
