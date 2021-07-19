//
//  Network_utils.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2020/2/2.
//  Copyright © 2020 coastcao(操海兵). All rights reserved.
//

import Foundation
import Alamofire

func check_network_available() -> Bool {
    /*
    if let delegate = UIApplication.shared.delegate as? AppDelegate{
        guard delegate._networkReachabilityManager.isReachable else {
            return false
        }
    }*/
    
    var _networkReachabilityManager = NetworkReachabilityManager(host: "www.baidu.com")
    
    _networkReachabilityManager!.listener = { status in
        //print("Network Status Changed: \(status)")
    }
    
    _networkReachabilityManager!.startListening()
    
    //sleep(1)
    return _networkReachabilityManager!.isReachable
}
