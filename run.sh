#!/bin/bash

cores="${1:-1}"

snakemake \
    --cores "${cores}" \
    --use-apptainer \
    -p
