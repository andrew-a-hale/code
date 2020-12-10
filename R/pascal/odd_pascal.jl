function pascal(n::Int)
    x = [1]
    oddCounter = 1
    for i = 2:n
        x = [0; x] .⊻ [x; 0]
        oddCounter += sum(x)
    end
    return oddCounter / sum(1:length(x)) * 100
end

pascal(2^7)
