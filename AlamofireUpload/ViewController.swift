//
//  ViewController.swift
//  AlamofireUpload
//
//  Created by Manoj Kulkarni on 1/5/18.
//  Copyright © 2018 Manoj Kulkarni. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        uploadImage(url: "https://orangevalleycaa.org/api/upload.php")
    }

    func uploadImage(url: String){
        
        //----***** Simple image upload *****------
//        if let img = UIImage.init(named: "nyc_by_me.JPG"){
//            if let data = UIImageJPEGRepresentation(img, 0.5){
//                Alamofire.upload(data, to: url).uploadProgress(closure: { (progress) in
//                    print("\(progress.fractionCompleted)")
//                }).responseJSON(completionHandler: { (response) in
//                    debugPrint(response)
//                })
//            }
//        }
        
        
        //----***** Multipart POST form upload *****-----
        
        if let fileUrl = Bundle.main.url(forResource: "nyc_by_me", withExtension: "JPG") {
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                multipartFormData.append("Manoj".data(using: .utf8)!, withName: "username")
                multipartFormData.append(fileUrl, withName: "fileBeingUploaded")
            }, to: url, encodingCompletion: { (encodingResult) in
                switch encodingResult {
                case .failure(let error):
                    print(error)
                case .success(let req, let streaming, let fileUrl):
                        req.responseJSON(completionHandler: { (response) in
                            debugPrint(response)
                        })
                        req.uploadProgress(closure: { (progress) in
                            print("\(progress.fractionCompleted)")
                        })
                }
            })
        }
        
        
        
        
    }

}

