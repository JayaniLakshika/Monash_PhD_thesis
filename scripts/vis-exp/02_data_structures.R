#### This script contains functions to generate the data structures

## Data structure 1
three_clust_01 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  curvilinear_cluster <- gen_curv_4d(
    n = n * 7/15,
    offset = c(0, 0, 0, 0)
  ) |>
    mutate(cluster = "cluster1")

  # Manually subtract column means
  curvilinear_cluster <- apply(curvilinear_cluster, 2,
                               function(col) col - mean(col))

  curvilinear_cluster <- as_tibble(curvilinear_cluster +
                                  matrix(rep(triangle_vertices[1,], n * 7/15),
                                         ncol=4, byrow=T))

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = c(0, 0, 0, 0)
  ) |>
    mutate(cluster = "cluster2")


  # Manually subtract column means
  elliptical_cluster <- apply(elliptical_cluster, 2,
                               function(col) col - mean(col))

  elliptical_cluster <- as_tibble(elliptical_cluster +
                                    matrix(rep(triangle_vertices[2,], n * 3/15),
                                           ncol=4, byrow=T))

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = c(0, 0, 0, 0)
  ) |>
    mutate(cluster = "cluster3")


  # Manually subtract column means
  blunted_corn_cluster <- apply(blunted_corn_cluster, 2,
                              function(col) col - mean(col))

  blunted_corn_cluster <- as_tibble(blunted_corn_cluster +
                                      matrix(rep(triangle_vertices[3,], n * 5/15),
                                             ncol=4, byrow=T))

  df <- bind_rows(curvilinear_cluster,
                  elliptical_cluster,
                  blunted_corn_cluster)

  df

}

## Data structure 2
three_clust_02 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  nonlinear_cluster <- gen_s_curve_4d(
    n = n * 7/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 5/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(nonlinear_cluster,
                  cube_cluster,
                  rect_corn_cluster)

  df

}

## Data structure 3

three_clust_03 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  nonlinear_cluster <- gen_curvy_cylinder_4d(
    n = n * 7/15,
    radius = 1,
    height = 10,
    curve_strength = 1,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 5/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(nonlinear_cluster,
                  hemisphere_cluster,
                  tri_corn_cluster)

  df

}

## Data structure 4

three_clust_04 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  curvilinear_cluster <- gen_curv2_4d(
    n = n * 7/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(curvilinear_cluster,
                  gau_cluster,
                  hex_pyr_cluster)

  df

}

## Data structure 5

three_clust_05 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  hyperbola_cluster <- gen_nonlinear_hyperbola_4d(
    n = n * 7/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(hyperbola_cluster,
                  elliptical_cluster,
                  blunted_corn_cluster)

  df

}

## Data structure 6

three_clust_06 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  curvilinear_cluster <- gen_crescent_4d(
    n = n * 7/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 5/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(curvilinear_cluster,
                  cube_cluster,
                  rect_corn_cluster)

  df

}

## Data structure 7

three_clust_07 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  hyperbola_cluster <- gen_nonlinear_hyperbola2_4d(
    n = n * 7/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 5/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(hyperbola_cluster,
                  hemisphere_cluster,
                  tri_corn_cluster)

  df

}

## Data structure 8

three_clust_08 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  spiral_cluster <- gen_conic_spiral_4d(
    n = n * 7/15,
    spiral_turns = 1,
    cone_height = 2,
    cone_radius = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(spiral_cluster,
                  gau_cluster,
                  hex_pyr_cluster)

  df

}


## Data structure 9

three_clust_09 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  helical_cluster <- gen_helical_hyper_spiral_4d(
    n = n * 7/15,
    a = 0.1,
    b = 0.1,
    k = 2,
    spiral_radius = 1,
    scale_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(helical_cluster,
                  cube_cluster,
                  blunted_corn_cluster)

  df

}


## Data structure 10

three_clust_10 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  spherical_spiral_cluster <- gen_spherical_spiral_4d(
    n = n * 7/15,
    radius = 1,
    spiral_turns = 1,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 5/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(spherical_spiral_cluster,
                  gau_cluster,
                  tri_corn_cluster)

  df

}

## Data structure 11

three_clust_11 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  curvilinear_cluster <- gen_curv_4d(
    n = n * 7/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 5/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(curvilinear_cluster,
                  elliptical_cluster,
                  rect_corn_cluster)

  df

}

## Data structure 12

three_clust_12 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  nonlinear_cluster <- gen_s_curve_4d(
    n = n * 7/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(nonlinear_cluster,
                  hemisphere_cluster,
                  hex_pyr_cluster)

  df

}

## Data structure 13

three_clust_13 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  nonlinear_cluster <- gen_curvy_cylinder_4d(
    n = n * 7/15,
    radius = 1,
    height = 10,
    curve_strength = 1,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(nonlinear_cluster,
                  cube_cluster,
                  blunted_corn_cluster)

  df

}

## Data structure 14

three_clust_14 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  curvilinear_cluster <- gen_curv2_4d(
    n = n * 7/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 5/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(curvilinear_cluster,
                  gau_cluster,
                  tri_corn_cluster)

  df

}

## Data structure 15

three_clust_15 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  hyperbola_cluster <- gen_nonlinear_hyperbola_4d(
    n = n * 7/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 5/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(hyperbola_cluster,
                  elliptical_cluster,
                  rect_corn_cluster)

  df

}

## Data structure 16

three_clust_16 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  curvilinear_cluster <- gen_crescent_4d(
    n = n * 7/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(curvilinear_cluster,
                  hemisphere_cluster,
                  hex_pyr_cluster)

  df

}

## Data structure 17

three_clust_17 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  hyperbola_cluster <- gen_nonlinear_hyperbola2_4d(
    n = n * 7/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(hyperbola_cluster,
                  cube_cluster,
                  blunted_corn_cluster)

  df

}

## Data structure 18

three_clust_18 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  spiral_cluster <- gen_conic_spiral_4d(
    n = n * 7/15,
    spiral_turns = 1,
    cone_height = 2,
    cone_radius = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 5/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(spiral_cluster,
                  gau_cluster,
                  tri_corn_cluster)

  df

}

## Data structure 19

three_clust_19 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  helical_cluster <- gen_helical_hyper_spiral_4d(
    n = n * 7/15,
    a = 0.1,
    b = 0.1,
    k = 2,
    spiral_radius = 1,
    scale_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(helical_cluster,
                  hemisphere_cluster,
                  hex_pyr_cluster)

  df

}

## Data structure 20

three_clust_20 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  spherical_spiral_cluster <- gen_spherical_spiral_4d(
    n = n * 7/15,
    radius = 1,
    spiral_turns = 1,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(spherical_spiral_cluster,
                  elliptical_cluster,
                  blunted_corn_cluster)

  df

}

## Data structure 21

three_clust_21 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  curvilinear_cluster <- gen_curv_4d(
    n = n * 7/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 5/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(curvilinear_cluster,
                  gau_cluster,
                  rect_corn_cluster)

  df

}


## Data structure 22

three_clust_22 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  nonlinear_cluster <- gen_s_curve_4d(
    n = n * 7/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 5/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(nonlinear_cluster,
                  cube_cluster,
                  tri_corn_cluster)

  df

}

## Data structure 23

three_clust_23 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  nonlinear_cluster <- gen_curvy_cylinder_4d(
    n = n * 7/15,
    radius = 1,
    height = 10,
    curve_strength = 1,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(nonlinear_cluster,
                  hemisphere_cluster,
                  hex_pyr_cluster)

  df

}


## Data structure 24

three_clust_24 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  curvilinear_cluster <- gen_curv2_4d(
    n = n * 7/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(curvilinear_cluster,
                  elliptical_cluster,
                  blunted_corn_cluster)

  df

}


## Data structure 25

three_clust_25 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  hyperbola_cluster <- gen_nonlinear_hyperbola_4d(
    n = n * 7/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 5/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(hyperbola_cluster,
                  gau_cluster,
                  rect_corn_cluster)

  df

}

## Data structure 26

three_clust_26 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  curvilinear_cluster <- gen_crescent_4d(
    n = n * 7/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 5/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(curvilinear_cluster,
                  cube_cluster,
                  tri_corn_cluster)

  df

}

## Data structure 27

three_clust_27 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  hyperbola_cluster <- gen_nonlinear_hyperbola2_4d(
    n = n * 7/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(hyperbola_cluster,
                  hemisphere_cluster,
                  hex_pyr_cluster)

  df

}

## Data structure 28

three_clust_28 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  spiral_cluster <- gen_conic_spiral_4d(
    n = n * 7/15,
    spiral_turns = 1,
    cone_height = 2,
    cone_radius = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 5/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  df <- bind_rows(spiral_cluster,
                  elliptical_cluster,
                  blunted_corn_cluster)

  df

}

###################Generate four clusters

## Data structure 1
four_clust_01 <- function(n = 1500, triangle_vertices) {

  #cluster_size <- n/3

  curvilinear_cluster <- gen_curv_4d(
    n = n * 6/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 2/15,
    radius = 1,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(curvilinear_cluster,
                  blunted_corn_cluster,
                  elliptical_cluster,
                  hemisphere_cluster)

  df

}

## Data structure 2
four_clust_02 <- function(n = 1500, triangle_vertices) {

  nonlinear_cluster <- gen_s_curve_4d(
    n = n * 6/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 4/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  helical_cluster <- gen_helical_hyper_spiral_4d(
    n = n * 2/15,
    a = 0.1,
    b = 0.1,
    k = 2,
    spiral_radius = 1,
    scale_factor = 0.5,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(nonlinear_cluster,
                  rect_corn_cluster,
                  cube_cluster,
                  helical_cluster)

  df

}

## Data structure 3

four_clust_03 <- function(n = 1500, triangle_vertices) {

  nonlinear_cluster <- gen_curvy_cylinder_4d(
    n = n * 6/15,
    radius = 1,
    height = 10,
    curve_strength = 1,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 4/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  curvilinear_cluster <- gen_crescent_4d(
    n = n * 2/15,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(nonlinear_cluster,
                  tri_corn_cluster,
                  hemisphere_cluster,
                  curvilinear_cluster)

  df

}

## Data structure 4

four_clust_04 <- function(n = 1500, triangle_vertices) {

  curvilinear_cluster <- gen_curv2_4d(
    n = n * 6/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  hyperbola_cluster <- gen_nonlinear_hyperbola_4d(
    n = n * 2/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(curvilinear_cluster,
                  hex_pyr_cluster,
                  gau_cluster,
                  hyperbola_cluster)

  df


}

## Data structure 5

four_clust_05 <- function(n = 1500, triangle_vertices) {

  hyperbola_cluster <- gen_nonlinear_hyperbola_4d(
    n = n * 6/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 2/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(hyperbola_cluster,
                  blunted_corn_cluster,
                  elliptical_cluster,
                  hex_pyr_cluster)

  df

}

## Data structure 6

four_clust_06 <- function(n = 1500, triangle_vertices) {

  curvilinear_cluster <- gen_crescent_4d(
    n = n * 6/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 4/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  spiral_cluster <- gen_conic_spiral_4d(
    n = n * 2/15,
    spiral_turns = 1,
    cone_height = 2,
    cone_radius = 0.5,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(curvilinear_cluster,
                  rect_corn_cluster,
                  cube_cluster,
                  spiral_cluster)

  df

}

## Data structure 7

four_clust_07 <- function(n = 1500, triangle_vertices) {

  hyperbola_cluster2 <- gen_nonlinear_hyperbola2_4d(
    n = n * 6/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 4/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  cube_cluster <- gen_cube_4d(
    n = n * 2/15,
    side_length = 1,
    center_point = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(hyperbola_cluster2,
                  tri_corn_cluster,
                  hemisphere_cluster,
                  cube_cluster)

  df

}

## Data structure 8

four_clust_08 <- function(n = 1500, triangle_vertices) {

  spiral_cluster <- gen_conic_spiral_4d(
    n = n * 6/15,
    spiral_turns = 1,
    cone_height = 2,
    cone_radius = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 2/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(spiral_cluster,
                  hex_pyr_cluster,
                  gau_cluster,
                  rect_corn_cluster)

  df

}

## Data structure 9

four_clust_09 <- function(n = 1500, triangle_vertices) {

  helical_cluster <- gen_helical_hyper_spiral_4d(
    n = n * 6/15,
    a = 0.1,
    b = 0.1,
    k = 2,
    spiral_radius = 1,
    scale_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 2/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(helical_cluster,
                  blunted_corn_cluster,
                  cube_cluster,
                  tri_corn_cluster)

  df


}

## Data structure 10

four_clust_10 <- function(n = 1500, triangle_vertices) {

  spherical_spiral_cluster <- gen_spherical_spiral_4d(
    n = n * 6/15,
    radius = 1,
    spiral_turns = 1,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 4/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  nonlinear_cluster <- gen_curvy_cylinder_4d(
    n = n * 2/15,
    radius = 1,
    height = 10,
    curve_strength = 1,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(spherical_spiral_cluster,
                  tri_corn_cluster,
                  gau_cluster,
                  nonlinear_cluster)

  df

}

## Data structure 11

four_clust_11 <- function(n = 1500, triangle_vertices) {

  curvilinear_cluster <- gen_curv_4d(
    n = n * 6/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 4/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  nonlinear_cluster <- gen_s_curve_4d(
    n = n * 2/15,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(curvilinear_cluster,
                  rect_corn_cluster,
                  elliptical_cluster,
                  nonlinear_cluster)

  df

}

## Data structure 12

four_clust_12 <- function(n = 1500, triangle_vertices) {

  nonlinear_cluster <- gen_s_curve_4d(
    n = n * 6/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 2/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(nonlinear_cluster,
                  hex_pyr_cluster,
                  hemisphere_cluster,
                  gau_cluster)

  df

}

## Data structure 13

four_clust_13 <- function(n = 1500, triangle_vertices) {

  nonlinear_cluster <- gen_curvy_cylinder_4d(
    n = n * 6/15,
    radius = 1,
    height = 10,
    curve_strength = 1,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  curvilinear_cluster <- gen_curv_4d(
    n = n * 2/15,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(nonlinear_cluster,
                  blunted_corn_cluster,
                  cube_cluster,
                  curvilinear_cluster)

  df

}

## Data structure 14

four_clust_14 <- function(n = 1500, triangle_vertices) {

  curvilinear_cluster <- gen_curv2_4d(
    n = n * 6/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 4/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  cube_cluster <- gen_cube_4d(
    n = n * 2/15,
    side_length = 1,
    center_point = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(curvilinear_cluster,
                  tri_corn_cluster,
                  gau_cluster,
                  cube_cluster)

  df

}

## Data structure 15

four_clust_15 <- function(n = 1500, triangle_vertices) {

  hyperbola_cluster <- gen_nonlinear_hyperbola_4d(
    n = n * 6/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 4/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  curvilinear_cluster <- gen_crescent_4d(
    n = n * 2/15,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(hyperbola_cluster,
                  rect_corn_cluster,
                  elliptical_cluster,
                  curvilinear_cluster)

  df

}

## Data structure 16

four_clust_16 <- function(n = 1500, triangle_vertices) {

  curvilinear_cluster <- gen_crescent_4d(
    n = n * 6/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 2/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(curvilinear_cluster,
                  hex_pyr_cluster,
                  hemisphere_cluster,
                  rect_corn_cluster)

  df

}

## Data structure 17

four_clust_17 <- function(n = 1500, triangle_vertices) {

  hyperbola_cluster2 <- gen_nonlinear_hyperbola2_4d(
    n = n * 6/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  hyperbola_cluster <- gen_nonlinear_hyperbola_4d(
    n = n * 2/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(hyperbola_cluster2,
                  blunted_corn_cluster,
                  cube_cluster,
                  hyperbola_cluster)

  df

}

## Data structure 18

four_clust_18 <- function(n = 1500, triangle_vertices) {

  spiral_cluster <- gen_conic_spiral_4d(
    n = n * 6/15,
    spiral_turns = 1,
    cone_height = 2,
    cone_radius = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 4/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  nonlinear_cluster <- gen_s_curve_4d(
    n = n * 2/15,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(spiral_cluster,
                  tri_corn_cluster,
                  gau_cluster,
                  nonlinear_cluster)

  df

}

## Data structure 19

four_clust_19 <- function(n = 1500, triangle_vertices) {

  helical_cluster <- gen_helical_hyper_spiral_4d(
    n = n * 6/15,
    a = 0.1,
    b = 0.1,
    k = 2,
    spiral_radius = 1,
    scale_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  curvilinear_cluster <- gen_curv_4d(
    n = n * 2/15,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(helical_cluster,
                  hex_pyr_cluster,
                  hemisphere_cluster,
                  curvilinear_cluster)

  df

}

## Data structure 20

four_clust_20 <- function(n = 1500, triangle_vertices) {

  spherical_spiral_cluster <- gen_spherical_spiral_4d(
    n = n * 6/15,
    radius = 1,
    spiral_turns = 1,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  spiral_cluster <- gen_conic_spiral_4d(
    n = n * 2/15,
    spiral_turns = 1,
    cone_height = 2,
    cone_radius = 0.5,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(spherical_spiral_cluster,
                  blunted_corn_cluster,
                  elliptical_cluster,
                  spiral_cluster)

  df

}

## Data structure 21

four_clust_21 <- function(n = 1500, triangle_vertices) {

  curvilinear_cluster <- gen_curv_4d(
    n = n * 6/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 4/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  nonlinear_cluster <- gen_curvy_cylinder_4d(
    n = n * 2/15,
    radius = 1,
    height = 10,
    curve_strength = 1,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(curvilinear_cluster,
                  rect_corn_cluster,
                  gau_cluster,
                  nonlinear_cluster)

  df

}

## Data structure 22

four_clust_22 <- function(n = 1500, triangle_vertices) {

  nonlinear_cluster <- gen_s_curve_4d(
    n = n * 6/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 4/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 2/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(nonlinear_cluster,
                  tri_corn_cluster,
                  cube_cluster,
                  blunted_corn_cluster)

  df

}

## Data structure 23

four_clust_23 <- function(n = 1500, triangle_vertices) {

  nonlinear_cluster <- gen_curvy_cylinder_4d(
    n = n * 6/15,
    radius = 1,
    height = 10,
    curve_strength = 1,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  hyperbola_cluster <- gen_nonlinear_hyperbola_4d(
    n = n * 2/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(nonlinear_cluster,
                  hex_pyr_cluster,
                  hemisphere_cluster,
                  hyperbola_cluster)

  df

}

## Data structure 24

four_clust_24 <- function(n = 1500, triangle_vertices) {

  curvilinear_cluster <- gen_curv2_4d(
    n = n * 6/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 2/15,
    radius = 1,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(curvilinear_cluster,
                  blunted_corn_cluster,
                  elliptical_cluster,
                  hemisphere_cluster)

  df

}

## Data structure 25

four_clust_25 <- function(n = 1500, triangle_vertices) {

  hyperbola_cluster <- gen_nonlinear_hyperbola_4d(
    n = n * 6/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 4/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 2/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(hyperbola_cluster,
                  rect_corn_cluster,
                  gau_cluster,
                  elliptical_cluster)

  df

}

## Data structure 26

four_clust_26 <- function(n = 1500, triangle_vertices) {

  curvilinear_cluster <- gen_crescent_4d(
    n = n * 6/15,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 4/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  helical_cluster <- gen_helical_hyper_spiral_4d(
    n = n * 2/15,
    a = 0.1,
    b = 0.1,
    k = 2,
    spiral_radius = 1,
    scale_factor = 0.5,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(curvilinear_cluster,
                  tri_corn_cluster,
                  cube_cluster,
                  helical_cluster)

  df

}

## Data structure 27

four_clust_27 <- function(n = 1500, triangle_vertices) {

  hyperbola_cluster <- gen_nonlinear_hyperbola2_4d(
    n = n * 6/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  nonlinear_cluster <- gen_curvy_cylinder_4d(
    n = n * 2/15,
    radius = 1,
    height = 10,
    curve_strength = 1,
    offset = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(hyperbola_cluster,
                  hex_pyr_cluster,
                  hemisphere_cluster,
                  nonlinear_cluster)

  df

}

## Data structure 28

four_clust_28 <- function(n = 1500, triangle_vertices) {

  spiral_cluster <- gen_conic_spiral_4d(
    n = n * 6/15,
    spiral_turns = 1,
    cone_height = 2,
    cone_radius = 0.5,
    offset = triangle_vertices[1, ]
  ) |>
    mutate(cluster = "cluster1")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = triangle_vertices[2, ]
  ) |>
    mutate(cluster = "cluster2")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = triangle_vertices[3, ]
  ) |>
    mutate(cluster = "cluster3")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 2/15,
    height = 5,
    base_radius = 3,
    tip_point = triangle_vertices[4, ]
  ) |>
    mutate(cluster = "cluster4")

  df <- bind_rows(spiral_cluster,
                  blunted_corn_cluster,
                  elliptical_cluster,
                  hex_pyr_cluster)

  df

}

###################Generate five clusters

## Data structure 1
five_clust_01 <- function(n = 1500, pentagon_vertices) {

  curvilinear_cluster <- gen_curv_4d(
    n = n * 5/15,
    offset = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x1",
             "x3" = "x2",
             "x1" = "x3",
             "x2" = "x4")) |>
    dplyr::select(x1, x2, x3, x4) |>
    mutate(cluster = "cluster1")


  # curvilinear_cluster <- curvilinear_cluster |>
  #   mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
  #          x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
  #          x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
  #   sweep(2, pentagon_vertices[1, ], "+") |>
  #   mutate(cluster = "cluster1")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x2",
             "x3" = "x1",
             "x1" = "x3",
             "x2" = "x4")) |>
    dplyr::select(x1, x2, x3, x4) |>
    mutate(cluster = "cluster2")

  # blunted_corn_cluster <- blunted_corn_cluster |>
  #   mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
  #          x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
  #          x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
  #   sweep(2, pentagon_vertices[2, ], "+") |>
  #   mutate(cluster = "cluster2")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = c(0, 0, 0, 0)
  ) |>
    mutate(cluster = "cluster3")

  # elliptical_cluster <- elliptical_cluster |>
  #   mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
  #          x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
  #          x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
  #   sweep(2, pentagon_vertices[3, ], "+") |>
  #   mutate(cluster = "cluster3")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 2/15,
    radius = 1,
    offset = c(0, 0, 0, 0)
  ) |>
    mutate(cluster = "cluster4")


  # hemisphere_cluster <- hemisphere_cluster |>
  #   mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
  #          x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
  #          x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
  #   sweep(2, pentagon_vertices[4, ], "+") |>
  #   mutate(cluster = "cluster4")

  cube_cluster <- gen_cube_4d(
    n = n * 1/15,
    side_length = 1,
    center_point = c(0, 0, 0, 0)
  ) |>
    mutate(cluster = "cluster5")

  # cube_cluster <- cube_cluster |>
  #   mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
  #          x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
  #          x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
  #   sweep(2, pentagon_vertices[5, ], "+") |>
  #   mutate(cluster = "cluster5")

  df <- bind_rows(curvilinear_cluster,
                  blunted_corn_cluster,
                  elliptical_cluster,
                  hemisphere_cluster,
                  cube_cluster)

  df

}

## Data structure 2
five_clust_02 <- function(n = 1500, pentagon_vertices) {

  nonlinear_cluster <- gen_s_curve_4d(
    n = n * 5/15,
    offset = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x1",
             "x3" = "x4",
             "x1" = "x2",
             "x2" = "x3")) |>
    dplyr::select(x1, x2, x3, x4) |>
    mutate(cluster = "cluster1")

  # nonlinear_cluster <- nonlinear_cluster |>
  #   mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
  #          x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
  #          x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
  #   sweep(2, pentagon_vertices[1, ], "+") |>
  #   mutate(cluster = "cluster1")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 4/15,
    height = 3,
    base_width_x = 3,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x2",
             "x3" = "x1",
             "x1" = "x3",
             "x2" = "x4")) |>
    dplyr::select(x1, x2, x3, x4) |>
    mutate(cluster = "cluster2")

  # rect_corn_cluster <- rect_corn_cluster |>
  #   mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
  #          x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
  #          x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
  #   sweep(2, pentagon_vertices[2, ], "+") |>
  #   mutate(cluster = "cluster2")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = c(0, 0, 0, 0)
  ) |>
    mutate(cluster = "cluster3")

  # cube_cluster <- cube_cluster |>
  #   mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
  #          x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
  #          x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
  #   sweep(2, pentagon_vertices[3, ], "+") |>
  #   mutate(cluster = "cluster3")

  helical_cluster <- gen_helical_hyper_spiral_4d(
    n = n * 2/15,
    a = 0.1,
    b = 0.1,
    k = 2,
    spiral_radius = 1,
    scale_factor = 0.5,
    offset = c(0, 0, 0, 0)
  ) |>
    mutate(cluster = "cluster4")

  # helical_cluster <- helical_cluster |>
  #   mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
  #          x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
  #          x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
  #   sweep(2, pentagon_vertices[4, ], "+") |>
  #   mutate(cluster = "cluster4")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 1/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = c(0, 0, 0, 0)
  ) |>
    mutate(cluster = "cluster5")

  # gau_cluster <- gau_cluster |>
  #   mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
  #          x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
  #          x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
  #   sweep(2, pentagon_vertices[5, ], "+") |>
  #   mutate(cluster = "cluster5")

  df <- bind_rows(nonlinear_cluster,
                  rect_corn_cluster,
                  cube_cluster,
                  helical_cluster,
                  gau_cluster)

  df

}

## Data structure 3

five_clust_03 <- function(n = 1500, pentagon_vertices) {

  nonlinear_cluster <- gen_curvy_cylinder_4d(
    n = n * 5/15,
    radius = 2,
    height = 10,
    curve_strength = 1,
    offset = c(0, 0, 0, 0)
  )

  nonlinear_cluster <- nonlinear_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 4/15,
    height = 5,
    base_width = 7,
    tip_radius = 0.5,
    tip_point = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x2",
             "x3" = "x1",
             "x1" = "x3",
             "x2" = "x4")) |>
    dplyr::select(x1, x2, x3, x4)

  tri_corn_cluster <- tri_corn_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 2,
    offset = c(0, 0, 0, 0)
  )

  hemisphere_cluster <- hemisphere_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  curvilinear_cluster <- gen_crescent_4d(
    n = n * 2/15,
    offset = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x1",
             "x3" = "x2",
             "x1" = "x3",
             "x2" = "x4")) |>
    dplyr::select(x1, x2, x3, x4)

  curvilinear_cluster <- curvilinear_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  cube_cluster <- gen_cube_4d(
    n = n * 1/15,
    side_length = 1,
    center_point = c(0, 0, 0, 0)
  )

  cube_cluster <- cube_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(nonlinear_cluster,
                  tri_corn_cluster,
                  hemisphere_cluster,
                  curvilinear_cluster,
                  cube_cluster)

  df

}


## Data structure 4

five_clust_04 <- function(n = 1500, pentagon_vertices) {

  curvilinear_cluster <- gen_curv2_4d(
    n = n * 5/15,
    offset = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x1",
             "x3" = "x4",
             "x1" = "x2",
             "x2" = "x3")) |>
    dplyr::select(x1, x2, x3, x4)

  curvilinear_cluster <- curvilinear_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 3,
    tip_point = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x2",
             "x3" = "x1",
             "x1" = "x3",
             "x2" = "x4")) |>
    dplyr::select(x1, x2, x3, x4)

  hex_pyr_cluster <- hex_pyr_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = c(0, 0, 0, 0)
  )

  gau_cluster <- gau_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  hyperbola_cluster <- gen_nonlinear_hyperbola_4d(
    n = n * 2/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = c(0, 0, 0, 0)
  )

  hyperbola_cluster <- hyperbola_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  cube_cluster <- gen_cube_4d(
    n = n * 1/15,
    side_length = 1,
    center_point = c(0, 0, 0, 0)
  )

  cube_cluster <- cube_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(curvilinear_cluster,
                  hex_pyr_cluster,
                  gau_cluster,
                  hyperbola_cluster,
                  cube_cluster)

  df


}


## Data structure 5

five_clust_05 <- function(n = 1500, pentagon_vertices) {

  hyperbola_cluster <- gen_nonlinear_hyperbola_4d(
    n = n * 5/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x1",
             "x3" = "x4",
             "x1" = "x2",
             "x2" = "x3")) |>
    dplyr::select(x1, x2, x3, x4)

  hyperbola_cluster <- hyperbola_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x2",
             "x3" = "x1",
             "x1" = "x3",
             "x2" = "x4")) |>
    dplyr::select(x1, x2, x3, x4)

  blunted_corn_cluster <- blunted_corn_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = c(0, 0, 0, 0)
  )

  elliptical_cluster <- elliptical_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 2/15,
    height = 5,
    base_radius = 3,
    tip_point = c(0, 0, 0, 0)
  )

  hex_pyr_cluster <- hex_pyr_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  cube_cluster <- gen_cube_4d(
    n = n * 1/15,
    side_length = 1,
    center_point = c(0, 0, 0, 0)
  )

  cube_cluster <- cube_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(hyperbola_cluster,
                  blunted_corn_cluster,
                  elliptical_cluster,
                  hex_pyr_cluster,
                  cube_cluster)

  df

}

## Data structure 6

five_clust_06 <- function(n = 1500, pentagon_vertices) {

  curvilinear_cluster <- gen_crescent_4d(
    n = n * 5/15,
    offset = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x1",
             "x3" = "x4",
             "x1" = "x2",
             "x2" = "x3")) |>
    dplyr::select(x1, x2, x3, x4)

  curvilinear_cluster <- curvilinear_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 4/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = c(0, 0, 0, 0)
  )

  rect_corn_cluster <- rect_corn_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = c(0, 0, 0, 0)
  )

  cube_cluster <- cube_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  spiral_cluster <- gen_conic_spiral_4d(
    n = n * 2/15,
    spiral_turns = 1,
    cone_height = 2,
    cone_radius = 0.5,
    offset = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x1",
             "x3" = "x4",
             "x1" = "x2",
             "x2" = "x3")) |>
    dplyr::select(x1, x2, x3, x4)

  spiral_cluster <- spiral_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 1/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = c(0, 0, 0, 0)
  )

  elliptical_cluster <- elliptical_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(curvilinear_cluster,
                  rect_corn_cluster,
                  cube_cluster,
                  spiral_cluster,
                  elliptical_cluster)

  df

}

## Data structure 7

five_clust_07 <- function(n = 1500, pentagon_vertices) {

  hyperbola_cluster2 <- gen_nonlinear_hyperbola2_4d(
    n = n * 5/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = c(0, 0, 0, 0)
  )

  hyperbola_cluster2 <- hyperbola_cluster2 |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 4/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = c(0, 0, 0, 0)
  )

  tri_corn_cluster <- tri_corn_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = c(0, 0, 0, 0)
  )

  hemisphere_cluster <- hemisphere_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  cube_cluster <- gen_cube_4d(
    n = n * 2/15,
    side_length = 1,
    center_point = c(0, 0, 0, 0)
  )

  cube_cluster <- cube_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 1/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = c(0, 0, 0, 0)
  )

  blunted_corn_cluster <- blunted_corn_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(hyperbola_cluster2,
                  tri_corn_cluster,
                  hemisphere_cluster,
                  cube_cluster,
                  blunted_corn_cluster)

  df

}

## Data structure 8

five_clust_08 <- function(n = 1500, pentagon_vertices) {

  spiral_cluster <- gen_conic_spiral_4d(
    n = n * 5/15,
    spiral_turns = 1,
    cone_height = 2,
    cone_radius = 0.5,
    offset = c(0, 0, 0, 0)
  )

  spiral_cluster <- spiral_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 3,
    tip_point = c(0, 0, 0, 0)
  )

  hex_pyr_cluster <- hex_pyr_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = c(0, 0, 0, 0)
  )

  gau_cluster <- gau_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 2/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = c(0, 0, 0, 0)
  )

  rect_corn_cluster <- rect_corn_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 1/15,
    radius = 1,
    offset = c(0, 0, 0, 0)
  )

  hemisphere_cluster <- hemisphere_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(spiral_cluster,
                  hex_pyr_cluster,
                  gau_cluster,
                  rect_corn_cluster,
                  hemisphere_cluster)

  df

}


## Data structure 9

five_clust_09 <- function(n = 1500, pentagon_vertices) {

  helical_cluster <- gen_helical_hyper_spiral_4d(
    n = n * 5/15,
    a = 0.1,
    b = 0.1,
    k = 2,
    spiral_radius = 1,
    scale_factor = 0.5,
    offset = c(0, 0, 0, 0)
  )

  helical_cluster <- helical_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = c(0, 0, 0, 0)
  )

  blunted_corn_cluster <- blunted_corn_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = c(0, 0, 0, 0)
  )

  cube_cluster <- cube_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 2/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = c(0, 0, 0, 0)
  )

  tri_corn_cluster <- tri_corn_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 1/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = c(0, 0, 0, 0)
  )

  elliptical_cluster <- elliptical_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(helical_cluster,
                  blunted_corn_cluster,
                  cube_cluster,
                  tri_corn_cluster,
                  elliptical_cluster)

  df


}


## Data structure 10

five_clust_10 <- function(n = 1500, pentagon_vertices) {

  spherical_spiral_cluster <- gen_spherical_spiral_4d(
    n = n * 5/15,
    radius = 1,
    spiral_turns = 1,
    offset = c(0, 0, 0, 0)
  )

  spherical_spiral_cluster <- spherical_spiral_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 4/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = c(0, 0, 0, 0)
  )

  tri_corn_cluster <- tri_corn_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = c(0, 0, 0, 0)
  )

  gau_cluster <- gau_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  nonlinear_cluster <- gen_curvy_cylinder_4d(
    n = n * 2/15,
    radius = 1,
    height = 10,
    curve_strength = 1,
    offset = c(0, 0, 0, 0)
  )

  nonlinear_cluster <- nonlinear_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 1/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x2",
             "x3" = "x1",
             "x1" = "x3",
             "x2" = "x4")) |>
    dplyr::select(x1, x2, x3, x4)

  blunted_corn_cluster <- blunted_corn_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(spherical_spiral_cluster,
                  tri_corn_cluster,
                  gau_cluster,
                  nonlinear_cluster,
                  blunted_corn_cluster)

  df

}

## Data structure 11

five_clust_11 <- function(n = 1500, pentagon_vertices) {

  curvilinear_cluster <- gen_curv_4d(
    n = n * 5/15,
    offset = c(0, 0, 0, 0)
  )

  curvilinear_cluster <- curvilinear_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 4/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = c(0, 0, 0, 0)
  )

  rect_corn_cluster <- rect_corn_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = c(0, 0, 0, 0)
  )

  elliptical_cluster <- elliptical_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  nonlinear_cluster <- gen_s_curve_4d(
    n = n * 2/15,
    offset = c(0, 0, 0, 0)
  )

  nonlinear_cluster <- nonlinear_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 1/15,
    radius = 1,
    offset = c(0, 0, 0, 0)
  )

  hemisphere_cluster <- hemisphere_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(curvilinear_cluster,
                  rect_corn_cluster,
                  elliptical_cluster,
                  nonlinear_cluster,
                  hemisphere_cluster)

  df

}

## Data structure 12

five_clust_12 <- function(n = 1500, pentagon_vertices) {

  nonlinear_cluster <- gen_s_curve_4d(
    n = n * 5/15,
    offset = c(0, 0, 0, 0)
  )

  nonlinear_cluster <- nonlinear_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 3,
    tip_point = c(0, 0, 0, 0)
  )

  hex_pyr_cluster <- hex_pyr_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = c(0, 0, 0, 0)
  )

  hemisphere_cluster <- hemisphere_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 2/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = c(0, 0, 0, 0)
  )

  gau_cluster <- gau_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 1/15,
    height = 5,
    base_width = 7,
    tip_radius = 0.5,
    tip_point = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x2",
             "x3" = "x1",
             "x1" = "x3",
             "x2" = "x4")) |>
    dplyr::select(x1, x2, x3, x4)

  tri_corn_cluster <- tri_corn_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")


  df <- bind_rows(nonlinear_cluster,
                  hex_pyr_cluster,
                  hemisphere_cluster,
                  gau_cluster,
                  tri_corn_cluster)

  df

}

## Data structure 13

five_clust_13 <- function(n = 1500, pentagon_vertices) {

  nonlinear_cluster <- gen_curvy_cylinder_4d(
    n = n * 5/15,
    radius = 1,
    height = 10,
    curve_strength = 1,
    offset = c(0, 0, 0, 0)
  )

  nonlinear_cluster <- nonlinear_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = c(0, 0, 0, 0)
  )

  blunted_corn_cluster <- blunted_corn_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = c(0, 0, 0, 0)
  )

  cube_cluster <- cube_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  curvilinear_cluster <- gen_curv_4d(
    n = n * 2/15,
    offset = c(0, 0, 0, 0)
  )

  curvilinear_cluster <- curvilinear_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 1/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = c(0, 0, 0, 0)
  )

  elliptical_cluster <- elliptical_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(nonlinear_cluster,
                  blunted_corn_cluster,
                  cube_cluster,
                  curvilinear_cluster,
                  elliptical_cluster)

  df

}

## Data structure 14

five_clust_14 <- function(n = 1500, pentagon_vertices) {

  curvilinear_cluster <- gen_curv2_4d(
    n = n * 5/15,
    offset = c(0, 0, 0, 0)
  )

  curvilinear_cluster <- curvilinear_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 4/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = c(0, 0, 0, 0)
  )

  tri_corn_cluster <- tri_corn_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = c(0, 0, 0, 0)
  )

  gau_cluster <- gau_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  cube_cluster <- gen_cube_4d(
    n = n * 2/15,
    side_length = 1,
    center_point = c(0, 0, 0, 0)
  )

  cube_cluster <- cube_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  nonlinear_cluster <- gen_s_curve_4d(
    n = n * 1/15,
    offset = c(0, 0, 0, 0)
  )

  nonlinear_cluster <- nonlinear_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(curvilinear_cluster,
                  tri_corn_cluster,
                  gau_cluster,
                  cube_cluster,
                  nonlinear_cluster)

  df

}

## Data structure 15

five_clust_15 <- function(n = 1500, pentagon_vertices) {

  hyperbola_cluster <- gen_nonlinear_hyperbola_4d(
    n = n * 5/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = c(0, 0, 0, 0)
  )

  hyperbola_cluster <- hyperbola_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 4/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = c(0, 0, 0, 0)
  )

  rect_corn_cluster <- rect_corn_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  elliptical_cluster <- gen_elliptical_cluster_4d(
    n = n * 3/15,
    axes_lengths = c(2, 1.5, 1, 0.5),
    offset = c(0, 0, 0, 0)
  )

  elliptical_cluster <- elliptical_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  curvilinear_cluster <- gen_crescent_4d(
    n = n * 2/15,
    offset = c(0, 0, 0, 0)
  )

  curvilinear_cluster <- curvilinear_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 1/15,
    radius = 1,
    offset = c(0, 0, 0, 0)
  )

  hemisphere_cluster <- hemisphere_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(hyperbola_cluster,
                  rect_corn_cluster,
                  elliptical_cluster,
                  curvilinear_cluster,
                  hemisphere_cluster)

  df

}

## Data structure 16

five_clust_16 <- function(n = 1500, pentagon_vertices) {

  curvilinear_cluster <- gen_crescent_4d(
    n = n * 5/15,
    offset = c(0, 0, 0, 0)
  )

  curvilinear_cluster <- curvilinear_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 3,
    tip_point = c(0, 0, 0, 0)
  )

  hex_pyr_cluster <- hex_pyr_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  hemisphere_cluster <- gen_hemisphere_4d(
    n = n * 3/15,
    radius = 1,
    offset = c(0, 0, 0, 0)
  )

  hemisphere_cluster <- hemisphere_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  rect_corn_cluster <- gen_corn_cluster_rectangular_base_4d(
    n = n * 2/15,
    height = 3,
    base_width_x = 2,
    base_width_y = 1,
    tip_radius = 0.5,
    tip_point = c(0, 0, 0, 0)
  )

  rect_corn_cluster <- rect_corn_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 1/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x2",
             "x3" = "x1",
             "x1" = "x3",
             "x2" = "x4")) |>
    dplyr::select(x1, x2, x3, x4)

  blunted_corn_cluster <- blunted_corn_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(curvilinear_cluster,
                  hex_pyr_cluster,
                  hemisphere_cluster,
                  rect_corn_cluster,
                  blunted_corn_cluster)

  df

}

## Data structure 17

five_clust_17 <- function(n = 1500, pentagon_vertices) {

  hyperbola_cluster2 <- gen_nonlinear_hyperbola2_4d(
    n = n * 5/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = c(0, 0, 0, 0)
  )

  hyperbola_cluster2 <- hyperbola_cluster2 |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  blunted_corn_cluster <- gen_blunted_corn_cluster_4d(
    n = n * 4/15,
    height = 5,
    base_radius = 1.5,
    tip_radius = 0.8,
    tip_point = c(0, 0, 0, 0)
  )

  blunted_corn_cluster <- blunted_corn_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  cube_cluster <- gen_cube_4d(
    n = n * 3/15,
    side_length = 1,
    center_point = c(0, 0, 0, 0)
  )

  cube_cluster <- cube_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  hyperbola_cluster <- gen_nonlinear_hyperbola_4d(
    n = n * 2/15,
    C = 1,
    nonlinear_factor = 0.5,
    offset = c(0, 0, 0, 0)
  )

  hyperbola_cluster <- hyperbola_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")


  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 1/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = c(0, 0, 0, 0)
  )

  gau_cluster <- gau_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(hyperbola_cluster2,
                  blunted_corn_cluster,
                  cube_cluster,
                  hyperbola_cluster,
                  gau_cluster)

  df

}

## Data structure 18

five_clust_18 <- function(n = 1500, pentagon_vertices) {

  spiral_cluster <- gen_conic_spiral_4d(
    n = n * 5/15,
    spiral_turns = 1,
    cone_height = 2,
    cone_radius = 0.5,
    offset = c(0, 0, 0, 0)
  )

  spiral_cluster <- spiral_cluster |>
    mutate(x5 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 5/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 5/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[1, ], "+") |>
    mutate(cluster = "cluster1")

  tri_corn_cluster <- gen_corn_cluster_triangular_base_4d(
    n = n * 4/15,
    height = 5,
    base_width = 3,
    tip_radius = 0.5,
    tip_point = c(0, 0, 0, 0)
  )

  tri_corn_cluster <- tri_corn_cluster |>
    mutate(x5 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 4/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 4/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[2, ], "+") |>
    mutate(cluster = "cluster2")

  gau_cluster <- gen_gaussian_cluster_4d(
    n = n * 3/15,
    mean_vec = c(0, 0, 0, 0),
    cov_mat = diag(4) * 0.1,
    offset = c(0, 0, 0, 0)
  )

  gau_cluster <- gau_cluster |>
    mutate(x5 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 3/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 3/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[3, ], "+") |>
    mutate(cluster = "cluster3")

  nonlinear_cluster <- gen_s_curve_4d(
    n = n * 2/15,
    offset = c(0, 0, 0, 0)
  )

  nonlinear_cluster <- nonlinear_cluster |>
    mutate(x5 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 2/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 2/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[4, ], "+") |>
    mutate(cluster = "cluster4")

  hex_pyr_cluster <- gen_filled_hexagonal_pyramid_4d(
    n = n * 1/15,
    height = 5,
    base_radius = 3,
    tip_point = c(0, 0, 0, 0)
  ) |>
    rename(c("x4" = "x2",
             "x3" = "x1",
             "x1" = "x3",
             "x2" = "x4")) |>
    dplyr::select(x1, x2, x3, x4)

  hex_pyr_cluster <- hex_pyr_cluster |>
    mutate(x5 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x6 = runif(n=n * 1/15, min=-0.5, max=0.5),
           x7 = runif(n=n * 1/15, min=-0.5, max=0.5)) |>
    sweep(2, pentagon_vertices[5, ], "+") |>
    mutate(cluster = "cluster5")

  df <- bind_rows(spiral_cluster,
                  tri_corn_cluster,
                  gau_cluster,
                  nonlinear_cluster,
                  hex_pyr_cluster)

  df

}
