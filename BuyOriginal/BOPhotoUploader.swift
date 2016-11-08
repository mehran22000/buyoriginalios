//
//  BOPhotoUploader.swift
//  BuyOriginal
//
//  Created by mehran najafi on 2016-10-03.
//  Copyright © 2016 MandM. All rights reserved.
//

import Foundation

class BOPhotoUploader: NSObject {

    class func upload (image: UIImage, uploadName: String, paramDic:[String:String]) -> () {
    
    // let url = NSURL(string: "https://buyoriginal.herokuapp.com/v1/insecure/upload/photo")
    let url = NSURL(string: "http://localhost:5000/v1/insecure/upload/photo")
    
    let request = NSMutableURLRequest(URL: url!)
    request.HTTPMethod = "POST"
    
    let boundary = generateBoundaryString()
    
    //define the multipart request type
    
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    let image_data = UIImagePNGRepresentation(image)
    
    if(image_data == nil)
    {
        return
    }
    
    let body = NSMutableData()
    let mimetype = "image/png"
    
    //define the data post parameter
    
    for (key,value) in paramDic {
        body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(("Content-Disposition:form-data; name=\"" + String(key) + "\"\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData((value + "\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
    }
        
    body.appendData("--\(boundary)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    body.appendData("Content-Disposition:form-data; name=\"file\"; type=request; filename=\"\(uploadName)\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    body.appendData("Content-Type: \(mimetype)\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    body.appendData(image_data!)
    body.appendData("\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    body.appendData("--\(boundary)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
    
    request.HTTPBody = body
    
    let session = NSURLSession.sharedSession()
    
    let task = session.dataTaskWithRequest(request) {
        (
        let data, let response, let error) in
        
        guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
            print("error")
            return
        }
        
        let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print(dataString)
        
    }
    
    task.resume()
}

class func generateBoundaryString() -> String
{
    return "Boundary-\(NSUUID().UUIDString)"
}
}