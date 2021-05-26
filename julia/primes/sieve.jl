module Sieve

function go(x::Int)::Array{Int}
  if x <= 2
    return [2]
  end
  nums::Array{Int} = 2:x
  rootx::Int = ceil(sqrt(x))
  for n::Int = 2:rootx
    filter!(x -> x % n > 0, nums)
  end
  return vcat(nums, go(rootx))
end

end

@time Sieve.go(10)
@time Sieve.go(100)
@time Sieve.go(1000)
@time Sieve.go(10000)
@time Sieve.go(100000)
@time Sieve.go(1000000)
