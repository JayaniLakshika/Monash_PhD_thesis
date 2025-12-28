## The model fitted using a variety of different cluster distance metric

library(tidyverse)
library(lme4)
library(broom.mixed)
library(emmeans)
library(patchwork)

metrics <- c("min_dist", "avg_btw_dist", "bw_ratio", "dunn", "dunn2",
             "pearsongamma", "sindex", "avg_silwidth_dist")

distance_df_scaled <- distance_df |>
  mutate(across(
    all_of(metrics),
    ~ (. - min(.)) / (max(.) - min(.)),
    .names = "{.col}_scaled"
  )) |>
  mutate(log_bw_ratio_scaled = log(bw_ratio)) |>
  mutate(sqr_avg_btw_dist_scaled = avg_btw_dist_scaled^2) |>
  mutate(sqr_pearsongamma_scaled = pearsongamma_scaled^2) |>
  mutate(sqr_avg_silwidth_dist_scaled = avg_silwidth_dist_scaled^2) |>
  mutate(sqrt_dunn_scaled = sqrt(dunn_scaled)) |>
  mutate(sqrt_dunn2_scaled = sqrt(dunn2_scaled))

metrics_scaled <- append(paste0(metrics[c(1, 7)], "_scaled"), c("log_bw_ratio_scaled",
                                                                "sqr_avg_btw_dist_scaled",
                                                                "sqr_pearsongamma_scaled",
                                                                "sqr_avg_silwidth_dist_scaled",
                                                                "sqrt_dunn_scaled",
                                                                "sqrt_dunn2_scaled"))

## To generate the model
gen_glmm_results_all_metrics <- function(dist_vars = c("bw_ratio", "min_dist", "avg_btw_dist",
                                                       "dunn", "dunn2", "pearsongamma",
                                                       "sindex", "avg_silwidth_dist")) {

  results_list <- purrr::map(dist_vars, function(dist_var) {

    form <- as.formula(
      paste("result ~ method *", dist_var, "+ (1 | subject)")
    )

    glmm_model <- glmer(
      form,
      data = results_df_method_ds,
      family = binomial(),
      control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 1e5))
    )

    fixed_effects_data <- broom.mixed::tidy(glmm_model, effects = "fixed") |>
      mutate(estimate   = round(estimate, 2),
             std.error  = round(std.error, 2),
             statistic  = round(statistic, 2),
             p.value    = round(p.value, 2),
             p_val_sig  = case_when(
               p.value <= 0.001 ~ "***",
               p.value <= 0.01  ~ "**",
               p.value <= 0.05  ~ "*",
               p.value <= 0.1   ~ ".",
               TRUE             ~ " "
             ),
             prop_error = paste0(round(estimate, 3), " (", round(std.error, 3), ")", p_val_sig),
             metric     = dist_var) |>
      dplyr::select(metric, term, estimate, std.error, statistic, p.value, p_val_sig, prop_error)

    list(fixed_effects_data = fixed_effects_data,
         glmm_model = glmm_model,
         metric = dist_var)
  })

  # bind fixed effects into one dataframe
  all_fixed_effects <- purrr::map_dfr(results_list, "fixed_effects_data")

  list(all_fixed_effects = all_fixed_effects, models = results_list)
}


## To generate trend plots facet by distance metrics

gen_plts <- function(emm_df, dist_vars, method_choice, breaks_vec = 0:3) {

  # Define your color vector for distance metrics (not methods anymore!)
  color_vec <- c(
    "min_dist_scaled" = "#e41a1c",
    "sqr_avg_btw_dist_scaled" = "#377eb8",
    "log_bw_ratio_scaled" = "#4daf4a",
    "sqrt_dunn_scaled" = "#984ea3",
    "sqrt_dunn2_scaled" = "#ff7f00",
    "sqr_pearsongamma_scaled" = "#a65628",
    "sindex_scaled" = "#f781bf",
    "sqr_avg_silwidth_dist_scaled" = "#999999"
  )

  # Filter to one method
  emm_df <- emm_df |> filter(method == method_choice)

  # Reshape to long format for metrics
  emm_long <- emm_df |>
    pivot_longer(
      cols = all_of(names(color_vec)),
      names_to = "metric_name",
      values_to = "metric_value"
    ) |>
    mutate(
      logit_est = log(prob / (1 - prob)),
      logit_LCL = logit_est - qnorm(0.975) * SE,
      logit_UCL = logit_est + qnorm(0.975) * SE,
      prob_LCL_logit = 1 / (1 + exp(-logit_LCL)),
      prob_UCL_logit = 1 / (1 + exp(-logit_UCL))
    )

  # Plot trends: one facet per distance metric
  trend_plt <- ggplot(emm_long, aes(x = metric_value, y = prob,
                                    color = metric, fill = metric)) +
    geom_line(linewidth = 1) +
    geom_ribbon(aes(ymin = prob_LCL_logit, ymax = prob_UCL_logit),
                alpha = 0.2, linewidth = 0.1) +
    geom_point(size = 2) +
    scale_y_continuous(limits = c(0, 1)) +
    scale_color_manual(values = color_vec) +
    scale_fill_manual(values = color_vec) +
    #facet_wrap(~metric, scales = "free_x") +
    labs(x = "Distance metric value", y = "Estimated probability",
         title = paste("Trend for", method_choice)) +
    theme_light() +
    theme(
      aspect.ratio = 1.3,
      legend.position = "none",
      strip.text = element_text(size = 12),
      axis.title = element_text(size = 13),
      plot.margin = margin(5, 5, 5, 5)
    )

  # Step 1: build observed probability df for selected method
  observed_prob_df <- purrr::map_dfr(dist_vars, function(dv) {
    results_df_method_ds %>%
      filter(method == !!method_choice) %>%
      mutate(metric = dv,
             metric_value = round(.data[[dv]], 2)) %>%
      group_by(method, metric, metric_value) %>%
      summarise(
        n = n(),
        successes = sum(result == 1),
        observed_prob = mean(result),
        .groups = "drop"
      )
  })

  # Step 2: build model df for selected method
  model_df <- purrr::map_dfr(dist_vars, function(dv) {
    emm_df %>%
      filter(method == !!method_choice) %>%
      mutate(metric = dv,
             metric_value = .data[[dv]])
  })

  # Step 3: color palette for metrics
  # color_vec <- c(
  #   "min_dist" = "#e41a1c",
  #   "avg_btw_dist" = "#377eb8",
  #   "bw_ratio" = "#4daf4a",
  #   "dunn" = "#984ea3",
  #   "dunn2" = "#ff7f00",
  #   "pearsongamma" = "#a65628",
  #   "sindex" = "#f781bf",
  #   "avg_silwidth_dist" = "#999999"
  # )

  # Step 4: facet plot by metric
  facet_plot <- ggplot() +
    geom_point(data = observed_prob_df,
               aes(x = metric_value, y = observed_prob, color = metric),
               alpha = 0.5,
               size = 0.5) +
    geom_line(data = model_df,
              aes(x = metric_value, y = prob, color = metric),
              linewidth = 1) +
    scale_color_manual(values = color_vec) +
    facet_wrap(~metric, scales = "free_x") +
    scale_x_continuous(breaks = breaks_vec) +
    scale_y_continuous(limits = c(0, 1)) +
    labs(x = "Distance metric value",
         y = "Observed vs Model probability",
         title = paste("NLDR Method:", method_choice)) +
    theme_light() +
    theme(
      aspect.ratio = 1.3,
      #strip.text = element_blank(),
      axis.title = element_blank(),
      legend.title = element_blank(),
      plot.margin = margin(10, 10, 10, 10),
      legend.position = "none"
    )

  trend_plt + wrap_plots(facet_plot) +
    plot_layout(guides = "collect")
}

## To read the results
results_df_method_ds <- read_rds(here::here("data/result_method_ds_factor.rds"))

results_df_method_ds <- results_df_method_ds |>
  filter(method != "pca") |>
  mutate(type = "old")

results_df_method_ds_missings <- read_rds(here::here("data/result_method_ds_factor_missings.rds")) |>
  mutate(type = "new")

results_df_method_ds <- bind_rows(
  results_df_method_ds, results_df_method_ds_missings)

## To reformat the response variable
results_df_method_ds <- results_df_method_ds |>
  mutate(result = if_else(result == "Correct", 1, 0))

## To change the type of distance factor
results_df_method_ds <- results_df_method_ds |>
  mutate(distance_factor = as.factor(distance_factor))

#Set TriMAP as base
results_df_method_ds <- results_df_method_ds |>
  mutate(method = factor(method,
                         levels = c("trimap", "umap", "pacmap", "tsne", "phate"))) |>
  mutate(method = recode(method,
                         tsne = "tSNE",
                         umap = "UMAP",
                         phate = "PHATE",
                         trimap = "TriMAP",
                         pacmap = "PaCMAP"))

## To change the type of distance time_taken_in_seconds
results_df_method_ds <- results_df_method_ds |>
  mutate(time_taken_in_minutes = as.numeric(time_taken_in_minutes))

## To join the distance
distance_df <- read_rds("data/three_clust_min_avg_dist_df.rds") |>
  filter(distance_sf != 0.8) |>
  mutate(distance_sf = as.factor(distance_sf)) |>
  mutate(bw_ratio = 1/wb_ratio)

distance_df_scaled <- distance_df %>%
  mutate(across(
    all_of(metrics),
    ~ (. - min(.)) / (max(.) - min(.)),
    .names = "{.col}_scaled"
  )) |>
  mutate(log_bw_ratio_scaled = log(bw_ratio)) |>
  mutate(sqr_avg_btw_dist_scaled = avg_btw_dist_scaled^2) |>
  mutate(sqr_pearsongamma_scaled = pearsongamma_scaled^2) |>
  mutate(sqr_avg_silwidth_dist_scaled = avg_silwidth_dist_scaled^2) |>
  mutate(sqrt_dunn_scaled = sqrt(dunn_scaled)) |>
  mutate(sqrt_dunn2_scaled = sqrt(dunn2_scaled))

results_df_method_ds <- left_join(results_df_method_ds, distance_df_scaled,
                                  by = c("structure_high_d" = "data_structure",
                                         "distance_factor" = "distance_sf"))

results_df_method_ds <- results_df_method_ds |>
  #mutate(bw_ratio = 1/wb_ratio) |>
  mutate(distance_factor = recode(distance_factor,
                                  `0.1` = "small (S)",
                                  `0.6` = "small medium (SM)",
                                  `0.9` = "medium (M)",
                                  `1` = "medium large (ML)",
                                  `1.1` = "large (L)"))


dist_vars <- c("min_dist", "avg_btw_dist", "bw_ratio",
               "dunn", "dunn2", "pearsongamma",
               "sindex", "avg_silwidth_dist")

model_results <- gen_glmm_results_all_metrics(metrics_scaled)

fixed_effects_data <- model_results$all_fixed_effects
fixed_effects_data
glmm_model <- model_results$models

# emm1_1 <- emmeans(glmm_model, specs = ~ method*bw_ratio_sca,
#                   type = "response", infer = TRUE, calc = c(n = ".wgt."),
#                   at = list(bw_ratio = 1:16))
#
# emm_df <- as_tibble(emm1_1)
#
# gen_plts(emm_df, metrics_scaled, method_choice = "UMAP")

library(purrr)
library(emmeans)
library(dplyr)
library(rlang)

emm_df <- map_dfr(glmm_model, function(m) {
  metric_var <- m$metric   # e.g. "min_dist_scaled"

  # build specs formula dynamically
  specs_formula <- as.formula(paste("~ method *", metric_var))

  # build at list dynamically
  at_list <- setNames(list(seq(0, 1, 0.1)), metric_var)

  emm <- emmeans(m$glmm_model,
                 specs = specs_formula,
                 type = "response",
                 infer = TRUE,
                 calc = c(n = ".wgt."),
                 at = at_list)

  as.data.frame(emm) |> mutate(metric = metric_var)
})

gen_plts(emm_df, metrics_scaled, method_choice = "tSNE")
gen_plts(emm_df, metrics_scaled, method_choice = "UMAP")
gen_plts(emm_df, metrics_scaled, method_choice = "PHATE")
gen_plts(emm_df, metrics_scaled, method_choice = "TriMAP")
gen_plts(emm_df, metrics_scaled, method_choice = "PaCMAP")
