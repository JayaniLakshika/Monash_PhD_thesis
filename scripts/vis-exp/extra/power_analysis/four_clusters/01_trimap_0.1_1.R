## Model only with TriMAP 0.1 and 1 distance factors

library(tidyverse)

set.seed(20250107)

##### To conduct power analysis

p1 <- 0.92 ## from collected data
p2_seq <- p1 - seq(0.01, 0.25, 0.01) ## from collected data (0.75)
#p2_seq <- 0.75 ## from collected data
actual_p2 <- 0.75 ## from collected data
ntrials <- 1000
n_seq <- seq(5, 75, 1)

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
                  p2 = prob[,2],
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

## Optimal sample size
prob_tb_opt <- prob_tb |>
  filter(p >= (actual_p2 - p1)) |>
  filter(p <= (actual_p2 - p1 + 0.01))

ggplot(prob_tb, aes(x=n, y=pdetect, group=p, colour=p)) +
  geom_line() +
  geom_vline(xintercept = 62, linetype = "dashed") +
  geom_hline(yintercept = 0.8) +
  scale_color_continuous_diverging(palette = "Purple-Brown") +
  theme_minimal()

## Run only once
write_rds(prob_tb, "data/trimap_0.1_1_four_clust_sample_size_determination.rds")
