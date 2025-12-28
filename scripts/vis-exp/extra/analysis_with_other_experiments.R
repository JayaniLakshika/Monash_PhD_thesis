### Experiment II

method + sample size

```{r}
#| label: read-collected-data-method-ss

results_df_method_ss <- read_rds(here::here("data/result_method_sample_size.rds"))

## To reformat the response variable
results_df_method_ss <- results_df_method_ss |>
  mutate(result = if_else(result == "Correct", 1, 0))

## To change the type of distance factor
results_df_method_ss <- results_df_method_ss |>
  mutate(sample_size = as.factor(sample_size))

#Set PCA as base
results_df_method_ss <- results_df_method_ss |>
  mutate(method = factor(method,
                         levels = c("pca", "tsne", "umap", "phate", "trimap", "pacmap")))
```

```{r}
#| label: pcp-ss
#| fig-cap: "Parallel coordinate plots of the various decisions made by participants based on different sample sizes."
#| fig-width: 15
#| fig-height: 10

results_df_method_ss |>
  select(subject, method, sample_size, result) |>
  mutate(result = if_else(result == 1, "Correct", "Wrong")) |>
  pivot_wider(names_from = sample_size,
              values_from = result) |>
  pcp_select(3:5) |>
  pcp_scale() |>
  pcp_arrange(method="from-right") |>
  ggplot(aes_pcp(), linewidth = 0.1) +
  geom_pcp_boxes(boxwidth=0.1) +
  geom_pcp(aes(group = subject), axiswidth = c(0,0)) +
  geom_pcp_labels() +
  facet_wrap(~method, scales = "free_y") +
  theme_light() +
  scale_x_discrete(labels = c("375", "1500", "7500")) +
  ylab("") +
  xlab("") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title = element_blank())

```

```{r}
#| label: logistic-method-ss
## Fit the logistic model (full)
model_main_results_ss <- glmer(result ~ method * sample_size + (1 | subject), data = results_df_method_ss,
                               family = "binomial",
                               control = glmerControl(optimizer = "bobyqa",
                                                      optCtrl = list(maxfun = 1e5)))

#summary(model_main_results_ss)
```

```{r}
#| eval: false

results_df_method_ss |>
  count(method, sample_size, result, sort = TRUE) |>
  filter(result == 1) |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "nldr") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```


```{r}
# Fit the model without interaction
model_no_interaction_ss <- glmer(result ~ method + sample_size + (1 | subject), data = results_df_method_ss,
                                 family = "binomial",
                                 control = glmerControl(optimizer = "bobyqa",
                                                        optCtrl = list(maxfun = 1e5)))

#summary(model_no_interaction_ss)
```


```{r}
#| label: tbl-glmer-comp-ss
#| tbl-cap: "Summary of model with and without interactions."

anova(model_no_interaction_ss, model_main_results_ss) |>
  tidy() |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "summarysscomp") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```

```{r}
#| label: tbl-glmer-no-ss
#| tbl-cap: "Parametric coefficients in GLMM model without interaction."

# Extract fixed effect
tidy(model_no_interaction_ss, effects = "fixed") |>
  select(-effect) |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "glmerssno") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```


```{r}
#| label: tbl-glmer-ss
#| tbl-cap: "Parametric coefficients in GLMM model with interaction."

# Extract fixed effect
tidy(model_main_results_ss, effects = "fixed") |>
  select(-effect) |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "glmerss") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```

```{r}
#| eval: false

resid_panel(model_main_results_ss, plots = "all")
```

```{r}
#| label: emmeans-glmer-ss
#| fig-cap: "Emmeans with interaction"

#ref_grid(model_main_results) ## The foundation for emmeans

emm1_1 <- emmeans(model_main_results_ss, specs = ~ method:sample_size, type = "response", infer = TRUE, calc = c(n = ".wgt."))
plot(emm1_1, comparisons = TRUE, type = "response") +
  theme_minimal()

## To get contrasts
# pairs(emm1_1, reverse = TRUE)
#emmip(model_main_results, method ~ distance_factor) + theme_minimal()

# emm1_1$contrasts |>
#      confint()
#
# emm1_1$contrasts |>
#      summary(infer = TRUE)
#
# emm1_1$emmeans |>
#      as_tibble()
# emm1 <- emmeans(model_main_results, specs = ~ method*distance_factor, adjust = "none") ## with Tukey
# # emm1$emmeans
# # emm1$contrasts
# plot(emm1) + theme_minimal()
```

```{r}
#| label: gen-correct-prop-by-method-ss

all_method_ss <- results_df_method_ss |>
  select(method, sample_size) |>
  distinct()

method_ss_by_result_df <- results_df_method_ss |>
  count(method, sample_size, result) |>
  mutate(prop = n/length(unique(results_df_method_ss$subject))) |> ## Since 4 subjects
  filter(result == 1)

method_ss_by_result_df <- left_join(all_method_ss, method_ss_by_result_df, by =c("method", "sample_size")) %>%
  replace(is.na(.), 0)
```

```{r}
#| label: fig-response-by-method-ss
#| fig-cap: "The corrected proportion achieved by participants when viewing NLDR methods and the sample size. Each point represents the correct proportion by the NLDR method and the sample size. XXXNeed to write conclude sentence after collecting data"
#| fig-pos: H

method_ss_by_result_df |>
  ggplot(
    aes(x = sample_size,
        y = prop,
        group = method)) +
  geom_point(alpha=0.5) +
  geom_line(alpha=0.5) +
  facet_wrap(~method, ncol = 3) +
  #scale_color_discrete_qualitative() +
  # stat_summary(mapping=aes(group=distance_factor, colour = distance_factor), fun = mean, geom = "line") +
  # stat_summary(mapping=aes(group=distance_factor, colour = distance_factor), fun = mean, geom = "point", shape = 19,
  #                size = 2, alpha = 0.5)  +
  ylim(0, 1) +
  theme_minimal()  +
  theme(axis.text.x=element_text(size = 5),
        axis.text.y=element_text(size = 5),
        axis.title =element_text(size = 7),
        axis.ticks.x = element_line(colour = "#bdbdbd", linewidth = 0.3),
        axis.ticks.y = element_line(colour = "#bdbdbd", linewidth = 0.3),
        strip.background = element_rect(fill="#bdbdbd", colour = "#bdbdbd"),
        panel.border = element_rect(colour = "#bdbdbd", fill = NA),
        strip.text = element_text(colour = "white")) +
  xlab("sample size") +
  ylab("correct proportion")

```

```{r}
#| label: fit-model-time-taken-ss

## To change the type of distance time_taken_in_seconds
results_df_method_ss <- results_df_method_ss |>
  mutate(time_taken_in_minutes = as.numeric(time_taken_in_minutes))

## Fit the logistic model (full)
model_main_time_taken_ss <- lmerTest::lmer(time_taken_in_minutes ~ method + sample_size + method * sample_size + (1 | subject), data = results_df_method_ss, control = lmerControl(optimizer = "bobyqa"))

# summary(model_main_time_taken)
# coef(model_main_time_taken)
```

```{r}
#| label: fit-model-time-taken-ss-no

## Fit the logistic model (full)
model_main_time_taken_no_interaction_ss <- lmerTest::lmer(time_taken_in_minutes ~ method + sample_size + (1 | subject), data = results_df_method_ss, control = lmerControl(optimizer = "bobyqa"))

# summary(model_main_time_taken)
# coef(model_main_time_taken)
```

```{r}
#| label: tbl-lmer-comp-ss
#| tbl-cap: "Summary of model with and without interactions."

anova(model_main_time_taken_no_interaction_ss, model_main_time_taken_ss) |>
  tidy() |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "summarysscompt") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```

```{r}
#| label: tbl-lmer-no-ss
#| tbl-cap: "Parametric coefficients in LMM model without interaction."

# Extract fixed effect
tidy(model_main_time_taken_no_interaction_ss, effects = "fixed") |>
  select(-effect) |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "glmernosst") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```

```{r}
#| label: tbl-lmer-ss
#| tbl-cap: "Parametric coefficients in LMM model with interaction."

# Extract fixed effect
tidy(model_main_time_taken_ss, effects = "fixed") |>
  select(-effect) |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "glmersst") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```

```{r}
#| label: emmeans-lmer-ss
#| fig-cap: "Emmeans with interaction"

#ref_grid(model_main_time_taken)

emm2_1 <- emmeans(model_main_time_taken_ss, specs = ~ method:sample_size, infer = TRUE, calc = c(n = ".wgt."))

plot(emm2_1, comparisons = TRUE) +
  theme_minimal()
## To get contrasts
# pairs(emm2_1, reverse = TRUE)
# emmip(model_main_time_taken, method ~ distance_factor) + theme_minimal()


# emm2_1$contrasts |>
#      confint()
#
# emm2_1$contrasts |>
#      summary(infer = TRUE)
#
# emm2_1$emmeans |>
#      as_tibble()
# emm2 <- emmeans(model_main_time_taken, specs = pairwise ~ method:distance_factor)
# plot(emm2) + theme_minimal()
#
# # emm2$emmeans
# # emm2$contrasts
```

```{r}
#| label: fig-time-by-method-ss
#| fig-cap: "The distribution of time taken (in minutes) to submit the response for each combination of NLDR method, the answer, and sample size, shown using horizontally jittered plots. The colored point indicates the average time taken for each NLDR method. XXXNeed to write conclude sentence after collecting data"
#| fig-pos: H

results_df_method_ss |>
  mutate(result = if_else(result == 0, "wrong", "correct")) |>
  ggplot(
    aes(x = reorder(method,-time_taken_in_minutes),
        y = time_taken_in_minutes)) +
  geom_quasirandom(alpha=0.5) +
  facet_grid(sample_size ~ result) +
  stat_summary(mapping=aes(group=1), colour="#d95f02",
               fun = mean, geom = "line",
               linewidth = 0.5) +
  stat_summary(mapping=aes(group=method),
               colour="#d95f02",
               fun = mean, geom = "point", shape = 19,
               size = 2, alpha = 0.6) +
  scale_color_discrete_qualitative() +
  theme_minimal() +
  theme(axis.text.x=element_text(size = 5),
        axis.text.y=element_text(size = 5),
        axis.title =element_text(size = 7),
        axis.ticks.x = element_line(colour = "#bdbdbd", linewidth = 0.3),
        axis.ticks.y = element_line(colour = "#bdbdbd", linewidth = 0.3),
        strip.background = element_rect(fill="#bdbdbd", colour = "#bdbdbd"),
        panel.border = element_rect(colour = "#bdbdbd", fill = NA),
        strip.text = element_text(colour = "white"),
        legend.position = "bottom",
        legend.title=element_blank(),
        legend.text = element_text(size = 7)) +
  guides(colour = guide_legend(nrow = 1)) +
  xlab("DR method") +
  ylab("time taken (in minutes)")

```


### Experiment III

method + percentage of background noise

```{r}
#| label: read-collected-data-method-bkg-noise

results_df_method_bkg <- read_rds(here::here("data/result_method_bkg_noise.rds"))

## To reformat the response variable
results_df_method_bkg <- results_df_method_bkg |>
  mutate(result = if_else(result == "Correct", 1, 0))

## To change the type of distance factor
results_df_method_bkg <- results_df_method_bkg |>
  mutate(bkg_noise = as.factor(bkg_noise))

#Set PCA as base
results_df_method_bkg <- results_df_method_bkg |>
  mutate(method = factor(method,
                         levels = c("pca", "tsne", "umap", "phate", "trimap", "pacmap")))

```

```{r}
#| label: pcp-bkg
#| fig-cap: "Parallel coordinate plots of the various decisions made by participants based on different percentage of background noise."
#| fig-width: 15
#| fig-height: 10

results_df_method_bkg |>
  select(subject, method, bkg_noise, result) |>
  mutate(result = if_else(result == 1, "Correct", "Wrong")) |>
  pivot_wider(names_from = bkg_noise,
              values_from = result) |>
  pcp_select(3:5) |>
  pcp_scale() |>
  pcp_arrange(method="from-right") |>
  ggplot(aes_pcp(), linewidth = 0.1) +
  geom_pcp_boxes(boxwidth=0.1) +
  geom_pcp(aes(group = subject), axiswidth = c(0,0)) +
  geom_pcp_labels() +
  facet_wrap(~method, scales = "free_y") +
  theme_light() +
  scale_x_discrete(labels = c("0", "0.2", "0.4")) +
  ylab("") +
  xlab("") +
  theme(axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        axis.title = element_blank())

```

```{r}
#| label: logistic-method-bkg

## Fit the logistic model (full)
model_main_results_bkg <- glmer(result ~ method * bkg_noise + (1 | subject), data = results_df_method_bkg,
                                family = "binomial",
                                control = glmerControl(optimizer = "bobyqa",
                                                       optCtrl = list(maxfun = 1e5)))

#summary(model_main_results_bkg)
```

```{r}
#| eval: false

results_df_method_bkg |>
  count(method, bkg_noise, result, sort = TRUE) |>
  filter(result == 1) |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "nldr") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```


```{r}
# Fit the model without interaction
model_no_interaction_bkg <- glmer(result ~ method + bkg_noise + (1 | subject), data = results_df_method_bkg,
                                  family = "binomial",
                                  control = glmerControl(optimizer = "bobyqa",
                                                         optCtrl = list(maxfun = 1e5)))

#summary(model_no_interaction_bkg)
```


```{r}
#| label: tbl-glmer-comp-bkg
#| tbl-cap: "Summary of model with and without interactions."

anova(model_no_interaction_bkg, model_main_results_bkg) |>
  tidy() |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "summarybkgcomp") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```

```{r}
#| label: tbl-glmer-no-bkg
#| tbl-cap: "Parametric coefficients in GLMM model without interaction."

# Extract fixed effect
tidy(model_no_interaction_bkg, effects = "fixed") |>
  select(-effect) |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "glmerbkgno") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```


```{r}
#| label: tbl-glmer-bkg
#| tbl-cap: "Parametric coefficients in GLMM model with interaction."

# Extract fixed effect
tidy(model_main_results_bkg, effects = "fixed") |>
  select(-effect) |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "glmerbkg") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```

```{r}
#| eval: false

resid_panel(model_main_results_bkg, plots = "all")
```

```{r}
#| label: emmeans-glmer-bkg
#| fig-cap: "Emmeans with interaction"

#ref_grid(model_main_results) ## The foundation for emmeans

emm1_1 <- emmeans(model_main_results_bkg, specs = ~ method:bkg_noise, type = "response", infer = TRUE, calc = c(n = ".wgt."))
plot(emm1_1, comparisons = TRUE, type = "response") +
  theme_minimal()

## To get contrasts
# pairs(emm1_1, reverse = TRUE)
#emmip(model_main_results, method ~ distance_factor) + theme_minimal()

# emm1_1$contrasts |>
#      confint()
#
# emm1_1$contrasts |>
#      summary(infer = TRUE)
#
# emm1_1$emmeans |>
#      as_tibble()
# emm1 <- emmeans(model_main_results, specs = ~ method*distance_factor, adjust = "none") ## with Tukey
# # emm1$emmeans
# # emm1$contrasts
# plot(emm1) + theme_minimal()
```

```{r}
#| label: gen-correct-prop-by-method-bkg

all_method_bkg <- results_df_method_bkg |>
  select(method, bkg_noise) |>
  distinct()

method_bkg_by_result_df <- results_df_method_bkg |>
  count(method, bkg_noise, result) |>
  mutate(prop = n/length(unique(results_df_method_bkg$subject))) |> ## Since 4 subjects
  filter(result == 1)

method_bkg_by_result_df <- left_join(all_method_bkg, method_bkg_by_result_df, by =c("method", "bkg_noise")) %>%
  replace(is.na(.), 0)
```

```{r}
#| label: fig-response-by-method-bkg
#| fig-cap: "The corrected proportion achieved by participants when viewing NLDR methods and the percentage of background noise. Each point represents the correct proportion by the NLDR method and the percentage of background noise. XXXNeed to write conclude sentence after collecting data"
#| fig-pos: H

method_bkg_by_result_df |>
  ggplot(
    aes(x = bkg_noise,
        y = prop,
        group = method)) +
  geom_point(alpha=0.5) +
  geom_line(alpha=0.5) +
  facet_wrap(~method, ncol = 3) +
  #scale_color_discrete_qualitative() +
  # stat_summary(mapping=aes(group=distance_factor, colour = distance_factor), fun = mean, geom = "line") +
  # stat_summary(mapping=aes(group=distance_factor, colour = distance_factor), fun = mean, geom = "point", shape = 19,
  #                size = 2, alpha = 0.5)  +
  ylim(0, 1) +
  theme_minimal()  +
  theme(axis.text.x=element_text(size = 5),
        axis.text.y=element_text(size = 5),
        axis.title =element_text(size = 7),
        axis.ticks.x = element_line(colour = "#bdbdbd", linewidth = 0.3),
        axis.ticks.y = element_line(colour = "#bdbdbd", linewidth = 0.3),
        strip.background = element_rect(fill="#bdbdbd", colour = "#bdbdbd"),
        panel.border = element_rect(colour = "#bdbdbd", fill = NA),
        strip.text = element_text(colour = "white")) +
  xlab("Percentage of background noise") +
  ylab("correct proportion")

```

```{r}
#| label: fit-model-time-taken-bkg

## To change the type of distance time_taken_in_seconds
results_df_method_bkg <- results_df_method_bkg |>
  mutate(time_taken_in_minutes = as.numeric(time_taken_in_minutes))

## Fit the logistic model (full)
model_main_time_taken_bkg <- lmerTest::lmer(time_taken_in_minutes ~ method + bkg_noise + method * bkg_noise + (1 | subject), data = results_df_method_bkg, control = lmerControl(optimizer = "bobyqa"))

# summary(model_main_time_taken)
# coef(model_main_time_taken)
```

```{r}
#| label: fit-model-time-taken-bkg-no

## Fit the logistic model (full)
model_main_time_taken_no_interaction_bkg <- lmerTest::lmer(time_taken_in_minutes ~ method + bkg_noise + (1 | subject), data = results_df_method_bkg, control = lmerControl(optimizer = "bobyqa"))

# summary(model_main_time_taken)
# coef(model_main_time_taken)
```

```{r}
#| label: tbl-lmer-comp-bkg
#| tbl-cap: "Summary of model with and without interactions."

anova(model_main_time_taken_no_interaction_bkg, model_main_time_taken_bkg) |>
  tidy() |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "summarybkgcompt") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```

```{r}
#| label: tbl-lmer-no-bkg
#| tbl-cap: "Parametric coefficients in LMM model without interaction."

# Extract fixed effect
tidy(model_main_time_taken_no_interaction_bkg, effects = "fixed") |>
  select(-effect) |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "glmernobkgt") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```

```{r}
#| label: tbl-lmer-bkg
#| tbl-cap: "Parametric coefficients in LMM model with interaction."

# Extract fixed effect
tidy(model_main_time_taken_bkg, effects = "fixed") |>
  select(-effect) |>
  kableExtra::kable(format = "latex",
                    booktabs = TRUE,
                    label = "glmerbkgt") |>
  kableExtra::kable_styling(latex_options = "scale_down")
```

```{r}
#| label: emmeans-lmer-bkg
#| fig-cap: "Emmeans with interaction"

#ref_grid(model_main_time_taken)

emm2_1 <- emmeans(model_main_time_taken_bkg, specs = ~ method:bkg_noise, infer = TRUE, calc = c(n = ".wgt."))

plot(emm2_1, comparisons = TRUE) +
  theme_minimal()
## To get contrasts
# pairs(emm2_1, reverse = TRUE)
# emmip(model_main_time_taken, method ~ distance_factor) + theme_minimal()


# emm2_1$contrasts |>
#      confint()
#
# emm2_1$contrasts |>
#      summary(infer = TRUE)
#
# emm2_1$emmeans |>
#      as_tibble()
# emm2 <- emmeans(model_main_time_taken, specs = pairwise ~ method:distance_factor)
# plot(emm2) + theme_minimal()
#
# # emm2$emmeans
# # emm2$contrasts
```

```{r}
#| label: fig-time-by-method-bkg
#| fig-cap: "The distribution of time taken (in minutes) to submit the response for each combination of NLDR method, the answer, and percentage of background noise, shown using horizontally jittered plots. The colored point indicates the average time taken for each NLDR method. XXXNeed to write conclude sentence after collecting data"
#| fig-pos: H

results_df_method_bkg |>
  mutate(result = if_else(result == 0, "wrong", "correct")) |>
  ggplot(
    aes(x = reorder(method,-time_taken_in_minutes),
        y = time_taken_in_minutes)) +
  geom_quasirandom(alpha=0.5) +
  facet_grid(bkg_noise ~ result) +
  stat_summary(mapping=aes(group=1), colour="#d95f02",
               fun = mean, geom = "line",
               linewidth = 0.5) +
  stat_summary(mapping=aes(group=method),
               colour="#d95f02",
               fun = mean, geom = "point", shape = 19,
               size = 2, alpha = 0.6) +
  scale_color_discrete_qualitative() +
  theme_minimal() +
  theme(axis.text.x=element_text(size = 5),
        axis.text.y=element_text(size = 5),
        axis.title =element_text(size = 7),
        axis.ticks.x = element_line(colour = "#bdbdbd", linewidth = 0.3),
        axis.ticks.y = element_line(colour = "#bdbdbd", linewidth = 0.3),
        strip.background = element_rect(fill="#bdbdbd", colour = "#bdbdbd"),
        panel.border = element_rect(colour = "#bdbdbd", fill = NA),
        strip.text = element_text(colour = "white"),
        legend.position = "bottom",
        legend.title=element_blank(),
        legend.text = element_text(size = 7)) +
  guides(colour = guide_legend(nrow = 1)) +
  xlab("DR method") +
  ylab("time taken (in minutes)")

```


### Experiment IV

### Experiment V
