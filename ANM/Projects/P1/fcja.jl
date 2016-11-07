setprecision(200)
Pkg.add("PyPlot")
using PyPlot
x = linspace(0,2*pi,1000); y = sin(3*x + 4*cos(2*x))
plot(x, y, color="red", linewidth=2.0, linestyle="--")

f1(x)=convert(typeof(x),7)* x*x
f2(x)=x*x - convert(typeof(x),4)


function steff(x,funkcja,kroki)
    i=0
    while i<kroki
        f_x=funkcja(x)
        x1=(f_x*f_x)/(funkcja(x+f_x)-f_x)
        x=x1
        i+=1
        println(x)
    end
    x
end
zmienna=BigFloat(0.0)
zmienna=zmienna+10*eps(typeof(zmienna))

println(steff(zmienna,f2,3000))
println("blah")
println(zmienna)