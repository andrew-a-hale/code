using Memoize

@memoize function fib(n::Int)::BigInt
    if n == 1
        return(1)
    elseif n == 2
        return(1)
    else
        return(fib(n-1) + fib(n-2))
    end
end

function isFibNaive(x::BigInt)
    n::Int = 1
    while true
        if x == fib(n)
            return(true)
        elseif x > fib(n)
            n += 1
        else
            return(false)
        end
    end
end

@time isFibNaive(BigInt(66666665161711112315113251617811111123215161111251))
