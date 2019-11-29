//
//  Foundation_extension.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/16.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation


extension URL{
    
    static func initPercent(string:String) -> URL
    {
        let urlwithPercentEscapes = string.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let url = URL.init(string: urlwithPercentEscapes!)
        return url!
    }
}
