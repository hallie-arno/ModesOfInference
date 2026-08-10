calc_likelihood_ratios <- function(DT) {
  setDT(DT)
  DT[, `:=` (
    Likelihood = fcase(
      !is.na(Rsquared) & !is.na(N), (1 - Rsquared) ^ (-N / 2),
      !is.na(Gstatistic), exp(Gstatistic / 2),
      !is.na(ChiSq), exp(ChiSq / 2),
      !is.na(tStatistic) & !is.na(N), (1 + (tStatistic ^ 2) / (N - 2)) ^ (N / 2),
      !is.na(Fstatistic) & !is.na(dfnum) * !is.na(dfdenom), (1 + Fstatistic * (dfnum / dfdenom)) ^ (N / 2)
    ),

    TypeStat = fcase(
      !is.na(Rsquared), "Rsquared",
      !is.na(Gstatistic), "ChiSq/G",
      !is.na(ChiSq), "ChiSq/G",
      !is.na(tStatistic), "tStatistic",
      !is.na(Fstatistic), "Fstatistic"
    ),

    #If p-values are reported as a threshold, adjust so they can be used in the dataset
    adjp =  fcase (
      grepl("<", p, fixed = TRUE) == TRUE, (p_num - .000001),
      grepl(">", p, fixed = TRUE) == TRUE, (p_num + .000001),
      grepl("<", p, fixed = FALSE) == FALSE &  grepl(">", p, fixed = TRUE) == FALSE, (p_num - 0)
    )

  )]
  return(as.data.frame(DT))
}
