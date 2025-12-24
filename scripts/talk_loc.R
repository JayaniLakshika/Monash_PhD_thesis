# Install packages if not already installed
#install.packages(c("rnaturalearth", "rnaturalearthdata", "sf", "ggplot2", "ggimage"))

library(rnaturalearth)
library(sf)
library(ggplot2)
library(ggimage)
library(patchwork)

# Load Austria map (states)
austria_states <- ne_states(country = "Austria", returnclass = "sf")

# Coordinates of cities
cities <- data.frame(
  name = c("Vienna", "Salzburg"),
  lon = c(16.3738, 13.0405),
  lat = c(48.2082, 47.8095),
  image = c(here::here("figures/vienna.png"), here::here("figures/salzburg.png"))  # replace with your file paths or URLs
)

# Plot Austria with states and cities
austria_map <- ggplot(austria_states) +
  geom_sf(fill = "grey90", color = "grey65") +       # map of states
  geom_point(data = cities, aes(x = lon, y = lat),
             color = "black", size = 2) +                 # city points
  geom_image(data = cities, aes(x = lon - 0.8, y = lat + 0.3, image = image), size = 0.3) +  # images
  # geom_text(data = cities, aes(x = lon, y = lat, label = name),
  #           nudge_y = 0.2, size = 7) +                  # city labels
  theme_minimal() +
  theme(
    #aspect.ratio = 1,
    plot.background = element_rect(fill = 'transparent', colour = NA),
    plot.title = element_text(size = 20, hjust = 0.5, vjust = -0.5),
    panel.background = element_rect(fill = 'transparent',
                                    colour = NA),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title.x = element_blank(), axis.title.y = element_blank(),
    axis.text.x = element_blank(), axis.ticks.x = element_blank(),
    axis.text.y = element_blank(), axis.ticks.y = element_blank(),
    legend.background = element_rect(fill = 'transparent',
                                     colour = NA),
    legend.key = element_rect(fill = 'transparent',
                              colour = NA),
    legend.position = "bottom",
    legend.title = element_blank(),
    legend.text = element_text(size=4),
    legend.key.height = unit(0.25, 'cm'),
    legend.key.width = unit(0.25, 'cm'),
    plot.margin = margin(0, 0, 0, 0)
  ) +
  ggtitle("Austria")

################################################################################

# Load USA states map
usa_states <- ne_states(country = "United States of America", returnclass = "sf")

# Locations with images
locations <- data.frame(
  name = c("Tennessee", "Nebraska", "Durham"),
  lon = c(-86.5804, -99.9018, -78.8986),
  lat = c(35.5175, 41.4925, 36.0014),
  image = c(here::here("figures/tennessee.png"), here::here("figures/nebraska.png"), here::here("figures/durham.png"))  # replace with your own images
)

# Plot map zoomed into region
usa_map <- ggplot(usa_states) +
  geom_sf(fill = "grey90", color = "grey65") +
  geom_image(data = locations, aes(x = lon, y = lat, image = image), size = 0.3) +
  #geom_text(data = locations, aes(x = lon, y = lat, label = name), nudge_y = 1, size = 4) +
  coord_sf(
    xlim = c(-105, -75),  # longitude limits for zoom
    ylim = c(33, 43)      # latitude limits for zoom
  ) +
  theme_minimal() +
  theme(
    #aspect.ratio = 1,
    plot.background = element_rect(fill = 'transparent', colour = NA),
    plot.title = element_text(size = 20, hjust = 0.5, vjust = -0.5),
    panel.background = element_rect(fill = 'transparent',
                                    colour = NA),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title.x = element_blank(), axis.title.y = element_blank(),
    axis.text.x = element_blank(), axis.ticks.x = element_blank(),
    axis.text.y = element_blank(), axis.ticks.y = element_blank(),
    legend.background = element_rect(fill = 'transparent',
                                     colour = NA),
    legend.key = element_rect(fill = 'transparent',
                              colour = NA),
    legend.position = "bottom",
    legend.title = element_blank(),
    legend.text = element_text(size=4),
    legend.key.height = unit(0.25, 'cm'),
    legend.key.width = unit(0.25, 'cm'),
    plot.margin = margin(0, 0, 0, 0)
  ) +
  ggtitle("USA")

################################################################################

# Australia map
aus <- ne_countries(country = "Australia", returnclass = "sf")

# Approximate coordinates for major cities
cities <- data.frame(
  name = c("Sydney", "Melbourne", "Canberra", "Perth"),
  lon = c(151.2093, 140.9631, 149.1300, 115.8575),
  lat = c(-25.8688, -35.8136, -36.2809, -31.9505),
  image = c(
    here::here("figures/sydney.png"),
    here::here("figures/melbourne.png"),
    here::here("figures/canberra.png"),
    here::here("figures/perth.png")
  ) # replace with your images or URLs
)

aus_map <- ggplot(aus) +
  geom_sf(fill = "grey90", color = "grey65") +                    # Australia map
  geom_image(data = cities, aes(x = lon, y = lat, image = image), size = 0.3) +  # city images
  # geom_text(data = cities, aes(x = lon, y = lat, label = name),
  #           nudge_y = 0.5, size = 4) +                                # city labels
  coord_sf(
    xlim = c(110, 155),    # longitude limits to zoom on southeast region
    ylim = c(-40, -20)     # latitude limits
  ) +
  theme_minimal() +
  theme(
    #aspect.ratio = 1,
    plot.background = element_rect(fill = 'transparent', colour = NA),
    plot.title = element_text(size = 20, hjust = 0.5, vjust = -0.5),
    panel.background = element_rect(fill = 'transparent',
                                    colour = NA),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title.x = element_blank(), axis.title.y = element_blank(),
    axis.text.x = element_blank(), axis.ticks.x = element_blank(),
    axis.text.y = element_blank(), axis.ticks.y = element_blank(),
    legend.background = element_rect(fill = 'transparent',
                                     colour = NA),
    legend.key = element_rect(fill = 'transparent',
                              colour = NA),
    legend.position = "bottom",
    legend.title = element_blank(),
    legend.text = element_text(size=4),
    legend.key.height = unit(0.25, 'cm'),
    legend.key.width = unit(0.25, 'cm'),
    plot.margin = margin(0, 0, 0, 0)
  ) +
  ggtitle("Australia")

aus_map + austria_map + usa_map +
  plot_layout(ncol = 1)
