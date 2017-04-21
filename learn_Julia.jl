## Julia

## 0. Basic
#packages
Pkg.installed() #which packages installed
Pkg.add("BenchmarkTools") #Install new packages
Pkg.rm("Benchmark")

Pkg.update()


## 1. Array
x = [1,2,3]
println(x^2)

x[1]


x[0]

## 2. DataFrames
###Create
df = DataFrame(A = 1:10, B = 2:2:20)
df

###can be loaded from CSV files using readtable()
using DataFrames, RDataSets #Load two packages at the same time!!!

car = readtable("car.csv")
size(car)
nrow(car)
ncol(car)
head(car)

writetable("output_df_iris.csv", df_iris_sample) #Export to csv

#Describle a DataFrame
describe(car)
names(car)


#Subset rows and columns
car[1,:]
car[1:5,:]
car[1:5,1:2]
car[2] #column 2
car[:price] #name of variable
car[2] == car[:price]
car[[1,3,5], [:price, :mpg]]



#Filter: price>5000
car[car[:price] .> 5000, :]
car[(car[:price] .> 5000) & (car[:mpg] .>= 18), :] #2 conditions


#Sort DataFrames: with !, it changes the original file
sort!(car, cols = [:price])
sort!(car, cols = [:price], rev = true)
sort!(car, cols = [:price, :mpg])

#By function: to tabulate
by(car, :rep78, size)
by(car, [:rep78], df -> mean(df[:price]))


#Add, delete, rename
  #A stupid mutate
car[:lw] = map((x,y) -> x/y, car[:length], car[:weight])
car[:mass] = map((x,y) -> x*y, car[:length], car[:weight])
car[:big_car] = map(x -> x>500000, car[:mass])

  #Index in Julia
car[:idx] = 1:size(car,1)

  #rename
rename!(car, old_name, new_name)

  #delete!
  delete!(car, :lw)

  #delete rows
  temp = deepcopy(car)
  deleterows!(temp, 3:5)



#Merge DataFrames
full_Df = join(DfAccidents,DfVehicles,on = :_Accident_Index)
full_Df = join(DfAccidents,DfVehicles,on = :_Accident_Index, kind= :left)
full_Df = join(DfAccidents,DfVehicles,on = :_Accident_Index, kind= :right)
full_Df = join(DfAccidents,DfVehicles,on = :_Accident_Index, kind= :inner)
full_Df = join(DfAccidents,DfVehicles,on = :_Accident_Index, kind= :outer)
full_Df = join(DfAccidents,DfVehicles,on = :_Accident_Index, kind= :semi)
full_Df = join(DfAccidents,DfVehicles,on = :_Accident_Index, kind= :anti)

##Aggregate data, split-apply-combine method
  ##Method 1
by(car, :rep78) do df
  DataFrame(m = mean(df[:price]), sd = std(df[:price]))
end


  ##Method 2
aggregate(car[2:4], :rep78, [sum, mean])

  ##Method 3
for subdf in groupby(car, :rep78)
  println(mean(subdf[:price]))
end

  ###Compare speed
  @time by(car, :rep78) do df
    println(mean(df[:price]))
  end

  @time aggregate(car[:price], :rep78, mean)

  @time for subdf in groupby(car, :rep78)
    println(mean(subdf[:price]))
  end

  using BenchmarkTools
  @benchmark




  ##Method 4: stack/melt and unstack
  ###Step 1: stack/melt data: both are same, should USE MELT
temp = car[dropna(car[:rep78]), 2:4]
temp[:id] = 1:size(temp, 1)

d = melt(temp, :rep78)
d2 = stack(temp, [:price, :mpg], :rep78)
melt(temp, :rep78) == stack(temp, [:price, :mpg], :rep78)

  ###Step 2: from long-data to wide-data
longdf =  melt(temp, :id)
unstack(longdf, :id, :variable, :value)
unstack(d, :variable, :value)












## 3. Summary statistics
### 3.1 Stats
geomean(car[:,2])
mean(car[:,2])
var(car[:,2])
std(car[:,2])
mean_and_std(car[:,2])
skewness(car[:,2])
kurtosis(car[:,2])
moment(car[:,2], 3)
quantile(car[:, 2]) #quantile at 0%, 25, 50, 75, 100%
summarystats(car[:, 2])

#all above code could be shorter if we select variable by
mean(car[:price])

#Apply a function to each variable
colwise(mean, car[2:3])

#Apply a function to each rows
for i in eachrow(car[1:3,:])
  println(i)
end

for i in eachrow(car[1:3,2:3])
  println(mean(convert(Array, i)))
end

###Deal with missing NA
showcols(car)
car[isna(car[:rep78]), :rep78] = 0 #replace by 0
dropna(car[:rep78])




### 3.2 Plots
using Distributions
using StatsBase
using Gadfly

#histogram
plot(x = car[:price], Geom.histogram())
plot(car, x = "price", Geom.density)

#QQ plot
plot(car, x = "price", y = Normal(), Stat.qq, Geom.point)

#Box.plot
plot(car, y = "price", Geom.boxplot)

#Bar
plot(car, x = "rep78", y = "sum", Geom.bar)

#scatter
plot(car, x = "mpg", y = "price", Geom.point)
plot(car, x = "mpg", y = "price", Geom.point, Geom.smooth(method=:loess, smoothing = 0.9))
