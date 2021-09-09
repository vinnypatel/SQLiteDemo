//
//  TempViewController.swift
//  SQLitedemo
//
//  Created by Vinay Patel on 09/09/2021.
//

import UIKit
import PDFKit

class TempViewController: UIViewController, UIDocumentInteractionControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        saveHtmlDoc()
        // Do any additional setup after loading the view.
    }
    

    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
    
    func saveHtmlDoc() {
        let filemgr = FileManager.default
        let docURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let destPath = URL(string:docURL)?.appendingPathComponent("temp")

        guard let newDestPath = destPath, let sourcePath = Bundle.main.path(forResource: "QURAN", ofType: ".zip"), let fullDestPath = NSURL(fileURLWithPath: newDestPath.absoluteString).appendingPathComponent("QURAN.zip") else { return  }

        //CREATE FOLDER
        if !filemgr.fileExists(atPath: newDestPath.path) {
            do {
                try filemgr.createDirectory(atPath: newDestPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription);
            }
        }
        else {
            print("Folder is exist")
        }

        if filemgr.fileExists(atPath: fullDestPath.path) {
            print("File is exist in \(fullDestPath.path)")
        }
        else {
            do {
                try filemgr.copyItem(atPath:  sourcePath, toPath: fullDestPath.path)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     /Users/patelvin/Library/Developer/CoreSimulator/Devices/EE13DE86-DD9D-44C3-B87F-AA515147EE47/data/Containers/Data/Application/48199043-BA94-4B40-9819-DBBB44F5DEDE/Documents/temp/PDF/ListAbstractions.pdf
    */
  //  #imageLiteral(resourceName: "ListAbstractions.pdf")
    @IBAction func btnExtract(_ sender: Any) {
        
       // let filemgr = FileManager.default
        let docURL = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let destPath = URL(string:docURL)?.appendingPathComponent("temp")
        let fullDestPath = NSURL(fileURLWithPath: destPath!.absoluteString).appendingPathComponent("QURAN.zip")
        let toUrl = NSURL(fileURLWithPath: destPath!.absoluteString).appendingPathComponent("PDF")
        
        if FileManager.default.fileExists(atPath: toUrl!.path) {
            do
            {try FileManager.default.removeItem(at: toUrl!)}
            catch let err {
                debugPrint("\(err.localizedDescription)")
            }
        }
        
        do {
            
            try FileManager.default.unzipItem(at: fullDestPath! , to: toUrl!)
        } catch let err {
            
            debugPrint("\(err.localizedDescription)")
        }
        let url = (toUrl?.absoluteURL.appendingPathComponent("/QURAN.pdf"))!
        let document = PDFDocument(url: url)!
        showDocument(document)
        
    }
    
    private func showDocument(_ document: PDFDocument) {
        let image = UIImage(named: "")
        let controller = PDFViewController.createNew(with: document, title: "Test", actionButtonImage: image, actionStyle: .activitySheet)
        navigationController?.pushViewController(controller, animated: true)
    }

}
