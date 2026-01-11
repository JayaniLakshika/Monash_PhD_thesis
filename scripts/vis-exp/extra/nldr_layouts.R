## \gD{} layouts
library(tidyverse)
library(patchwork)

#embedding_data <- read_rds(here::here("data/embedding_data_four_clust_all.rds"))
embedding_data <- read_rds(here::here("data/embedding_data_three_clust_all.rds"))

get_embeddings <- function(dt_structutre, observe_factor = "scale_factor"){

  if (observe_factor == "scale_factor") {

    embedding_data_selected <- embedding_data |>
      filter(dataset == dt_structutre) |>
      filter(num_noise == 0) |>
      filter(bkg_noise == 0) |>
      filter((n_neighbors == "default") |
               is.na(n_neighbors)) |>
      filter(sample_size == 7500) |>
      select(method, scale_factor, embedding_data)

    embedding_exapnd_df <- data.frame()

    # Create a list of combinations for sample_size, method, and scale_factor
    combinations <- expand_grid(
      method = unique(embedding_data_selected$method),
      scale_factor = unique(embedding_data_selected$scale_factor)
    )

    # Use pmap to iterate through each combination
    embedding_exapnd_df <- combinations |>
      pmap_dfr(function(method, scale_factor) {
        embedding_data_sf <- embedding_data_selected |>
          filter(method == !!method,
                 scale_factor == !!scale_factor) |>
          pull(embedding_data)

        # Access the embedding data list and mutate the columns
        embedding_data_sf[[1]] |>
          mutate(method = !!method,
                 scale_factor = !!scale_factor)
      })

    embedding_exapnd_df

  } else if(observe_factor == "sample_size"){

    embedding_data_selected <- embedding_data |>
      filter(dataset == dt_structutre) |>
      filter(num_noise == 0) |>
      filter(bkg_noise == 0) |>
      filter((n_neighbors == "default") |
               is.na(n_neighbors)) |>
      filter(scale_factor == 1) |>
      select(method, sample_size, embedding_data)

    embedding_exapnd_df <- data.frame()

    # Create a list of combinations for sample_size, method, and scale_factor
    combinations <- expand_grid(
      method = unique(embedding_data_selected$method),
      sample_size = unique(embedding_data_selected$sample_size)
    )

    # Use pmap to iterate through each combination
    embedding_exapnd_df <- combinations |>
      pmap_dfr(function(method, sample_size) {
        embedding_data_sf <- embedding_data_selected |>
          filter(method == !!method,
                 sample_size == !!sample_size) |>
          pull(embedding_data)

        # Access the embedding data list and mutate the columns
        embedding_data_sf[[1]] |>
          mutate(method = !!method,
                 sample_size = !!sample_size)
      })

    embedding_exapnd_df

  } else if(observe_factor == "num_noise"){

    embedding_data_selected <- embedding_data |>
      filter(dataset == dt_structutre) |>
      filter(sample_size == 7500) |>
      filter(bkg_noise == 0) |>
      filter((n_neighbors == "default") |
               is.na(n_neighbors)) |>
      filter(scale_factor == 1) |>
      select(method, num_noise, embedding_data)

    embedding_exapnd_df <- data.frame()

    # Create a list of combinations for sample_size, method, and scale_factor
    combinations <- expand_grid(
      method = unique(embedding_data_selected$method),
      num_noise = unique(embedding_data_selected$num_noise)
    )

    # Use pmap to iterate through each combination
    embedding_exapnd_df <- combinations |>
      pmap_dfr(function(method, num_noise) {
        embedding_data_sf <- embedding_data_selected |>
          filter(method == !!method,
                 num_noise == !!num_noise) |>
          pull(embedding_data)

        # Access the embedding data list and mutate the columns
        embedding_data_sf[[1]] |>
          mutate(method = !!method,
                 num_noise = !!num_noise)
      })

    embedding_exapnd_df

  } else if(observe_factor == "bkg_noise"){

    embedding_data_selected <- embedding_data |>
      filter(dataset == dt_structutre) |>
      filter(sample_size == 7500) |>
      filter(num_noise == 0) |>
      filter((n_neighbors == "default") |
               is.na(n_neighbors)) |>
      filter(scale_factor == 1) |>
      select(method, bkg_noise, embedding_data)

    embedding_exapnd_df <- data.frame()

    # Create a list of combinations for sample_size, method, and scale_factor
    combinations <- expand_grid(
      method = unique(embedding_data_selected$method),
      bkg_noise = unique(embedding_data_selected$bkg_noise)
    )

    # Use pmap to iterate through each combination
    embedding_exapnd_df <- combinations |>
      pmap_dfr(function(method, bkg_noise) {
        embedding_data_sf <- embedding_data_selected |>
          filter(method == !!method,
                 bkg_noise == !!bkg_noise) |>
          pull(embedding_data)

        # Access the embedding data list and mutate the columns
        embedding_data_sf[[1]] |>
          mutate(method = !!method,
                 bkg_noise = !!bkg_noise)
      })

    embedding_exapnd_df

  } else if(observe_factor == "n_neighbors"){

    embedding_data_selected <- embedding_data |>
      filter(dataset == dt_structutre) |>
      filter(sample_size == 7500) |>
      filter(num_noise == 0) |>
      filter(bkg_noise == 0) |>
      filter(scale_factor == 1) |>
      filter(!is.na(n_neighbors)) |>
      select(method, n_neighbors, embedding_data)

    embedding_exapnd_df <- data.frame()

    # Create a list of combinations for sample_size, method, and n_neighbors
    combinations <- expand_grid(
      method = unique(embedding_data_selected$method),
      n_neighbors = unique(embedding_data_selected$n_neighbors)
    )

    # Use pmap to iterate through each combination
    embedding_exapnd_df <- combinations |>
      pmap_dfr(function(method, n_neighbors) {
        embedding_data_sf <- embedding_data_selected |>
          filter(method == !!method,
                 n_neighbors == !!n_neighbors) |>
          pull(embedding_data)

        # Access the embedding data list and mutate the columns
        embedding_data_sf[[1]] |>
          mutate(method = !!method,
                 n_neighbors = !!n_neighbors)
      })

    embedding_exapnd_df

  } else {
    print("error!!!!")
  }

}

vis_nldr_layouts <- function(dt_structutre, observe_factor = "scale_factor"){

  embedding_exapnd_df <- get_embeddings(dt_structutre, observe_factor)

  if (observe_factor == "scale_factor") {

    embedding_exapnd_df <- embedding_exapnd_df |>
      mutate(scale_factor = paste0("distance sf = ", scale_factor))

  } else if (observe_factor == "sample_size") {

    embedding_exapnd_df <- embedding_exapnd_df |>
      mutate(sample_size = paste0("sample size = ", sample_size)) |>
      mutate(sample_size = factor(sample_size, levels = c("sample size = 375", "sample size = 1500", "sample size = 7500")))

  } else if (observe_factor == "num_noise") {

    embedding_exapnd_df <- embedding_exapnd_df |>
      mutate(num_noise = paste0("noise dims = ", num_noise))

  } else if (observe_factor == "bkg_noise") {

    embedding_exapnd_df <- embedding_exapnd_df |>
      mutate(bkg_noise = paste0("bkg_noise = ", bkg_noise * 100, "%"))

  } else if (observe_factor == "n_neighbors") {

    embedding_exapnd_df <- embedding_exapnd_df |>
      mutate(n_neighbors = paste0("n_neighbors = ", n_neighbors)) |>
      mutate(n_neighbors = factor(n_neighbors, levels = c("n_neighbors = 0.6", "n_neighbors = default", "n_neighbors = 1.7")))

  }

  embedding_plots_tsne <- ggplot(
    data = embedding_exapnd_df |> filter(method == "tsne"),
    aes(
      x = emb1,
      y = emb2
    )
  ) +
    geom_point(
      size = 0.5,
      alpha = 0.1
    ) +
    facet_grid(method ~ get(observe_factor), scales = "free") +
    theme(
      strip.text.x = element_text(size = 20),
      strip.text.y = element_text(size = 25)
    )

  embedding_plots_umap <- ggplot(
    data = embedding_exapnd_df |> filter(method == "umap"),
    aes(
      x = emb1,
      y = emb2
    )
  ) +
    geom_point(
      size = 0.5,
      alpha = 0.1
    ) +
    facet_grid(method ~ get(observe_factor), scales = "free") +
    theme(
      strip.text.x = element_blank(),
      strip.text.y = element_text(size = 25)
    )

  embedding_plots_phate <- ggplot(
    data = embedding_exapnd_df |> filter(method == "phate"),
    aes(
      x = emb1,
      y = emb2
    )
  ) +
    geom_point(
      size = 0.5,
      alpha = 0.1
    ) +
    facet_grid(method ~ get(observe_factor), scales = "free") +
    theme(
      strip.text.x = element_blank(),
      strip.text.y = element_text(size = 25)
    )

  embedding_plots_trimap <- ggplot(
    data = embedding_exapnd_df |> filter(method == "trimap"),
    aes(
      x = emb1,
      y = emb2
    )
  ) +
    geom_point(
      size = 0.5,
      alpha = 0.1
    ) +
    facet_grid(method ~ get(observe_factor), scales = "free") +
    theme(
      strip.text.x = element_blank(),
      strip.text.y = element_text(size = 25)
    )

  embedding_plots_pacmap <- ggplot(
    data = embedding_exapnd_df |> filter(method == "pacmap"),
    aes(
      x = emb1,
      y = emb2
    )
  ) +
    geom_point(
      size = 0.5,
      alpha = 0.1
    ) +
    facet_grid(method ~ get(observe_factor), scales = "free") +
    theme(
      strip.text.x = element_blank(),
      strip.text.y = element_text(size = 25)
    )

  if (observe_factor == "n_neighbors") {

    embedding_plots_tsne + embedding_plots_umap +
      embedding_plots_phate + embedding_plots_pacmap +
      embedding_plots_trimap  +
      plot_layout(nrow = 5)

  } else{

    embedding_plots_pca <- ggplot(
      data = embedding_exapnd_df |> filter(method == "pca"),
      aes(
        x = emb1,
        y = emb2
      )
    ) +
      geom_point(
        size = 0.5,
        alpha = 0.1
      ) +
      facet_grid(method ~ get(observe_factor), scales = "free") +
      theme(
        strip.text.x = element_blank(),
        strip.text.y = element_text(size = 25)
      )

    embedding_plots_tsne + embedding_plots_umap +
      embedding_plots_phate + embedding_plots_pacmap +
      embedding_plots_trimap + #embedding_plots_pca +
      plot_layout(nrow = 5)

  }

}

# vis_nldr_layouts("four_clust_01")
# vis_nldr_layouts("four_clust_02")
# vis_nldr_layouts("four_clust_03")
# vis_nldr_layouts("four_clust_04")
# vis_nldr_layouts("four_clust_05")
# vis_nldr_layouts("four_clust_06")
# vis_nldr_layouts("four_clust_07")
# vis_nldr_layouts("four_clust_08")
# vis_nldr_layouts("four_clust_09")
# vis_nldr_layouts("four_clust_10")
# vis_nldr_layouts("four_clust_11")
# vis_nldr_layouts("four_clust_12")
# vis_nldr_layouts("four_clust_13")
# vis_nldr_layouts("four_clust_14")
# vis_nldr_layouts("four_clust_15")
# vis_nldr_layouts("four_clust_16")
# vis_nldr_layouts("four_clust_17")
# vis_nldr_layouts("four_clust_18")




### Distance scale factor

# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 1."

vis_nldr_layouts("three_clust_01")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 2."

vis_nldr_layouts("three_clust_02")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 3."

vis_nldr_layouts("three_clust_03")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 4."

vis_nldr_layouts("three_clust_04")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 5."

vis_nldr_layouts("three_clust_05")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 6."

vis_nldr_layouts("three_clust_06")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 7."

vis_nldr_layouts("three_clust_07")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 8."

vis_nldr_layouts("three_clust_08")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 9."

vis_nldr_layouts("three_clust_09")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 10."

vis_nldr_layouts("three_clust_10")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 11."

vis_nldr_layouts("three_clust_11")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 12."

vis_nldr_layouts("three_clust_12")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 13."

vis_nldr_layouts("three_clust_13")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 14."

vis_nldr_layouts("three_clust_14")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 15."

vis_nldr_layouts("three_clust_15")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 16."

vis_nldr_layouts("three_clust_16")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 17."

vis_nldr_layouts("three_clust_17")
# ```
#
# ```{r}
# #| fig-height: 18
# #| fig-width: 9
# #| out-height: 85%
# #| fig-cap: "Eighteen different NLDR layout for different NLDR methods and distance scale factor combinations of data structure 18."

vis_nldr_layouts("three_clust_18")
# ```
#
#
# ```{r}
# #| label: tbl-dist-centroid
# #| tbl-cap: "$4\\text{-}D$ distances between centroid points in clusters."

all_dist_centroids <- bind_rows(compute_centroid_clusters("three_clust_01"),
                                compute_centroid_clusters("three_clust_02"),
                                compute_centroid_clusters("three_clust_03"),
                                compute_centroid_clusters("three_clust_04"),
                                compute_centroid_clusters("three_clust_05"),
                                compute_centroid_clusters("three_clust_06"),
                                compute_centroid_clusters("three_clust_07"),
                                compute_centroid_clusters("three_clust_08"),
                                compute_centroid_clusters("three_clust_09"),
                                compute_centroid_clusters("three_clust_10"),
                                compute_centroid_clusters("three_clust_11"),
                                compute_centroid_clusters("three_clust_12"),
                                compute_centroid_clusters("three_clust_13"),
                                compute_centroid_clusters("three_clust_14"),
                                compute_centroid_clusters("three_clust_15"),
                                compute_centroid_clusters("three_clust_16"),
                                compute_centroid_clusters("three_clust_17"),
                                compute_centroid_clusters("three_clust_18"))

all_dist_centroids <- all_dist_centroids |>
  rename(c("structure" = "data_structure",
           "dist_sf" = "distance_sf"))

all_dist_centroids |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    longtable = TRUE,
                    label = "dist_centroid") |>
  column_spec(1, width = "6em") |>
  column_spec(3, width = "6em") |>
  column_spec(4, width = "6em") |>
  column_spec(5, width = "6em") |>
  kableExtra::kable_styling(latex_options = "scale_down")
# ```
#
# ```{r}
# #| label: tbl-dist
# #| tbl-cap: "$4\\text{-}D$ distances between closest points in clusters."

all_dist <- bind_rows(compute_min_dist_btw_clusters("three_clust_01"),
                      compute_min_dist_btw_clusters("three_clust_02"),
                      compute_min_dist_btw_clusters("three_clust_03"),
                      compute_min_dist_btw_clusters("three_clust_04"),
                      compute_min_dist_btw_clusters("three_clust_05"),
                      compute_min_dist_btw_clusters("three_clust_06"),
                      compute_min_dist_btw_clusters("three_clust_07"),
                      compute_min_dist_btw_clusters("three_clust_08"),
                      compute_min_dist_btw_clusters("three_clust_09"),
                      compute_min_dist_btw_clusters("three_clust_10"),
                      compute_min_dist_btw_clusters("three_clust_11"),
                      compute_min_dist_btw_clusters("three_clust_12"),
                      compute_min_dist_btw_clusters("three_clust_13"),
                      compute_min_dist_btw_clusters("three_clust_14"),
                      compute_min_dist_btw_clusters("three_clust_15"),
                      compute_min_dist_btw_clusters("three_clust_16"),
                      compute_min_dist_btw_clusters("three_clust_17"),
                      compute_min_dist_btw_clusters("three_clust_18"))

all_dist |>
  select(data_structure, distance_sf,
         min_dist12, min_dist13, min_dist23, prop12, prop13, prop23) |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    longtable = TRUE,
                    label = "dist") |>
  kableExtra::kable_styling(latex_options = "scale_down")
# ```
#
# ```{r}
# #| label: fig-dist-comp
# #| fig-cap: "Distance comparion of data structure 1 with scale factor $0.1$. Green color represents 2D distances, while Orange color represents 4D distances."
# #| eval: false
## Obtain 2D embeddings
dist_2d <- get_embeddings("three_clust_01") |>
  filter(method == "tsne") |>
  filter(scale_factor == 0.1)
## Obtain high-D data
data <- high_d_data |>
  filter(dataset == "three_clust_01") |>
  filter(scale_factor == 0.1) |>
  filter(sample_size == 7500) |>
  filter(num_noise == 0) |>
  filter(bkg_noise == 0) |>
  pull(high_d_data)

data <- data[[1]]
## Add cluster column to 2D data
cluster_df <- data |>
  select(cluster)

dist_2d <- bind_cols(dist_2d, cluster_df)

## Compute high-D distances
dist_highd <- compute_min_dist_btw_clusters("three_clust_01") |>
  filter(distance_sf == 0.1)

dist_highd <- dist_highd |>
  select(from_1_2, to_1_2, dist_1_2,
         from_1_3, to_1_3, dist_1_3,
         from_2_3, to_2_3, dist_2_3)

# Reshape the data into long format
dist_long <- dist_highd |>
  pivot_longer(cols = everything(),
               names_to = c(".value", "cluster_type"),
               names_pattern = "(from|to|dist)_(1_2|1_3|2_3)") |>
  mutate(cluster_type = paste0("cluster", cluster_type)) |>
  filter(!is.na(from) & !is.na(to)) |>  # Filter out rows with NA values
  rename(dist_4d = dist)

## Cluster 1 & 2
clust1 <- dist_2d |> filter(cluster == "cluster1") |> filter(row_number() == 448) |>
  select(emb1, emb2)
clust2 <- dist_2d |> filter(cluster == "cluster1") |> filter(row_number() == 269) |>
  select(emb1, emb2)
clust1_2 <- bind_rows(clust1, clust2)

dist_vec <- proxy::dist(x = clust1_2, y = clust1_2, method = "Euclidean") |> as.vector()

from_vec <- rep(1:nrow(clust1), nrow(clust2))
to_vec <- rep(1:nrow(clust2), each = nrow(clust1))

clust1_2_dist <- tibble(from = from_vec, to = to_vec, dist_2d = dist_vec)|>
  distinct() |>
  filter(dist_2d != 0)

## Cluster 1 & 3
clust1 <- dist_2d |> filter(cluster == "cluster1") |> filter(row_number() == 26) |>
  select(emb1, emb2)
clust3 <- dist_2d |> filter(cluster == "cluster3") |> filter(row_number() == 297) |>
  select(emb1, emb2)
clust1_3 <- bind_rows(clust1, clust2)

dist_vec <- proxy::dist(x = clust1_3, y = clust1_3, method = "Euclidean") |> as.vector()

from_vec <- rep(1:nrow(clust1), nrow(clust3))
to_vec <- rep(1:nrow(clust3), each = nrow(clust1))

clust1_3_dist <- tibble(from = from_vec, to = to_vec, dist_2d = dist_vec)|>
  distinct() |>
  filter(dist_2d != 0)

## Cluster 2 & 3
clust2 <- dist_2d |> filter(cluster == "cluster2") |> filter(row_number() == 26) |>
  select(emb1, emb2)
clust3 <- dist_2d |> filter(cluster == "cluster3") |> filter(row_number() == 242) |>
  select(emb1, emb2)
clust2_3 <- bind_rows(clust1, clust2)

dist_vec <- proxy::dist(x = clust2_3, y = clust2_3, method = "Euclidean") |> as.vector()

from_vec <- rep(1:nrow(clust2), nrow(clust3))
to_vec <- rep(1:nrow(clust3), each = nrow(clust2))

clust2_3_dist <- tibble(from = from_vec, to = to_vec, dist_2d = dist_vec)|>
  distinct() |>
  filter(dist_2d != 0)

clust_2d_dist <- bind_rows(clust1_2_dist,
                           clust1_3_dist,
                           clust2_3_dist) |>
  select(dist_2d)

dist_long <- bind_cols(dist_long, clust_2d_dist)

# Create the plot
ggplot(data = dist_long) +
  # Draw arrows from 2d to 4d
  geom_segment(aes(x = cluster_type, xend = cluster_type,
                   y = dist_2d,
                   yend = dist_4d),
               #arrow = arrow(length = unit(0.1, "inches")),
               color = "#636363") +# Plot points for both 2d and 4d
  geom_point(aes(x = cluster_type,
                 y = dist_2d), color = "#1b9e77", size = 2) +
  geom_point(aes(x = cluster_type,
                 y = dist_4d), color = "#d95f02", size = 2) +
  theme_minimal() +
  theme(legend.position = "bottom",
        legend.text = element_text(size = 10)) +
  coord_flip() +
  ylab("distance")
# ```

