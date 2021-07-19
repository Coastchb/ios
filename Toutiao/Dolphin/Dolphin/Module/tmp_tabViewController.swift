//
//  tmp_tabViewControlle.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/10/15.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import Foundation

class tmp_tabbar_VC : UITabBarController {
    override func viewDidLoad() {
        self.selectedIndex = 1
        UserDefaults.standard.removeObject(forKey: STARED_TYPE_KEY)
        UserDefaults.standard.removeObject(forKey: STARED_ID_KEY)
        UserDefaults.standard.removeObject(forKey: USER_AVATAR_KEY)
        UserDefaults.standard.removeObject(forKey: USER_TAGS_KEY)
        UserDefaults.standard.removeObject(forKey: USER_INFO_KEY)
        
        /*
        if(User.is_logined()) {
            var avatar_url = URL(string: "http://localhost:8000/coastcao.jpg")!
            var avatar_data = NSData(contentsOf: avatar_url)!
            var avatar_path = User.save_avatar(image_content: avatar_data as Data)
            print("after logging:\(avatar_path)")
            UserDefaults.standard.set(avatar_path, forKey: USER_AVATAR_KEY)
            
        }*/

       
    }
}
