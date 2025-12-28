library(ggplot2)
library(dplyr)

# Function to create square blocks with specified rows and columns
create_square_block <- function(n, start_x, start_y, rows, cols, side_length = 1, spacing = 0.1) {
  # Create a grid for the specified number of rows and columns
  squares <- expand.grid(
    x = seq(start_x, start_x + (cols - 1) * (side_length + spacing), by = side_length + spacing),
    y = seq(start_y, start_y + (rows - 1) * (side_length + spacing), by = side_length + spacing)
  )[1:n, ]  # Ensure only 'n' squares are created

  squares <- squares %>%
    mutate(
      xmin = x,
      xmax = x + side_length,
      ymin = y,
      ymax = y + side_length
    )

  return(squares)
}

# Parameters
side_length <- 2  # Size of squares
spacing <- 0.3    # Spacing between squares

# Create the blocks
block1 <- create_square_block(24, start_x = 1, start_y = 1, rows = 4, cols = 6, side_length, spacing) |>  # 6x3 block for 18 squares
  mutate(is_same = append(experiment_design |> filter(subject == "subject01") |> pull(is_same), "DIFFERENT")) |>
  mutate(attempt = append(experiment_design |> filter(subject == "subject01") |> pull(attempt), 24)) |>
  mutate(is_attention_check = if_else(attempt == 12, "*", "")) |>
  mutate(structure = sample(1:24, 24))

attention_check_square <- block1 |>
  filter(attempt == 12)

block2 <- create_square_block(6, start_x = 1, start_y = 9.5, rows = 1, cols = 6, side_length, spacing) |>  # 1 x 6 block for 6 squares
            mutate(text = c("tsne", "umap", "phate", "trimap", "pacmap", "pca"))

block3 <- create_square_block(3, start_x = 14, start_y = 1, rows = 3, cols = 1, side_length, spacing) |>  # 1 x 3 block for 6 squares
  mutate(text = c("0.1", "0.6", "1"))


# Plot the squares with text labels in the top right corner of each square
p1 <- ggplot() +
  geom_rect(data = block1, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax, fill = is_same), color = "black") +  # Draw squares
  geom_rect(data = block2, aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax), color = NA, fill = NA) +  # Draw squares
  geom_text(data = block1,
            aes(x = xmax - 0.1, y = ymax - 0.1, label = attempt), size = 3, hjust = 1, vjust = 1) +  # Add text labels in the top right corner
  geom_text(data = attention_check_square,
            aes(x = xmax - side_length + 0.1, y = ymax - 0.1, label = is_attention_check), size = 5, hjust = 0, vjust = 1) +  # Add text labels in the top left corner
  geom_text(data = block1, aes(x = (xmin + xmax) / 2, y = (ymin + ymax) / 2, label = structure), size = 5) +  # Add text labels in the center of squares
  geom_text(data = block2, aes(x = (xmin + xmax) / 2, y = (ymin + ymax) / 2, label = text), size = 4) +  # Add text labels in the center of squares
  geom_text(data = block3, aes(x = (xmin + xmax) / 2, y = (ymin + ymax) / 2, label = text), size = 4) +  # Add text labels in the center of squares
  coord_fixed(ratio = 1) +  # Ensure squares are square
  theme_void() +  # Clean up the plot
  theme(plot.background = element_rect(color = "black", fill = NA, linewidth = 1),
        legend.position = "none",
        plot.title = element_text(hjust = 0.5)) +
  ggtitle("subject 01")

p1
