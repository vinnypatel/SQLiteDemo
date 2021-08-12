//
//  AppDelegate.swift
//  SQLitedemo
//
//  Created by Vinay Patel on 27/07/2021.
//

import UIKit

let APPDELEGATE = AppDelegate.sharedAppDelegate()

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    class func sharedAppDelegate() -> AppDelegate {
        
        return UIApplication.shared.delegate as! AppDelegate
        
    }
    
    var totolChoiceCount: Int = 0
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func saveImageToDocumentDirectory(image: UIImage, fileName: String) -> String {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
       /// let fileName = "image001.png" // name of the image to be saved
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if let data = image.pngData(),!FileManager.default.fileExists(atPath: fileURL.path){
            do {
                try data.write(to: fileURL)
                print("file saved")
                return fileName
            } catch {
                print("error saving file:", error)
            }
        }
        return ""
    }


    func loadImageFromDocumentDirectory(nameOfImage : String) -> UIImage {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first{
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(nameOfImage)
            let image    = UIImage(contentsOfFile: imageURL.path)
            return image!
        }
        return UIImage.init(named: "default.png")!
    }

}

