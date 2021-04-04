# 1 star
oneStar <- 
  list(
    0L, 2L, 0L, 0L, 1L, 0L, 7L, 0L, 0L,
    0L, 5L, 9L, 4L, 0L, 7L, 0L, 1L, 8L,
    1L, 0L, 8L, 3L, 0L, 9L, 0L, 0L, 5L,
    0L, 9L, 6L, 2L, 0L, 0L, 0L, 0L, 4L,
    7L, 8L, 0L, 0L, 3L, 0L, 0L, 6L, 1L,
    3L, 0L, 0L, 0L, 0L, 8L, 5L, 7L, 0L,
    2L, 0L, 0L, 9L, 0L, 3L, 6L, 0L, 7L,
    8L, 3L, 0L, 1L, 0L, 6L, 2L, 5L, 0L,
    0L, 0L, 4L, 0L, 5L, 0L, 0L, 8L, 0L
  ) %>% 
  matrix(ncol = 9L, byrow = TRUE)

# 2 star
twoStar <-
  list(
    0L, 0L, 0L, 0L, 0L, 2L, 0L, 4L, 3L,
    0L, 3L, 7L, 0L, 5L, 9L, 0L, 0L, 8L,
    4L, 0L, 2L, 0L, 0L, 7L, 9L, 0L, 0L,
    6L, 1L, 0L, 8L, 0L, 0L, 5L, 0L, 0L,
    0L, 8L, 0L, 7L, 0L, 4L, 0L, 2L, 0L,
    0L, 0L, 3L, 0L, 0L, 6L, 0L, 1L, 4L,
    0L, 0L, 1L, 9L, 0L, 0L, 6L, 0L, 7L,
    7L, 0L, 0L, 2L, 3L, 0L, 1L, 9L, 0L,
    8L, 5L, 0L, 6L, 0L, 0L, 0L, 0L, 0L
  ) %>% 
  matrix(ncol = 9L, byrow = TRUE)

# 3 star
threeStar <-
  list(
    0L, 0L, 4L, 0L, 6L, 0L, 1L, 0L, 0L,
    9L, 0L, 0L, 3L, 0L, 1L, 0L, 0L, 8L,
    0L, 3L, 0L, 8L, 0L, 5L, 0L, 2L, 0L,
    8L, 0L, 7L, 0L, 0L, 0L, 5L, 0L, 6L,
    0L, 5L, 0L, 0L, 0L, 0L, 0L, 4L, 0L,
    4L, 0L, 6L, 0L, 0L, 0L, 3L, 0L, 9L,
    0L, 7L, 0L, 9L, 0L, 4L, 0L, 8L, 0L,
    1L, 0L, 0L, 6L, 0L, 2L, 0L, 0L, 7L,
    0L, 0L, 8L, 0L, 1L, 0L, 4L, 0L, 0L
  ) %>% 
  matrix(ncol = 9L, byrow = TRUE)

# 4 star
fourStar <- 
  list(
    9L, 0L, 6L, 0L, 8L, 0L, 5L, 0L, 0L,
    0L, 0L, 0L, 0L, 0L, 3L, 0L, 4L, 0L,
    0L, 0L, 5L, 0L, 0L, 0L, 0L, 0L, 2L,
    0L, 0L, 0L, 4L, 0L, 1L, 0L, 5L, 0L,
    0L, 0L, 8L, 0L, 9L, 0L, 1L, 0L, 0L,
    0L, 3L, 0L, 8L, 0L, 7L, 0L, 0L, 0L,
    1L, 0L, 0L, 0L, 0L, 0L, 9L, 0L, 0L,
    0L, 7L, 0L, 2L, 0L, 0L, 0L, 0L, 0L,
    0L, 0L, 3L, 0L, 1L, 0L, 8L, 0L, 6L
  ) %>% 
  matrix(ncol = 9L, byrow = TRUE)

# 5 star
fiveStar <-
  list(
    1L, 0L, 3L, 0L, 0L, 0L, 0L, 0L, 0L,
    0L, 8L, 0L, 0L, 0L, 0L, 0L, 5L, 3L,
    0L, 0L, 0L, 8L, 0L, 5L, 9L, 0L, 0L,
    8L, 0L, 0L, 0L, 2L, 4L, 0L, 0L, 0L,
    0L, 1L, 6L, 0L, 0L, 0L, 4L, 3L, 0L,
    0L, 0L, 0L, 3L, 8L, 0L, 0L, 0L, 6L,
    0L, 0L, 1L, 7L, 0L, 9L, 0L, 0L, 0L,
    4L, 6L, 0L, 0L, 0L, 0L, 0L, 7L, 0L,
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 4L
  ) %>% 
  matrix(ncol = 9L, byrow = TRUE)

# final
final <-
  list(
    0L, 0L, 1L, 0L, 5L, 0L, 0L, 0L, 0L,
    8L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L,
    0L, 0L, 0L, 2L, 0L, 3L, 1L, 9L, 0L,
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 4L, 0L,
    7L, 0L, 0L, 0L, 8L, 0L, 0L, 0L, 1L,
    0L, 9L, 0L, 0L, 0L, 0L, 0L, 0L, 0L,
    0L, 3L, 2L, 4L, 0L, 9L, 0L, 0L, 0L,
    0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 6L,
    0L, 0L, 0L, 0L, 7L, 0L, 5L, 0L, 0L
  ) %>% 
  matrix(ncol = 9L, byrow = TRUE)

# bruteforcewiki
bruteforcewiki <-
  list(
    5L, 3L, 0L, 0L, 7L, 0L, 0L, 0L, 0L,
    6L, 0L, 0L, 1L, 9L, 5L, 0L, 0L, 0L,
    0L, 9L, 8L, 0L, 0L, 0L, 0L, 6L, 0L,
    8L, 0L, 0L, 0L, 6L, 0L, 0L, 0L, 3L,
    4L, 0L, 0L, 8L, 0L, 3L, 0L, 0L, 1L,
    7L, 0L, 0L, 0L, 2L, 0L, 0L, 0L, 6L,
    0L, 6L, 0L, 0L, 0L, 0L, 2L, 8L, 0L,
    0L, 0L, 0L, 4L, 1L, 9L, 0L, 0L, 5L,
    0L, 0L, 0L, 0L, 8L, 0L, 0L, 7L, 9L
  ) %>% 
  matrix(ncol = 9L, byrow = TRUE)

