include("generate-valid-abn.jl")

n = 1000
abn = ABN.generate_abn(n)

fname = "./abn.txt"
f = open(fname, "w")

for i ∈ abn
    println(f, i)
end

close(f)