# FizzBuzz

for (i in 1:100) {
  if (i %% 15 == 0) {
    print("FizzBuzz")
  } else if (i %% 3 == 0) {
    print("Fizz")
  } else if (i %% 5 == 0) {
    print("Buzz")
  } else {
    print(i)
  }
}

fizzBuzz <- function(arr) {
  if (length(arr) == 0) {
    return(NULL)
  }
  n <- arr[1]
  arr <- arr[-1]

  if (n %% 15 == 0) {
    append("FizzBuzz", fizzBuzz(arr))
  } else if (n %% 3 == 0) {
    append("Fizz", fizzBuzz(arr))
  } else if (n %% 5 == 0) {
    append("Buzz", fizzBuzz(arr))
  } else {
    append(n, fizzBuzz(arr))
  }
}
