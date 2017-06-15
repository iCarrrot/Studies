class Node
    @value
    @before
    @after
    def initialize(value,before,after)
        @value=value
        @before=before
        @after=after
    end
    def next()
        return @after
    end
    def previous()
        return @before
    end
    def setnext(nast)
        @after=nast
    end
    def setprevious(prev)
        @before=prev
    end
    def value()
        return @value
    end
end

class Kolekcja
    @root
    @length
    def initialize(value)
        @root=Node.new(value,nil,nil)
        @length=1
    end
    def add(value)
        @length+=1
        temp=@root
        if @root.value>value
            new=Node.new(value,nil,@root)
            @root=new
            (new.next).setprevious(new)
            return
        end
        while temp.next and value>(temp.next).value
            temp=temp.next
        end
        new=Node.new(value,temp,temp.next)
        if temp.next
            (temp.next).setprevious(new)
        end
        temp.setnext(new)
    end
    def get(i)
        t=0
        temp=@root
        while t!=i and temp
            t+=1
            temp=temp.next
        end
        return temp.value
    end
    def print()
        a=[]
        temp=@root
        while temp
            a<<temp.value
            temp=temp.next
        end
        p a
    end
    def length()
        return @length
    end
end

class Wyszukiwanie
    def self.binsearch(kolekcja,value)
        min=0
        max=kolekcja.length
        while min!=max
            t=(max+min)/2
            if kolekcja.get(t)==value
                return t
            end
            if kolekcja.get(t)>value
                max=t
            else
                min=t
            end
        end
        if kolekcja.get(t)==value
            return t
        end
        return nil
    end
    def self.linsearch(kolekcja,value)
        for i in 0..(kolekcja.length-1)
            if kolekcja.get(i)==value
                return i
            end
        end
        return nil
    end
end

kekimus=Kolekcja.new(3)
kekimus.add(2)
kekimus.add(5)
kekimus.add(-1)
kekimus.add(7)
kekimus.add(6)
kekimus.print
puts "6 jest na miejscu:"+Wyszukiwanie.binsearch(kekimus,6).to_s
puts "6 jest na miejscu:"+Wyszukiwanie.linsearch(kekimus,6).to_s
