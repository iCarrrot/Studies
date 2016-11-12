n=10
newton_x=[]
newton_y=[]
steff_x=[]
steff_y=[]
x0=BigFloat(5.0)

for i in 1:n
    (xn,f_xn,εn)=newton(x0,poly_function,50,i*20)
    (xs,f_xs,εs)=steff(x0,poly_function,50,i*20)
    εn=convert(Float64,εn)
    εs=convert(Float64,εs)
    push!(newton_y,εn)
    push!(steff_y,εs)
    push!(newton_x,20*i)
    push!(steff_x,20*i)
end
