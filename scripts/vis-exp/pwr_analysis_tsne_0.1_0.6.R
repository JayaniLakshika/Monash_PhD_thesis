## This script is used to decide number of responses need to collect for tSNE 0.1 and 0.6 combinations.

library(tidyverse)
library(emmeans)
library(lme4)

set.seed(20240110)

results_df_method_ds <- read_rds(here::here("data/vis-exp/result_method_ds_factor.rds"))

results_df_method_ds <- results_df_method_ds |>
  filter(method != "pca")

## To reformat the response variable
results_df_method_ds <- results_df_method_ds |>
  mutate(result = if_else(result == "Correct", 1, 0))

## To change the type of distance factor
results_df_method_ds <- results_df_method_ds |>
  mutate(distance_factor = as.factor(distance_factor))

results_df_method_ds_tsne <- results_df_method_ds |>
  filter(method == "tsne")

## Fit the logistic model (full) with 18 subjects
model_main_results_ds_tsne <- glmer(result ~ distance_factor + (1 | subject), data = results_df_method_ds_tsne,
                                    family = "binomial",
                                    control = glmerControl(optimizer = "bobyqa",
                                                           optCtrl = list(maxfun = 1e5)))

emmeans_tsne <- emmeans(model_main_results_ds_tsne, specs = pairwise ~ distance_factor, type = "response", infer = TRUE)


##### To conduct power analysis


p1 <- 0.501 ## from collected data: emmeans_tsne, distance_factor = 0.1
p2_seq <- p1 - seq(0.01, 0.3, 0.01) ## from collected data (0.428) distance_factor = 0.6
ntrials <- 1000
n_seq <- seq(5, 100, 5)

prob <- NULL
for (j in 1:length(n_seq)) {
  for (k in 1:length(p2_seq)) {
    n <- n_seq[j]
    p2 <- p2_seq[k]
    dif <- NULL; pval <- NULL; pdetect <- NULL
    for (i in 1:ntrials) {
      d1 <- rbinom(n, 1, p1)
      d2 <- rbinom(n, 1, p2)
      dif <- c(dif, (sum(d1)-sum(d2))/n)
      pval <- c(pval, prop.test(x=c(sum(d1), sum(d2)), n=c(n, n),
                                alternative="greater")$p.value)
      pdetect <- c(pdetect,
                   ifelse(prop.test(x=c(sum(d1), sum(d2)), n=c(n, n),
                                    alternative="greater")$p.value < 0.05, 1, 0))
    }
    prob <- rbind(prob, cbind(n, p2, mean(dif), mean(pval), sum(pdetect)/ntrials))
  }
  cat(j, "\n")
}

prob_tb <- tibble(n = prob[,1],
                  p = prob[,2]-p1,
                  dif = prob[,3],
                  pval = prob[,4],
                  pdetect = prob[,5]
) |>
  mutate(sig = ifelse(pval < 0.05, "yes", "no"))
ggplot(prob_tb, aes(x=n, y=p, fill=sig)) +
  geom_tile() +
  theme_minimal()

ggplot(prob_tb, aes(x=n, y=pval, group=p, colour=p)) +
  geom_hline(yintercept=0.05) +
  geom_line() +
  theme_minimal()

ggplot(prob_tb, aes(x=n, y=pdetect, group=p, colour=p)) +
  geom_line() +
  geom_hline(yintercept = 0.8) +
  theme_minimal()

## Run only once
write_rds(prob_tb, here::here("data/vis-exp/tsne_0.1_0.6_three_clust_pwr_results.rds"))
