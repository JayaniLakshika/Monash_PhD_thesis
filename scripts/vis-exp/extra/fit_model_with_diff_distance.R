## The model fitted using a variety of different cluster distance metric

library(tidyverse)
library(lme4)
library(broom.mixed)
library(emmeans)
library(patchwork)

## To generate the model
gen_glmm_results <- function(dist_var = "bw_ratio"){

  # dist_var should be a string, e.g. "min_dist" or "some_other_var"
  form <- as.formula(
    paste("result ~ method *", dist_var, "+ (1 | subject)")
  )

  glmm_model <- glmer(
    form,
    data = results_df_method_ds,
    family = binomial(),
    control = glmerControl(optimizer = "bobyqa", optCtrl = list(maxfun = 1e5))
  )

  # Fixed effects only
  fixed_effects_data <- tidy(glmm_model, effects = "fixed") |>
    mutate(estimate = round(estimate, 2),
           std.error = round(std.error, 2),
           statistic = round(statistic, 2),
           p.value = round(p.value, 2)) |>
    mutate(p_val_sig = if_else(p.value <= 0.001, "***",
                               if_else(p.value <= 0.01, "**",
                                       if_else(p.value <= 0.05, "*", if_else(p.value <= 0.1, ".", " "))))) |>
    mutate(prop_error = paste0(round(estimate, 3), " (", round(std.error, 3), ")", p_val_sig)) |>
    dplyr::select(term, estimate, std.error, statistic, p.value, p_val_sig)

  list(fixed_effects_data = fixed_effects_data, glmm_model = glmm_model)
}

## To generate trend plots

gen_plts <- function(emm_df, dist_var = "bw_ratio", breaks_vec = 0:3) {

  # Define your color vector with matching names
  color_vec <- c(
    "TriMAP" = "#e41a1c",
    "UMAP" = "#377eb8",
    "PaCMAP" = "#4daf4a",
    "tSNE" = "#984ea3",
    "PHATE" = "#ff7f00"
  )

  # Make sure factor levels match color_vec
  emm_df$method <- factor(emm_df$method, levels = names(color_vec))

  emm_df <- emm_df |>
    mutate(
      logit_est = log(prob / (1 - prob)),
      logit_LCL = logit_est - qnorm(0.975) * SE,
      logit_UCL = logit_est + qnorm(0.975) * SE,
      prob_LCL_logit = 1 / (1 + exp(-logit_LCL)),
      prob_UCL_logit = 1 / (1 + exp(-logit_UCL))
    )


  # Now plot
  trend_plt <- ggplot(emm_df, aes(x = .data[[dist_var]], y = prob, color = method, fill = method)) +
    geom_line(linewidth = 1) +
    geom_ribbon(aes(ymin = prob_LCL_logit,
                    ymax = prob_UCL_logit),
                #width = 0.2,
                linewidth = 0.1,
                alpha = 0.3) +
    geom_point(size = 2) +
    scale_x_continuous(breaks = breaks_vec) +
    scale_y_continuous(limits = c(0, 1)) +
    scale_color_manual(values = color_vec) +
    scale_fill_manual(values = color_vec) +
    labs(x = dist_var, y = "estimated probability") +
    theme_light() +
    theme(
      aspect.ratio = 1.3,
      legend.position = "bottom",
      strip.text = element_text(size = 12),
      axis.title = element_text(size = 13),
      legend.title = element_blank(),
      plot.margin = margin(0, 0, 0, 0)
    )


  observed_prob_df <- results_df_method_ds |>
    mutate(!!dist_var := round(.data[[dist_var]], 2)) |>
    group_by(method, .data[[dist_var]]) |> #, type
    summarise(
      n = n(),
      successes = sum(result == 1),
      observed_prob = mean(result),
      .groups = "drop"
    ) |>
    ungroup()

  methods <- unique(observed_prob_df$method)

  # Step 3: Named list of plots using purrr::map
  method_plots <- map(methods, function(m) {
    obs_df <- filter(observed_prob_df, method == m)
    model_df <- filter(emm_df, method == m)

    ggplot(obs_df, aes_string(x = dist_var, y = "observed_prob")) +
      geom_point() + #aes(shape = type)
      geom_line(data = model_df, aes_string(x = dist_var, y = "prob"), linewidth = 1, color = color_vec[[m]]) +
      labs(x = "BW ratio", y = "observed probability") +
      scale_x_continuous(breaks = breaks_vec) +
      scale_y_continuous(limits = c(0, 1)) +
      #scale_shape_manual(values = c(16, 4)) +
      theme_light() +
      theme(
        aspect.ratio = 1.3,
        strip.text = element_text(size = 12),
        axis.title = element_blank(),
        legend.title = element_blank(),
        plot.margin = margin(10, 10, 10, 10)
      )
  }) |> set_names(methods)

  trend_plt + wrap_plots(method_plots[[3]], method_plots[[2]], method_plots[[1]], method_plots[[5]], method_plots[[4]], ncol = 3) +
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
  mutate(distance_sf = as.factor(distance_sf))

results_df_method_ds <- left_join(results_df_method_ds, distance_df,
                                  by = c("structure_high_d" = "data_structure",
                                         "distance_factor" = "distance_sf"))

results_df_method_ds <- results_df_method_ds |>
  mutate(bw_ratio = 1/wb_ratio) |>
  mutate(distance_factor = recode(distance_factor,
                                  `0.1` = "small (S)",
                                  `0.6` = "small medium (SM)",
                                  `0.9` = "medium (M)",
                                  `1` = "medium large (ML)",
                                  `1.1` = "large (L)"))

####################BW ratio ###########################################

dist_var <- "bw_ratio"
model_results <- gen_glmm_results(dist_var = dist_var)

fixed_effects_data <- model_results$fixed_effects_data
fixed_effects_data
glmm_model <- model_results$glmm_model

emm1_1 <- emmeans(glmm_model, specs = ~ method*bw_ratio,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."),
                  at = list(bw_ratio = 1:16))

emm_df <- as_tibble(emm1_1)

gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = c(1, 3, 5, 7, 9, 11, 13, 16))


####################minimum distance ###########################################

dist_var <- "min_dist"
model_results <- gen_glmm_results(dist_var = dist_var)

fixed_effects_data <- model_results$fixed_effects_data
fixed_effects_data
glmm_model <- model_results$glmm_model

emm1_1 <- emmeans(glmm_model, specs = ~ method*min_dist,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."),
                  at = list(min_dist = seq(0, 2.2, 0.2)))

emm_df <- as_tibble(emm1_1)

gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = c(0, 0.4, 0.8, 1.2, 1.6, 2.0, 2.2))

####################avg_btw_dist ###########################################

dist_var <- "avg_btw_dist"
model_results <- gen_glmm_results(dist_var = dist_var)

fixed_effects_data <- model_results$fixed_effects_data
fixed_effects_data
glmm_model <- model_results$glmm_model

emm1_1 <- emmeans(glmm_model, specs = ~ method*avg_btw_dist,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."),
                  at = list(avg_btw_dist = seq(2.5, 3.5, 0.1)))

emm_df <- as_tibble(emm1_1)

gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = c(2.5, 2.8, 3.0, 3.3, 3.5))


####################sindex ###########################################

dist_var <- "sindex"
model_results <- gen_glmm_results(dist_var = dist_var)

fixed_effects_data <- model_results$fixed_effects_data
fixed_effects_data
glmm_model <- model_results$glmm_model

emm1_1 <- emmeans(glmm_model, specs = ~ method*sindex,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."),
                  at = list(sindex = seq(0, 2.2, 0.1)))

emm_df <- as_tibble(emm1_1)

gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = seq(0, 2.2, 0.2))

################ To see how all between cluster distance metrics

langevitour::langevitour(distance_df |> select(min_dist, avg_btw_dist, sindex), group = distance_df$distance_sf)

####################max_diameter ###########################################

dist_var <- "max_diameter"
model_results <- gen_glmm_results(dist_var = dist_var)

fixed_effects_data <- model_results$fixed_effects_data
fixed_effects_data
glmm_model <- model_results$glmm_model

emm1_1 <- emmeans(glmm_model, specs = ~ method*max_diameter,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."),
                  at = list(max_diameter = c(seq(0, 9.5, 0.3), 9.5)))

emm_df <- as_tibble(emm1_1)

gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = c(seq(0, 9.5, 0.8), 9.5))


####################within_ss ###########################################

dist_var <- "within_ss"
model_results <- gen_glmm_results(dist_var = dist_var)

fixed_effects_data <- model_results$fixed_effects_data
fixed_effects_data
glmm_model <- model_results$glmm_model

emm1_1 <- emmeans(glmm_model, specs = ~ method*within_ss,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."),
                  at = list(within_ss = c(seq(266, 29871, 2000), 29871)))

emm_df <- as_tibble(emm1_1)

gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = c(seq(266, 29871, 2000), 29871))


####################avg_within_dist ###########################################

dist_var <- "avg_within_dist"
model_results <- gen_glmm_results(dist_var = dist_var)

fixed_effects_data <- model_results$fixed_effects_data
fixed_effects_data
glmm_model <- model_results$glmm_model

emm1_1 <- emmeans(glmm_model, specs = ~ method*avg_within_dist,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."),
                  at = list(avg_within_dist = seq(0, 2.6, 0.2)))

emm_df <- as_tibble(emm1_1)

gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = seq(0, 2.6, 0.2))


####################avg_silwidth_dist ###########################################

dist_var <- "avg_silwidth_dist"
model_results <- gen_glmm_results(dist_var = dist_var)

fixed_effects_data <- model_results$fixed_effects_data
fixed_effects_data
glmm_model <- model_results$glmm_model

emm1_1 <- emmeans(glmm_model, specs = ~ method*avg_silwidth_dist,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."),
                  at = list(avg_silwidth_dist = seq(-0.1, 1, 0.1)))

emm_df <- as_tibble(emm1_1)

gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = seq(-0.1, 1, 0.1))

####################widestgap ###########################################

dist_var <- "widestgap"
model_results <- gen_glmm_results(dist_var = dist_var)

fixed_effects_data <- model_results$fixed_effects_data
fixed_effects_data
glmm_model <- model_results$glmm_model

emm1_1 <- emmeans(glmm_model, specs = ~ method*widestgap,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."),
                  at = list(widestgap = seq(0, 1.1, 0.1)))

emm_df <- as_tibble(emm1_1)

gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = seq(0, 1.1, 0.1))

####################pearsongamma ###########################################

dist_var <- "pearsongamma"
model_results <- gen_glmm_results(dist_var = dist_var)

fixed_effects_data <- model_results$fixed_effects_data
fixed_effects_data
glmm_model <- model_results$glmm_model

emm1_1 <- emmeans(glmm_model, specs = ~ method*pearsongamma,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."),
                  at = list(pearsongamma = seq(-0.1, 1.0, 0.1)))

emm_df <- as_tibble(emm1_1)

gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = seq(-0.1, 1.0, 0.1))

####################dunn ###########################################

dist_var <- "dunn"
model_results <- gen_glmm_results(dist_var = dist_var)

fixed_effects_data <- model_results$fixed_effects_data
fixed_effects_data
glmm_model <- model_results$glmm_model

emm1_1 <- emmeans(glmm_model, specs = ~ method*dunn,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."),
                  at = list(dunn = seq(0, 2.3, 0.1)))

emm_df <- as_tibble(emm1_1)

gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = seq(0, 2.3, 0.1))

####################dunn2 ###########################################

dist_var <- "dunn2"
model_results <- gen_glmm_results(dist_var = dist_var)

fixed_effects_data <- model_results$fixed_effects_data
fixed_effects_data
glmm_model <- model_results$glmm_model

emm1_1 <- emmeans(glmm_model, specs = ~ method*dunn2,
                  type = "response", infer = TRUE, calc = c(n = ".wgt."),
                  at = list(dunn2 = seq(0.5, 8.3, 0.3)))

emm_df <- as_tibble(emm1_1)

gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = seq(0.5, 8.3, 0.6))

####################entropy ###########################################
results_df_method_ds$entropy |> unique()

######The entropy value is the same for all data structure.

# dist_var <- "entropy"
# model_results <- gen_glmm_results(dist_var = dist_var)
#
# fixed_effects_data <- model_results$fixed_effects_data
# fixed_effects_data
# glmm_model <- model_results$glmm_model
#
# emm1_1 <- emmeans(glmm_model, specs = ~ method*entropy,
#                   type = "response", infer = TRUE, calc = c(n = ".wgt."),
#                   at = list(entropy = seq(2.5, 3.5, 0.1)))
#
# emm_df <- as_tibble(emm1_1)
#
# gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = c(2.5, 2.8, 3.0, 3.3, 3.5))

####################ch ###########################################

## Can't fit the model

# dist_var <- "ch"
# model_results <- gen_glmm_results(dist_var = dist_var)
#
# fixed_effects_data <- model_results$fixed_effects_data
# fixed_effects_data
# glmm_model <- model_results$glmm_model
#
# emm1_1 <- emmeans(glmm_model, specs = ~ method*ch,
#                   type = "response", infer = TRUE, calc = c(n = ".wgt."),
#                   at = list(ch = seq(15, 417531, 10000)))
#
# emm_df <- as_tibble(emm1_1)
#
# gen_plts(emm_df = emm_df, dist_var = dist_var, breaks_vec = seq(15, 417531, 10000))

GGally::ggpairs(results_df_method_ds |> select(min_dist, avg_btw_dist, sindex, bw_ratio, method),
                columns = 1:4,
                mapping = aes(color = as.factor(method)))

