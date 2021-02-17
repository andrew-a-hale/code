logger::log_threshold(logger::INFO)
path <- "C:\\Users\\derpi\\Documents\\Warcraft III\\CustomMapData\\TBR Saves\\v1.39"
logger::log_appender(logger::appender_stdout)
logger::log_info("backup job started!")

files <- normalizePath(list.files(path, ".txt", full.names = T))
backup_dir <- "C:\\Users\\derpi\\Documents\\code\\code-main\\backup\\tbr"

if (!dir.exists(backup_dir)) dir.create(backup_dir)

res <- file.copy(files, backup_dir, overwrite = T)

for (f in seq_along(files)) {
  file <- stringr::str_extract(files[f], "[_a-z]+.txt")
  if (all(res)) {
    logger::log_info("{file} backed up") 
  } 
  else {
    logger::log_error("error while copying {file}")
  }
}

logger::log_success("backup job completed!")
