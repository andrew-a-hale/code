include("generate-valid-abn.jl")

n = 1000
abn = Array{Int}(undef, n)
for i = 1:n
    abn[i] = ABN.generate_abn()
end

fname = "./abn/abn.txt"
f = open(fname, "w")

for i ∈ abn
    println(f, i)
end

close(f)