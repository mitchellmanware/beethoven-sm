#######################################################################################
# Path to BEETHOVEN configuration file.
configfile: "config/config.yaml"

#######################################################################################
print(
    f"Running {{beethoven}} pipeline: "
    f"{config['chr_daterange']['start']} - "
    f"{config['chr_daterange']['end']}"
)

#######################################################################################
# Define pipeline endpoint.
rule all:
    input:
        "output/list_narr.qs"

#######################################################################################
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
        "scripts/a01_initiate.R"

#######################################################################################
# Download all data files.
rule download:
    input:
        int_years="output/int_years.qs"

    output:
        list_narr="output/list_narr.qs"

    params:
        chr_dir=os.path.join(
            os.environ["HOME"],
            config["chr_dir"],
        )

    container:
        "container/sif/container_covariates.sif"

    script:
        "scripts/b01_narr.R"
