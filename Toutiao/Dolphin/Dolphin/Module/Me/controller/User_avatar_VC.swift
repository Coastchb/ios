//
//  User_avatar_VC.swift
//  Toutiao
//
//  Created by coastcao(操海兵) on 2019/11/26.
//  Copyright © 2019 coastcao(操海兵). All rights reserved.
//

import UIKit
import Alamofire

class User_avatar_VC: UIViewController {

    @IBOutlet weak var avatar_img_view: UIImageView!
    
    @IBOutlet weak var select_btn: UIButton!
    
    @IBOutlet weak var upload_btn: UIButton!
    
    var init_image = UIImage(imageLiteralResourceName: "uc_account")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置头像"

        avatar_img_view.image = init_image //User.get_user_avatar()!
        
        // Do any additional setup after loading the view.
    }

    @IBAction func select_avatar(_ sender: Any) {
          let picker = UIImagePickerController()
          picker.delegate = self
          picker.allowsEditing = false
          
          if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
          } else {
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .fullScreen
          }
          
          present(picker, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func change_avatar(_ sender: Any) {
        // first save the new avatar to local FS
        
        var avatar_content = self.avatar_img_view.image!.jpegData(compressionQuality: 0.5)
        print("User.is_logined() while signup...:\(User.is_logined())")
        if(User.is_logined()) {
            if (!check_network_available()) {
                self.prompt(OFFLINE_OP_PROMPT, OFFLINE_OP_PROMPT_DELAY)
                print("here!!!")
                return
            }

            // upload to server
            let ret = upload_avatar(phone_num: User.get_user_phone_num()!, image: self.avatar_img_view.image!)
            print("change avatar ret:\(ret)")
            if(!ret.0) {
                self.prompt(ret.1, SERVER_CRASH_PROMPT_DELAY)
            } else {
                let avatar_path = NSString(string: USER_DATA_BASE_DIR).appendingPathComponent("\(User.get_user_phone_num()!).jpg")
                User.save_avatar_to_cache(avatar_path:avatar_path, image_content: avatar_content!)
                UserDefaults.standard.set(avatar_path, forKey: "\(USER_AVATAR_KEY)_\(User.get_user_id() ?? "-1")")
            }
        } else {
            let avatar_path = NSString(string: USER_DATA_BASE_DIR).appendingPathComponent("\(ANONYMOUS_USER_NAME).jpg")
            User.save_avatar_to_cache(avatar_path:avatar_path, image_content: avatar_content!)
            UserDefaults.standard.set(avatar_path, forKey: ANONYMOUS_USER_AVATAR_KEY)
        }

        self.navigationController?.popViewController(animated: true)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.avatar_img_view.layer.masksToBounds = true
        self.avatar_img_view.layer.cornerRadius = CGFloat(AVATAR_CORNER_RADIUS)
    }
}


// MARK: - UIImagePickerControllerDelegate
extension User_avatar_VC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.originalImage] as? UIImage else {
      print("Info did not have the required UIImage for the Original Image")
      dismiss(animated: true)
      return
    }
    
    avatar_img_view.image = image
    
    dismiss(animated: true) // dismiss imagePickerController
  }
}

