library(data.table)
library(magrittr)

abns <- readr::read_csv("abn_memberno.csv")
setDT(abns)

weights <- c(10L, seq.int(1, 19, 2))

validate_abn <- function(abn) {
  ds <- as.numeric(stringr::str_split(abn, "")[[1]])
  ds[1] <- ds[1] - 1
  sum(ds * weights) %% 89L == 0L
}

weighted_abn_sum <- function(abn) {
  ds <- as.numeric(stringr::str_split(abn, "")[[1]])
  ds[1] <- ds[1] - 1
  sum(ds * weights)
}

cleaning_abn <- abns[
  stringr::str_detect(Abn, "^[1-9]{1}[0-9]{1} ?[0-9]{3} ?[0-9]{3} ?[0-9]{3}$"),
  .(Abn = stringr::str_remove_all(Abn, " "))
][
  ,
  .(
    Abn,
    valid = purrr::map_lgl(Abn, validate_abn)
  )
][
  valid == TRUE
] %>%
  unique()

big_string <- stringr::str_c(unlist(cleaning_abn$Abn), collapse = "")
setNames(
  purrr::map_dfc(0:9, ~stringr::str_count(big_string, as.character(.x))),
  0:9
)

digit_dt <- cleaning_abn$Abn %>%
  stringr::str_split("", simplify = TRUE) %>%
  data.table()

digit_summary <- digit_dt[
    ,
    lapply(.SD, factor, levels = 0:9)
  ][
    ,
    lapply(.SD, table)
  ]

digit_summary_final <- digit_summary[
  ,
  .SD,
  .SDcols = stringr::str_subset(names(digit_summary), ".N$")
] %>%
  data.frame(row.names = 0:9) %>%
  setNames(1:11)

cleaning_abn[
  order(Abn),
  .(Abn = as.numeric(Abn), weightedSum = purrr::map_dbl(Abn, weighted_abn_sum))
][
  ,
  .(
    Abn, weightedSum, 
    prev_abn = shift(Abn), prev_sum = shift(weightedSum), 
    diff = Abn - shift(Abn), sum_diff = abs(weightedSum - shift(weightedSum))
  )
][
  order(diff)
] %>% 
  View()

