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
# Get commits by repository
# ------------------------------------------------------------------------------

types <- c("Presentation", "Analysis & writing", "Package", "Shiny app")

talks <- map_dfr(c("ASC2025_talk", "BIBC2025_talk", "IDWSDS_presentation",
                   "useR2025_talk", "JSM2025_talk", "PhD_presubmission_presentation2025",
                   "data_science_club_UNO_seminar", "graphics_group_presentation_2024",
                   "useR2024_talk", "3MT_talk_2024", "PhD_progress_review_presentation_2024",
                   "bioinformatic_seminar_talk_2024", "Talk_ASC_2023", "Talk_IASC_ARS_2023",
                   "PhD_confirmation_presentation_2023"), get_commits_from_github) %>%
  distinct(SHA, .keep_all = TRUE) %>%
  mutate(Repository = types[1])

writing <- c("paper-cardinalR", "paper-quollr", "paper-menuraR", "paper-nldr-vis-algorithm", "paper-vis-experiment",
             "Publications_PhD", "Monash_PhD_thesis", "Match-a-roo-experiment", "PhD-Plan", "paper-fritillaR",
             "Match-a-roo_experiment_results_archive", "paper-nldr-vis-diagnostics",
             "poster-quollr") %>%
  map_dfr(get_commits_from_github) %>%
  distinct(SHA, .keep_all = TRUE) %>%
  mutate(Repository = types[2])

pkgs <- map_dfr(c("cardinalR", "quollr"), get_commits_from_github) %>%
  distinct(SHA, .keep_all = TRUE) %>%
  mutate(Repository = types[3])

apps <- map_dfr(c("menuraR", "Match-a-roo", "vimror-webr-test", "diadim"), get_commits_from_github) %>%
  distinct(SHA, .keep_all = TRUE) %>%
  mutate(Repository = types[4])

phd_commits <- bind_rows(pkgs, talks, writing, apps)

phd_milestones <-
  tribble(
    ~ date, ~ event, ~ Repository,
    "2023-08-15", "Confirmation", types[1],
    "2024-08-06", "Mid-Candidature", types[1],
    "2025-07-28", "Pre-Submission", types[1],
    "2017-05-29", "ASC2025", types[1],
    "2017-10-28", "BIBC2025", types[1],
    "2017-12-11", "IDWSDS", types[1],
    "2018-05-24", "JSM2025", types[1],
    "2018-07-13", "useR! 2025", types[1],
    "2018-10-04", "UNO", types[1],
    "2019-01-17", "Graphics group", types[1],
    "2019-07-28", "useR! 2024", types[1],
    "2019-07-28", "3MT", types[1],
    "2019-07-28", "MGBP seminar", types[1],
    "2017-05-29", "ASC2023", types[1],
    "2017-05-29", "IASC ARS 2023", types[1],
    "2016-12-15", "Init quollr", types[3],
    "2017-07-20", "Init cardinalR", types[3],
    "2017-07-20", "Init menuraR", types[4],
    "2017-07-20", "Init Match-a-roo", types[4],
    "2017-07-28", "Release quollr", types[3],
    "2018-01-09", "Release cardinalR", types[3],
    "2017-07-20", "Release menuraR", types[4],
    "2017-07-20", "Release Match-a-roo", types[4],
    "2017-08-22", "Init vis-exp paper", types[2],
    "2017-08-22", "Init menuraR paper", types[2],
    "2017-08-22", "Init thesis", types[2],
    "2017-08-22", "Submit vis-algo paper", types[2],
    "2017-08-22", "Submit quollr paper", types[2],
    "2019-02-13", "Submit cardinalR paper", types[2],
    "2026-01-14", "Submit thesis", types[2]
  ) %>%
  mutate(date = ymd(date))

phd_commits <- phd_commits %>%
  mutate(date = as_date(When)) %>%
  left_join(phd_milestones) %>%
  mutate(event = case_when(duplicated(event) ~ NA_character_, TRUE ~ event))

write_rds(phd_commits, here::here("data/git_commits_by_tasks.rds"))

library(ggrepel)
library(ggbeeswarm)
library(ggplot2)

p_commits <- phd_commits %>%
  ggplot(aes(x = When, y = Repository, colour = Repository)) +
  ggbeeswarm::geom_quasirandom(groupOnX = FALSE, size = 0.6) +
  geom_label_repel(
    aes(label = event), data = filter(phd_commits, Repository == types[3]),
    nudge_y = 0.5, hjust = 0,
    arrow = arrow(length = unit(0.02, "npc"), type = "closed")
  ) +
  geom_label_repel(
    aes(label = event), data = filter(phd_commits, Repository == types[2]),
    nudge_y = -1, hjust = 0,
    arrow = arrow(length = unit(0.02, "npc"), type = "closed")
  ) +
  geom_label_repel(
    aes(label = event), data = filter(phd_commits, Repository == types[1]),
    nudge_y = 4, hjust = 1,
    arrow = arrow(length = unit(0.02, "npc"), type = "closed")
  ) +
  ylab("") +
  scale_colour_brewer(palette = "Set2") +
  theme_bw() +
  theme(legend.position = "none")

