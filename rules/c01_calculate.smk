########################################################################################
# Collect download-generated lists for pipeline dispatch anchor.
rule calculate_aqs:
    input:
        chr_dates="output/chr_dates.qs",
        list_dl_aqs="output/list_dl_aqs.qs",
        list_dl_narr="output/list_dl_narr.qs",
        list_dl_hms="output/list_dl_hms.qs"

    output:
        sf_feat_aqs_sp="output/sf_feat_aqs_sp.qs",
        dt_feat_aqs_sptmpl="output/dt_feat_aqs_sptmpl.qs"

    params:
        chr_dir=os.path.join(
            os.environ["HOME"],
            config["chr_dir"],
        )

    container:
        "container/sif/container_covariates.sif"

    script:
        "../scripts/c01_aqs.R"
