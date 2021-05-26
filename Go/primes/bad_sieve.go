package main

import (
	"fmt"
	"math"
	"time"
)

func main() {
	s := time.Now()
	fmt.Println(sieve(1000000))
	fmt.Println(time.Now().Sub(s))
}

func sieve(n int) []int {
	if n <= 2 {
		return []int{2}
	}
	nums := makearray(n)[1:]
	rootn := int(math.Ceil(math.Sqrt(float64(n))))
	for x := 2; x <= rootn; x++ {
		for iy, y := range nums {
			if y%x == 0 && iy <= len(nums) {
				nums = remove(nums, iy)
			}
		}
	}
	return append(nums, sieve(rootn)...)
}

func makearray(n int) []int {
	var result []int
	for i := 1; i <= n; i++ {
		result = append(result, i)
	}
	return result
}

func remove(arr []int, i int) []int {
	return append(arr[:i], arr[i+1:]...)
}
