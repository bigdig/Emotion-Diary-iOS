//
//  FaceConnector.swift
//  Emotion Diary
//
//  Created by 范志康 on 16/4/9.
//  Copyright © 2016年 范志康. All rights reserved.
//

import UIKit
import Alamofire

class FaceConnector: NSObject {
    
    let detectionURL = "https://v1-api.visioncloudapi.com/face/detection"
    let api_id = "8787dcbe92344652902ab319bbbb8e80"
    let api_secret = "c11e8b064d3f481681d250439e517a8e"
    let landmarks106 = "1"
    let attributes = "1"
    
    func scanAndAnalyzeFace(image: UIImage, andBlock block:(result: FaceConnectorRequestResult, message: String, data: Int) -> Void) {
        
    }
    
    func postImage(image: UIImage, block: (result: FaceConnectorRequestResult, message: String) -> Void) {
        
        let imgPath = NSString(string: NSTemporaryDirectory()).stringByAppendingPathComponent("0.jpeg")
        let data = UIImageJPEGRepresentation(image, 0.5)!
        data.writeToFile(imgPath, atomically: true)
        Alamofire.upload(.POST, detectionURL, multipartFormData: { (multipartFormData) in
            //multipartFormData.appendBodyPart(fileURL: NSURL(string: imgPath)!, name: "file")
            multipartFormData.appendBodyPart(data: data, name: "file", fileName: "image.jpg", mimeType: "image/jpeg")
            multipartFormData.appendBodyPart(data: self.api_id.dataUsingEncoding(NSUTF8StringEncoding)!, name: "api_id")
            multipartFormData.appendBodyPart(data: self.api_secret.dataUsingEncoding(NSUTF8StringEncoding)!, name: "api_secret")
            multipartFormData.appendBodyPart(data: self.landmarks106.dataUsingEncoding(NSUTF8StringEncoding)!, name: "landmarks106")
            multipartFormData.appendBodyPart(data: self.attributes.dataUsingEncoding(NSUTF8StringEncoding)!, name: "attributes")
            }) { (encodingResult) in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                        switch response.result {
                        case .Failure( _):
                            block(result: .Error, message: "服务器错误或网络错误")
                        case .Success(let value):
                            let json = JSON(value)
                            print(json);
                            block(result: .Success, message: "OK")
                        }

                    }
                case .Failure(let encodingError):
                    print(encodingError)
                    block(result: .Error, message: "无法编码")
                }
        }
    }

}

@objc enum FaceConnectorRequestResult: Int, CustomStringConvertible {
    
    case Success
    case Error
    
    var description: String {
        switch self {
        case .Success:
            return "Success"
        case .Error:
            return "Error"
        }
    }
}
