dt <- data.table::data.table(
  id = 1,
  loc = c(rep("A", 10), rep("B", 40), rep("C", 30), rep("A", 20)),
  date = c(
    seq.Date(as.Date("2020-1-1"), as.Date("2020-1-1") + 49, 1), 
    seq.Date(as.Date("2021-1-1"), as.Date("2021-1-1") + 49, 1)
  )
)

data.table::setorder(dt, id, date)

dt[
  ,
  .(f =  min(date), l = max(date)),
  by = .(id, loc, rleid = data.table::rleid(id, loc))
]

