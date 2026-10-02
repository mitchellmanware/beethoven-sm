################################################################################
# Derive all time-related objects from initial date range definition.
# --1 chr_dates
# --2 chr_years
# --3 list_dates
# --4 list_dates_julian

################################################################################
# Manually define {beethoven} function to limit .sif time (temporary).
split_dates <- function(
  dates,
  n,
  year = TRUE,
  julian = FALSE
) {
  dates_full <- amadeus::generate_date_sequence(
    dates[1],
    dates[2],
    sub_hyphen = FALSE
  )

  if (year) {
    u_years <- unique(substr(dates_full, 1, 4))
    list_split <- lapply(
      u_years,
      function(year) {
        dates_year <- grep(year, dates_full, value = TRUE)
        base::split(
          dates_year,
          ceiling(seq_along(dates_year) / n)
        )
      }
    )
    dates_split <- do.call(c, list_split)
    names(dates_split) <- seq(1, length(dates_split), 1)
  } else {
    dates_split <- base::split(
      dates_full,
      ceiling(seq_along(dates_full) / n)
    )
  }

  if (julian) {
    dates_julian <- lapply(dates_split, function(x) format(as.Date(x), "%Y%j"))
  } else {
    dates_julian <- dates_split
  }

  return(dates_julian)
}

################################################################################
# Full date range as dates.
chr_dates <- amadeus::generate_date_sequence(
  date_start = snakemake@params[["start"]],
  date_end = snakemake@params[["end"]],
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
