//
//  Date.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/12/3.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

func currentTime(_ format: String) -> String {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = format //"YYYY-MM-dd/HH:mm:ss"// 自定义时间格式
    // GMT时间 转字符串，直接是系统当前时间
    return dateformatter.string(from: Date())
}

func currentDate() -> String {
    let dateformatter = DateFormatter()
    dateformatter.dateFormat = "YYYY/MM/dd"// 自定义时间格式
    // GMT时间 转字符串，直接是系统当前时间
    return dateformatter.string(from: Date())
}


/*
 刚刚(一分钟内)
 X分钟前(一小时内)
 X小时前(当天)
 昨天 HH:mm(昨天)
 MM-dd HH:mm(同一年内)
 yyyy-MM-dd HH:mm(跨年)
 */

func convert_date(_ timeStr: String, _ format:String) -> String {  //将服务器返回的时间格式化为Date
    let formatter = DateFormatter()
    formatter.dateFormat = format //"yyyy-MM-dd HH:mm:ss" //"EE MM dd HH:mm:ss Z yyyy"
    formatter.locale = Locale(identifier: "en")

    print(formatter.date(from: timeStr))
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
            formatterSr = "MM-dd " + formatterSr
            formatter.dateFormat = formatterSr
            result = formatter.string(from: createDate)
        }
    }
    
    return result
}
