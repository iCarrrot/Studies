function poly_generator(number)
    i=1
    poly=""

    multi_poly="using Match\n \nfunction poly_function(x,i)\n    @match i begin\n"
    while i-1<number
        poly=string("       ",i,"       => ")
        n=rand(2:10)


        while n>0
            
            wsp=rand(-50:50)
            poly=string(poly,repeat("x*",n-1),"x*convert(typeof(x),",wsp,")+")
            n-=1
        end
        wsp=rand(-50:50)
        poly=string(poly,"convert(typeof(x),",wsp,")\n")
        multi_poly=string(multi_poly,poly)
        i+=1
    end
    multi_poly=string(multi_poly,"  end\nend\n")
    multi_poly

end

function real_generator(number)
        i=1
    poly1=""
   
    multi_poly="using Match\n \nfunction real_function(x,i)\n    @match i begin\n"
    poly2=""

    while i-1<number
        poly1=string("       ",i,"       => (")
        poly2=string("/(")
        n=rand(0:10)
        n1=rand(1:10)

        while n>0  
            wsp=rand(-50:50)
            poly1=string(poly1,repeat("x*",n-1),"x*convert(typeof(x),",wsp,")+")

            n-=1
        end


        while n1>0 
            wsp=rand(-50:50)
            poly2=string(poly2,repeat("x*",n1-1),"x*convert(typeof(x),",wsp,")+")

            n1-=1
        end
        wsp=rand(-50:50)
        wsp2=rand(-50:50)

        while(wsp2==0)
            wsp2=rand(-50:50)
        end


        poly1=string(poly1,"convert(typeof(x),",wsp,"))")
        poly2=string(poly2,"convert(typeof(x),",wsp2,"))\n")
        multi_poly=string(multi_poly,poly1,poly2)
        i+=1
    end
    multi_poly=string(multi_poly,"  end\nend\n")
    multi_poly

end

print(poly_generator(100))
print(real_generator(100))