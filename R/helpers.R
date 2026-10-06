################################################################################
# Helper functions for checking SLURM jobs and nodes

################################################################################
# nocov start
job <- function(job_id) {
  system(
    paste0("sacct -j ", job_id, " --format=JobID,Elapsed,TotalCPU,MaxRSS")
  )
}

kb_to_gb <- function(kb) kb / (1024^2)

geo <- function() system("srun --partition=geo --cpus-per-task=1 --pty top")

node <- function(node = "gn040815") system(paste0("scontrol show node ", node))

queue <- function() system("squeue -u $USER")

run <- function(cores = 1L) {
  system2("sh", args = c("run.sh", as.integer(cores)))
}

batch <- function(file = "run.sh") system(paste0("sbatch ", file))

clean <- function(pattern = NULL) system(paste0("rm slurm/*"))

gpu <- function() system("nvidia-smi")
# nocov end
