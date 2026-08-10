table_1 <- function(DT) {
  dcast(as.data.table(DT), name ~ Year, value.var = 'value') %>%
    as_tibble() %>%
    gt(rowname_col = 'name',
       groupname_col = 'Year',
       row_group_as_column = TRUE)
}
