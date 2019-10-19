//
//  news_manager.swift
//  COpenSSL
//
//  Created by coastcao(操海兵) on 2019/9/22.
//

import Foundation

func show_all() -> [News] {
    print("show all news")
    let obj = News()
    try? obj.findAll()
    return obj.rows().sorted(by: {(n1,n2) in n1.news_id < n2.news_id})
}

func show_target(id: Int) -> News {
    print("show target news")
    let obj = News()
    obj.news_id = id
    try? obj.get(id)
    return obj
}

func show_all_2() -> [News_2] {
    print("show all news_2")
    let obj = News_2()
    try? obj.findAll()
    return obj.rows().sorted(by: {(n1,n2) in n1.id < n2.id})
}

func show_target_2(id: Int) -> News_2 {
    print("show target news_2")
    let obj = News_2()
    obj.id = id
    try? obj.get(id)
    return obj
}

func show_all_3() -> [News_3] {
    print("show all news_3")
    let obj = News_3()
    try? obj.findAll()
    return obj.rows().sorted(by: {(n1,n2) in n1.id < n2.id})
}

func show_target_3(id: Int) -> News_3 {
    print("show target news_3")
    let obj = News_3()
    obj.id = id
    try? obj.get(id)
    return obj
}

