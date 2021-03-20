module ABN

const weights = [10; range(1, 19, step = 2)]

function generate_abn()::Int
    s1 = floor.(Int, rand(9) * 10)
    s2 = [1; 0; s1]
    s3 = sum([popfirst!(s2) - 1; s2] .* weights)
    s4 = s3 % 89
    s5 = 89 - s4 + 10
    s6 = [s5 ÷ 10; s5 % 10; s1]
    
    abn = 0
    for i = 1:length(s6)
        abn += s6[i] * 10^(length(s6) - i)
    end

    return abn
end

function generate_abn(n::Int) 
    x = Array{Int}(undef, n)
    for i = 1:n
        x[i] = generate_abn()
    end
    return x
end

function format_abn(abn::Int)::String
    s = string(abn)
    return s[1:2] * " " * s[3:5] * " " * s[6:8] * " " * s[9:11]
end

function weighted_abn_sum(abn::Int)
    ds = reverse(digits(abn))
    s1 = [popfirst!(ds) - 1; ds]
    s2 = s1 .* weights
    return sum(s2)
end

function validate_abn(abn::Int)::Bool
    return weighted_abn_sum(abn) % 89 == 0
end

function weighted_abn_sum(abn::String)::Bool 
    abn = parse(Int, replace(abn, " " => ""))
    return validate_abn(abn::Int)::Bool
end

end

