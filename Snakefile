#######################################################################################
# Path to BEETHOVEN configuration file.
configfile: "config/config.yaml"

#######################################################################################
# Draw date range from configuration file.
print("BEETHOVEN date range:")
print(f"  start = {config['chr_daterange']['start']}")
print(f"  end   = {config['chr_daterange']['end']}")

#######################################################################################
# Generate all dates in date range.
rule generate_dates:

  output:
    chr_dates = "output/chr_dates.txt"

  params:
    start=lambda wildcards: config["chr_daterange"]["start"],
    end=lambda wildcards: config["chr_daterange"]["end"]

  script:
    "scripts/a01_chr_dates.R"
