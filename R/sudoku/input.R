# 1 star
oneStar <- matrix(
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
  ),
  nrow = 9,
  ncol = 9,
  byrow = TRUE
)

# 2 star
twoStar <- matrix(
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
  ),
  nrow = 9,
  ncol = 9,
  byrow = TRUE
)

# 3 star
threeStar <- matrix(
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
  ),
  nrow = 9,
  ncol = 9,
  byrow = TRUE
)

# 4 star
fourStar <- matrix(
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
  ),
  nrow = 9,
  ncol = 9,
  byrow = TRUE
)

# 5 star
fiveStar <- matrix(
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
  ),
  nrow = 9,
  ncol = 9,
  byrow = TRUE
)

# final
final <- matrix(
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
  ),
  nrow = 9,
  ncol = 9,
  byrow = TRUE
)

# bruteforcewiki
bruteforcewiki <- matrix(
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
  ),
  nrow = 9,
  ncol = 9,
  byrow = TRUE
)

