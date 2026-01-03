
interior_annotation <- function(label, position = c(0.92, 0.92), cex = 1, col="grey70") {
  annotation_custom(grid::textGrob(label = label,
                                   x = unit(position[1], "npc"), y = unit(position[2], "npc"),
                                   gp = grid::gpar(cex = cex, col=col)))
}

# Center the data by subtracting the mean of each column
center_data <- function(data) {
  center_values <- colMeans(data)
  data_centered <- sweep(data, 2, center_values, FUN = "-")  # subtract means
  data_centered
}

get_embeddings <- function(dt_structutre){

  embedding_data <- read_rds(here::here("data/vis-exp/embedding_data_three_clust_all.rds"))

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

}

# Get projection

get_projection <- function(projection, centered_data, axis_param) {

  projected <- as.matrix(centered_data) %*% projection
  projected_df <- projected |>
    tibble::as_tibble(.name_repair = "unique") |>
    dplyr::rename(c("proj1" = "...1",
                    "proj2" = "...2")) |>
    dplyr::mutate(ID = dplyr::row_number())

  limits <- axis_param$limits
  axis_scaled <- axis_param$axis_scaled
  axis_pos_x <- axis_param$axis_pos_x
  axis_pos_y <- axis_param$axis_pos_y
  threshold <- axis_param$threshold

  axes_obj <- gen_axes(
    proj = projection * axis_scaled,
    limits = limits,
    axis_pos_x = axis_pos_x,
    axis_pos_y = axis_pos_y,
    axis_labels = names(centered_data),
    threshold = threshold)

  axes <- axes_obj$axes
  circle <- axes_obj$circle

  return(list(projected_df = projected_df,
              axes = axes,
              circle = circle))

}

# Plot projection
plot_proj <- function(proj_obj,
                      point_param = c(1.5, 0.5, "#000000"), # size, alpha, color
                      plot_limits, title, cex = 2,
                      position = c(0.92, 0.92),
                      axis_text_size = 3,
                      is_color = FALSE) {

  projected_df <- proj_obj$projected_df
  axes <- proj_obj$axes
  circle <- proj_obj$circle

  if(is_color == FALSE) {

    initial_plot <- ggplot() +
      geom_point(
        data = projected_df,
        aes(
          x = proj1,
          y = proj2),
        size = as.numeric(point_param[1]),
        alpha = as.numeric(point_param[2]),
        color = point_param[3])

  } else {

    projected_df <- projected_df |>
      dplyr::mutate(cluster = proj_obj$cluster)

    initial_plot <- ggplot() +
      geom_point(
        data = projected_df,
        aes(
          x = proj1,
          y = proj2,
          color = cluster),
        size = as.numeric(point_param[1]),
        alpha = as.numeric(point_param[2]))

  }

  initial_plot <- initial_plot +
    geom_segment(
      data=axes,
      aes(x=x1, y=y1, xend=x2, yend=y2),
      colour="grey70") +
    geom_text(
      data=axes,
      aes(x=x2, y=y2),
      label=rownames(axes),
      colour="grey50",
      size = axis_text_size) +
    geom_path(
      data=circle,
      aes(x=c1, y=c2), colour="grey70") +
    xlim(plot_limits) +
    ylim(plot_limits) +
    interior_annotation(title, position, cex = cex)

  initial_plot

}

# Generate axes

gen_axes <- function(proj, limits = 1, axis_pos_x = NULL, axis_pos_y = NULL, axis_labels, threshold) {

  axis_scale <- limits/6

  if (is.null(axis_pos_x)) {

    axis_pos_x <- -2/3 * limits

  }

  if (is.null(axis_pos_y)) {

    axis_pos_y <- -2/3 * limits

  }

  adj <- function(x, axis_pos) axis_pos + x * axis_scale
  axes <- data.frame(x1 = adj(0, axis_pos_x),
                     y1 = adj(0, axis_pos_y),
                     x2 = adj(proj[, 1], axis_pos_x),
                     y2 = adj(proj[, 2], axis_pos_y))

  rownames(axes) <- axis_labels

  ## To remove axes
  axes <- axes |>
    mutate(distance = sqrt((x2 - x1)^2 + (y2 - y1)^2)) |>
    filter(distance >= threshold)

  theta <- seq(0, 2 * pi, length = 50)
  circle <- data.frame(c1 = adj(cos(theta), axis_pos_x),
                       c2 = adj(sin(theta), axis_pos_y))

  return(list(axes = axes, circle = circle))

}

plot_data_structures <- function(structure, ds_factor,
                                 method_vec = c("trimap", "umap", "pacmap", "tsne", "phate"),
                                 num_proj = 4){

  nldr1 <- get_embeddings(dt_structutre = structure) |>
    filter(scale_factor == ds_factor) |>
    filter(method %in% method_vec)

  nld_plt1 <- ggplot(
    data = nldr1,
    aes(
      x = emb1,
      y = emb2
    )
  ) +
    geom_point(alpha=0.2, size=1, colour = "black") +
    facet_wrap(~method, scales = "free") +
    theme(aspect.ratio = 1,
          strip.text = element_text(size = 20))

  three_clust_01_data <- high_d_data |>
    filter(dataset == structure) |>
    filter(scale_factor == ds_factor) |>
    filter(sample_size == 7500) |>
    pull(high_d_data)

  three_clust_01_data <- three_clust_01_data[[1]] |>
    select(-cluster)

  # Apply the scaling

  centered_three_clust_01_data <- center_data(three_clust_01_data) |>
    as_tibble()

  ## First projection
  prj1 <- cbind(
    c(0.13547,-0.08077,-0.14494,-0.06269),
    c(-0.02681,-0.20528,0.06918,0.04658))


  projected_df <- get_projection(projection = prj1,
                                 centered_data = centered_three_clust_01_data,
                                 axis_param = list(limits = 0.5,
                                                   axis_scaled = 3,
                                                   axis_pos_x = -0.4,
                                                   axis_pos_y = -0.4,
                                                   threshold = 0.03))


  three_clust01_proj1 <- plot_proj(
    proj_obj = projected_df,
    point_param = c(1, 0.05, "#000000"), # size, alpha, color
    plot_limits = c(-0.5, 0.5),
    title = "a1",
    cex = 2,
    axis_text_size = 4,
    is_color = FALSE)

  ## Second projection
  prj2 <- cbind(
    c(-0.13993,0.00179,-0.15287,-0.08282),
    c(0.01124,0.16552,-0.07749,0.12761))

  projected_df <- get_projection(projection = prj2,
                                 centered_data = centered_three_clust_01_data,
                                 axis_param = list(limits = 0.5,
                                                   axis_scaled = 4,
                                                   axis_pos_x = -0.45,
                                                   axis_pos_y = -0.45,
                                                   threshold = 0.055))

  three_clust01_proj2 <- plot_proj(
    proj_obj = projected_df,
    point_param = c(1, 0.05, "#000000"), # size, alpha, color
    plot_limits = c(-0.55, 0.55),
    title = "a2",
    cex = 2,
    axis_text_size = 4,
    is_color = FALSE)

  ## Third projection
  prj3 <- cbind(
    c(-0.09101,0.05539,0.18359,0.06896),
    c(-0.13489,0.06141,-0.12634,0.10901))

  projected_df <- get_projection(projection = prj3,
                                 centered_data = centered_three_clust_01_data,
                                 axis_param = list(limits = 0.5,
                                                   axis_scaled = 3.7,
                                                   axis_pos_x = -0.4,
                                                   axis_pos_y = -0.4,
                                                   threshold = 0.04))

  three_clust01_proj3 <- plot_proj(
    proj_obj = projected_df,
    point_param = c(1, 0.05, "#000000"), # size, alpha, color
    plot_limits = c(-0.5, 0.5),
    title = "a3",
    cex = 2,
    axis_text_size = 4,
    is_color = FALSE)

  ## Fourth projection
  prj4 <- cbind(
    c(-0.11690,-0.04468,-0.02008,-0.18371),
    c(-0.15317,0.11424,-0.08414,0.07888))


  projected_df <- get_projection(projection = prj4,
                                 centered_data = centered_three_clust_01_data,
                                 axis_param = list(limits = 0.5,
                                                   axis_scaled = 4,
                                                   axis_pos_x = -0.45,
                                                   axis_pos_y = -0.45,
                                                   threshold = 0.06))

  three_clust01_proj4 <- plot_proj(
    proj_obj = projected_df,
    point_param = c(1, 0.05, "#000000"), # size, alpha, color
    plot_limits = c(-0.55, 0.55),
    title = "a4",
    cex = 2,
    axis_text_size = 4,
    is_color = FALSE)

  if (num_proj == 4) {

    nld_plt1 | (three_clust01_proj1 | three_clust01_proj2) /
      (three_clust01_proj3 | three_clust01_proj4) +
      plot_layout(widths = c(1, 2))

  } else if (num_proj == 3) {

    nld_plt1 | (three_clust01_proj1 + three_clust01_proj2 + three_clust01_proj3) + plot_layout(ncol = 3)


  } else if (num_proj == 2) {

    nld_plt1 | (three_clust01_proj1 + three_clust01_proj2) + plot_layout(ncol = 2)


  }

}
