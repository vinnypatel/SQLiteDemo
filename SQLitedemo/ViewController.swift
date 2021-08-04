//
//  ViewController.swift
//  SQLitedemo
//
//  Created by Vinay Patel on 31/07/21.
//

import UIKit

class ViewController: UIViewController {

    var db:DBHelper = DBHelper()
    
    @IBOutlet weak var clVwChoices : UICollectionView!
    @IBOutlet weak var btnKeyboard: UIButton!
    @IBOutlet weak var btnDelete : UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnCore: UIButton!
    @IBOutlet weak var btnMistake: UIButton!
    @IBOutlet weak var btnAler:UIButton!
    
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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        readChoiceDB()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func readChoiceDB() {
        
        choices = db.read()
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
        vc.callBack = {
            self.readChoiceDB()
        }
        self.present(vc, animated: true, completion: nil)

    }

}

extension ViewController {
    
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
    
        return choices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = clVwChoices.dequeueReusableCell(withReuseIdentifier: "choiceCell", for: indexPath) as! ChoiceClVwCell
        
        cell.modelChoice = choices[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
                        return CGSize(width: 184, height: 140)
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
}
