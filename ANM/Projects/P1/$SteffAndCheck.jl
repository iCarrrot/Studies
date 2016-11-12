using PyPlot

setprecision(300)
    
f1(x)=convert(typeof(x),7)* x*x
f3(x)=convert(typeof(x),10)*log10(x)
f4(x)=x*x*x-convert(typeof(x),5)*x*x+convert(typeof(x),3)*x-convert(typeof(x),7)
f5(x)=x-tan(x)
f6(x)=x*x-convert(typeof(x),15)*x+convert(typeof(x),50)

function steff(x,funkcja,kroki)
    i=0
    
    #println("bbbbbbbbbbbbbbbbb")
    while i<kroki
        #println("aaaaaaa")
        f_x=funkcja(x)
        last_x=x

        x=x-(f_x*f_x)/(funkcja(x+f_x)-f_x)
        if (isnan(x)||isinf(x))
            println("WARNING!!","  f_x ",f_x,"  x ",x,"  last_x ",last_x)
            return last_x

            break
        end
       # println("i  ",i,)
       # println("x  ",x)
       # println("f_x  ",f_x)
        i+=1
        
    end
 
    x

end
zmienna=BigFloat(0.0)
zmienna=zmienna+10*eps(typeof(zmienna))



#println(steff(zmienna,f2,3000))

#println("blah")
#println(zmienna)



function check( f , m ,m1)

    plotx1=[]
    plotx2=[]
    ploty1=[]
    ploty2=[]
    plotx11=[]
    ploty11=[]
    i=0
    m0=m
    m01=m1
    x0=steff(m,f,600)
    x01=steff(m1,f,600)
    while i<300
        x1=steff(m,f,300)
        if abs(x1-x0)<convert(typeof(x1), 0.001)

            push!(plotx1,m)
            push!(ploty1,1.0)
            #println(x1,"  ",x1-x0)

        elseif (abs(x1-x01)<convert(typeof(x1), 0.001))

            push!(plotx11,m)
            push!(ploty11,1.0)
            #println(x1,"  ",x1-x01)

        else

            push!(plotx2,m)
            push!(ploty2,-1.0)

        end
        m+=convert(typeof(x1), 0.1)
        #println("m  ", m,"  x  ",x1)
        i+=1
    end
    i=0
    m=m0
    m1=m01
    while i<300
        x1=steff(m,f,300)
        if abs(x1-x0)<convert(typeof(x1), 0.1)

            push!(plotx1,m)
            push!(ploty1,1.0)
        elseif (abs(x1-x01)<convert(typeof(x1), 0.1))
                push!(plotx11,m)
                push!(ploty11,1.0)
        else
                push!(plotx2,m)
                push!(ploty2,-1.0)
        end
        m+=convert(typeof(x1), 0.1)
        #println("m  ", m,"  x  ",x1)
        i+=1
        #print("i: ",i)
    end

    (plotx1,ploty1,plotx11,ploty11,plotx2,ploty2)
    
end
#=
miejsce=BigFloat(7.7)
miejsce1=BigFloat(4.5)
(x1,y1,x11,y11,x2,y2)=check(f5,miejsce,miejsce1)
=#
miejsce=BigFloat(5.0)
miejsce1=BigFloat(10.0)
(x1,y1,x11,y11,x2,y2)=check(f6,miejsce,miejsce1)
#println(x1,"/n")
#println("end")
#println(x2)
x2=map(x->convert(Float64, x),x2)
x1=map(x->convert(Float64, x),x1)
y2=map(x->convert(Float64, x),y2)
y1=map(x->convert(Float64, x),y1)
x11=map(x->convert(Float64, x),x11)
y11=map(x->convert(Float64, x),y11)




plot(x1, y1, "blue",linewidth=0.0 ,marker="o")
plot(x2, y2 , "red", linewidth=0.0 ,marker="o")
plot(x11, y11 , "green", linewidth=0.0 ,marker="o")
axis([ 3, 40,-2, 2])
title("Wykres zbierzności")
show()
