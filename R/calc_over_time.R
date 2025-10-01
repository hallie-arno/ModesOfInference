calc_over_time <- function(DT) {
  DT %>%
    filter(Journal != "") %>%
    mutate(Frequentist = if_else(Type == "Frequentist", TRUE, Frequentist)) %>%
    mutate(Evidentialist = if_else(Type == "Evidentialist", TRUE, Evidentialist)) %>%
    filter(Title != "Social ontogeny in the communication system of an insect") %>%
    #  filter(Journal %in% c("AnBehav", "CJFAS", "LandEcol")) %>%
    group_by(Year) %>%
    #filter(Evidentialist != TRUE & Frequentist != TRUE & AIC != TRUE & Bayesian !=TRUE) %>%
    summarize(Bayesian = sum(Bayesian, na.rm = TRUE),
              Frequentist = sum(Frequentist, na.rm = TRUE),
              Evidentialist = sum(Evidentialist, na.rm = TRUE)) %>%
    ungroup() %>%
    rowwise() %>%
    mutate(Total = sum(Bayesian, Frequentist, Evidentialist)) %>%
    # filter(Journal == "AnBehav" & Year == 2019) %>%
    pivot_longer(cols = c(Bayesian, Frequentist, Evidentialist)) %>%
    mutate(across(name, ~factor(., levels=c("Frequentist", "Evidentialist","Bayesian"))))
}
