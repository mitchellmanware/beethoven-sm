########################################################################################
# Collect download-generated lists for pipeline dispatch anchor.
rule calculate_collect:
    input:
        list_aqs="output/list_aqs.qs",
        list_narr="output/list_narr.qs",
        list_hms="output/list_hms.qs"

    output:
        list_collect="output/list_collect.qs"

    container:
        "container/sif/container_covariates.sif"

    script:
        "../scripts/c01_calculate.R"
