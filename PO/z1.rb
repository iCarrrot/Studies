class Funkcja
	@@epsilon=1.0e-7
	def initialize(fun)
        @function = fun
    end
    def value(x)
        return @function.call(x)
    end
    def zerowe(a,b,e)
    	temp=a
        mlist=[]
        while temp<=b
            if value(temp).abs<@@epsilon/10000000000.0
                mlist<<temp
            end
            temp+=e
        end
        return mlist
    end
    def pole(a,b)
    	temp=a
    	pole=0.0
    	while temp<b
    		a1=temp
    		epsilon=@@epsilon/10
    		b1=a1+epsilon*1000.0
    		pole+=(value(a1).abs+value(b1).abs)*epsilon*500.0
			temp+=epsilon*1000.0
		end
		return pole
	end
	def poch(x)
		pochodna=(value(x+@@epsilon/2.0)-value(x-@@epsilon/2.0))/@@epsilon
		return pochodna
	end
	def plot(a,b,file)
		temp=a
		aFile=File.new(file,"w")
		epsilon=10000.0*@@epsilon
		if aFile
			aFile.syswrite("%!PS-Adobe-2.0 EPSF-2.0\n"+"%%BoundingBox: 0 0 0 0\n" +"newpath 0 0 moveto\n")
			while (temp<b)
				aFile.syswrite("#{temp} #{value(temp)} lineto\n")
				temp+=epsilon
			end
			aFile.syswrite("#{b} #{value(b)} lineto\n")
			aFile.syswrite(".4 setlinewidth\nstroke\nshowpage\n%%Trailer\n%EOF")
		end
	end
end
foo=Proc.new {|x|x*x*Math.sin(x)}
foo2=Funkcja.new(foo)
puts "wartosc dla 1:"
puts foo2.value(1)
puts "miejsca zerowe od -4 do 4:"
puts foo2.zerowe(-4,4,1e-5).inspect
puts "pole od 0 do 0.3"
puts foo2.pole(0,0.3)
puts "pochodna w 1"
puts foo2.poch(1)
foo2.plot(-100,100,"a.gst")
foo=Proc.new {|x|x*x*x-2*x*x-x+2}
foo3=Funkcja.new(foo)
foo3.plot(-2,3,"a2.gst")
