class Fixnum
	def prime?
		if self<=1
			return false
		end
		if self%2 == 0 && self !=2
			return false
		elsif self ==2
			return true
		end
		i=3
		while i*i<=self do
			if self%i==0
				return false
			end
			i+=2	
		end 
		return true
	end
	def ack(y)
		if self ==0
			return y+1
		elsif y==0
			return (self-1).ack(1)
		else
			return (self-1).ack(self.ack(y-1))
		end
	end
	def doskonala
		i=2
		sum=1
		while (i*i<=self)do
			if self%i==0
				sum+=i+self/i
			end
			if sum>self
				return false
			end
			i+=1
		end
		if sum==self
			return true
		else
			return false
		end
	end
	def slownie
		tab=['zero','jeden','dwa','trzy','cztery','piec','szesc','siedem','osiem','dziewiec']
		liczba=self
		newtab=''
		while (liczba>0)
			newtab=tab[liczba%10]+' '+newtab
			liczba=liczba/10
		end
		return newtab
	end
end

puts "Czy 10 jest pierwsza? #{10.prime? }" 
puts("Czy 7 jest pierwsza? #{7.prime? }")
puts("ack(3,6)? #{3.ack(6)}")	
puts("ack(3,4)? #{3.ack(4)}")
puts("Czy 28 jest doskonala? #{28.doskonala}")
puts("Czy 12 jest doskonala? #{12.doskonala}")
puts("1203517879879798 #{1203517879879798.slownie}")




