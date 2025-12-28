high_d_data <- read_rds(here::here("data/high_d_data_four_close_clust_all.rds"))

high_d_data_selected <- high_d_data |>
  filter(dataset == "four_clust_01") |>
  filter(sample_size == 7500) |>
  select(scale_factor, high_d_data)

high_d_data_selected1 <- high_d_data_selected |>
  filter(scale_factor == 1) |>
  pull(high_d_data)

calculate_pca <- function(feature_dataset){
  pcaY_cal <- prcomp(feature_dataset, center = TRUE, scale = FALSE)
  PCAresults <- data.frame(pcaY_cal$x[, 1:2])
  summary_pca <- summary(pcaY_cal)
  var_explained_df <- data.frame(PC= paste0("PC",1:2),
                                 var_explained=(pcaY_cal$sdev[1:2])^2/sum((pcaY_cal$sdev[1:2])^2))
  return(list(prcomp_out = pcaY_cal,pca_components = PCAresults, summary = summary_pca, var_explained_pca  = var_explained_df))
}

df <- high_d_data_selected1[[1]] |> select(-cluster)

calculate_pca(df)

