target_models <-
  list(
    ############################################################################
    targets::tar_target(
      chr_list_files,
      command = list.files("input", full.names = TRUE, recursive = TRUE)
    ),
    targets::tar_target(
      dt_feat_pm_imputed,
      command = qs2::qs_read(chr_list_files[1])
    ),
    targets::tar_target(
      list_base_params_static,
      command = list(
        yvar = "Arithmetic.Mean",
        xvar = names(dt_feat_pm_imputed)[seq(5, ncol(dt_feat_pm_imputed))],
        drop_vars = names(dt_feat_pm_imputed)[seq(1, 3)],
        normalize = TRUE
      ),
      description = "Static parameters | base learner"
    ),
    targets::tar_target(
      list_rset_train_raw,
      command = list(
        qs2::qs_read(chr_list_files[2]),
        qs2::qs_read(chr_list_files[3])
      )
    ),
    targets::tar_target(
      num_cv_index,
      command = seq_len(length(list_rset_train_raw)),
    ),
    targets::tar_target(
      list_rset_train,
      command = list_rset_train_raw[[num_cv_index]],
      iteration = "list",
      pattern = map(num_cv_index)
    ),
    targets::tar_target(
      fit_learner_base_lgb,
      command = {
        int_lgb_threads <- as.integer(Sys.getenv("SLURM_CPUS_PER_TASK"))
        # lightgbm::setLGBMThreads(int_lgb_threads)
        engine_base_lgb <- parsnip::boost_tree(
          mtry = parsnip::tune(),
          trees = parsnip::tune(),
          learn_rate = parsnip::tune(),
          tree_depth = parsnip::tune()
        ) %>%
          parsnip::set_engine(
            "lightgbm",
            device = "cpu",
            num_threads = int_lgb_threads
          ) %>%
          parsnip::set_mode("regression")
        beethoven::fit_base_learner(
          rset = list_rset_train,
          model = engine_base_lgb,
          tune_grid_size = expand.grid(
            mtry = c(150, 239),
            trees = c(250, 445),
            learn_rate = c(0.1, 0.15),
            tree_depth = c(4, 7)
          ),
          yvar = list_base_params_static$yvar,
          xvar = list_base_params_static$xvar,
          drop_vars = list_base_params_static$drop_vars,
          normalize = list_base_params_static$normalize
        )
      },
      pattern = map(list_rset_train),
      iteration = "list",
      resources = targets::tar_resources(
        crew = targets::tar_resources_crew(controller = "controller_cpu")
      ),
      description = "Fit base learner | lgb | cpu | base learner"
    )
    ############################################################################
    ############################################################################
  )
