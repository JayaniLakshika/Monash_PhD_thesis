### This script is to looks embedding and highD data with four clusters

library(readr)
library(dplyr)
library(ggplot2)

## 2D layouts

embedding_data <- read_rds(here::here("data/embedding_data_four_clust_all.rds"))

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
      embedding_plots_trimap + embedding_plots_pca +
      plot_layout(nrow = 6)

  }

}

vis_nldr_layouts("four_clust_01")
vis_nldr_layouts("four_clust_02")
vis_nldr_layouts("four_clust_03")
vis_nldr_layouts("four_clust_04")
vis_nldr_layouts("four_clust_05")
vis_nldr_layouts("four_clust_06")
vis_nldr_layouts("four_clust_07")
vis_nldr_layouts("four_clust_08")
vis_nldr_layouts("four_clust_09")
vis_nldr_layouts("four_clust_10")
vis_nldr_layouts("four_clust_11")
vis_nldr_layouts("four_clust_12")
vis_nldr_layouts("four_clust_13")
vis_nldr_layouts("four_clust_14")
vis_nldr_layouts("four_clust_15")
vis_nldr_layouts("four_clust_16")
vis_nldr_layouts("four_clust_17")
vis_nldr_layouts("four_clust_18")

high_d_data <- read_rds(here::here("data/high_d_data_four_close_clust_all.rds"))

vis_highd_data <- function(dt_structutre, sf_fac = 1){
  high_d_data_selected <- high_d_data |>
    filter(scale_factor == sf_fac) |>
    filter(dataset == dt_structutre) |>
    pull(high_d_data)

  high_d_data_selected <- high_d_data_selected[[1]] |>
    select(-cluster)
  langevitour::langevitour(high_d_data_selected)
}

vis_highd_data("four_clust_01")
vis_highd_data("four_clust_02")
vis_highd_data("four_clust_03")
vis_highd_data("four_clust_04")
vis_highd_data("four_clust_05")
vis_highd_data("four_clust_06")
vis_highd_data("four_clust_07")
vis_highd_data("four_clust_08")
vis_highd_data("four_clust_09")
vis_highd_data("four_clust_10")
vis_highd_data("four_clust_11")
vis_highd_data("four_clust_12")
vis_highd_data("four_clust_13")
vis_highd_data("four_clust_14")
vis_highd_data("four_clust_15")
vis_highd_data("four_clust_16")
vis_highd_data("four_clust_17")
vis_highd_data("four_clust_18")
