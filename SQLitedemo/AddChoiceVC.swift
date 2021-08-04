//
//  AddChoiceVC.swift
//  SQLitedemo
//
//  Created by Vinay Patel on 29/07/2021.
//

import UIKit

class AddChoiceVC: UIViewController {

    
    @IBOutlet weak var vwImageBg: UIView!
    @IBOutlet weak var vwBgImg: UIImageView!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var tfCaption: UITextField!
    @IBOutlet weak var tfMoreWords: UITextField!
    @IBOutlet weak var tfWorkType: UITextField!
    @IBOutlet weak var btnAddMoreWords : UIButton!
    @IBOutlet weak var lblCaption: UILabel!
    
    var callBack : (()->())?
    
    var isCategory: Bool = false
    var vwbgColor: UIColor = .lightGray {
        
        didSet {
            if isCategory {
                vwBgImg.tintColor = vwbgColor
            } else {
                vwImageBg.backgroundColor = vwbgColor
            }
            
        }
        
    }
    
    var strCaption: String = ""{
        didSet {
            
            lblCaption.text = strCaption
        }
    }
    
    var strWordType: String = "Others" {
        
        didSet {
            
            tfWorkType.text = strWordType
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfCaption.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)

        if isCategory {
            vwBgImg.isHidden = false
            vwImageBg.backgroundColor = .clear
            tfCaption.placeholder = "Enter Category"
            vwBgImg.image = #imageLiteral(resourceName: "folder")
            vwBgImg.tintColor = .lightGray
        }

        // Do any additional setup after loading the view.
    }
    
    @objc func textFieldDidChange(textField:UITextField)
    {
        strCaption = textField.text!
        NSLog(textField.text!)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}

//MARK:- UIButton Actions

extension AddChoiceVC {
    
    @IBAction func btnClearImagePressed(_ sender: Any) {
        
        imgVw.image = nil
        if isCategory {
                
            vwBgImg.tintColor = .lightGray
            return
        }
        
        vwImageBg.backgroundColor = .lightGray
        
       
    }
    
    @IBAction func btnCameraPressed(_ sender : UIButton) {
        
        CameraHandler.shared.showActionSheet(vc: self, btn: sender)
        CameraHandler.shared.imagePickedBlock = { [weak self] (image) in
            
            self?.imgVw.image = image
            /* get your image here */
        }
        
    }
    
    @IBAction func btnSavePressed(_ sender: Any) {
        
        let db:DBHelper = DBHelper()
        
        var imagePath = ""
        if let image = imgVw.image {
                
            imagePath =  APPDELEGATE.saveImageToDocumentDirectory(image: image, fileName: "\(Date().timeIntervalSince1970).png")
        }
        
      
        
        if db.insert(id: 0, parentId: 0, caption: tfCaption.text!, showInMessageBox: false, imgPath: imagePath, recordingPath: "", wordType: strWordType, color: vwbgColor.hexString(), moreWords: tfMoreWords.text!, isCategory: isCategory) {
            
            self.callBack?()
        }
        
    }
    
    @IBAction func btnCancelPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnWordTypePressed(_ sender: Any) {
        
        let alertView = UIAlertController(title: "WordType", message: "Please select Word Type.", preferredStyle: .actionSheet)
        
        alertView.addAction(UIAlertAction(title: "Noun", style: .default, handler: { [weak self] alert in
            
            self!.strWordType = alert.title!
        }))
        alertView.addAction(UIAlertAction(title: "Verb", style: .default, handler: { [weak self] alert in
            
            self!.strWordType = alert.title!
        }))
        alertView.addAction(UIAlertAction(title: "Descriptive", style: .default, handler: { [weak self] alert in
            
            self!.strWordType = alert.title!
        }))
        alertView.addAction(UIAlertAction(title: "Phrase", style: .default, handler: { [weak self] alert in
            
            self!.strWordType = alert.title!
        }))
        alertView.addAction(UIAlertAction(title: "Others", style: .default, handler: { [weak self] alert in
            
            self!.strWordType = alert.title!
        }))
        
        alertView.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        
        if let presenter = alertView.popoverPresentationController {
                presenter.sourceView = tfWorkType;
                presenter.sourceRect = tfWorkType.bounds;
            }
        
        self.present(alertView, animated: true, completion: nil)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        tfMoreWords.isUserInteractionEnabled = false
        btnAddMoreWords.isSelected = false
    }
    
    @IBAction func btnAddWordForsPressed(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        
        if sender.isSelected {
            tfMoreWords.isUserInteractionEnabled = true
            tfMoreWords.becomeFirstResponder()
        } else {
            tfMoreWords.isUserInteractionEnabled = false
            tfMoreWords.resignFirstResponder()
        }
    }
    
    @IBAction func btnColorsPressed(_ sender: UIButton) {
        
        var clr : UIColor = .clear
        switch sender.tag {
        case 0:
            clr = #colorLiteral(red: 0.7608028054, green: 0.3028233647, blue: 0, alpha: 1)
            break
        case 1:
            clr = #colorLiteral(red: 0, green: 0.569468379, blue: 0, alpha: 1)
            break
        case 2:
            clr = #colorLiteral(red: 0.6713187099, green: 0, blue: 0.5584232807, alpha: 1)
            break
        case 3:
            clr = #colorLiteral(red: 0.5993054509, green: 0.5179988742, blue: 0, alpha: 1)
            break
        case 4:
            clr = #colorLiteral(red: 0.5147576332, green: 0.008318921551, blue: 0.6677450538, alpha: 1)
            break
        case 5:
            clr = #colorLiteral(red: 0.4588036537, green: 0.4587942362, blue: 0.4630755782, alpha: 1)
            break
        case 6:
            clr = #colorLiteral(red: 0, green: 0.4767668843, blue: 0.6516603827, alpha: 1)
            break
        case 7:
            clr = #colorLiteral(red: 0.5876073241, green: 0.3765279353, blue: 0.2195830047, alpha: 1)
            break
        default:
            break
            
        }
        
        vwbgColor = clr
    }
   
    
}

