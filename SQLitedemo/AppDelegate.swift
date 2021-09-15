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

    
    var myOrientation : UIInterfaceOrientationMask = UIDevice.current.userInterfaceIdiom == .phone ? .portrait : .all
    
    class func sharedAppDelegate() -> AppDelegate {
        
        return UIApplication.shared.delegate as! AppDelegate
        
    }
    
    var totolChoiceCount: Int = 0
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        return myOrientation
        
        /*
         if self.window?.rootViewController?.presentedViewController is SecondViewController {

                 let secondController = self.window!.rootViewController!.presentedViewController as! SecondViewController

             if secondController.isBeingPresented {

                     return UIInterfaceOrientationMask.landscapeLeft;

             } else {
                return UIInterfaceOrientationMask.all;
             }
     } else {
         
         return UIInterfaceOrientationMask.all;
     }
         */
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
            return image != nil ? image! : #imageLiteral(resourceName: "picture")
        }
        return UIImage.init(named: "default.png")!
    }
    
    func deleteFile(fileNameToDelete: String) {
       // let fileNameToDelete = "myFileName.txt"
        var filePath = ""
        // Fine documents directory on device
         let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        if dirs.count > 0 {
            let dir = dirs[0] //documents directory
            filePath = dir.appendingFormat("/" + fileNameToDelete)
            print("Local path = \(filePath)")
         
        } else {
            print("Could not find local directory to store file")
            return
        }
        do {
             let fileManager = FileManager.default
            
            // Check if file exists
            if fileManager.fileExists(atPath: filePath) {
                // Delete file
                try fileManager.removeItem(atPath: filePath)
            } else {
                print("File does not exist")
            }
         
        }
        catch let error as NSError {
            print("An error took place: \(error)")
        }
    }

}

