using PyPlot

setprecision(300)
    
f1(x)=convert(typeof(x),7)* x*x
f3(x)=convert(typeof(x),10)*log10(x)
f4(x)=x*x*x-convert(typeof(x),5)*x*x+convert(typeof(x),3)*x-convert(typeof(x),7)
f5(x)=x-tan(x)
f6(x)=x*x-convert(typeof(x),15)*x+convert(typeof(x),50)

function newton(x,funkcja,nr,kroki)
    i=0
    (f_x,df_x)=funkcja(x,nr)
    while i<kroki
        (f_x,df_x)=funkcja(x,nr)
       # println(funkcja(x,nr))
        x=x-f_x/df_x
        i+=1
    end
    (f_x,df_x)=funkcja(x,nr)
    (x,f_x,-log10(abs(f_x-convert(typeof(x),0.0)) ) )
end


function steff(x,funkcja,nr,kroki)
    i=0
    (f_x,df_x)=funkcja(x,nr)
    #println("bbbbbbbbbbbbbbbbb")
    while i<kroki
        #println("aaaaaaa")
        (f_x,df_x)=funkcja(x,nr)
       # println(f_x)
        (f2_x,df2_x)=funkcja(x+f_x,nr)
       # println(f2_x)
        last_x=x
       # println(( f_x * f_x )/(f2_x-f_x))
        x=x-( f_x * f_x )/(f2_x-f_x)
        if (isnan(x)||isinf(x))
            #println("WARNING!!","  f_x ",f_x,"  x ",x,"  last_x ",last_x)
            x=last_x

            break
        end
       # println("i  ",i,)
       # println("x  ",x)
       # println("f_x  ",f_x)
        i+=1
        
    end
 
    (x,f_x,-log10(abs(f_x-convert(typeof(x),0.0)) ) )

end
#=
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
 
    (x,f_x,-log10(abs(f_x-convert(typeof(x),0.0)) ) )

end
=#
zmienna=BigFloat(0.0)
zmienna=zmienna+10*eps(typeof(zmienna))



#println(steff(zmienna,f2,3000))

#println("blah")
#println(zmienna)



function check( typ,f ,nr, m ,m1,krok,border)
    if(typ=="steff")
        plotx1=[]
        plotx2=[]
        ploty1=[]
        ploty2=[]
        plotyx=[]
        i=0
        if(m1<m)
            temp=m
            m=m1
            m1=temp
        end
        m0=m
        m01=m1
        m=m1
        while m<m01+border*krok
            (x1,f_x,_)=steff(m,f,nr,100)
            if abs(f_x)<convert(typeof(x1), 0.001)

                push!(plotx1,m)
                push!(plotyx,x1)
                push!(ploty1,3.0)
                #println(x1,"  ",x1-x0)

            else
                push!(plotx2,m)
                push!(ploty2,-3.0)

            end
            m+=convert(typeof(x1), krok)
            #println("m  ", m,"  x  ",x1)
        end
        i=0
        m=m0
        m1=m01
        m=m01
        while m>m0
            (x1,f_x,_)=steff(m,f,nr,300)
            if abs(f_x)<convert(typeof(x1), 0.1)
                push!(plotyx,x1)
                push!(plotx1,m)
                push!(ploty1,2.0)

            else
                    push!(plotx2,m)
                    push!(ploty2,-2.0)
            end
            m-=convert(typeof(x1), krok/convert(typeof(krok), 10))
            #println("m  ", m,"  x  ",x1)
            #print("i: ",i)
        end
        i=0
        m=m0
        while m>m0-border*krok
            (x1,f_x,_)=steff(m,f,nr,100)
            if abs(f_x)<convert(typeof(x1), 0.001)
                push!(plotyx,x1)
                push!(plotx1,m)
                push!(ploty1,1.0)
                #println(x1,"  ",x1-x0)

            else
                push!(plotx2,m)
                push!(ploty2,-1.0)

            end
            m-=convert(typeof(x1), krok)
            #println("m  ", m,"  x  ",x1)
        end
    elseif(typ=="newton")
        plotx1=[]
        plotx2=[]
        ploty1=[]
        ploty2=[]
        plotyx=[]
        i=0
        if(m1<m)
            temp=m
            m=m1
            m1=temp
        end
        m0=m
        m01=m1
        m=m1
        while m<m01+border*krok
            (x1,f_x,_)=newton(m,f,nr,100)
            if abs(f_x)<convert(typeof(x1), 0.001)
                push!(plotyx,x1)
                push!(plotx1,m)
                push!(ploty1,3.0)
                #println(x1,"  ",x1-x0)

            else
                push!(plotx2,m)
                push!(ploty2,-3.0)

            end
            m+=convert(typeof(x1), krok)
            #println("m  ", m,"  x  ",x1)
        end
        i=0
        m=m0
        m1=m01
        m=m01
        while m>m0
            (x1,f_x,_)=newton(m,f,nr,300)
            if abs(f_x)<convert(typeof(x1), 0.1)
                push!(plotyx,x1)
                push!(plotx1,m)
                push!(ploty1,2.0)

            else
                    push!(plotx2,m)
                    push!(ploty2,-2.0)
            end
            m-=convert(typeof(x1), krok/convert(typeof(krok), 10))
            #println("m  ", m,"  x  ",x1)
            #print("i: ",i)
        end
        i=0
        m=m0
        while m>m0-border*krok
            (x1,f_x,_)=newton(m,f,nr,100)
            if abs(f_x)<convert(typeof(x1), 0.001)
                push!(plotyx,x1)
                push!(plotx1,m)
                push!(ploty1,1.0)
                #println(x1,"  ",x1-x0)

            else
                push!(plotx2,m)
                push!(ploty2,-1.0)

            end
            m-=convert(typeof(x1), krok)
            #println("m  ", m,"  x  ",x1)
        end
    end

    (plotx1,ploty1,plotyx,plotx2,ploty2)
    
end



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

function dokladnosc(n,nr,x0,lebel)

    newton_y=[]
    ax=[]
    steff_y=[]
    s_n_y=[]


    for i in 1:(n+1)
        (xn,fxn,εn)=newton(x0,poly_function,nr,i)
        (xs,fxs,εs)=steff(x0,poly_function,nr,i)
        εn=convert(Float64,εn)
        εs=convert(Float64,εs)
        xn=convert(Float64,xn)
        xs=convert(Float64,xs)
        
        push!(newton_y,εn)
        push!(steff_y,εs)
        push!(ax,i)
        push!(s_n_y,εn-εs)

    end

    subplot(211)
    suptitle(string("Dokładnosci metod dla ",lebel, " i x0=",convert(Float64,x0)))
    plot(ax, newton_y, label="Newton", "blue",linewidth=1.0 ,marker="o")
    plot(ax, steff_y , "red", linewidth=1.0 ,marker="o",label="Steffensen")
    legend(loc="lower right",fancybox="true")

    subplot(212)
    plot(ax, s_n_y , "green", linewidth=1.0 ,marker="o",label="Róznica")
    legend(loc="upper right",fancybox="true")


end
function rozbieganie(krok,nr,border,x,x1,)

    wart_x=[convert(Float64,x),convert(Float64,x1)]
    wart_y=[0.0,0.0]


    goods_y=[]
    goods_x=[]
    bads_y=[]
    bads_x=[]
    zn_pl=[]
    zs_pl=[]

    goodn_y=[]
    goodn_x=[]
    badn_y=[]
    badn_x=[]


    (goods_x,goods_y,z_pl,bads_x,bads_y)=check("steff",poly_function,nr,x,x1,krok,border)
    goods_x=map(x->convert(Float64, x),goods_x)
    bads_x=map(x->convert(Float64, x),bads_x)
    goods_y=map(x->convert(Float64, x),goods_y)
    bads_y=map(x->convert(Float64, x),bads_y)
    zs_pl=map(x->convert(Float64, x),z_pl)



    (goodn_x,goodn_y,z_pl,badn_x,badn_y)=check("newton",poly_function,nr,x,x1,krok,border)
    goodn_x=map(x->convert(Float64, x),goodn_x)
    badn_x=map(x->convert(Float64, x),badn_x)
    goodn_y=map(x->convert(Float64, x),goodn_y)
    badn_y=map(x->convert(Float64, x),badn_y)
    zn_pl=map(x->convert(Float64, x),z_pl)



    subplot(321)
    title("steff")
    plot(goods_x, goods_y, "blue",linewidth=0.0 ,marker="x")
    plot(bads_x, bads_y , "red", linewidth=0.0 ,marker="x")
    plot(wart_x, wart_y , "green", linewidth=0.0 ,marker="o")
    axis([ (convert(Float64,x)-convert(Float64,krok)*convert(Float64,border)), (convert(Float64,x1)+convert(Float64,krok)*convert(Float64,border)),-3.5, 3.5,])

    subplot(322)
    title("steff w powiększeniu")
    plot(goods_x, goods_y, "blue",linewidth=0.0 ,marker="o")
    plot(bads_x, bads_y , "red", linewidth=0.0 ,marker="o")
    plot(wart_x, wart_y , "green", linewidth=0.0 ,marker="o")
    axis([ (convert(Float64,x)-1.5), (convert(Float64,x1)+1.5),-3.5, 3.5])

    subplot(323)
    title("newton")
    plot(goodn_x, goodn_y, "blue",linewidth=0.0 ,marker="x")
    plot(badn_x, badn_y , "red", linewidth=0.0 ,marker="x")
    plot(wart_x, wart_y , "green", linewidth=0.0 ,marker="o")
    axis([ (convert(Float64,x)-convert(Float64,krok)*convert(Float64,border)), (convert(Float64,x1)+convert(Float64,krok)*convert(Float64,border)),-3.5, 3.5,])

    subplot(324)
    title("newton w powiększeniu")
    plot(goodn_x, goodn_y, "blue",linewidth=0.0 ,marker="o")
    plot(badn_x, badn_y , "red", linewidth=0.0 ,marker="o")
    plot(wart_x, wart_y , "green", linewidth=0.0 ,marker="o")
    axis([(convert(Float64,x)-1.5), (convert(Float64,x1)+1.5),-3.5, 3.5])


    subplot(313)
    title("znalezione pierwiatki")
    plot(goodn_x, zn_pl, "blue",linewidth=0.0 ,marker="o")
    plot(goods_x, zs_pl , "red", linewidth=0.0 ,marker="x")


    #axis([ -100, 100,-3.5, 3.5,])

end










#=
miejsce=BigFloat(7.7)
miejsce1=BigFloat(4.5)
(x1,y1,x11,y11,x2,y2)=check(f5,miejsce,miejsce1)
=#

#=
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
=#



#=


plot(x1, y1, "blue",linewidth=0.0 ,marker="o")
plot(x2, y2 , "red", linewidth=0.0 ,marker="o")
plot(x11, y11 , "green", linewidth=0.0 ,marker="o")
axis([ 3, 40,-2, 2])
title("Wykres zbierzności")
show()
=#