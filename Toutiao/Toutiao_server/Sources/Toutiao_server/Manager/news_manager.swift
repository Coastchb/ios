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
    return obj.rows()
}

func show_target(id: Int) -> News {
    print("show target news")
    let obj = News()
    obj.news_id = id
    try? obj.get(id)
    return obj
}
