
#####################################################
# Author: Hung Vo (An Evaluator Analytics)
# Date: 30/09/2020
# 
# Note that the data-import.R script needs to be run to import the DASS-42 data.
# Run the source function below if needed.
#####################################################

# ================= RUN THE DATA IMPORT SCRIPT =================

# run import script
source("data-import.R")

# ================= EDA: ASSOCIATIONS BETWEEN SCALES =================

# glance at correlation between depression and anxiety
dep_anx_p <- ggstatsplot::ggscatterstats(
    data = dass_data,
    x = depression_total_score,
    y = anxiety_total_score,
    point.alpha = 0.5,
    marginal = FALSE,
    title = "Relationship between depression and anxiety total scores",
    xlab = "Depression Total Score",
    ylab = "Anxiety Total Score",
    type = "pearson",
    caption = "Source: DASS-42 Raw Data, Open Psychometrics
    Analysis: Hung Vo, An Evaluator Analytics"
) +
    ylim(c(0, 75))

# glance at correlation between depression and stress
dep_str_p <- ggstatsplot::ggscatterstats(
    data = dass_data,
    x = depression_total_score,
    y = stress_total_score,
    point.alpha = 0.5,
    marginal = FALSE,
    title = "Relationship between depression and stress total scores",
    xlab = "Depression Total Score",
    ylab = "Stress Total Score",
    type = "pearson",
    caption = "Source: DASS-42 Raw Data, Open Psychometrics
    Analysis: Hung Vo, An Evaluator Analytics"
) +
    ylim(c(0, 75))

# glance at correlation between anxiety and stress
anx_str_p <- ggstatsplot::ggscatterstats(
    data = dass_data,
    x = anxiety_total_score,
    y = stress_total_score,
    point.alpha = 0.5,
    marginal = FALSE,
    title = "Relationship between anxiety and stress total scores",
    xlab = "Anxiety Total Score",
    ylab = "Stress Total Score",
    type = "pearson",
    caption = "Source: DASS-42 Raw Data, Open Psychometrics
    Analysis: Hung Vo, An Evaluator Analytics"
) +
    ylim(c(0, 75))

# combine the plots
dass_combined_p <- patchwork::wrap_plots(dep_anx_p,
                                         dep_str_p,
                                         anx_str_p,
                                         ncol = 1)

# ================= EDA: DEPRESSION ACROSS PERSONALITY =================

# depression total scores by tipi items
dep_tipi_data <- dass_data %>% 
    select(respondent_id, tipi1:tipi10, depression_total_score) %>%
    tidyr::pivot_longer(data = .,
                        cols = contains("tipi"),
                        names_to = "measure_name",
                        values_to = "measure_value") %>%
    filter(str_detect(measure_name, "tipi") & measure_value != 0) %>% 
    mutate(measure_name = factor(dplyr::recode(measure_name, 
                                        "tipi1" = "TIPI1: Extraverted, enthusiastic.",
                                        "tipi2" = "TIPI2: Critical, quarrelsome.",
                                        "tipi3" = "TIPI3: Dependable, self-disciplined.",
                                        "tipi4" = "TIPI4: Anxious, easily upset.",
                                        "tipi5" = "TIPI5: Open to new experiences, complex.",
                                        "tipi6" = "TIPI6: Reserved, quiet.",
                                        "tipi7" = "TIPI7: Sympathetic, warm.",
                                        "tipi8" = "TIPI8: Disorganized, careless.",
                                        "tipi9" = "TIPI9: Calm, emotionally stable.",
                                        "tipi10" = "TIPI10: Conventional, uncreative."),
                                 levels = c("TIPI1: Extraverted, enthusiastic.",
                                            "TIPI2: Critical, quarrelsome.",
                                            "TIPI3: Dependable, self-disciplined.",
                                            "TIPI4: Anxious, easily upset.",
                                            "TIPI5: Open to new experiences, complex.",
                                            "TIPI6: Reserved, quiet.",
                                            "TIPI7: Sympathetic, warm.",
                                            "TIPI8: Disorganized, careless.",
                                            "TIPI9: Calm, emotionally stable.",
                                            "TIPI10: Conventional, uncreative."))) 

# depression total scores by tipi items plot
dep_tipi_p <- ggpubr::ggboxplot(data = dep_tipi_data, 
                                x = "measure_value", 
                                y = "depression_total_score",
                                color = "measure_name", 
                                palette = c(ggsci::pal_lancet("lanonc")(9), "cornflowerblue"),
                                title = "Boxplot of depression total scores across the Ten Item Personality Inventory (TIPI)",
                                xlab = "Ten Item Personality Inventory (TIPI) Item",
                                ylab = "Depression Total Score",
                                shape = "tipi1") +
    # ggsci::scale_color_lancet() +
    theme_bw() +
    theme(legend.position = "none") +
    stat_compare_means(label = "p.signif", label.y = 70, method = "t.test", ref.group = 1) +
    stat_compare_means(label.y = 80, label.x = 1, method = "kruskal")  +
    facet_wrap( ~ measure_name, ncol = 3) +
    labs(caption = "Source: DASS-42 Raw Data, Open Psychometrics
    Analysis: Hung Vo, An Evaluator Analytics
         
         1=Disagree strongly and 7=Agree strongly
         T-test comparisons are made against 1=Disagree stronglyns: p > 0.05
         *: p <= 0.05; **: p <= 0.01; ***: p <= 0.001; ****: p <= 0.0001")
dep_tipi_p

# ================= EDA: ANXIETY ACROSS PERSONALITY =================

# anxiety total scores by tipi items
anx_tipi_data <- dass_data %>% 
    select(respondent_id, tipi1:tipi10, anxiety_total_score) %>%
    tidyr::pivot_longer(data = .,
                        cols = contains("tipi"),
                        names_to = "measure_name",
                        values_to = "measure_value") %>%
    filter(str_detect(measure_name, "tipi") & measure_value != 0) %>% 
    mutate(measure_name = factor(dplyr::recode(measure_name, 
                                               "tipi1" = "TIPI1: Extraverted, enthusiastic.",
                                               "tipi2" = "TIPI2: Critical, quarrelsome.",
                                               "tipi3" = "TIPI3: Dependable, self-disciplined.",
                                               "tipi4" = "TIPI4: Anxious, easily upset.",
                                               "tipi5" = "TIPI5: Open to new experiences, complex.",
                                               "tipi6" = "TIPI6: Reserved, quiet.",
                                               "tipi7" = "TIPI7: Sympathetic, warm.",
                                               "tipi8" = "TIPI8: Disorganized, careless.",
                                               "tipi9" = "TIPI9: Calm, emotionally stable.",
                                               "tipi10" = "TIPI10: Conventional, uncreative."),
                                 levels = c("TIPI1: Extraverted, enthusiastic.",
                                            "TIPI2: Critical, quarrelsome.",
                                            "TIPI3: Dependable, self-disciplined.",
                                            "TIPI4: Anxious, easily upset.",
                                            "TIPI5: Open to new experiences, complex.",
                                            "TIPI6: Reserved, quiet.",
                                            "TIPI7: Sympathetic, warm.",
                                            "TIPI8: Disorganized, careless.",
                                            "TIPI9: Calm, emotionally stable.",
                                            "TIPI10: Conventional, uncreative."))) 

# anxiety total scores by tipi items plot
anx_tipi_p <- ggpubr::ggboxplot(data = anx_tipi_data, 
                                x = "measure_value", 
                                y = "anxiety_total_score",
                                color = "measure_name", 
                                palette = c(ggsci::pal_lancet("lanonc")(9), "cornflowerblue"),
                                title = "Boxplot of anxiety total scores across the Ten Item Personality Inventory (TIPI)",
                                xlab = "Ten Item Personality Inventory (TIPI) Item",
                                ylab = "Anxiety Total Score",
                                shape = "tipi1") +
    # ggsci::scale_color_lancet() +
    theme_bw() +
    theme(legend.position = "none") +
    stat_compare_means(label = "p.signif", label.y = 70, method = "t.test", ref.group = 1) +
    stat_compare_means(label.y = 80, label.x = 1, method = "kruskal")  +
    facet_wrap( ~ measure_name, ncol = 3) +
    labs(caption = "Source: DASS-42 Raw Data, Open Psychometrics
    Analysis: Hung Vo, An Evaluator Analytics
         
         1=Disagree strongly and 7=Agree strongly
         T-test comparisons are made against 1=Disagree stronglyns: p > 0.05
         *: p <= 0.05; **: p <= 0.01; ***: p <= 0.001; ****: p <= 0.0001")
anx_tipi_p

# ================= EXPORT IMAGES =================

# export the depression and anxiety plot
ggplot2::ggsave(filename = "output/dass_combined_p.png",
                plot = dass_combined_p,
                units = "in",
                width = 10,
                height = 24,
                dpi = 150)

# export the depression and tipi plot
ggplot2::ggsave(filename = "output/dep_tipi_p.png",
                plot = dep_tipi_p,
                units = "in",
                width = 10,
                height = 24,
                dpi = 150)

# export the depression and tipi plot
ggplot2::ggsave(filename = "output/anx_tipi_p.png",
                plot = anx_tipi_p,
                units = "in",
                width = 10,
                height = 24,
                dpi = 150)
