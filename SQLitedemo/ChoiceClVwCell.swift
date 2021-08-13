//
//  ChoiceClVwCell.swift
//  SQLitedemo
//
//  Created by Vinay Patel on 28/07/2021.
//

import UIKit

class ChoiceClVwCell: UICollectionViewCell {
    
    @IBOutlet weak var vw: UIView!
    @IBOutlet weak var bgImgVw: UIImageView!
    @IBOutlet weak var imgVwChoice: UIImageView!
    @IBOutlet weak var lblChoiceName: UILabel!
    @IBOutlet weak var imgSelect: UIImageView!
    @IBOutlet weak var vWimgContainer: UIView!
    var modelChoice : Choices? {
        
        didSet {
            
            guard let model = modelChoice else {
                return
            }
            
            lblChoiceName.text = model.caption
            if !model.imgPath!.isEmpty {
                
                vWimgContainer.isHidden = false
                let img = APPDELEGATE.loadImageFromDocumentDirectory(nameOfImage: model.imgPath!)
                imgVwChoice.image = img//UIImage(contentsOfFile: model.imgPath!)
               
            } else {
                vWimgContainer.isHidden = true
            }
            
            //var alpha : CGFloat = 1.0
            imgSelect.isHidden = true
            if model.isSelected {
              //  alpha = 0.5
                imgSelect.isHidden = false
            }
            
            if model.isCategory {
                bgImgVw.isHidden = false
                vWimgContainer.isHidden = false
                bgImgVw.image = #imageLiteral(resourceName: "folder")
                bgImgVw.tintColor = UIColor(model.color)//.withAlphaComponent(alpha)//.withAlphaComponent(0.5)
               // bgImgVw.tintColor = .darkGray
                vw.backgroundColor = .clear
            } else {
                bgImgVw.isHidden = true
                //vWimgContainer.isHidden = true
                vw.backgroundColor = UIColor(model.color)//.withAlphaComponent(alpha)//.withAlphaComponent(0.5)
            }
            
            
        }

    }
    
}
