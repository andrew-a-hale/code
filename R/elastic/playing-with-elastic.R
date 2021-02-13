library(magrittr)
library(jsonlite)
library(data.table)

# docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.10.2

dt <- data.table(ggplot2::diamonds)

big_dt <- dt[
  sample.int(nrow(dt), 1e7, replace = T)
][
  ,
  .(data = list(data.table(carat, color, clarity, depth, table, price, x, y, z))),
  keyby = cut
]

fwrite(big_dt[[2]][[2]], "c.csv")
fwrite(big_dt, "z.csv")
