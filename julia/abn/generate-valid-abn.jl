module ABN

## https://stackoverflow.com/questions/15503188/how-to-generate-an-australian-abn-number
const weights = [10; range(1, 19, step = 2)]

function generate_abn()::Int
    ## each variable is a step of the calculation from SO thread
    s1 = rand(0:9, 9)
    s2 = append!([1, 0], s1)
    s3 = sum(pushfirst!(s2, popfirst!(s2) - 1) .* weights)
    s4 = s3 % 89
    s5 = 89 - s4 + 10
    s6 = append!([s5 ÷ 10, s5 % 10], s1)
    return sum(s6[i] * 10^(length(s6)-i) for i in 1:length(s6))
end

function generate_abn(n::Int) 
    x = Array{Int}(undef, n)
    for i = 1:n
        x[i] = generate_abn()
    end
    return x
end

function _format_abn(abn::String)
    if (!validate_abn(abn)) 
        error("$abn is not a valid abn") 
    end
    return abn[1:2] * " " * abn[3:5] * " " * abn[6:8] * " " * abn[9:11]
end

function format_abn(abn::Int)::String
    s = string(abn)
    return _format_abn(s)
end

function format_abn(abn::String)::String
    if occursin(" ", abn)
        abn = replace(abn, " " => "")
    end
    return _format_abn(abn)
end

function weighted_abn_sum(abn::Int)
    ## https://abr.business.gov.au/Help/AbnFormat
    ## see also validate_abn
    if (length(digits(abn)) != length(weights)) 
        error("abn must have 11 digits")
    end
    ds = reverse(digits(abn))
    s1 = pushfirst!(ds, popfirst!(ds) - 1)
    s2 = s1 .* weights
    return sum(s2)
end

function validate_abn(abn::Int)::Bool
    return weighted_abn_sum(abn) % 89 == 0
end

function validate_abn(abn::String)::Bool 
    abn = parse(Int, replace(abn, " " => ""))
    return validate_abn(abn::Int)::Bool
end

end

