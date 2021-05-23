// Fizzbuzz
package main

import (
	"strconv"
	"strings"
)

func main() {
	//loopbuzz(100)
	arr := recursivebuzz(makeIntArray(100), []string{})
	println(strings.Join(arr, "\n"))
}

func fizzBuzz(x int) string {
	if x%15 == 0 {
		return "FizzBuzz"
	} else if x%3 == 0 {
		return "Fizz"
	} else if x%5 == 0 {
		return "Buzz"
	} else {
		return strconv.Itoa(x)
	}
}

func loopbuzz(x int) {
	for i := 1; i < x+1; i++ {
		println(fizzBuzz(i))
	}
}

func recursivebuzz(xs []int, done []string) []string {
	if len(xs) == 0 {
		return done
	}
	done = append(done, fizzBuzz(xs[0]))
	xs = xs[1:]
	return recursivebuzz(xs, done)
}

func makeIntArray(x int) []int {
	var xs []int
	for i := 1; i <= 100; i++ {
		xs = append(xs, i)
	}
	return xs
}
