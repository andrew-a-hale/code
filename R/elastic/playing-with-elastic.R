library(magrittr)
library(jsonlite)
library(data.table)
library(elastic)

system(
  'docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.10.2',
  ignore.stdout = TRUE,
  show.output.on.console = FALSE
)

conn <- connect()

dt <- data.table(ggplot2::diamonds)

docs_bulk_index(conn, dt, "diamonds", quiet = TRUE)
