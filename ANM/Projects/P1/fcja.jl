setprecision(3000)


f(1,x)=convert(typeof(x),7)* x*x  
f(2,x)=x*x - convert(typeof(x),4)        


function steff(x,funkcja,numer,kroki)
    i=0
    while i<kroki
        f_x=funkcja(numer,x)
        x1=(f_x*f_x)/(funkcja(numer,x+f_x)-f_x)
        x=x1
        i+=1
        println(x)
    end
    x
end
zmienna=BigFloat(0.0)
println(steff(zmienna,f,1,300))
