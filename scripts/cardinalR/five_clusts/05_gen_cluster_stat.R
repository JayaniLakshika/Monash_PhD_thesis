## This script is to generate different cluster stats for different clustering methods

library(tidyverse)
library(proxy)

five_clusts <- read_rds(here::here("data/five_clusts/five_clusts.rds"))

true_labels <- as.numeric(gsub("cluster", "", five_clusts$cluster))

# Hierarchical clustering
dist_mat <- dist(five_clusts[, -5])
hc_fit <- hclust(dist_mat, method = "ward.D2")
hc_cl <- NULL
for (ncl in 2:10) {
  hcl <- cutree(hc_fit, ncl)
  hc_cl <- cbind(hc_cl, hcl)
}
colnames(hc_cl) <- paste0("cl", 2:10)

x <- cluster.stats(dist_mat,
                   hc_cl[,1])[c("within.cluster.ss", "pearsongamma", "dunn2",
                                "wb.ratio", "ch", "sindex")]
hc_stats <- tibble(method="hc", cl=2) |>
  bind_cols(as_tibble(x))
for (i in 3:10) {
  x <- cluster.stats(dist_mat,
                     hc_cl[,i-1])[c("within.cluster.ss", "pearsongamma", "dunn2",
                                    "wb.ratio", "ch", "sindex")]
  hcms <- tibble(method="hc", cl=i) |>
    bind_cols(as_tibble(x))
  hc_stats <- hc_stats |>
    bind_rows(hcms)
}

# K-means clustering
kmeans_cl <- NULL
for (ncl in 2:10) {
  kcl <- kmeans(five_clusts[, -5], centers = ncl, nstart = 20)$cluster
  kmeans_cl <- cbind(kmeans_cl, kcl)
}
colnames(kmeans_cl) <- paste0("cl", 2:10)

x <- cluster.stats(dist_mat,
                   kmeans_cl[,1])[c("within.cluster.ss", "pearsongamma", "dunn2",
                                    "wb.ratio", "ch", "sindex")]
kmeans_stats <- tibble(method="km", cl=2) |>
  bind_cols(as_tibble(x))
for (i in 3:10) {
  x <- cluster.stats(dist_mat,
                     kmeans_cl[,i-1])[c("within.cluster.ss", "pearsongamma", "dunn2",
                                        "wb.ratio", "ch", "sindex")]
  kms <- tibble(method="km", cl=i) |>
    bind_cols(as_tibble(x))
  kmeans_stats <- kmeans_stats |>
    bind_rows(kms)
}

# Model-based clustering
modelbased_cl <- NULL
for (ncl in 2:10) {
  mcl <- Mclust(five_clusts[, -5], G = ncl, modelNames = "EII")$classification
  modelbased_cl <- cbind(modelbased_cl, mcl)
}
colnames(modelbased_cl) <- paste0("cl", 2:10)

x <- cluster.stats(dist_mat,
                   modelbased_cl[,1])[c("within.cluster.ss", "pearsongamma", "dunn2",
                                        "wb.ratio", "ch", "sindex")]
modelbased_stats <- tibble(method="mb", cl=2) |>
  bind_cols(as_tibble(x))
for (i in 3:10) {
  x <- cluster.stats(dist_mat,
                     modelbased_cl[,i-1])[c("within.cluster.ss", "pearsongamma", "dunn2",
                                            "wb.ratio", "ch", "sindex")]
  mbs <- tibble(method="mb", cl=i) |>
    bind_cols(as_tibble(x))
  modelbased_stats <- modelbased_stats |>
    bind_rows(mbs)
}

all_stats <- bind_rows(hc_stats, kmeans_stats, modelbased_stats)

write_rds(all_stats, "data/five_clusts/cluster_stat.rds")
