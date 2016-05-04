class Jawna
	def initialize(string)
        @napis=string
    end
	def zaszyfruj(klucz)
		n2=''
		i=0
		while (i<@napis.size)
			if (@napis[i]>='A'&&@napis[i]<='Z')
				n2=n2+((@napis[i].ord - 65+klucz)%26+65).chr
			elsif (@napis[i]>='a'&&@napis[i]<='z')
				n2=n2+((@napis[i].ord-97+klucz)%26+97).chr

			else
				n2=n2+@napis[i].chr
			end
			i+=1
		end
		ret = Zaszyfrowana.new(n2)
		return ret

	end
	def to_s
        return @napis
    end
end
class Zaszyfrowana
	def initialize(string)
        @napis=string
    end
	def odszyfruj(klucz)
		n2=''
		i=0
		while (i<@napis.size)
			if (@napis[i]>='A'&&@napis[i]<='Z')
				n2=n2+((@napis[i].ord - 65-klucz)%26+65).chr
			elsif (@napis[i]>='a'&&@napis[i]<='z')
				n2=n2+((@napis[i].ord-97-klucz)%26+97).chr

			else
				n2=n2+@napis[i].chr
			end
			i+=1
		end
		ret = Jawna.new(n2)
		return ret

	end
	def to_s
        return @napis
    end
end



raz = Zaszyfrowana.new('')
dwa = Jawna.new('Lorem ipsum dolor sit amet, consectetuer adipiscing elit.')
raz = dwa.zaszyfruj(1)
puts(raz.to_s)
trzy = Jawna.new('')
trzy = raz.odszyfruj(1)
puts(trzy.to_s)
