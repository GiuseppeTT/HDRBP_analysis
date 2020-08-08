# Load packages and utils.R (functions for main.R)------------------------------
library(tidyverse)
library(drake)
library(HDRBP)
source("utils.R")



# Load configurations ----------------------------------------------------------
config <- yaml::read_yaml("config.yml", eval.expr = TRUE)



# Load drake main plan and R/ directory (functions for plan.R) -----------------
source_directory("R")
source("plan.R")


# Remove C stack limit (check ?HDRBP::backtest details) ------------------------
system("ulimit -s unlimited")



# Define future plan -----------------------------------------------------------
future::plan(future::multisession)



# Make drake main plan ---------------------------------------------------------
make(
    main_plan,
    log_progress = FALSE,
    garbage_collection = TRUE,
    memory_strategy = "autoclean",
    history = FALSE,
    recover = FALSE
)
