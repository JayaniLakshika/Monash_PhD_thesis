#### This script is to work on git commits for each repository

library(gh)
library(tidyverse)
library(lubridate)
conflicts_prefer(dplyr::filter)

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
    "2025-11-15", "ASC2025", types[1],
    "2025-11-15", "BIBC2025", types[1],
    "2025-10-14", "IDWSDS", types[1],
    "2025-08-04", "JSM2025", types[1],
    "2025-08-09", "useR! 2025", types[1],
    "2024-11-23", "UNO", types[1],
    "2024-11-13", "Graphics group", types[1],
    "2024-07-10", "useR! 2024", types[1],
    "2024-07-10", "3MT", types[1],
    "2024-05-15", "MGBP seminar", types[1],
    "2023-12-10", "ASC2023", types[1],
    "2023-12-08", "IASC ARS 2023", types[1],
    "2024-01-01", "Init quollr", types[3],
    "2024-03-08", "Init cardinalR", types[3],
    "2024-07-09", "Init menuraR", types[4],
    "2023-03-21", "Init Match-a-roo", types[4],
    "2025-12-19", "Release quollr", types[3],
    "2025-12-18", "Release cardinalR", types[3],
    "2025-12-14", "Release menuraR", types[4],
    "2025-08-20", "Release Match-a-roo", types[4],
    "2024-10-08", "Init vis-exp ppr", types[2],
    "2025-03-17", "Init menuraR ppr", types[2],
    "2024-01-09", "Init vis-algo ppr", types[2],
    "2024-02-05", "Init quollr ppr", types[2],
    "2025-03-11", "Init cardinalR ppr", types[2],
    "2025-11-14", "Submit vis-algo ppr", types[2],
    "2025-12-20", "Submit quollr ppr", types[2],
    "2025-12-20", "Submit cardinalR ppr", types[2]
  ) %>%
  mutate(date = ymd(date))

phd_commits <- phd_commits %>%
  mutate(date = as_date(When)) %>%
  left_join(phd_milestones, relationship = "many-to-many") %>%
  mutate(event = case_when(duplicated(event) ~ NA_character_, TRUE ~ event))

write_rds(phd_commits, here::here("data/git_commits_by_tasks.rds"))
