# julia_basic
Learn how to use Julia language. Why? It is similar to Python, but fast.

I use JuliaBox to run the IJulia notebook. They offer a system of 6gb memory.

But writing Julia in Atom editor is a good idea. I find it very useful in some ways. First, it offers a very good system of autocomplete code for beginners. Second, the Workspace is quite good, especially for who are R-studio addicted. And so on.


## 1. Some first words
Julia has a simlar indexer as in R, but different from Python. While you index from 0 in Python, Julia use the first index as 1 as in R.

For example:
```r
x = [1,2,3]

x[0]
LoadError: MethodError: no method matching *(::Array{Int64,1}, ::Array{Int64,1})

x[1]
1
```
It is a bit good for R-users. In my view, I don't think beginning from 0 brings no additional value at all.

## 2. Some interesting codes
To re-index the data, we use this code:
```julia
car[:idx] = 1:size(car,1)
```
This is useful when you want to do event study. Above, `car` is the data frame name of the `car` dataset.

In R, thanks to Hadleyverse, we can use `group_by` and `summarise` to do any split-apply-combine strategy. In Julia, they offer a very strange way to do that. Let see this example: to calculate mean of `price` for each `rep78` groups
```julia
for subdf in groupby(car, :rep78)
  println(mean(subdf[:price]))
end
```

Another interesting way is using `by` and `do` together:
```julia
by(car, :rep78) do df
  DataFrame(m = mean(df[:price]), sd = std(df[:price]))
end
```

In Python, I prefer the `lambda` such as `lambda x: x + 1`. In Julia, they have: ` x -> x + 1`.

## 3. Benchmark
Finally, how is the performance between Julia and Python (we should ignore R, ^^)? Actually, Julia is quite as same as Python, as opposed to the benchmark in their homepage. Actually, some tasks Python are very fast now (ver 3.). In addition, with Numba, Python can be better with JIT compiler.

See the benchmark [here](https://modelingguru.nasa.gov/docs/DOC-2625) from NASA.
