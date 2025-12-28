library(simr)

## Model only with tsne 0.1 and 1 distance factors

library(tidyverse)
library(emmeans)
library(lme4)
set.seed(20250107)

results_df_method_ds <- read_rds(here::here("data/result_method_ds_factor.rds"))

## To reformat the response variable
results_df_method_ds <- results_df_method_ds |>
  mutate(result = if_else(result == "Correct", 1, 0))

## To change the type of distance factor
# results_df_method_ds <- results_df_method_ds |>
#   mutate(distance_factor = as.factor(distance_factor))

#Set PCA as base
results_df_method_ds <- results_df_method_ds |>
  mutate(method = factor(method,
                         levels = c("pca", "tsne", "umap", "phate", "trimap", "pacmap")))

### Only for 0.1 and 1
results_df_method_ds_1 <- results_df_method_ds |>
  filter(method == "pacmap") |>
  filter(distance_factor %in% c(0.1, 1))

## Fit the logistic model (full) with 18 subjects
model_main_results_ds_1 <- glmer(result ~ distance_factor + (1 | subject),
                                 data = results_df_method_ds_1,
                                 family = "binomial",
                                 control = glmerControl(optimizer = "bobyqa",
                                                        optCtrl = list(maxfun = 1e5)))

summary(model_main_results_ds_1)

emmeans(model_main_results_ds_1, specs = ~ distance_factor, type = "response",
        infer = TRUE, calc = c(n = ".wgt."))

powerSim(model_main_results_ds_1) #67.20%
pc1 <- powerCurve(model_main_results_ds_1, along="subject")
plot(pc1)

## Increasing the number of levels in distance factor
model_main_results_ds_2 <- extend(model_main_results_ds_1, along="distance_factor", n=5)

powerSim(model_main_results_ds_2)

pc2 <- powerCurve(model_main_results_ds_2)
print(pc2)

model3 <- extend(model_main_results_ds_1, along="subject", n=15)
pc3 <- powerCurve(model3, along="subject")
plot(pc3)
