
import Foundation

enum WordType : String {
    case Noun = "Noun"
    case Verb = "Verb"
    case Descriptive = "Descriptive"
    case Phrase = "Phrase"
    case Others = "Others"
}

class Choices
{
    var id : Int = 0
    var parentId : Int = 0
    var caption : String = ""
    var showInMessageBox : Bool = false
    var imgPath: String? = ""
    var recordingPath: String? = ""
    var wordType: WordType!
    var color: String = ""
    var moreWords: String = ""
    var isCategory: Bool = false
    var isSelected: Bool = false
    
    init(id : Int, parentId : Int, caption : String, showInMessageBox : Bool, imgPath: String, recordingPath: String, wordType: WordType, color: String, moreWords: String, isCategory: Bool) {
        self.id = id
        self.parentId = parentId
        self.caption = caption
        self.showInMessageBox = showInMessageBox
        self.imgPath = imgPath
        self.recordingPath = recordingPath
        self.wordType = wordType
        self.color = color
        self.moreWords = moreWords
        self.isCategory = isCategory
        
        }
}
