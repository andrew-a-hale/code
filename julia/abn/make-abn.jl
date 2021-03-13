include("generate-valid-abn.jl")

make_abn() = ABN.format_abn(ABN.generate_abn())

n = 10000
abn = Array{String}(undef, n)
for i = 1:n
    abn[i] = make_abn()
end

fname = "abn.txt"
f = open(fname, "w")

for i ∈ abn
    println(f, i)
end

close(f)