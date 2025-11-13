#### This script is to work on git commits for each repository

library(gh)
library(tidyverse)
library(lubridate)

# ------------------------------------------------------------------------------
# Function: get_commits_from_github()
# ------------------------------------------------------------------------------

get_commits_from_github <- function(repos, user = "JayaniLakshika", from = "2022-07-14") {
  all_commits <- purrr::map_dfr(repos, function(repo_name) {
    message("Fetching commits for: ", repo_name)

    # GitHub API: list commits
    commits <- gh::gh(
      "/repos/{user}/{repo}/commits",
      user = user,
      repo = repo_name,
      .limit = Inf
    )

    # Convert to tibble
    tibble(
      Repository = repo_name,
      SHA = purrr::map_chr(commits, "sha"),
      Name = purrr::map_chr(commits, c("commit", "author", "name")),
      When = purrr::map_chr(commits, c("commit", "author", "date"))
    ) %>%
      mutate(When = as_datetime(When)) %>%
      filter(When >= as_datetime(from))
  })

  all_commits
}

# ------------------------------------------------------------------------------
# Example usage
# ------------------------------------------------------------------------------

repos <- c(
  "quollr",
  "cardinalR"
)

commits <- get_commits_from_github(repos, user = "JayaniLakshika")

write_rds(commits, here::here("data/git_commits.rds"))

# ------------------------------------------------------------------------------
# Plot commits over time by repository
# ------------------------------------------------------------------------------

commits %>%
  mutate(Week = floor_date(When, unit = "week")) %>%
  group_by(Repository, Week) %>%
  summarise(Commits = n()) %>%
  ggplot(aes(x = Week, y = Commits)) +
  geom_line(color = "steelblue") +
  geom_point() +
  facet_wrap(~ Repository, scales = "free_y", ncol = 1) +
  theme_bw()
