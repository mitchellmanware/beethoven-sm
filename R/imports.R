################################################################################
# Manually define {beethoven} functions to limit .sif time (temporary).
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
    lapply(dates_split, function(x) format(as.Date(x), "%Y%j"))
  } else {
    dates_split
  }
}

fl_dates <- function(
  dates
) {
  first <- dates[1]
  last <- dates[length(dates)]
  c(first, last)
}
