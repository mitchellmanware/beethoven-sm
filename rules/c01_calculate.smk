########################################################################################
# Collect download-generated lists for pipeline anchor point.
rule calculate_collect:
    input:
        list_narr="output/list_narr.qs",
        list_hms="output/list_hms.qs"

    output:
        list_collect="output/list_collect.qs"

    params:
        chr_dir=os.path.join(
            os.environ["HOME"],
            config["chr_dir"],
        )

    container:
        "container/sif/container_covariates.sif"

    script:
        "../scripts/c01_calculate.R"
