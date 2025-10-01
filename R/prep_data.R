prep_data <- function(path) {
  data <- read.csv(path) %>%
    rename("p" = "X.p") %>%  #weird column names
    mutate(N = as.numeric(N)) %>%
    mutate(Rsquared = as.numeric(Rsquared)) %>%
    mutate(ChiSq = as.numeric(ChiSq)) %>%
    mutate(Gstatistic = as.numeric(Gstatistic)) %>%
    mutate(tStatistic = as.numeric(Tstatistic)) %>%
    mutate(Fstatistic = as.numeric(Fstatistic)) %>%
    mutate(dfnum = as.numeric(dfnum)) %>%
    mutate(dfdenom = as.numeric(dfdenom)) %>%
    select(-c(Lreduced, Lfull)) %>%
    mutate(N = if_else((!is.na(dfnum) & !is.na(dfdenom)), dfnum+dfdenom+1, N)) %>% #N did not always match df
    filter(p != "NS") %>%
    filter(!is.na(p)) %>%
    mutate(p1 = as.numeric(p)) %>%
    mutate(p_num = extract_numeric(p)) %>%
    filter(Exclude != "TRUE") %>%
    filter(!DOI %in% c("https://doi.org/10.1016/j.anbehav.2018.12.014", "")) %>%  #Not sure what happened to this paper but need to remove it
    filter(Title != "Social ontogeny in the communication system of an insect")  %>% #multiple moi for each stat
  # TODO: double check this rowwise nTrue worked
    rowwise() %>%
    mutate(nTrue = length(which(c(Evidentialist, Bayesian, Frequentist) == "TRUE"))) %>%
    filter(nTrue > 1)
}
