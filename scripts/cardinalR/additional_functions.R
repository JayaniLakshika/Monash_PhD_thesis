# Add plot label

interior_annotation <- function(label, position = c(0.92, 0.92), cex = 1, col="grey70") {
  annotation_custom(grid::textGrob(label = label,
                                   x = unit(position[1], "npc"), y = unit(position[2], "npc"),
                                   gp = grid::gpar(cex = cex, col=col)))
}

# Scale high-d data

# Center the data by subtracting the mean of each column
center_data <- function(data) {
  apply(data, 2, function(col) col - mean(col))
}

# Function to scale data manually
scale_data_manual <- function(data) {
  # Step 1: Center the data (mean 0)
  data_centered <- center_data(data)

  # Step 2: Calculate the standard deviation of each dimension
  sds <- apply(data_centered, 2, sd)

  # Step 3: Scale each dimension to have the range [0, 1]
  data_scaled <- apply(data_centered, 2, function(col) col / max(abs(col)))

  # Step 4: Scale dimensions according to their variation
  # The dimension with the highest standard deviation is scaled to [-1, 1]
  # Other dimensions are scaled to smaller ranges based on their standard deviations
  max_sd <- max(sds)

  # Normalize the standard deviations to get scaling factors
  scaling_factors <- sds / max_sd

  for (i in seq_along(scaling_factors)) {
    data_scaled[, i] <- data_scaled[, i] * scaling_factors[i]
  }

  # Combine the scaled data with the 'type' column and return as a tibble
  data_scaled <- as_tibble(data_scaled)

  return(data_scaled)
}

# Get projection

get_projection <- function(projection, proj_scale, scaled_data,
                           axis_param) {

  projection_scaled <- projection * proj_scale
  projected <- as.matrix(scaled_data) %*% projection_scaled

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
    axis_labels = names(scaled_data),
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


plot_rmse <- function(error_df) {

  ggplot(error_df,
         aes(x = a1,
             y = RMSE,
             colour = method)) +
    geom_point(size = 0.8) +
    geom_line(linewidth = 0.3) +
    ylab("RMSE") +
    xlab(expression(paste("binwidth (", a[1], ")"))) +
    theme_minimal() +
    theme(panel.border = element_rect(fill = 'transparent'),
          plot.title = element_text(size = 12, hjust = 0.5, vjust = -0.5),
          axis.ticks.x = element_line(),
          axis.ticks.y = element_line(),
          legend.position = "none",
          axis.text.x = element_text(size = 7),
          axis.text.y = element_text(size = 7),
          axis.title.x = element_text(size = 7),
          axis.title.y = element_text(size = 7),
          plot.margin = margin(0, 0, 0, 0))

}

