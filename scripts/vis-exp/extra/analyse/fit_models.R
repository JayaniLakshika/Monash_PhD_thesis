library(tidyverse)
library(lme4)
library(emmeans)
library(broom.mixed)

results_df_method_ds <- read_rds(here::here("data/result_method_ds_factor.rds"))

results_df_method_ds <- results_df_method_ds |>
  filter(method != "pca")

results_df_method_ds_missings <- read_rds(here::here("data/result_method_ds_factor_missings.rds"))

results_df_method_ds <- bind_rows(
  results_df_method_ds, results_df_method_ds_missings)

## To reformat the response variable
results_df_method_ds <- results_df_method_ds |>
  mutate(result = if_else(result == "Correct", 1, 0))

## To change the type of distance factor
results_df_method_ds <- results_df_method_ds |>
  mutate(distance_factor = as.factor(distance_factor))

#Set PCA as base
results_df_method_ds <- results_df_method_ds |>
  mutate(method = factor(method,
                         levels = c("tsne", "umap", "phate", "trimap", "pacmap")))

## To change the type of distance time_taken_in_seconds
results_df_method_ds <- results_df_method_ds |>
  mutate(time_taken_in_minutes = as.numeric(time_taken_in_minutes))

## To join the distance
min_max_dist <- read_rds("data/three_clust_min_max_dist_df.rds")

min_max_dist <- min_max_dist |>
  mutate(distance_sf = as.factor(distance_sf)) |>
  mutate(min_dist = pmin(min_dist12, min_dist13, min_dist23)) |>
  mutate(avg_dist = rowMeans(across(c(min_dist12, min_dist13, min_dist23)))) |>
  mutate(max_dist = pmin(max_dist12, max_dist13, max_dist23))

results_df_method_ds <- left_join(results_df_method_ds, min_max_dist,
                                  by = c("structure_high_d" = "data_structure",
                                         "distance_factor" = "distance_sf"))

## To join the cluster components
cluster_structures <- read_csv("data/data_structures_components.csv")

## Group the clusters according to the cluster components
cluster_structures <- cluster_structures |>
  mutate(data_structure_group = if_else(
    cluster3 == "filled_hexagonal_pyramid", "group1", "group2"
  ))

## To bind the new grouping
results_df_method_ds <- results_df_method_ds |>
  left_join(cluster_structures, by = c("structure_high_d" = "data_structure"))

###################### Fit the logistic model (full) for all methods ###########

model_main_results_ds <- glmer(result ~ method * min_dist + (1 | subject) + (1 | data_structure_group),
           data = results_df_method_ds,
           family = "binomial",
           control = glmerControl(optimizer = "bobyqa",
                                  optCtrl = list(maxfun = 1e5)))

summary(model_main_results_ds)

## Interpretations (This helps to compare NLDR methods)
### TriMAP performs significantly better than tSNE overall.
### min_dist has a negative effect for tSNE, but improves UMAP and PaCMAP significantly.
### UMAP and PHATE are not significantly different from tSNE at min_dist = 0.
### Random intercepts for subject are important; not so for data_structure_group.

# emm1_1 <- emmeans(model_main_results_ds, specs = ~ min_dist, type = "response",
#                   infer = TRUE, calc = c(n = ".wgt."))
#
# emm1_1 <- tidy(emm1_1, effects = "fixed")
# emm1_1
#
# emmip(model_main_results_ds, method ~ min_dist, CIs = TRUE, type = "response") +
#   facet_wrap(~method, scales = "free_y") +
#   scale_color_manual(values = rep("#000000", 6)) +
#   theme_minimal() +
#   theme(
#     legend.position = "none"
#   ) +
#   xlab("distance scale factors") +
#   ylab("estimate")

############################################################################
## Split the data by method
results_split <- results_df_method_ds |>
  group_split(method)

results_df_method_ds_tsne <- results_split[[1]]
results_df_method_ds_umap <- results_split[[2]]
results_df_method_ds_phate <- results_split[[3]]
results_df_method_ds_trimap <- results_split[[4]]
results_df_method_ds_pacmap <- results_split[[5]]

###################### Fit the logistic model (full) only for PHATE ############
model_main_results_ds_phate <- glmer(result ~ min_dist + (1 | subject),
                                     data = results_df_method_ds_phate,
                                     family = "binomial",
                                     control = glmerControl(optimizer = "bobyqa",
                                                            optCtrl = list(maxfun = 1e5)))

summary(model_main_results_ds_phate)

## Interpretation
### no strong evidence that PHATE’s performance is sensitive to min_dist over the range considered.

### PHATE is designed for continuous manifolds and transitions, not discrete clusters.
### Therefore, large inter-cluster distances in PHATE may indicate loss of continuum or forced separation.
### Since our model shows a non-significant effect, that would be expected.

# emm1_1 <- emmeans(model_main_results_ds_phate, specs = ~ min_dist, type = "response",
#                   infer = TRUE, calc = c(n = ".wgt."))
#
# emm1_1 <- tidy(emm1_1, effects = "fixed")
# emm1_1


##################### Fit the logistic model (full) only for tSNE ##############
model_main_results_ds_tsne <- glmer(result ~ min_dist + (1|subject),
                                     data = results_df_method_ds_tsne,
                                     family = "binomial",
                                     control = glmerControl(optimizer = "bobyqa",
                                                            optCtrl = list(maxfun = 1e5)))

summary(model_main_results_ds_tsne)

## Interpretation
### Larger min_dist is detrimental to tSNE performance.

### tSNE emphasizes local structure and often pulls similar points into dense clusters, but it distorts global relationships—i.e., inter-cluster distances are not meaningful.

# emm1_1 <- emmeans(model_main_results_ds_tsne, specs = ~ min_dist, type = "response",
#                   infer = TRUE, calc = c(n = ".wgt."))
#
# emm1_1 <- tidy(emm1_1, effects = "fixed")
# emm1_1

##################### Fit the logistic model (full) only for UMAP ##############
model_main_results_ds_umap <- glmer(result ~ min_dist + (1 | subject),
                                    data = results_df_method_ds_umap,
                                    family = "binomial",
                                    control = glmerControl(optimizer = "bobyqa",
                                                           optCtrl = list(maxfun = 1e5)))

summary(model_main_results_ds_umap)

## Interpretation
### UMAP performance increases with min_dist.

### UMAP preserves both local and global structure, but actual inter-cluster distances in the 2D layout do carry some meaning.

# emm1_1 <- emmeans(model_main_results_ds_umap, specs = ~ min_dist, type = "response",
#                   infer = TRUE, calc = c(n = ".wgt."))
#
# emm1_1 <- tidy(emm1_1, effects = "fixed")
# emm1_1

##################### Fit the logistic model (full) only for TriMAP ##############
model_main_results_ds_trimap <- glmer(result ~ min_dist + (1 | subject),
                                    data = results_df_method_ds_trimap,
                                    family = "binomial",
                                    control = glmerControl(optimizer = "bobyqa",
                                                           optCtrl = list(maxfun = 1e5)))

summary(model_main_results_ds_trimap)

## Interpretation
### TriMAP’s performance is insensitive to min_dist.

### TriMAP is designed to preserve global structure using triplets (anchor, positive, negative).
### This means the relative positioning between clusters is more meaningful.
### However, it's not optimized for maximizing tight cluster separation. It emphasizes correct ordering of distances.

# emm1_1 <- emmeans(model_main_results_ds_trimap, specs = ~ min_dist, type = "response",
#                   infer = TRUE, calc = c(n = ".wgt."))
#
# emm1_1 <- tidy(emm1_1, effects = "fixed")
# emm1_1

##################### Fit the logistic model (full) only for PaCMAP ##############
model_main_results_ds_pacmap <- glmer(result ~ min_dist + (1 | subject),
                                      data = results_df_method_ds_pacmap,
                                      family = "binomial",
                                      control = glmerControl(optimizer = "bobyqa",
                                                             optCtrl = list(maxfun = 1e5)))

summary(model_main_results_ds_pacmap)

## The difference between the data structures can be seen with PaCMAP only.
## Therefore, need to find reason why on this is happening.
## To look at the each structure, which contains "star" shape will help.
## three_clust_04, three_clust_08, three_clust_12, and three_clust_16
## The non-linear cluster in each data structure make this different.

## Interpretation
### For PaCMAP, increasing min_dist might improve performance.

### PaCMAP explicitly balances local and global preservation via near, mid, and far pairs.
### This means inter-cluster distances in the embedding are often meaningful; closer clusters can imply structural similarity.

# emm1_1 <- emmeans(model_main_results_ds_pacmap, specs = ~ min_dist, type = "response",
#                   infer = TRUE, calc = c(n = ".wgt."))
#
# emm1_1 <- tidy(emm1_1, effects = "fixed")
# emm1_1

## Final conclusion

### The influence of high-dimensional cluster separation on the performance of
### non-linear dimensionality reduction (NLDR) methods reveals important insights
### into their structural preservation tendencies. Using a generalized linear mixed model
### with the minimum inter-cluster distance in the high-dimensional space (`min_dist`) as a predictor,
### we found that UMAP and PaCMAP are more likely to produce correct results when clusters are well separated.
### This aligns with their design: UMAP constructs a topological representation that benefits from distinct neighborhoods,
### while PaCMAP explicitly leverages both local and global pairwise relationships, including far-apart points.
### In contrast, tSNE performed better when clusters were closer together in the original space.
### This result reflects tSNE's strong emphasis on local structure and its tendency to distort global relationships, especially when distant clusters are involved.
### TriMAP, which uses relative triplet constraints to emphasize global geometry, showed no meaningful dependence on `min_dist`, suggesting that the method is relatively robust to varying degrees of cluster separation but may not prioritize cluster delineation.
### These findings confirm that methods such as UMAP and PaCMAP are better suited for tasks involving well-separated high-dimensional clusters, whereas tSNE may be more appropriate when the goal is to recover local relationships in overlapping or tightly packed clusters.


results_df_grouped <- results_df_method_ds_tsne |>
  select(method, avg_dist, data_structure_group, result)

ggplot(data = results_df_grouped,
       aes(y = avg_dist,
           x = as.factor(result))) +
  #facet_wrap(~data_structure_group) +
  geom_quasirandom(alpha = 0.5) +
  stat_summary(colour = "red") +
  #geom_point(alpha = 0.5) +
  ylab("average distance") +
  theme_minimal()
