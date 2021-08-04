

import Foundation
import SQLite3

class DBHelper
{
    init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    
    
    
    
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS TABLE_CHOICE(id INTEGER PRIMARY KEY,parentId INTEGER,caption TEXT, showInMessageBox INT, imgPath TEXT, recordingPath TEXT, wordType CHAR(10), color CHAR(10), moreWords TEXT, isCategory INT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    
    
    func insert(id : Int, parentId : Int, caption : String, showInMessageBox : Bool, imgPath: String, recordingPath: String, wordType: String, color: String, moreWords: String, isCategory: Bool) -> Bool
    {
        var isSuccess = false
        let choices = read()
        for p in choices
        {
            if p.id == id
            {
                return isSuccess
            }
        }

        let insertStatementString = "INSERT INTO TABLE_CHOICE(id, parentId, caption, showInMessageBox, imgPath, recordingPath, wordType, color, moreWords, isCategory) VALUES(NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(insertStatement, 1, Int32(parentId))
            sqlite3_bind_text(insertStatement, 2, (caption as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(showInMessageBox ? 1 : 0))
            sqlite3_bind_text(insertStatement, 4, (imgPath as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (recordingPath as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (wordType as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (color as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (moreWords as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 9, Int32(isCategory ? 1 : 0))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
                isSuccess = true
            } else {
                print("Could not insert row.")
                
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
        
        return isSuccess
    }
    
    func read() -> [Choices] {
        let queryStatementString = "SELECT * FROM TABLE_CHOICE;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Choices] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let parentId = sqlite3_column_int(queryStatement, 1)
                let caption = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let intShowInMessageBox = sqlite3_column_int(queryStatement, 3)
                let imgPath = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let recordingPath = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let wordType = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let color = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let moreWords = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let isCategory = sqlite3_column_int(queryStatement, 9)
                var wt: WordType!
                
                switch wordType {
                case "Noun":
                    wt = .Noun
                    break
                    
                case "Verb":
                    wt = .Verb
                    break
                    
                case "Descriptive":
                    wt = .Descriptive

                    break
                case "Phrase":
                    wt = .Phrase
                    break
                    
                case "Others":
                    wt = .Others
                    break
                    
                default: break
                    
                }

                psns.append(Choices(id: Int(id), parentId: Int(parentId), caption: caption, showInMessageBox: intShowInMessageBox == 1 ? true : false, imgPath: imgPath, recordingPath: recordingPath, wordType: wt, color: color, moreWords:moreWords, isCategory: isCategory == 1 ? true : false))
//                psns.append(Choices(id : id, parentId : parentId, caption : caption, showInMessageBox : intShowInMessageBox == 1 ? true : false, imgPath: imgPath, recordingPath: recordingPath, wordType: wordType, color: color))
                print("Query Result:")
               // print("\(id) | \(name) | \(year)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM TABLE_CHOICE WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}
