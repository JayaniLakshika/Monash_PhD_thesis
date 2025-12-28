library(tidyverse)
library(langevitour)
library(plotly)
library(crosstalk)

###########Read high-dimensional data ##########################################
high_d_data <- read_rds(here::here("data/high_d_data_three_close_clust_all.rds"))

###########Read NLDR data ##########################################
embedding_data <- read_rds(here::here("data/embedding_data_three_clust_all.rds"))

## To get NLDR for specific data structure
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

## To vis NLDR layout
plot_data_structures <- function(structure, ds_factor = 1, nldr){

  nldr1 <- get_embeddings(dt_structutre = structure) |>
    filter(scale_factor == ds_factor) |>
    filter(method != "pca") |>
    filter(method == nldr)

  nld_plt1 <- ggplot(
    data = nldr1,
    aes(
      x = emb1,
      y = emb2
    )
  ) +
    geom_point(alpha=0.2, size=1, colour = "#000000") +
    theme(aspect.ratio = 1)

  nld_plt1

}

## To generate link plot

gen_link_plts <- function(structure, nldr, ds_factor = 1) {

  clust_data <- high_d_data |>
    filter(dataset == structure) |>
    filter(scale_factor == ds_factor) |>
    filter(sample_size == 7500) |>
    pull(high_d_data)

  clust_data <- clust_data[[1]] |>
    select(-cluster)

  nldr_data <- get_embeddings(dt_structutre = structure) |>
    filter(scale_factor == ds_factor) |>
    filter(method != "pca") |>
    filter(method == nldr)

  data_all <- dplyr::bind_cols(clust_data, nldr_data)

  shared_df <- crosstalk::SharedData$new(data_all)

  nldr_plt <- shared_df |>
    ggplot(aes(x = emb1, y = emb2)) +
    geom_point(alpha=0.5, colour="#000000", size = 0.5) +
    theme_linedraw() +
    theme(
      #aspect.ratio = 1,
      plot.background = element_rect(fill = 'transparent', colour = NA),
      plot.title = element_text(size = 7, hjust = 0.5, vjust = -0.5),
      panel.background = element_rect(fill = 'transparent',
                                      colour = NA),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.title.x = element_blank(), axis.title.y = element_blank(),
      axis.text.x = element_blank(), axis.ticks.x = element_blank(),
      axis.text.y = element_blank(), axis.ticks.y = element_blank()
    )

  nldr_plt <- ggplotly(nldr_plt, width = "600",
                       height = "600", tooltip = "none") |>
    style(unselected=list(marker=list(opacity=1))) |>
    highlight(on="plotly_selected", off="plotly_deselect") |>
    config(displayModeBar = FALSE)


  langevitour_output <- langevitour::langevitour(clust_data[1:4],
                                                 levelColors = "#000000",
                                                 link=shared_df,
                                                 linkFilter=FALSE)

  linked_plt <- crosstalk::bscols(
    htmltools::div(style="display: grid; grid-template-columns: 1fr 1fr;",
                   nldr_plt,
                   langevitour_output),
    device = "sm"
  )

  linked_plt
}

### three_clust_04

three_clust_04_data <- high_d_data |>
  filter(dataset == "three_clust_04") |>
  filter(scale_factor == 1) |>
  filter(sample_size == 7500) |>
  pull(high_d_data)

three_clust_04_data <- three_clust_04_data[[1]] |>
  select(-cluster)

langevitour(three_clust_04_data)
plot_data_structures(structure = "three_clust_04", ds_factor = 1, nldr = "pacmap")
gen_link_plts("three_clust_04", nldr = "pacmap")

### three_clust_08

three_clust_08_data <- high_d_data |>
  filter(dataset == "three_clust_08") |>
  filter(scale_factor == 1) |>
  filter(sample_size == 7500) |>
  pull(high_d_data)

three_clust_08_data <- three_clust_08_data[[1]] |>
  select(-cluster)

langevitour(three_clust_08_data)
plot_data_structures(structure = "three_clust_08", ds_factor = 1, nldr = "pacmap")
gen_link_plts("three_clust_08", nldr = "pacmap")

### three_clust_12

three_clust_12_data <- high_d_data |>
  filter(dataset == "three_clust_12") |>
  filter(scale_factor == 1) |>
  filter(sample_size == 7500) |>
  pull(high_d_data)

three_clust_12_data <- three_clust_12_data[[1]] |>
  select(-cluster)

langevitour(three_clust_12_data)
plot_data_structures(structure = "three_clust_12", ds_factor = 1, nldr = "pacmap")
gen_link_plts("three_clust_12", nldr = "pacmap")

### three_clust_16

three_clust_16_data <- high_d_data |>
  filter(dataset == "three_clust_16") |>
  filter(scale_factor == 1) |>
  filter(sample_size == 7500) |>
  pull(high_d_data)

three_clust_16_data <- three_clust_16_data[[1]] |>
  select(-cluster)

langevitour(three_clust_16_data)
plot_data_structures(structure = "three_clust_16", ds_factor = 1, nldr = "pacmap")
gen_link_plts("three_clust_16", nldr = "pacmap")
