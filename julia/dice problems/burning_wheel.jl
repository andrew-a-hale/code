function problemOne(failMax::Int)
    dice = 9
    successCount = 0
    failFlag = 0
    for i = 1:dice
        d = ceil(Int, rand()*6)
        while true
            if d < 4 && failFlag < failMax
                failFlag += 1
                d = ceil(Int, rand()*6)
            elseif d < 4 && failFlag == failMax
                break
            elseif d < 6
                successCount += 1
                break
            else
                successCount += 1
                d = ceil(Int, rand()*6)
            end
        end
        failFlag = false
    end
    successCount
end

function problemTwo()
    dice = 9
    successCount = 0
    for i = 1:dice
        d = ceil(Int, rand()*6)
        while true
            if 2 < d < 6
                successCount += 1
                break
            elseif d <= 2
                break
            else
                successCount += 1
                d = ceil(Int, rand()*6)
            end
        end
    end
    successCount
end

N = 1000000

xCounter = 0
for i = 1:N
    if problemOne(1) >= 11
        xCounter += 1
    end
end

yCounter = 0
for i = 1:N
    if problemOne(2) >= 25
        yCounter += 1
    end
end

xCounter
yCounter
