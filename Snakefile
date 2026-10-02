#######################################################################################
# Path to BEETHOVEN configuration file.
configfile: "config/config.yaml"

#######################################################################################
# Draw date range from configuration file.
print("BEETHOVEN date range:")
print(f"  start = {config['daterange']['start']}")
print(f"  end   = {config['daterange']['end']}")
