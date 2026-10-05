########################################################################################
# Generate all dates in date range.
rule initiate:
    output:
        chr_dates="output/chr_dates.qs",
        int_years="output/int_years.qs",
        list_dates="output/list_dates.qs",
        list_dates_julian="output/list_dates_julian.qs"

    params:
        start=lambda wildcards: config["chr_daterange"]["start"],
        end=lambda wildcards: config["chr_daterange"]["end"],

    container:
        "container/sif/container_covariates.sif"

    script:
        "../scripts/a01_initiate.R"
