// Fizzbuzz
package main

func main() {
	loopbuzz(100)
	arr := makeintarray(100)
	recursivebuzz(arr)
}

func loopbuzz(x int) {
	for i := 1; i < x+1; i++ {
		if i%15 == 0 {
			println("FizzBuzz")
		} else if i%3 == 0 {
			println("Fizz")
		} else if i%5 == 0 {
			println("Buzz")
		} else {
			println(i)
		}
	}
}

func recursivebuzz(xs []int) string {
	if len(xs) == 0 {
		return ""
	}
	i := xs[0]
	xs = xs[1:]
	if i%15 == 0 {
		println("FizzBuzz")
	} else if i%3 == 0 {
		println("Fizz")
	} else if i%5 == 0 {
		println("Buzz")
	} else {
		println(i)
	}
	return recursivebuzz(xs)
}

func makeintarray(x int) []int {
	var xs []int
	for i := 1; i <= 100; i++ {
		xs = append(xs, i)
	}
	return xs
}
