function loopPie(n::Int)
    x = BitArray(undef, n)
    offset = 0.5
    for i = 1:n
        x[i] = (rand() - offset) ^ 2 + (rand() - offset) ^ 2 < 1/4
    end
    4 * sum(x) / n
end

@time loopPie(100000)


function fastPie(n::Int)
    x = BigFloat(0)
    c1 = 12/(640320^1.5)
    for k = 0:(n-1)
        x += /(
            big(factorial(big(6k))*(13591409 + 545159134k)),
            factorial(big(3k))*(factorial(big(k)))^3*^(big(-640320), 3k)
        )
    end
    return big(1 / (c1 * x))
end

@time fastPie(6000)
