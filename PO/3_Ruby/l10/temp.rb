def run
	puts "Zaraz sie zacznie \n"
	yield 3,4,5
	yield 7,5,6
	yield 'a','b','c'
	puts "Juz sie skonczylo \n"
	yield "al", "bl", "cl"
end

run { |x,y,z| puts x+y+z}