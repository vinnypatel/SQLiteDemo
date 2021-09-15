//
//  selectedChoiceWords.swift
//  SQLitedemo
//
//  Created by Vinay Patel on 04/08/2021.
//

import Foundation

struct selectedChoiceWords {
    
    var strCaption: String
    var strImageName:String
    var isSpeaking: Bool = false
    
    init(strCaption: String, strImageName: String, isSpeaking: Bool = false) {
        
        self.strCaption = strCaption
        self.strImageName = strImageName
        self.isSpeaking = isSpeaking
    }
}
