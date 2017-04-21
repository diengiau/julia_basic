# julia_basic
Learn how to use Julia language. Why? It is similar to Python, but fast.

I use JuliaBox to run the IJulia notebook. They offer a system of 6gb memory.


## 1. Some first words
Julia has a simlar indexer as in R, but different from Python. While you index from 0 in Python, Julia use the first index as 1 as in R.

For example:
```r
x = [1,2,3]

x[0]
LoadError: MethodError: no method matching *(::Array{Int64,1}, ::Array{Int64,1})
Closest candidates are:
  *(::Any, ::Any, !Matched::Any, !Matched::Any...) at operators.jl:138
  *{T<:Union{Complex{Float32},Complex{Float64},Float32,Float64},S}(!Matched::Union{Base.ReshapedArray{T<:Union{Complex{Float32},Complex{Float64},Float32,Float64},2,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N}}},DenseArray{T<:Union{Complex{Float32},Complex{Float64},Float32,Float64},2},SubArray{T<:Union{Complex{Float32},Complex{Float64},Float32,Float64},2,A<:Union{Base.ReshapedArray{T,N,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N}}},DenseArray},I<:Tuple{Vararg{Union{Base.AbstractCartesianIndex,Colon,Int64,Range{Int64}},N}},L}}, ::Union{Base.ReshapedArray{S,1,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N}}},DenseArray{S,1},SubArray{S,1,A<:Union{Base.ReshapedArray{T,N,A<:DenseArray,MI<:Tuple{Vararg{Base.MultiplicativeInverses.SignedMultiplicativeInverse{Int64},N}}},DenseArray},I<:Tuple{Vararg{Union{Base.AbstractCartesianIndex,Colon,Int64,Range{Int64}},N}},L}}) at linalg\matmul.jl:79
  *(!Matched::Base.LinAlg.AbstractTriangular{T,S<:AbstractArray{T,2}}, ::AbstractArray{T,1}) at linalg\triangular.jl:1496
  ...
while loading untitled, in expression starting on line 3
 in power_by_squaring(::Array{Int64,1}, ::Int64) at intfuncs.jl:116
 in ^(::Array{Int64,1}, ::Int64) at intfuncs.jl:144
 in include_string(::String, ::String) at loading.jl:441
 in include_string(::Module, ::String, ::String) at eval.jl:32
 in (::Atom.##59#62{String,String})() at eval.jl:81
 in withpath(::Atom.##59#62{String,String}, ::String) at utils.jl:30
 in withpath(::Function, ::String) at eval.jl:46
 in macro expansion at eval.jl:79 [inlined]
 in (::Atom.##58#61{Dict{String,Any}})() at task.jl:60

x[1]
1
```
It is a bit good for R-users. In my view, I don't think beginning from 0 brings no additional value at all.
