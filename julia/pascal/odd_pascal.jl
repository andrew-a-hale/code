function pascalBroadcast(n::Int)
    x = [1]
    oddCounter = 1
    for i = 2:n
        x = pushfirst!(copy(x), 0) .⊻ push!(copy(x), 0)
        oddCounter += sum(x)
    end
    return oddCounter / sum(1:length(x)) * 100
end

@time pascalBroadcast(2^7)
