function pascal(n::Int)
    x = [1]
    for i = 2:n
        x = [0; x] .⊻ [x; 0]
    end
    return x
end

function recusivePascal(n::Int)
    if n == 1
        return [1]
    else
        prow = recusivePascal(n-1)
        return [0; prow] .⊻ [prow; 0]
    end
end

using Memoize
@memoize function memoizePascal(n::Int)
    if n == 1
        return [1]
    else
        return [0; memoizePascal(n-1)] .⊻ [memoizePascal(n-1); 0]
    end
end

n = 2^14 + 1
using BenchmarkTools
@benchmark pascal(n)
@benchmark recusivePascal(n)
@benchmark memoizePascal(n)
