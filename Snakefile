########################################################################################
# Path to BEETHOVEN configuration file.
configfile: "config/config.yaml"

########################################################################################
print(
    f"Running {{beethoven}} pipeline: "
    f"{config['chr_daterange']['start']} - "
    f"{config['chr_daterange']['end']}"
)

########################################################################################
# Define pipeline endpoint.
rule all:
    input:
        "output/sf_feat_aqs_sp.qs",
        "output/dt_feat_aqs_sptmpl.qs"

###############################      PIPELINE RULES      ###############################
include: "rules/a01_initiate.smk"
include: "rules/b01_download.smk"
include: "rules/c01_calculate.smk"
