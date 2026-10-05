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
        "output/list_narr.qs"

###############################      PIPELINE RULES      ###############################
include: "rules/a01_initiate.smk"
include: "rules/b01_download.smk"
