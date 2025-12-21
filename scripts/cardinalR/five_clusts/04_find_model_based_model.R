library(tidyverse)
library(proxy)

five_clusts <- read_rds(here::here("data/five_clusts/five_clusts.rds"))

true_labels <- as.numeric(gsub("cluster", "", five_clusts$cluster))

# Hierarchical clustering
dist_mat <- dist(five_clusts[, -5])

model_table <- tribble(
  ~Model, ~Sigma, ~Family, ~Volume, ~Shape, ~Orientation,
  "EII","$\\lambda I$","Spherical","Equal","Equal",NA,
  "VII","$\\lambda_k I$","Spherical","Variable","Equal",NA,
  "EEI","$\\lambda A$","Diagonal","Equal","Equal","Coordinate axes",
  "VEI","$\\lambda_kA$","Diagonal","Variable","Equal","Coordinate axes",
  "EVI","$\\lambda A_k$","Diagonal","Equal","Variable","Coordinate axes",
  "VVI","$\\lambda_k A_k$","Diagonal","Variable","Variable","Coordinate axes",
  "EEE","$\\lambda DAD^\\top$","Diagonal","Equal","Equal","Equal",
  "EVE","$\\lambda DA_kD^\\top$","Ellipsoidal","Equal","Variable","Equal",
  "VEE","$\\lambda_k DAD^\\top$","Ellipsoidal","Variable","Equal","Equal",
  "VVE","$\\lambda_k DA_kD^\\top$","Ellipsoidal","Variable","Variable","Equal",
  "EEV","$\\lambda D_kAD_k^\\top$","Ellipsoidal","Equal","Variable","Variable",
  "VEV","$\\lambda_k D_kAD_k^\\top$","Ellipsoidal","Variable","Equal","Variable",
  "EVV","$\\lambda D_kA_kD_k^\\top$","Ellipsoidal","Equal","Variable","Variable",
  "VVV","$\\lambda_k D_kA_kD_k^\\top$","Ellipsoidal","Variable","Variable","Variable"
)


get_model_stats <- function(model_name, data, dist_mat, G = 2:10) {

  classifications <- lapply(G, function(g) {
    Mclust(data, G = g, modelNames = model_name)$classification
  })

  stats_list <- lapply(seq_along(G), function(i) {
    x <- cluster.stats(dist_mat, classifications[[i]])[
      c("within.cluster.ss", "pearsongamma", "dunn2",
        "wb.ratio", "ch", "sindex")
    ]

    tibble(
      method = model_name,
      cl = G[i]
    ) |> bind_cols(as_tibble(x))
  })

  bind_rows(stats_list)
}

all_model_stats <- bind_rows(
  lapply(model_table$Model[c(1, 14)], function(m) {
    get_model_stats(m,
                    data = five_clusts[, -5],
                    dist_mat = dist_mat,
                    G = 2:10)
  })
)

all_model_stats |>
  pivot_longer(within.cluster.ss:sindex, names_to = "stat", values_to = "value") |>
  ggplot(aes(x=cl, y=value, colour=method)) +
  geom_line() +
  facet_wrap(~stat, ncol=3, scales="free_y") +
  xlab("Number of clusters") +
  ylab("") +
  theme_minimal() +
  theme(panel.border = element_rect(fill = 'transparent'),
        plot.title = element_text(size = 12, hjust = 0.5, vjust = -0.5),
        axis.ticks.x = element_line(),
        axis.ticks.y = element_line(),
        legend.position = "bottom",
        axis.text.x = element_text(size = 7),
        axis.text.y = element_text(size = 7),
        axis.title.x = element_text(size = 7),
        axis.title.y = element_text(size = 7),
        plot.margin = margin(0, 0, 0, 0))
