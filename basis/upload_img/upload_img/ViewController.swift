//
//  ViewController.swift
//  upload_img
//
//  Created by coastcao(操海兵) on 2019/11/25.
//  Copyright © 2019 coastcao. All rights reserved.
//

import UIKit

//
//  ViewController.swift
//  UseAlamofire
//
//  Created by 刘浩浩 on 16/7/15.
//  Copyright © 2016年 CodingFire. All rights reserved.
//

//import Alamofire.Swift
//import Alamofire

class ViewController: UIViewController , UIImagePickerControllerDelegate,
UINavigationControllerDelegate{

    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.image = UIImage(named: "fire.jpg")
        imageView.frame = CGRectMake(0, 0, 150, 150)
        imageView.center = self.view.center
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 150 / 2
        imageView.isUserInteractionEnabled = true
        self.view.addSubview(imageView)
        
//        self.loadData()
    }
    
    func loadData() {
        Alamofire.request(.GET, "https://api.108tian.com/mobile/v3/SceneDetail?id=528b91c9baf6773975578c5c", parameters: nil).responseJSON() { response in
           
            if let dic = response.result.value {
                print("dic: \(dic)")
            }
            else
            {
                print("dic: \(response)")
            }
        }
        
        
        
        var headers:Dictionary = [String:String]()
        headers["Content-Type"] = "application/json"
        headers["Set-Cookie"] = "xxxxxxxxxxxxxxxxx"
        
        
        var dic = [String:AnyObject]()
        dic["id"] = "CodingFire"
        dic["passWord"] = "1234567890"
        
        
        Alamofire.request(.POST, "https://api.108tian.com/mobile/v3/SceneDetail?id=", parameters:dic , encoding: ParameterEncoding.JSON, headers: headers).responseJSON{ (response)  in
            
            


            if let dic = response.result.value {
                print("dic: \(dic)")
            }
            else
            {
                print("dic: \(response)")
            }
        }
        
        

        
        
        Alamofire.upload(.POST, "https://api.108tian.", multipartFormData: { multipartFormData in
            let data = NSData()
            let data1 = NSData()
            multipartFormData.appendBodyPart(data: data, name: "image")
            multipartFormData.appendBodyPart(data: data1, name: "image1")
            }, encodingCompletion: { response in
                switch response {
                case .Success(let upload, _, _):
                    upload.responseJSON(completionHandler: { (response) in
                        print(response)
                    })
                case .Failure(let encodingError):
                    print(encodingError)
                }
                
        })
        
        
    }
    //点击屏幕触发方法
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let actionSheet = UIAlertController(title: "上传头像", message: nil, preferredStyle: .actionSheet)
        let cancelBtn = UIAlertAction(title: "取消", style: .cancel, handler: nil)

        
        let takePhotos = UIAlertAction(title: "拍照", style: .destructive, handler: {
            (action: UIAlertAction) -> Void in

            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let picker = UIImagePickerController()
                picker.sourceType = .camera
                picker.delegate = self
                picker.allowsEditing = true
                self.present(picker, animated: true, completion: nil)

            }
            else
            {
                print("模拟其中无法打开照相机,请在真机中使用");
            }

        })
        let selectPhotos = UIAlertAction(title: "相册选取", style: .default, handler: {
            (action:UIAlertAction)
            -> Void in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            self.present(picker, animated: true, completion: nil)

        })
        actionSheet.addAction(cancelBtn)
        actionSheet.addAction(takePhotos)
        actionSheet.addAction(selectPhotos)
        self.present(actionSheet, animated: true, completion: nil)
        

    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let type: String = (info[UIImagePickerControllerMediaType] as! String)
        
        //当选择的类型是图片
        if type == "public.image"
        {
            //修正图片的位置
            let image = self.fixOrientation(aImage: (info[UIImagePickerControllerOriginalImage] as! UIImage))
            //先把图片转成NSData
            let data = UIImageJPEGRepresentation(image, 0.5)
            //图片保存的路径
            //这里将图片放在沙盒的documents文件夹中
            //Home目录
            let homeDirectory = NSHomeDirectory()
            let documentPath = homeDirectory + "/Documents"
            //文件管理器
            let fileManager: FileManager = FileManager.default
            //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
            do {
                try fileManager.createDirectory(atPath: documentPath, withIntermediateDirectories: true, attributes: nil)
            }
            catch let error {
            }
            fileManager.createFileAtPath(documentPath.stringByAppendingString("/image.png"), contents: data, attributes: nil)
            //得到选择后沙盒中图片的完整路径
            let filePath: String = String(format: "%@%@", documentPath, "/image.png")
            print("filePath:" + filePath)
            Alamofire.upload(.POST, "http://192.168.3.16:9060/client/updateHeadUrl", multipartFormData: { multipartFormData in
                let lastData = NSData(contentsOfFile: filePath)
                
                multipartFormData.appendBodyPart(data: lastData!, name: "image")
                
                }, encodingCompletion: { response in
                    picker.dismissViewControllerAnimated(true, completion: nil)
                    switch response {
                    case .Success(let upload, _, _):
                        upload.responseJSON(completionHandler: { (response) in
                            print(response)
                            self.imageView.image = UIImage(data: data!)
                        })
                    case .Failure(let encodingError):
                        print(encodingError)
                    }
            })
        }
    }
    
    func fixOrientation(aImage: UIImage) -> UIImage {
        // No-op if the orientation is already correct
        if aImage.imageOrientation == .up {
            return aImage
        }
        // We need to calculate the proper transformation to make the image upright.
        // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
        var transform: CGAffineTransform = CGAffineTransformIdentity
        switch aImage.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(M_PI))
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: aImage.size.height)
            transform = transform.rotated(by: CGFloat(-M_PI_2))
        default:
            break
        }
        
        switch aImage.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: aImage.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: aImage.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            break
        }
        
        // Now we draw the underlying CGImage into a new context, applying the transform
        // calculated above.
        

        
        let ctx: CGContext = CGBitmapContextCreate(nil, Int(aImage.size.width), Int(aImage.size.height), CGImageGetBitsPerComponent(aImage.CGImage ?? <#default value#>), 0, CGImageGetColorSpace(aImage.CGImage ?? <#default value#>) ?? <#default value#>, CGImageGetBitmapInfo(aImage.CGImage).rawValue)!
        ctx.concatenate(transform)
        switch aImage.imageOrientation {
        case .left, .leftMirrored, .right, .RightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.height, aImage.size.width), aImage.cgImage)
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, aImage.size.width, aImage.size.height), aImage.cgImage)
        }
        
        // And now we just create a new UIImage from the drawing context
        let cgimg: CGImage = ctx.makeImage()!
        let img: UIImage = UIImage(cgImage: cgimg)
        return img
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



