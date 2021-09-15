//
//  AddChoiceVC.swift
//  SQLitedemo
//
//  Created by Vinay Patel on 29/07/2021.
//

import UIKit
import AVKit

class AddChoiceVC: UIViewController {

    
    @IBOutlet weak var vwImageBg: UIView!
    @IBOutlet weak var vwBgImg: UIImageView!
    @IBOutlet weak var imgVw: UIImageView!
    @IBOutlet weak var tfCaption: UITextField!
    @IBOutlet weak var tfMoreWords: UITextField!
    @IBOutlet weak var tfWorkType: UITextField!
    @IBOutlet weak var btnAddMoreWords : UIButton!
    @IBOutlet weak var lblCaption: UILabel!
    
    private let audioManager: SCAudioManager!
    private let imageDrawer: WaveformImageDrawer!
    @IBOutlet weak var waveformView: WaveformLiveView!
    
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnRecord: UIButton!
    @IBOutlet weak var btnDeleteRecord: UIButton!
    var isSaved = false
    var audioURL : URL?

    var strSelectedTable: String?
    
    var selectedChoice : Choices?
    
    required init?(coder: NSCoder) {
        audioManager = SCAudioManager()
        
        imageDrawer = WaveformImageDrawer()
        super.init(coder: coder)

        audioManager.recordingDelegate = self
    }
    
    var callBack : (()->())?
    var selectedParentID : Int = 0
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
        
        if selectedChoice != nil {
            
            tfCaption.text = selectedChoice?.caption
            lblCaption.text = selectedChoice?.caption
            tfMoreWords.text = selectedChoice?.moreWords
            tfWorkType.text = selectedChoice?.wordType.rawValue
            isCategory = selectedChoice!.isCategory
            strWordType = (selectedChoice?.wordType)!.rawValue
            if selectedChoice?.recordingPath != "" {
                audioURL = URL(string: selectedChoice!.recordingPath!)
            }
            if isCategory {
                vwBgImg.isHidden = false
                vwImageBg.backgroundColor = .clear
                vwBgImg.tintColor = UIColor(selectedChoice!.color)
                vwBgImg.image = #imageLiteral(resourceName: "folder")
            } else {
                vwImageBg.backgroundColor = UIColor(selectedChoice!.color)
            }
            
            if selectedChoice?.imgPath != "" {
                imgVw.image = APPDELEGATE.loadImageFromDocumentDirectory(nameOfImage: selectedChoice!.imgPath!)
            }
        } else {
            if isCategory {
                vwBgImg.isHidden = false
                vwImageBg.backgroundColor = .clear
                tfCaption.placeholder = "Enter Category"
                vwBgImg.image = #imageLiteral(resourceName: "folder")
                vwBgImg.tintColor = .lightGray
            }
        }

       

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        waveformView.configuration = waveformView.configuration.with(
            style: .striped(.init(color: .red, width: 3, spacing: 3))
        )
        audioManager.prepareAudioRecording()
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
    
    @IBAction func btnDeleteRecording(_ sender: Any) {
        
        if audioURL != nil {
            APPDELEGATE.deleteFile(fileNameToDelete: "recordings/\(audioURL!.lastPathComponent)")
        }
    }
    @IBAction func btnPlayRecoding(_ sender: Any) {
        
        if audioURL != nil {
            
            audioManager.playAudioFile(from: audioURL)
//            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
//            let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
//            let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
//            if let dirPath = paths.first{
//                let audioURL1 = URL(fileURLWithPath: dirPath).appendingPathComponent("recordings/\(audioURL!.lastPathComponent)")
//
//                audioManager.playAudioFile(from: audioURL)
//            }
        }
    }
    @IBAction func btnRecording(_ sender: Any) {
        
        if audioURL != nil {
            
            APPDELEGATE.deleteFile(fileNameToDelete: "recordings/\(audioURL!.lastPathComponent)")
        }
        
        
        if audioManager.recording() {
            audioManager.stopRecording()
            btnRecord.tintColor = .red//setTitle("Start Recording", for: .normal)
        } else {
            waveformView.reset()
            audioManager.startRecording()
            btnRecord.tintColor = .black//setTitle("Stop Recording", for: .normal)
        }
    }
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if !isSaved && audioURL != nil{
            APPDELEGATE.deleteFile(fileNameToDelete: "recordings/\(audioURL!.lastPathComponent)")
        }
    }
    
    @IBAction func btnSavePressed(_ sender: Any) {
        
        let db:DBHelper = DBHelper()
        
        var imagePath = ""
        if let image = imgVw.image {
            
            if selectedChoice?.imgPath != "" {
                
                imagePath =  APPDELEGATE.saveImageToDocumentDirectory(image: image, fileName: selectedChoice != nil ? "\(URL(string:selectedChoice!.imgPath!)?.lastPathComponent ?? "")" : "\(Date().timeIntervalSince1970).png")
                
            } else {
                
                imagePath =  APPDELEGATE.saveImageToDocumentDirectory(image: image, fileName: "\(Date().timeIntervalSince1970).png")
            }
        }
        
        if selectedChoice != nil {
            
            if db.updateById(id: selectedChoice!.id, parentId: selectedParentID, caption: tfCaption.text!, showInMessageBox: false, imgPath: imagePath, recordingPath: audioURL != nil ? audioURL!.absoluteString : "", wordType: strWordType, color: vwbgColor.hexString(), moreWords: tfMoreWords!.text!, isCategory: isCategory, tableName: strSelectedTable!) {
                
                isSaved = true
                self.dismiss(animated: true) {
                    
                    self.callBack?()
                }
            }
            
            return
        }
        
        if db.insert(id: 0, parentId: selectedParentID, caption: tfCaption.text!, showInMessageBox: false, imgPath: imagePath, recordingPath: audioURL != nil ? audioURL!.absoluteString : "", wordType: strWordType, color: vwbgColor.hexString(), moreWords: tfMoreWords.text!, isCategory: isCategory, tableName: strSelectedTable!) {
            isSaved = true
            self.dismiss(animated: true) {
                
                self.callBack?()
            }
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
        
        var clr : UIColor = .lightGray
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

extension AddChoiceVC: RecordingDelegate {

    func audioManager(_ manager: SCAudioManager!, didAllowRecording success: Bool) {
        if !success {
            preconditionFailure("Recording must be allowed in Settings to work.")
        }
    }

    func audioManager(_ manager: SCAudioManager!, didFinishRecordingSuccessfully success: Bool, recodingURL url: URL!) {
        print("did finish recording with success=\(success)")
        
        print(" recodeing URL \(url)")
        audioURL = url
        btnRecord.tintColor = .red//setTitle("Start Recording", for: .normal)
        
       // APPDELEGATE.saveImageToDocumentDirectory(image: <#T##UIImage#>, fileName: <#T##String#>)
    }

    func audioManager(_ manager: SCAudioManager!, didUpdateRecordProgress progress: CGFloat) {
        print("current power: \(manager.lastAveragePower()) dB")
        let linear = 1 - pow(10, manager.lastAveragePower() / 20)

        // Here we add the same sample 3 times to speed up the animation.
        // Usually you'd just add the sample once.
        waveformView.add(samples: [linear, linear, linear])
    }
}
