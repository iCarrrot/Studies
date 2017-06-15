class Kolekcja
    @array
    def initialize()
        @array=[]
    end
    def initialize(array)
        @array=array
    end
    def add(something)
        @array<<something
    end
    def swap(i,j)
        @array[i],@array[j]=@array[j],@array[i]
    end
    def get(i)
        return @array[i]
    end
    def length()
        return @array.length
    end
    def print()
        p @array
    end
end

class Sortowanie
    def self.sort1(kolekcja)
        loop do
            flag=false
            for i in 0..(kolekcja.length-2)
                if kolekcja.get(i)>kolekcja.get(i+1)
                    kolekcja.swap(i,i+1)
                    flag=true
                end
            end
            break if not flag
        end
    end
    def self.sort2(kolekcja,start=0,finnish=-1)
        if finnish==-1
            finnish=(kolekcja.length-1)
        end
        if start==finnish
            return
        end
        if start+1==finnish
            if kolekcja.get(start)>kolekcja.get(finnish)
                kolekcja.swap(start,finnish)
            end
            return
        end
        min=[kolekcja.get(start),start]
        max=[kolekcja.get(start+1),start+1]
        if max[0]<min[0]
            min,max=max,min
        end
        for i in (start+2)..finnish
            t=kolekcja.get(i)
            if t<min[0]
                min=[t,i]
            end    
            if max[0]<t
                max=[t,i]
            end
        end
        kolekcja.swap(min[1],start)
        if start!=max[1]
            kolekcja.swap(max[1],finnish)
        end
        sort2(kolekcja,start+1,finnish-1)
    end
end

//
foo=Kolekcja.new([12,9,8,4,4,3,2,1])
Sortowanie.sort1(foo)
foo.print
foo2=Kolekcja.new([12,9,8,4,4,3,2,1,90,100,-1])
Sortowanie.sort2(foo2)
foo2.print
