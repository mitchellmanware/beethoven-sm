########################################################################################
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
        "../scripts/b01_narr.R"
