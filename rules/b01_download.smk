########################################################################################
##############################            NARR            ##############################
rule download_narr:
    input:
        int_years="output/int_years.qs"

    output:
        chr_iter_narr="output/chr_iter_narr.qs",
        list_narr="output/list_narr.qs"

    params:
        chr_dir=os.path.join(
            os.environ["HOME"],
            config["chr_dir"],
        )

    container:
        "container/sif/container_covariates.sif"

    script:
        "../scripts/b02_narr.R"

##############################            HMS            ##############################
rule download_hms:
    input:
        chr_dates="output/chr_dates.qs"

    output:
        list_hms="output/list_hms.qs"

    params:
        chr_dir=os.path.join(
            os.environ["HOME"],
            config["chr_dir"],
        )

    container:
        "container/sif/container_covariates.sif"

    script:
        "../scripts/b03_hms.R"
