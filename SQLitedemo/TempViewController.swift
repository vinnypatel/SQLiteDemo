//
//  TempViewController.swift
//  SQLitedemo
//
//  Created by Vinay Patel on 09/09/2021.
//

import UIKit
import PDFKit

class TempViewController: UIViewController, UIDocumentInteractionControllerDelegate{

    @IBOutlet weak var tblVw: UITableView!
    
    var arr : [Tempodel] = []
    var arrIndexSet: IndexSet? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        saveHtmlDoc()
        
        arr = [Tempodel(leading: 8, top: 34), Tempodel(leading: 8, top: 34), Tempodel(leading: 8, top: 34), Tempodel(leading: 8, top: 34), Tempodel(leading: 108, top: 8),Tempodel(leading: 8, top: 34), Tempodel(leading: 8, top: 34),Tempodel(leading: 8, top: 34), Tempodel(leading: 8, top: 34), Tempodel(leading: 8, top: 34)]
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


extension TempViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = self.tblVw.dequeueReusableCell(withIdentifier: "cell") as! tempCell
//
//       // cell.vwExpand.isHidden = !self.arrIndexSet!.contains(indexPath.row)
//
//        return cell
        //
        //                              // return cell
        //var cell = tempCell()
//        UIView.transition(with: tblVw, duration: 0.5, options: .transitionCrossDissolve) {
//
            if self.arrIndexSet!.contains(indexPath.row) {

               let cell = self.tblVw.dequeueReusableCell(withIdentifier: "cellExpanded") as! tempCell

                               return cell
            }
            else {

            let cell = self.tblVw.dequeueReusableCell(withIdentifier: "cell") as! tempCell

                               return cell
            }
//        } completion: { _ in
//
//        }
//
//        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
//        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
//        UIView.animate(withDuration: 0.3, animations: {
//            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
//            },completion: { finished in
//                UIView.animate(withDuration: 0.1, animations: {
//                    cell.layer.transform = CATransform3DMakeScale(1,1,1)
//                })
//        })
//        var rotation = CATransform3DMakeRotation( CGFloat((90.0 * Double.pi)/180), 0.0, 0.7, 0.4);
//            rotation.m34 = 1.0 / -600
//
//            //2. Define the initial state (Before the animation)
//            cell.layer.shadowOffset = CGSize(width: 10.0, height: 10.0)
//            cell.alpha = 0;
//            cell.layer.transform = rotation;
//            cell.layer.anchorPoint = CGPoint(x: 0.0, y: 0.5)
//
//            //3. Define the final state (After the animation) and commit the animation
//            cell.layer.transform = rotation
//            UIView.animate(withDuration: 0.8, animations:{cell.layer.transform = CATransform3DIdentity})
//            cell.alpha = 1
//            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
//            UIView.commitAnimations()
        
        
        
        
        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
           UIView.animate(withDuration: 0.4) {
               cell.transform = CGAffineTransform.identity
           }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if arrIndexSet!.contains(indexPath.row) {
            
            arrIndexSet?.remove(indexPath.row)
            
        } else {
            arrIndexSet?.insert(indexPath.row)
        }
        
        tblVw.beginUpdates()
        tblVw.reloadRows(at: [indexPath], with: .fade)
        tblVw.endUpdates()
        
//        tblVw.reloadRows(at: [indexPath], with: .none)
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        arrIndexSet?.remove(indexPath.row)
//        tblVw.reloadRows(at: [indexPath], with: .automatic)
//    }
    
    
}


class tempCell: UITableViewCell {
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4 : UILabel!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var vwExpand: UIView!
    @IBOutlet weak var leadingConst : NSLayoutConstraint!
    
}
