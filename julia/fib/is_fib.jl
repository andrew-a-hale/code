isSquare(x::BigInt) = isinteger(sqrt(BigInt(x)))

function isFib(x::BigInt)
    if isSquare(BigInt(5x^2+4)) || isSquare(BigInt(5x^2-4))
        return(true)
    else
        return(false)
    end
end

@time isFib(big(66666665161711112315113251617811111123215161111251))
