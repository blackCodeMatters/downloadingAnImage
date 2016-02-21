//
//  ViewController.swift
//  downloadingAnImage
//
//  Created by Dustin M on 2/21/16.
//  Copyright © 2016 Vento. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/1_epcot_spaceship_earth_2010a.JPG/1024px-1_epcot_spaceship_earth_2010a.JPG")
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) -> Void in
            
            if error != nil {
                
                print(error)
                
            } else {
                
                //the following code is used to save the downloaded image
                
                var documentsDirectory: String?
                var paths: [AnyObject] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
                
                if paths.count > 0 {
                    
                    documentsDirectory = paths[0] as? String
                    
                    let savePath = documentsDirectory! + "/epcot.jpg"
                    
                    NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                    
                
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    //used to process image download on main thread rather than in a background thread
                
                    self.image.image = UIImage(named: savePath)
                    
                    })

                }
                    
            }
            
        }
        
        task.resume()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

