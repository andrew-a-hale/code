function pascal(n::Int)
    x = ones(BigInt, 1)
    for i = 2:n
        x = [0; x] .+ [x; 0]
    end
    return x
end

# nth row pascal function
using Memoize
@memoize function memoizePascal(n::Int)::Array{BigInt, 1}
    if n == 1
        return [1]
    else
        return [0; memoizePascal(n-1)] .+ [memoizePascal(n-1); 0]
    end
end

function closedFormPascal(n::Int)::Array{BigInt, 1}
    x = zeros(BigInt, n)
    m = floor(Int, n / 2)
    if n == 1
        return([1])
    elseif n == 2
        return([1, 1])
    end
    for i = 1:m
        v = binomial(big(n-1), big(i-1))
        x[i] = v
        x[n-i+1] = v
    end
    if isodd(n)
        x[m+1] = binomial(big(n-1), big(m))
    end
    return(x)
end

n = 2^12
@time pascal(n)
@time memoizePascal(n)
@time closedFormPascal(n)
