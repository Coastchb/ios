import UIKit

class Category_tags {
    var catagory_name : String
    var tags : [Tag]
    
    init(category:String, tags:[Tag]) {
        self.catagory_name = category
        self.tags = tags
    }
}
class Tag {
    var tag_id : Int
    var tag_name : String
    init(tag_id:Int, tag_name:String) {
        self.tag_name = tag_name
        self.tag_id = tag_id
    }
}

func print_category_tag(c: Category_tags) {
    print("category name:\(c.catagory_name);contains \(c.tags.count) tags:")
    c.tags.forEach({ tag in
        print("tag id:\(tag.tag_id); tag name: \(tag.tag_name)")
    })
}


var c1 = [
    Category_tags(category: "前端", tags:[Tag(tag_id: 1, tag_name: "HTML"), Tag(tag_id: 0, tag_name: "CSS"),Tag(tag_id: 2, tag_name: "JS")])
]

c1.forEach({ c in
    print_category_tag(c: c)
})

c1.forEach({c in
    c.tags.sort(by: {(c1,c2) in
        c1.tag_name < c2.tag_name
    })
})

c1.forEach({ c in
    print_category_tag(c: c)
})

class A {
    var id : Int?
}

extension A: Hashable {
    static func == (lhs: A, rhs: A) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
var A_dict : [A:String] = [:]


var a = [3,2,6,1]
print(a)
a.sort(by: {(aa,bb) in
    aa < bb
})
print(a)
