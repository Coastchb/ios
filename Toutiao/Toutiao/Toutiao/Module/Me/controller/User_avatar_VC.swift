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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        avatar_img_view.image = User.get_user_avatar()!

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
        var avatar_path = User.save_avatar(image_content: avatar_content!)
        
        UserDefaults.standard.set(avatar_path, forKey: USER_AVATAR_KEY)
        
        // upload to server
        upload_avatar()
        
        self.navigationController?.popViewController(animated: true)
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


// MARK: - Networking calls
extension User_avatar_VC {
  func upload_avatar() {
    var image = self.avatar_img_view.image!
    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
      print("Could not get JPEG representation of UIImage")
      return
    }
    
    Alamofire.upload(multipartFormData: { multipartFormData in
      multipartFormData.append(imageData,
                               withName: "imagefile",
                               fileName: "\(User.get_user_name()!).jpg",
                               mimeType: "image/jpeg")
    }, to:"http://localhost:8888/image/content")
    { (result) in
        switch result {
        case .success(let upload, _, _):

            upload.uploadProgress(closure: { (progress) in
                //Print progress
            })

            upload.responseJSON { response in
                //print response.result
            }

        case .failure(let encodingError): break
               //print encodingError.description
        }
    }
}
}
