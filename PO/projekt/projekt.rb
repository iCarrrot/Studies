def makeMacroTab(line)
	tab=[]
	i=1
	temp=""
	while line[i]!=","
		temp+=line[i]
		i+=1
	end
	tab<<(temp.to_i)
	i+=3
	temp=""
	while line[i+1]!=","
		temp+=line[i]
		i+=1
	end
	tab.push(temp)
	i+=3
	while i<line.size-1
		counter=0
		temp=""
		while line[i]!="]" || counter<2
			temp+=line[i]
			i+=1
			line[i]=="]"? counter+=1 : 1
		end
		#i+=1
		temp+=line[i]
		tab<<makeMicroTab(temp)
		i+=3
	end
	return tab
end

def makeMicroTab(string)
	tab=[string[2]]
	i=6
	temp=""
	while string[i-1]!="]"
		temp+=string[i]
		i+=1
	end
	tab<<makeNumberTab(temp)
	i+=3
	temp=""
	while string[i+1]!=","
		temp+=string[i]
		i+=1
	end
	tab<<temp
	i+=3
	temp=""

	while string[i]!=","
		temp+=string[i]
		i+=1
	end
	tab<<temp.to_i
	i+=2
	temp=""
	while string[i]!=","
		temp+=string[i]
		i+=1
	end
	tab<<temp.to_i
	i+=3
	temp=""
	while string[i+1]!="]"
		temp+=string[i]
		i+=1
	end
	tab<<temp
end


def makeNumberTab(string)
	tab=[]
	i=1

	while i+1<string.size
		temp=""
		while string[i]!=","&&i+1<string.size
			temp+=string[i]
			i+=1
		end
		tab<<(temp.to_i)
		i+=2
	end
	return tab
end


def newObject(chosen_map)
	system "clear" or system "cls"
	puts "podaj typ obiektu: ","b-budynek", "g-gora", "r-rzeka", "d-dzialka", "i-inne"
	tty_param = `stty -g`
	system 'stty raw'
	doTyp = IO.read '/dev/stdin', 1
	system "stty #{tty_param}"
	puts "\n"

	#dodaj(typ,list,name,high,epsilon,id)
	case doTyp
	when "b"
		puts("podaj nazwe")
		id=gets.chomp
		list=[]
		while true
			
			puts ("podaj x, lub k-koniec listy")
			a=gets.chomp
			if a=="k"
				break
			else
				list.push(a.to_i)
				puts("podaj y")
				a=gets.chomp
				list.push(a.to_i)
			end
		end
		puts("podaj wysokosc")
		high=gets.chomp
		chosen_map.dodaj("b",list,"",high.to_i,0,id)
	when "d"
		puts("podaj nazwe")
		id=gets.chomp
		list=[]
		while true
			
			puts ("podaj x, lub k-koniec listy")
			a=gets.chomp
			if a=="k"
				break
			else
				list.push(a.to_i)
				puts("podaj y")
				a=gets.chomp
				list.push(a.to_i)
			end
		end
		puts("podaj wlasciciela")
		name=gets.chomp
		chosen_map.dodaj("d",list,name,0,0,id)
	when "g"
		puts("podaj nazwe")
		id=gets.chomp
		list=[]

		puts ("podaj x wierzcholka")
		a=gets.chomp
		list.push(a.to_i)

		puts("podaj y wierzcholka")
		a=gets.chomp
		list.push(a.to_i)						
		
		puts("podaj wysokosc")
		high=gets.chomp
		puts("podaj dokladnosc")
		epsilon=gets.chomp
		chosen_map.dodaj("g",list,"",high.to_i,epsilon.to_i,id)
	when "r"
		puts("podaj nazwe")
		id=gets.chomp
		list=[]
		while true
			
			puts ("podaj x, lub k-koniec listy")
			a=gets.chomp
			if a=="k"
				break
			else
				list.push(a.to_i)
				puts("podaj y")
				a=gets.chomp
				list.push(a.to_i)
			end
		end
		chosen_map.dodaj("r",list,"",0,0,id)
	else
		puts("podaj nazwe")
		id=gets.chomp
		list=[]
		while true
			puts ("podaj x, lub k-koniec listy")
			a=gets.chomp
			if a=="k"
				break
			else
				list.push(a.to_i)
				puts("podaj y")
				a=gets.chomp
				list.push(a.to_i)
			end
		end
		chosen_map.dodaj("i",list,"",0,0,id)
	end
	showObjects(chosen_map)
	chosen_map.rysuj("a.gst")
	puts("dodano pomyslnie")
end

def saveObjects(file,maps)
	aFile=File.new(file,"w")
	if aFile
		maps.each{|x|aFile.syswrite(x.getEvery+"\n")}
	end
end

def openObjects(file)
	aFile=File.open(file, "r")
	maps=[]
    while (a =aFile.gets)
    	line=makeMacroTab(a)
        tempMap=Map.new(line[0],line[1])
        i=2
        while i<line.size
        	object=line[i]
        	tempMap.dodaj(object[0],object[1],object[2],object[3],object[4],object[5])
        	i+=1
        end
        maps<<tempMap
    end
    return maps
end

def showObjects(chosen_map)
	chosen_map.getObjects("b").size!=0 ? puts("budynki:") : ""
	i=0
	chosen_map.getObjects("b").each{|x|i+=1;print"b";print i;print". "+x.getId+"\n" }
	chosen_map.getObjects("m").size!=0 ? puts("gory:") : ""
	i=0
	chosen_map.getObjects("m").each{|x|i+=1;print"g";print i;print". "+x.getId+"\n" }
	chosen_map.getObjects("r").size!=0 ? puts("rzeki:") : ""
	i=0
	chosen_map.getObjects("r").each{|x|i+=1;print"r";print i;print". "+x.getId+"\n" }
	chosen_map.getObjects("g").size!=0 ? puts("dzialki:") : ""
	i=0
	chosen_map.getObjects("g").each{|x|i+=1;print"d";print i;print". "+x.getId+"\n" }
	chosen_map.getObjects("i").size!=0 ? puts("inne:") : ""
	i=0
	chosen_map.getObjects("i").each{|x|i+=1;print"i";print i;print". "+x.getId+"\n" }
end

class Color
	def initialize(scale)
		@scale=scale
	end
	def high(high) 
		r=1.0
		g=1.0
		b=1.0
		a=high*@scale
		if a>0
			if a>256
				g=255*2-a
				r=255
				b=0
			else
				r=a
				g=255
				b=0
			end
		else
			if a<(-255)
				g=255*2+a
				b=255
				r=0
			else	
				b=-a	
				g=255
				r=0
			end
		end
		tab=[r,g,b]
		i=0
		while i<tab.size
			tab[i]<0?tab[i]=0: tab[i]=tab[i]/256.0
			i+=1
		end
		return tab
	end
end

class Linia
	def initialize(list,id)
		@id=id
		@list=list
	end
	def getId
		return @id
	end
	#dodaj(typ,list,name,high,epsilon,id)
	def getEvery
		@every=["i",@list,"name",0,0,@id]
		return @every
	end

	def rysuj
		@pic=""
		scale=1
		i=0
		@pic="newpath\n"+"#{scale*@list[i]} #{scale*@list[i+1]} moveto\n"
		i+=2
		while (i<@list.size)
			@pic=@pic+"#{scale*@list[i]} #{scale*(@list[i+1])} lineto\n"
			i+=2
		end
		return @pic
	end
end
class Siatka
	def initialize(skala)
		@skala=skala
	end
	def rysuj
		@pic=""
		if @skala>0
			i=0
			while (i<1000)
				@pic=@pic+"newpath\n"+"#{i} #{0} moveto\n"
				@pic=@pic+"#{i} #{1000} lineto\n"
				@pic=@pic+"#{0.8} #{0.8} #{0.8} setrgbcolor\n0.02 setlinewidth\nstroke\n"
				i+=@skala
			end
			i=0
			while (i<1000)
				@pic=@pic+"newpath\n"+"#{0} #{i} moveto\n"
				@pic=@pic+"#{1000} #{i} lineto\n"
				@pic=@pic+"#{0.8} #{0.8} #{0.8} setrgbcolor\n0.02 setlinewidth\nstroke\n"
				i+=@skala
			end
		end
		return @pic
	end
end
class Rzeka < Linia
	def rysuj
		super
		@pic=@pic+"#{0} #{0} #{1} setrgbcolor\n4 setlinewidth\nstroke\n"
		return @pic
	end
	def getEvery
		super
		@every[0]="r"
			
		return @every
	end
end

class Building <Linia
	def initialize(list,high,id)
        @id=id
		@list=list
        @high=high
    end
    def getEvery
		super
		@every[0]="b"
		@every[3]=@high
		return @every
	end

    def rysuj
    	super
		color=Color.new(3)
		tab=color.high(@high)
		@pic=@pic+"closepath\n"+"#{tab[0]} #{tab[1]} #{tab[2]} setrgbcolor\n2 setlinewidth\nstroke\n"
		return @pic
	end
end
class Parcela<Linia
	def initialize(list,name,id)
		@id=id
		@list=list
		@name=name
	end
	def getEvery
		super
		@every[0]="d"
		@every[2]=@name	
		return @every
	end

	def rysuj 
		super
		i=0
		xs=0
		ys=0
		@pic+="closepath\n"+"#{1} #{0.4} #{0.5} setrgbcolor\n0.5 setlinewidth\nstroke\n"
		while i<@list.size do
			if i%2 ==1
				ys+=@list[i]
			else

				xs+=@list[i]
			end
			i+=1		
		end
		ys=2*ys/@list.size
		xs=2*xs/@list.size
		@pic+="/Times-Roman findfont\n12 scalefont\nsetfont\nnewpath\n#{xs-@name.size*2} #{ys-15} moveto\n(#{@name}) show\nstroke\n"
		return @pic
	end
end
	#dodaj(typ,list,name,high,epsilon,id)
class Gora<Linia
	def initialize(list,high,epsilon,id)
		@high=high
		@id=id
		@epsilon=epsilon
		@list=list
	end
	def getEvery
		super
		@every[0]="g"
		@every[3]=@high
		@every[4]=@epsilon
		return @every
	end
	def rysuj
		temp=@high
		radius=1
		kolor=Color.new(3)
		rgb=kolor.high(temp)
		r=rgb[0]
		g=rgb[1]
		b=rgb[2]
		@pic="#{@list[0]} #{@list[1]} #{radius} 0 360 arc closepath\n"+"#{r} #{g} #{b} setrgbcolor\n0.01 setlinewidth\nstroke\n"
		c=1/10*@high
		temp=@high
		while temp>0
			radius=-1/10*temp+c
			#radius=3*-(Math.log(temp+1.0)-Math.log(@high)+5)
			rgb=kolor.high(@high-temp)
			#puts("a",temp,r)
			r=rgb[0]
			g=rgb[1]
			b=rgb[2]
			@pic+="#{@list[0]} #{@list[1]} #{radius} 0 360 arc closepath\n"+"#{r} #{g} #{b} setrgbcolor\n0.2 setlinewidth\nstroke\n"
			temp-=@epsilon
		end
		return @pic
	end
end

class Map
	def initialize(a,id)
		@id=id
		@a=a
		@rivers=[]
		@mountains=[]
		@buildings=[]
		@grounds=[]
		@anothers=[]
	end
	def getId
		return @id
	end
	def getObjects(s)
		case s
		when "r"
			#@rivers.each{|x|puts x.getEvery}
			return @rivers
		when "m"
			#@mountains.each{|x|puts x.getEvery}
			return @mountains
		when "b" 
			#@buildings.each{|x|puts x.getEvery}
			return @buildings
		when "g"
			#@grounds.each{|x|puts x.getEvery}
			return @grounds
		else 
			#@anothers.each{|x|puts x.getEvery}
			return @anothers
		end

	end
	def getEvery
		objects=[@a,@id]
		@rivers.each{|x|objects<<x.getEvery}
		@mountains.each{|x|objects<<x.getEvery}
		@buildings.each{|x|objects<<x.getEvery}
		@grounds.each{|x|objects<<x.getEvery}
		@anothers.each{|x|objects<<x.getEvery}
		return objects.to_s
	end

	def dodaj(typ,list,name,high,epsilon,id)
		case typ
		when "r"
			r=Rzeka.new(list,id)
			@rivers.push(r)
		when "g"
			g=Gora.new(list,high,epsilon,id)
			@mountains.push(g)
		when "b"
			b=Building.new(list,high,id)
			@buildings.push(b)
		when "d"
			d=Parcela.new(list,name,id)
			@grounds.push(d)
		else
			i=Linia.new(list,id)
			@anothers.push(i)
		end
	end

	def rysuj(file)
		aFile=File.new(file,"w")
		if aFile
    		scale=8
    		i=0
    		objects="%!PS-Adobe-2.0 EPSF-2.0\n"+"%%BoundingBox: 0 0 0 0\n"
    		@rivers.each{|x|objects+=x.rysuj}
			@mountains.each{|x|objects+=x.rysuj}
			@buildings.each{|x|objects+=x.rysuj}
			@grounds.each{|x|objects+=x.rysuj}
			@anothers.each{|x|objects+=x.rysuj}
		
    		#aFile.syswrite("%!PS-Adobe-2.0 EPSF-2.0\n"+"%%BoundingBox: 0 0 0 0\n")
			#b=[50,30,50,50,40,50,40,30]
			#b1=Building.new(b,60,"b1")
			#b4=[180,170,180,190,170,190,170,170]
			#b3=Building.new(b4,30,"b3")
			#c=[80,70,80,90,70,90,70,70]
			#b2=Building.new(c,10,"b2")
			#d=[20,0,20,20,30,40,30,60,50,60,70,40,100,100,200,250,600,400,1000,1000]
			#rz=Rzeka.new(d,"r1")
			siatka=Siatka.new(@a)
			#p=[46,56,40,160,159,160,130,56]
			#p1=Parcela.new(p,"dzialka nr 1.","dzialka1")
			#gora=Gora.new([250+50,250-140],150,10,"g1")
			#aFile.syswrite(b1.rysuj())
			#aFile.syswrite(b2.rysuj())
			#aFile.syswrite(b3.rysuj())
			#aFile.syswrite(rz.rysuj)
			#aFile.syswrite(p1.rysuj)
			#aFile.syswrite(gora.rysuj)
			objects+=siatka.rysuj()
			#aFile.syswrite("showpage\n%%Trailer\n%EOF")
			objects+="showpage\n%%Trailer\n%EOF"
			aFile.syswrite(objects)
		end
	end
end
@maps=[]

#mapa=Map.new(50,"Mapa Marchwkowego Pola")
#@maps.push(mapa)
#dodaj(typ,list,name,high,epsilon,id)
#mapa.dodaj("r",[1,2,3,4,5,6,12,89,3,5],"",0,0,"Odra")
#mapa.dodaj("b",[50,30,50,50,40,50,40,30],"",90,0,"Sky Tower")
#mapa.dodaj("b",[180,170,180,190,170,190,170,170],"",20,0,"Moj Dom")
#mapa.dodaj("b",[80,70,80,90,70,90,70,70],"",50,0,"Instytut Informatyki")
#mapa.dodaj("r",[20,0,20,20,30,40,30,60,50,60,70,40,100,100,200,250,600,400,1000,1000],"",0,0,"Widawa")
#mapa.dodaj("d",[46,56,40,160,159,160,130,56],"dzialka nr 1",0,0,"Dzialka nr 1-1")
#mapa.dodaj("g",[250+50,250-140],"",150,20,"Sleza")
#mapa.rysuj("a.gst")
@maps=openObjects("s")


while true
	system "clear" or system "cls"
	puts("***Witaj w przegladarce map iCarrotMaps v0.5.0 alpha***\n\n")
	puts("m- przejrzyj dostepne mapy", "n- nowa mapa", "anykey- wyjscie\n\n")
	tty_param = `stty -g`
	system 'stty raw'
	a = IO.read '/dev/stdin', 1
	system "stty #{tty_param}"
	do1=a
	puts "\n"
	case do1
	when 'm'
		while true
			system "clear" or system "cls"
			puts ("Dostepne sa nastepujace mapy:")
			i=0
			@maps.each{|x|i+=1;print(i);print(". "+x.getId+"\n")}
			puts "\nWybierz numer", "w- wyjscie do menu glownego\n\n"
			do2=gets.chomp
			do2=="w"? break : 1+1
			while true
				do2=do2.to_i
				chosen_map=@maps[do2-1]
				system "clear" or system "cls"

				print("wybrales nr ")
				print do2
				print ".: "+chosen_map.getId+"\n"
				puts "e- edytuj mape", "d- dodaj element", "p- pokaz fragment mapy", "w- wyjscie do menu glownego", "i- inna mapa\n\n"
				
				tty_param = `stty -g`
				system 'stty raw'
				do3 = IO.read '/dev/stdin', 1
				system "stty #{tty_param}"
				puts "\n"

				while do3=="e"
					system "clear" or system "cls"
					puts("lista elementow na mapie:")
					showObjects(chosen_map)
					puts("\nwpisz id obiektu do edycji", "w- wyjscie do menu glowego", "i- inna mapa","p- pozostale opcje\n\n")
					do4=gets.chomp
					if do4=="w"||do4=="i"||do4=="p"
						system "clear" or system "cls"
						do3=do4
						break
					end
					case do4[0]
					when "b"
					when "d"
					when "g"
					when "r"
					else
					end
				end
				if do3=="d"
					newObject(chosen_map)				
				end
				while do3=="p"
					system "clear" or system "cls"
					puts "na razie tylko cala mapa"
					showObjects(chosen_map)
					saveObjects("s",@maps)
					exec("xdg-open a.gst")
					a=gets
					break
				end
				do3=="w"||do3=="i"? break : 1
			end
				do3=="w"? break : 1
		end
	when 'n'
		system "clear" or system "cls"
		puts ("blala")
	else
		break
	end
end

system "clear" or system "cls"
#exec("xdg-open a.gst")

