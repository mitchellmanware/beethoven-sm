################################################################################
##############################      BEETHOVEN      #############################
##### Main file controlling the settings, options, and sourcing of targets
##### for the beethoven analysis pipeline.

#############################      CONTROLLER      #############################
controller_1 <- crew::crew_controller_local(
  name = "controller_1",
  workers = 1
)

##### `controller_gpu` uses 4 GPU workers (undefined memory allocation).
scriptlines_apptainer <- "apptainer"
scriptlines_basedir <- "$PWD"
scriptlines_targetdir <- paste0(
  "/ddn/gs1/home/manwareme/beethoven/beethoven_dev/_targets"
)
scriptlines_container <- "container_models.sif"
##### `controller_cpu` uses 100 CPUs for {lightGBM} models.
scriptlines_cpu <- glue::glue(
  "#SBATCH --job-name=submodel \
  #SBATCH --partition=gpu \
  #SBATCH --nodelist=gn040809 \
  #SBATCH --ntasks=1 \
  #SBATCH --cpus-per-task=32 \
  #SBATCH --mem=100G \
  #SBATCH --error=slurm/submodel_%j.out \
  export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK \
  export LIGHTGBM_NUM_THREADS=$SLURM_CPUS_PER_TASK \
  {scriptlines_apptainer} exec --env OMP_NUM_THREADS=$OMP_NUM_THREADS ",
  "--env LIGHTGBM_NUM_THREADS=$LIGHTGBM_NUM_THREADS ",
  "--bind {scriptlines_basedir}:/mnt ",
  "--bind {scriptlines_basedir}/inst:/inst ",
  "--bind {scriptlines_basedir}/input:/input ",
  "--bind {scriptlines_targetdir}:/opt/_targets ",
  "{scriptlines_container} \\"
)
controller_cpu <- crew.cluster::crew_controller_slurm(
  name = "controller_cpu",
  workers = 2,
  options_cluster = crew.cluster::crew_options_slurm(
    verbose = TRUE,
    script_lines = scriptlines_cpu
  )
)
##############################        STORE       ##############################
targets::tar_config_set(store = "/opt/_targets")

##############################       OPTIONS      ##############################
targets::tar_option_set(
  packages = c(
    "amadeus",
    "targets",
    "tarchetypes",
    "dplyr",
    "tidyverse",
    "data.table",
    "sf",
    "crew",
    "crew.cluster",
    "lubridate",
    "qs2",
    "torch",
    "parsnip",
    "bonsai",
    "dials",
    "lightgbm",
    "glmnet",
    "finetune",
    "spatialsample",
    "tidymodels",
    "brulee",
    "workflows"
  ),
  repository = "local",
  error = "continue",
  memory = "transient",
  format = "qs",
  storage = "worker",
  deployment = "worker",
  garbage_collection = TRUE,
  seed = 202401L,
  controller = crew::crew_controller_group(
    controller_1,
    controller_cpu
  ),
  resources = targets::tar_resources(
    crew = targets::tar_resources_crew(controller = "controller_1")
  ),
  retrieval = "worker"
)

###########################      SOURCE TARGETS      ###########################
targets::tar_source("inst/targets/targets_models.R")

##############################      PIPELINE      ##############################
list(
  target_models
)
