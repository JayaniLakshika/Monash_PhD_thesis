clr_choice <- "#0077A3"
umap_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_umap_n-neigbors_15_min-dist_0.1.rds"))

nldr1 <- umap_pbmc |>
  ggplot(aes(x = emb1,
             y = emb2)) +
  geom_point(alpha=0.1, size=1, colour=clr_choice) +
  interior_annotation("a")

umap_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_umap_n-neigbors_54_min-dist_0.5.rds"))

nldr2 <- umap_pbmc |>
  ggplot(aes(x = emb1,
             y = emb2))+
  geom_point(alpha=0.1, size=1, colour=clr_choice) +
  interior_annotation("b")

pacmap_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_pacmap_n-neighbors_51_init_random_MN-ratio_0.3_FP-ratio_2.rds"))
nldr3 <- pacmap_pbmc |>
  ggplot(aes(x = emb1,
             y = emb2))+
  geom_point(alpha=0.1, size=1, colour=clr_choice) +
  interior_annotation("c")

tsne_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_tsne_perplexity_30.rds"))

nldr4 <- tsne_pbmc |>
  ggplot(aes(x = emb1,
             y = emb2))+
  geom_point(alpha=0.1, size=1, colour=clr_choice) +
  interior_annotation("d")

tsne_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_tsne_perplexity_84.rds"))

nldr5 <- tsne_pbmc |>
  ggplot(aes(x = emb1,
             y = emb2))+
  geom_point(alpha=0.1, size=1, colour=clr_choice) +
  interior_annotation("e")

phate_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_phate_knn_5.rds"))
nldr6 <- phate_pbmc |>
  ggplot(aes(x = emb1,
             y = emb2))+
  geom_point(alpha=0.1, size=1, colour=clr_choice) +
  interior_annotation("f")

trimap_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_trimap_n-inliers_12_n-outliers_4_n-random_3.rds"))
nldr7 <- trimap_pbmc |>
  ggplot(aes(x = emb1,
             y = emb2))+
  geom_point(alpha=0.1, size=1, colour=clr_choice) +
  interior_annotation("g", c(0.08, 0.93))

pacmap_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_pacmap_n-neighbors_10_init_random_MN-ratio_0.5_FP-ratio_2.rds"))
nldr8 <- pacmap_pbmc |>
  ggplot(aes(x = emb1,
             y = emb2))+
  geom_point(alpha=0.1, size=1, colour=clr_choice) +
  interior_annotation("h")


library(readr)
library(quollr)
library(dplyr)

set.seed(20240110)

data <- read_rds(here::here("data/CITE-seq/cite_seq_pbmc.rds"))

## For umap
umap_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_umap_n-neigbors_30_min-dist_0.3.rds"))

error_pbmc_umap <- gen_diffbin1_errors(highd_data = data, nldr_data = umap_pbmc,
                                       hd_thresh = 0, bin1_vec = 5:50) |>
  dplyr::mutate(method = "UMAP_30_min_dist_0.3")

write_rds(error_pbmc_umap, here::here("data/CITE-seq/error_CITE-seq_umap_n-neigbors_30_min-dist_0.3.rds"))

## For trimap
trimap_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_trimap_n-inliers_12_n-outliers_4_n-random_3.rds"))

error_pbmc_trimap <- gen_diffbin1_errors(highd_data = data, nldr_data = trimap_pbmc,
                                         hd_thresh = 0, bin1_vec = 5:50) |>
  dplyr::mutate(method = "trimap_n-inliers_12_n-outliers_4_n-random_3")

write_rds(error_pbmc_trimap, here::here("data/CITE-seq/error_CITE-seq_trimap_n-inliers_12_n-outliers_4_n-random_3.rds"))

## For pacmap
pacmap_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_pacmap_n-neighbors_10_init_random_MN-ratio_0.5_FP-ratio_2.rds"))

error_pbmc_pacmap <- gen_diffbin1_errors(highd_data = data, nldr_data = pacmap_pbmc,
                                         hd_thresh = 0, bin1_vec = 5:50) |>
  dplyr::mutate(method = "pacmap_n-neighbors_10_init_random_MN-ratio_0.5_FP-ratio_2")

write_rds(error_pbmc_pacmap, "data/CITE-seq/error_CITE-seq_pacmap_n-neighbors_10_init_random_MN-ratio_0.5_FP-ratio_2.rds")


## For umap
umap_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_umap_n-neigbors_15_min-dist_0.1.rds"))

error_pbmc_umap <- gen_diffbin1_errors(highd_data = data, nldr_data = umap_pbmc,
                                       hd_thresh = 0, bin1_vec = 5:50) |>
  dplyr::mutate(method = "UMAP_15_min_dist_0.1")

write_rds(error_pbmc_umap, here::here("data/CITE-seq/error_CITE-seq_umap_n-neigbors_15_min-dist_0.1.rds"))

## For umap
umap_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_umap_n-neigbors_54_min-dist_0.5.rds"))

error_pbmc_umap <- gen_diffbin1_errors(highd_data = data, nldr_data = umap_pbmc,
                                       hd_thresh = 0, bin1_vec = 5:50) |>
  dplyr::mutate(method = "UMAP_54_min_dist_0.5")

write_rds(error_pbmc_umap, here::here("data/CITE-seq/error_CITE-seq_umap_n-neigbors_54_min-dist_0.5.rds"))


## For tsne
tsne_pbmc <- read_rds(here::here("data/CITE-seq/CITE-seq_tsne_perplexity_84.rds"))

error_pbmc_tsne <- gen_diffbin1_errors(highd_data = data, nldr_data = tsne_pbmc,
                                       hd_thresh = 0, bin1_vec = 5:50) |>
  dplyr::mutate(method = "tSNE_perplexity_84")

write_rds(error_pbmc_tsne, here::here("data/CITE-seq/error_CITE-seq_tsne_perplexity_84.rds"))


error_pbmc <- bind_rows(error_pbmc_umap, #UMAP_30_min_dist_0.3
                        error_pbmc_umap2, #UMAP_15_min_dist_0.1
                        error_pbmc_trimap,
                        error_pbmc_pacmap,
                        error_pbmc_tsne)

error_pbmc <- error_pbmc |>
  mutate(a1 = round(a1, 2)) |>
  filter(b1 >= 5) |>
  filter(a1 >= 0.03) |>
  group_by(method, a1) |>
  filter(HBE == min(HBE)) |>
  ungroup()

error_pbmc <- error_pbmc |>
  mutate(method = factor(method,
                         levels = c("UMAP_30_min_dist_0.3", "UMAP_15_min_dist_0.1", "tSNE_perplexity_84", "trimap_n-inliers_12_n-outliers_4_n-random_3", "pacmap_n-neighbors_10_init_random_MN-ratio_0.5_FP-ratio_2")))


error_plot_limb <- plot_hbe(error_pbmc) +
  scale_x_continuous(breaks = sort(unique(error_pbmc$a1))[c(1, 5, 9, 13, 17, 21, 26)]) +
  scale_color_manual(values=c('#a65628','#999999','#e41a1c','#984ea3','#4daf4a','#ff7f00'))
