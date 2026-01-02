#### This script contains functions to generate the data structures for the attention check
#### 3 and 4 Gaussian clusters
gau_clust <- function(n, num_clust, mean_matrix, var_vec, num_dims) {

  if (n <= 0) {
    stop("Number of points should be a positive number.")
  }

  if (num_clust < 0) {
    stop("Number of clusters should be a positive number.")
  }

  if (num_dims < 0) {
    stop("Number of effective dimensions should be a positive number.")
  }

  if (missing(n)) {
    stop("Missing n.")
  }

  if (missing(num_dims)) {
    stop("Missing num_dims.")
  }

  if (missing(mean_matrix)) {
    stop("Missing mean_matrix.")
  }

  if (missing(var_vec)) {
    stop("Missing var_vec.")
  }

  if (n < num_clust) {
    stop("Number of clusters exceed the number of observations.")
  }

  if ((num_dims == 0) | (num_dims == 1)) {
    stop("There should be at least two dimensions.")
  }

  if (dim(mean_matrix)[1] != length(var_vec)) {
    stop("The length of mean and variance vectors are different.")
  }

  if (dim(mean_matrix)[1] != num_clust) {
    stop("There is not enough mean values for clusters.")
  }

  if (dim(mean_matrix)[2] != num_dims) {
    stop("There is not enough mean values for dimensions.")
  }

  if (length(var_vec) != num_clust) {
    stop("There is not enough varaiance values for clusters.")
  }

  # To check that the assigned n is divided by three
  if ((n %% num_clust) != 0) {
    warning("The sample size should be a product of number of clusters.")
    cluster_size <- floor(n / num_clust)
  } else {
    cluster_size <- n / num_clust
  }

  df <- data.frame()

  for (i in 1:num_clust) {
    # To filter the mean values for specific cluster
    mean_val_for_cluster <- mean_matrix[i, ]

    # To filter the variance values for specific cluster
    variance_val_for_cluster <- var_vec[i]

    # Initialize an empty list to store the vectors with column
    # values
    dim_val_list <- list()

    for (j in 1:num_dims) {
      dim_val_list[[j]] <- stats::rnorm(cluster_size,
                                        mean = mean_val_for_cluster[j],
                                        sd = variance_val_for_cluster
      )
    }
    # To generate a tibble for a cluster
    df_cluster <- matrix(unlist(dim_val_list), ncol = length(dim_val_list))
    df_cluster <- cbind(df_cluster, paste0("cluster", i))

    df <- rbind(df, df_cluster)
  }

  colnames(df) <- append(paste0("x", 1:num_dims), "cluster")

  df <- tibble::as_tibble(df) |>
    mutate(across(paste0("x", 1:num_dims), as.numeric))

  df
}
