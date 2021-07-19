//: A UIKit based Playground for presenting user interface
  
import Foundation

/// 帐号
var acount = "339662012@qq.com"
/// 正则规则字符串
var pattern = "^[A-Z,a-z,\\d]+([-_.][A-Z,a-z,\\d]+)*@([A-Z,a-z,\\d]+[-.])+[A-Z,a-z,\\d]{2,4}"
/// 正则规则
let regex1 = try? NSRegularExpression(pattern: pattern, options: [])
/// 进行正则匹配
if let results = regex1?.matches(in: acount, options: [], range: NSRange(location: 0, length: acount.count)), results.count != 0 {
    print("帐号匹配成功")
    for result in results{
        let string = (acount as NSString).substring(with: result.range)
        print("对应帐号:",string)
    }
}


pattern = "raw=(\\d+) mV level=(\\d+(?:\\.\\d+)?)%"
let batteryLevel = "raw=281804 mV level=100.00%"

/**
 正则表达式获取目的值
 - parameter pattern: 一个字符串类型的正则表达式
 - parameter str: 需要比较判断的对象
 - imports: 这里子串的获取先转话为NSString的[以后处理结果含NS的还是可以转换为NS前缀的方便]
 - returns: 返回目的字符串结果值数组(目前将String转换为NSString获得子串方法较为容易)
 - warning: 注意匹配到结果的话就会返回true，没有匹配到结果就会返回false
 */
func regexGetSub(pattern:String, str:String) -> [String] {
    var subStr = [String]()
    let regex = try! NSRegularExpression(pattern: pattern, options:[])
    let matches = regex.matches(in: str, options: [], range: NSRange(str.startIndex...,in: str))
    //解析出子串
    for  match in matches {
        //        subStr.append(String(str[Range(match.range(at: 1), in: str)!]))
        //        subStr.append(String(str[Range(match.range(at: 2), in: str)!]))
        subStr.append(contentsOf: [String(str[Range(match.range(at: 1), in: str)!]),String(str[Range(match.range(at: 2), in: str)!])])
    }
    return subStr
}


var batteryParams = [String]()
batteryParams = regexGetSub(pattern: pattern, str: batteryLevel)
print(batteryParams)


var str0 = "www.runoob.com/a/b.html"
var str1 = "https://www.runoob.com/a/b.html"
var str2 = "http://www.runoob.com/a/b.html"
var str3 = "https://dev.w3.org/html5/html-author/"


func get_domain_name(link: String) -> String {
    var ret = ""
    var pat = "^(http[s]*://){0,1}([^/]*)/.*"
    let regex = try? NSRegularExpression(pattern: pat, options: [])
    /// 进行正则匹配
    if let results = regex?.matches(in: link, options: [], range: NSRange(link.startIndex...,in:link)) {
        //print(results.count)
        for result in results{
            //let string = (link as NSString).substring(with: result.range)
            //print("对应帐号:",string)

            ret = String(link[Range(result.range(at: 2), in: link)!]) //,String(str1[Range(result.range(at: 2), in: str1)!]))
        }
    }
    return ret
}

print("ret: \(get_domain_name(link: str0))")
print("ret: \(get_domain_name(link: str1))")
print("ret: \(get_domain_name(link: str2))")
print("ret: \(get_domain_name(link: str3))")


