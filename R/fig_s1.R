fig_s1 <- function(DT) {
  g <- DT %>%
    mutate(pRange = if_else(grepl(">", p) | grepl("<", p), 1, 0)) %>%
    mutate(index = 1) %>%
    filter(Journal != "") %>%
    group_by(Journal, Year) %>%
    summarize(NumSummaries = sum(pRange)/sum(index)) %>%
    ggplot(aes(x = Year, y = NumSummaries, color = Journal)) +
    geom_point() +
    geom_line() +
    theme_bw(base_size = 18) +
    labs(y = "Ratio of threshold values reported")

  ggsave(g, filename = file.path('results', 'fig_s1.png'),
         width = 9, height = 8)
}
