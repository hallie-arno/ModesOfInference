fig_1 <- function(DT) {
  InfCutoff <- 10**100000000
  NegInfCutoff <- -10**100000000

  g <- DT %>%
    filter(log(adjp, base = 10) < InfCutoff) %>%
    ggplot(aes(color = TypeStat, shape = TypeStat, label1 = Title, label2 = adjp, label3 = round(Likelihood, 2), label4 = N, label5 = dfnum, label6 = dfdenom))+
    theme_bw() +
    ylim(0, 4.25) +
    # ggtitle("Likelihood ratio vs. p-value (log transformed)") +
    xlab("Calculated likelihood ratio (log transformed)") +
    ylab("Reported p-value (log transformed)") +
    geom_point(aes(log(Likelihood, base = 10), -log(p1, base = 10))) +
    scale_colour_grey() +
    labs(color  = "Test", shape  = "Test") +
    scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
    scale_x_continuous(labels = function(x) format(x, scientific = FALSE)) +
    xlim(0, 60) +
    theme_bw(base_size = 18) +
    coord_fixed(10)

  ggsave(g, filename = file.path('results', 'fig_1.png'),
         width = 9, height = 8)
}
