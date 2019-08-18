struct Name {
    var firstName: String
    var lastName: String
}

struct Student {
    var id: Int
    var name: Name
}

// initialization will not call willSet and didSet
var student_a = Student(id: 10, name: Name(firstName: "Coast", lastName: "Cao")) {
    willSet {
        print("value will change")
    }
    didSet {
        print("value changed")
    }
}

// in fact this assignment has three steps:
// 1. call willSet in student_a
// 2. assign new value to student_a
// 3. call didSet in student_a
student_a = Student(id: 11, name: Name(firstName: "coast", lastName: "Cao"))

// willSet and didSet will be called even if only its member parameters are assigned, instead of the variable itself
student_a.id = 09
student_a.name.firstName = "Tao"
