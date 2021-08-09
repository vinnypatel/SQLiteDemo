//
//  ViewController.swift
//  SQLitedemo
//
//  Created by Vinay Patel on 31/07/21.
//

///********fa ldsadflfj ;laj --- ghp_VU5xPdd4NNjkYzk8PM7VPbap63zyb9CB1njdwK-------

import UIKit

class ViewController: UIViewController {

  
    var db:DBHelper = DBHelper()
    var selectedParentID = 0
    var arrSelectedParentID : [Int] = []
    @IBOutlet weak var clVwChoices : UICollectionView!
    @IBOutlet weak var btnKeyboard: UIButton!
    @IBOutlet weak var btnDelete : UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnCore: UIButton!
    @IBOutlet weak var btnMistake: UIButton!
    @IBOutlet weak var btnAler:UIButton!
    var arrSelectedChoices: [selectedChoiceWords] = [] {
        
        didSet {
            clVwSelectedChoices.reloadData()
        }
        
    }
    @IBOutlet weak var clVwSelectedChoices: UICollectionView!
    
    var isEnabled: Bool = true {
        didSet {
            
            btnDelete.isEnabled = isEnabled
            btnBack.isEnabled = isEnabled
            btnHome.isEnabled = isEnabled
            btnCore.isEnabled = isEnabled
            btnMistake.isEnabled = isEnabled
            btnAler.isEnabled = isEnabled
            
            btnDelete.alpha = isEnabled ? 1.0: 0.5
            btnBack.alpha = isEnabled ? 1.0: 0.5
            btnHome.alpha = isEnabled ? 1.0: 0.5
            btnCore.alpha = isEnabled ? 1.0: 0.5
            btnMistake.alpha = isEnabled ? 1.0: 0.5
            btnAler.alpha = isEnabled ? 1.0: 0.5


        }
    }
    
    @IBOutlet weak var lblKeyboard: UILabel!
        
    var choices:[Choices] = [] {
        
        didSet {
            self.clVwChoices.reloadData()
        }
    }
    
    var arrTravel: [String] = [] {
        
        didSet {
            
            if arrTravel.count == 1 {
                strPath = arrTravel[0]
                btnHome.isEnabled = false
                btnBack.isEnabled = false
            } else {
                btnHome.isEnabled = true
                btnBack.isEnabled = true
                strPath = ""
                for i in 0..<arrTravel.count {
                    
                    if i == arrTravel.count - 1 {
                        
                        strPath = strPath + " " + arrTravel[i]
                    }  else  {
                        
                        strPath = strPath + " " + arrTravel[i] + "->"
                    }
                }
            }
 
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        arrTravel = ["Home"]
        arrSelectedParentID = [0]
        readChoiceDB(parentID: 0)
        
        btnDelete.addTarget(self, action: #selector(multipleTap(_:event:)), for: .touchDownRepeat)
        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnChoicesWords))
        clVwSelectedChoices.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapOnChoicesWords() {
        
        if arrSelectedChoices.count == 0 {
            return
        }
        
        let arrCaption = arrSelectedChoices.map({$0.strCaption})
        let utterance = AVSpeechUtterance(string: arrCaption.joined())
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.1

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    @IBOutlet weak var lblTravelPath: UILabel!
    
    var strPath: String = "" {
        
        didSet {
            lblTravelPath.text = strPath
        }
        
    }
    
    fileprivate func readChoiceDB(parentID: Int) {
        
        choices = db.read(parentID: parentID)
    }
    
    @objc fileprivate func multipleTap(_ sender: UIButton, event: UIEvent) {
        
        if arrSelectedChoices.count == 0 {
            return
        }
        let touch: UITouch = event.allTouches!.first!
        
        
        if (touch.tapCount == 1) {
            
            arrSelectedChoices.removeLast()
            // do action.
        } else {
            
            arrSelectedChoices.removeAll()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    fileprivate func openChoiceVC(isCategory: Bool){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddChoiceVC") as! AddChoiceVC
        vc.isCategory = isCategory
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        vc.selectedParentID = selectedParentID
        vc.callBack = { [weak self] in
            self!.readChoiceDB(parentID: self!.selectedParentID)
        }
        self.present(vc, animated: true, completion: nil)

    }

}

extension ViewController {
    
    
    @IBAction func btnDeletePressed(_ sender: Any) {
        
        if arrSelectedChoices.count > 0 {
            
            arrSelectedChoices.removeLast()
        }
    }
    
    @IBAction func btnHomePressed(_ sender: Any) {
        arrTravel = ["Home"]
        arrSelectedParentID = [0]
        readChoiceDB(parentID: 0)
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        arrTravel.removeLast()
        arrSelectedParentID.removeLast()
        readChoiceDB(parentID: arrSelectedParentID[arrSelectedParentID.last!])
        
    }
    
    @IBAction func btnEditPressed(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        sender.tintColor = sender.isSelected ? .orange : .blue
        isEnabled.toggle()
        if sender.isSelected {
            
            btnKeyboard.setImage(#imageLiteral(resourceName: "ic_add"), for: .normal)
            lblKeyboard.text = "Add"
            
        } else {
            
            btnKeyboard.setImage(#imageLiteral(resourceName: "keyboard"), for: .normal)
            lblKeyboard.text = "Keyboard"
        }
        
    }
    
    @IBAction func btnAddChoicePressed(_ sender: Any) {
        
        if lblKeyboard.text == "Add" {
            
            let alertView = UIAlertController(title: "Choice", message: "What do you want to create?", preferredStyle: .actionSheet)
            
            alertView.addAction(UIAlertAction(title: "Add Many items togethor", style: .default, handler: { [weak self] alert in
                
                //self!.openChoiceVC(isCategory: false)
            }))
            alertView.addAction(UIAlertAction(title: "Add New Choice", style: .default, handler: { [weak self] alert in
                self!.openChoiceVC(isCategory: false)
               
            }))
            alertView.addAction(UIAlertAction(title: "Add New Category", style: .default, handler: { [weak self] alert in
                self!.openChoiceVC(isCategory: true)
               
            }))
            
            alertView.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
            
            if let presenter = alertView.popoverPresentationController {
                    presenter.sourceView = btnKeyboard;
                    presenter.sourceRect = btnKeyboard.bounds;
                }
            
            self.present(alertView, animated: true, completion: nil)
        }
        
       // let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddChoiceVC") as! AddChoiceVC
    }
}


extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if collectionView == clVwChoices {
        
            return choices.count
        } else {
            return arrSelectedChoices.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == clVwChoices {
        let cell = clVwChoices.dequeueReusableCell(withReuseIdentifier: "choiceCell", for: indexPath) as! ChoiceClVwCell
        
        cell.modelChoice = choices[indexPath.row]
        
        return cell
        } else {
            let cell = clVwSelectedChoices.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SelectedChoiceCell
            
            cell.selectedChoice = arrSelectedChoices[indexPath.row]
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == clVwChoices {
            return CGSize(width: 184, height: 140)
        }
                        
        
        return CGSize(width: 106, height: 83)
            }

            func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 1.0
            }

            func collectionView(_ collectionView: UICollectionView, layout
                collectionViewLayout: UICollectionViewLayout,
                                minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 1.0
            }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == clVwSelectedChoices {
            return
        }
        let model = choices[indexPath.row]
        
        if model.isCategory {
            arrTravel.append(model.caption)
            arrSelectedParentID.append(model.id)
            selectedParentID = model.id
            self.readChoiceDB(parentID: model.id)
            
        } else {
            
            arrSelectedChoices.append(selectedChoiceWords(strCaption: model.caption, strImageName: model.imgPath!))
        }
        
    }
}

///********fa ldsadflfj ;laj --- ghp_VU5xPdd4NNjkYzk8PM7VPbap63zyb9CB1njdwK-------
