let t1: (Int, String) = (1, "string 1")
let (i, s) = t1
print(t1)
print(i)
print(s)


let t2: (i:Int, s:String) = (2, "string 2")
print(t2.i)
print(t2.s)


func t_fun() -> (p1:Int, p2:String) { return (3, "string 3")}
let p = t_fun()
print(p.p1)
print(p.p2)
