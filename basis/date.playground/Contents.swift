//: A UIKit based Playground for presenting user interface
import Foundation

let today = Date()
print("\(today)")

let zone = NSTimeZone.system
print("zone = \(zone)")

let interval = zone.secondsFromGMT()
print("interval = \(interval)")// 当前时区和格林威治时区的时间差 8小时 = 28800秒
print("interval = \(interval/3600)")// 输出当前系统时区

let now = today.addingTimeInterval(TimeInterval(interval))
print("now = \(now)")// 是Date格式不是String

let timeInterval = Date().timeIntervalSince1970


func get_curren_time() {
    let date = Date()
    print("date:\(date)")
    let timeFormatter = DateFormatter()
    //日期显示格式，可按自己需求显示
    timeFormatter.dateFormat = "yyy-MM-dd' at 'HH:mm:ss.SSS"
    let strNowTime = timeFormatter.string(from: date) as String
    print("当前时间是:\(strNowTime)")
}

get_curren_time()


func currentTime() -> String {
  let dateformatter = DateFormatter()
  dateformatter.dateFormat = "YYYY/MM/dd" // HH:mm:ss"// 自定义时间格式
  // GMT时间 转字符串，直接是系统当前时间
  return dateformatter.string(from: Date())
}
print(currentTime())


func currentTimeStamp() -> TimeInterval {
  let date = Date()
  // GMT时间转时间戳 没有时差，直接是系统当前时间戳
  return date.timeIntervalSince1970
}

func timeStampToString(_ timeStamp: TimeInterval) -> String {
  let date = NSDate(timeIntervalSince1970: timeStamp) as! Date
  let dateformatter = DateFormatter()
  dateformatter.dateFormat = "YYYY-MM-dd HH:mm:ss"// 自定义时间格式
  return dateformatter.string(from: date)
}

print(timeStampToString(currentTimeStamp()))



func string2Date(_ str: String) -> Date {
    let date_format = DateFormatter()
    date_format.dateFormat = "yyyy-mm-dd HH:mm:ss"
    return date_format.date(from:str)!
}

print("string2Date ret:\(string2Date("2020-01-24 10:14:00"))")


extension Date{
    func isThisYear() -> Bool {
        let calendar = Calendar.current
        
        //let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //"EE MM dd HH:mm:ss Z yyyy"
        //formatter.locale = Locale(identifier: "en")
        //let createDate = formatter.date(from: timeStr)!
        let nowCmps = calendar.dateComponents([.year], from: Date())
        let selfCmps = calendar.dateComponents([.year], from: self)
        let result = nowCmps.year == selfCmps.year
        return result
    }
}


/*
刚刚(一分钟内)
X分钟前(一小时内)
X小时前(当天)
昨天 HH:mm(昨天)
MM-dd HH:mm(同一年内)
yyyy-MM-dd HH:mm(跨年)
*/

//新浪服务器返回时间格式："Tue May 31 17:46:55 +0800 2011" 星期 月 日 时 分 秒 时区 年份

func convert_date(_ timeStr: String) -> String {  //将服务器返回的时间格式化为Date
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //"EE MM dd HH:mm:ss Z yyyy"
    formatter.locale = Locale(identifier: "en")

    let createDate = formatter.date(from: timeStr)! //创建一个日历类
    let calendar = Calendar.current
    var result = ""
    var formatterSr = "HH:mm"

    if( !createDate.isThisYear()) {
        formatterSr = "yyyy-MM-dd " + formatterSr
        formatter.dateFormat = formatterSr
        result = formatter.string(from: createDate)
    } else {
        if calendar.isDateInToday(createDate) { //今天
            let interval = Int(NSDate().timeIntervalSince(createDate))  //比较两个时间的差值
            if interval < 60 {
                result = "刚刚"
            }else if interval < 60 * 60 {
                result = "\(interval/60)分钟前"
            }else if interval < 60 * 60 * 24 {
                result = "\(interval / (60 * 60))小时前"
            }
        }else if calendar.isDateInYesterday(createDate) {  //昨天
            formatterSr = "昨天 " + formatterSr
            formatter.dateFormat = formatterSr
            result = formatter.string(from: createDate)
        }else {
            //该方法可以获取两个时间之间的差值
            let comps = calendar.dateComponents([Calendar.Component.year,Calendar.Component.month], from: createDate, to: Date())
            //print(comps)
            //if comps.year! >= 1 {  //更早时间
            //    formatterSr = "yyyy-MM-dd " + formatterSr
            //}else { //一年以内
                formatterSr = "MM-dd " + formatterSr
            //}
            //print("createDate:\(createDate)")
            formatter.dateFormat = formatterSr
            result = formatter.string(from: createDate)
        }
    }
    
    return result    //timeLabel是显示时间的标签
}


print(convert_date("2019-12-31 23:59:59"))
print(convert_date("2019-11-24 01:00:00"))
print(convert_date("2019-10-24 01:00:00"))
print(convert_date("2019-09-24 01:00:00"))
print(convert_date("2019-01-25 12:06:00"))
print(convert_date("2019-01-24 12:06:00"))
print(convert_date("2019-01-24 16:06:00"))
print(convert_date("2019-01-24 16:00:00"))
print(convert_date("2019-01-23 12:06:00"))
print(convert_date("2018-12-27 01:23:00"))

print(convert_date("2020-01-01 00:00:00"))
print(convert_date("2020-01-23 23:59:59"))
print(convert_date("2020-01-24 13:36:59"))
print(convert_date("2020-01-24 16:30:59"))
print(convert_date("2020-01-24 16:36:59"))

/*
print(isThisYear("2018-12-27 01:23:00"))
print(isThisYear("2019-12-31 23:59:59"))
print(isThisYear("2019-11-24 01:00:00"))
print(isThisYear("2019-10-24 01:00:00"))
print(isThisYear("2019-09-24 01:00:00"))
print(isThisYear("2019-01-25 12:06:00"))
print(isThisYear("2019-01-24 12:06:00"))
print(isThisYear("2019-01-24 16:06:00"))
print(isThisYear("2019-01-24 16:00:00"))
print(isThisYear("2019-01-23 12:06:00"))
print(isThisYear("2020-01-01 00:00:00"))*/


// 参考：https://www.jianshu.com/p/184762c3cd53
//      https://www.jianshu.com/p/8a9ffbf2a493
