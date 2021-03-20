include("generate-valid-abn.jl")

N = 1000000
n = 0
vec = rand(10^10:10^11-1, N)
for i ∈ vec
    n += ABN.validate_abn(i)
end
n / N * 100

N = 10000
vec = rand(10^10:10^11-1, N)
d = Dict{Int,Int}()
for i ∈ vec
    if (haskey(d, ABN.weighted_abn_sum(i)))
        d[ABN.weighted_abn_sum(i)] += 1
    else 
        get!(d, ABN.weighted_abn_sum(i), 1)
    end
end
d

using Plots
x = ABN.weighted_abn_sum.(ABN.generate_abn(1000))
histogram(x, bins = range(minimum(x), stop = maximum(x), step = 1))