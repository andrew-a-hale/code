logger::log_threshold(logger::INFO)
logger::log_appender(logger::appender_stdout)

logger::log_info("tbr to git start")
setwd("C:\\Users\\derpi\\Documents\\Warcraft III\\CustomMapData\\TBR Saves\\v1.39\\backup\\tbr")
shell(".\\to_git.sh")
logger::log_info("tbr to git end")