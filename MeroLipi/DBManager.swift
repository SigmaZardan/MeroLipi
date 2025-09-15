//
//  DBManager.swift
//  MeroLipi
//
//  Created by Bibek Bhujel on 14/09/2025.
//

import Foundation
import SQLite3

class DBManager {
    static let shared = DBManager()
   private var db: OpaquePointer?
    private init() {
        db = openDatabase()
    }

    func openDatabase() -> OpaquePointer?{
        guard let path = Bundle.main.path(forResource: "nepali_words", ofType: "sqlite") else {
            print("Database file not found in bundle")
            return nil
        }
        var db: OpaquePointer?
        if sqlite3_open(path, &db) == SQLITE_OK {
            print("Successfully opened database at \(path)")
            return db
        } else {
            print("Unable to open database")
            return nil
        }
    }

    func queryWords(prefix: String, limit: Int = 20) -> [String] {
           let queryStatementString = "SELECT word FROM words WHERE word LIKE ? ORDER BY word LIMIT ?;"
           var queryStatement: OpaquePointer? = nil
        var results: [String] = []
        let prefixPattern = "\(prefix)%" as NSString

           if sqlite3_prepare_v2(db,  queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
               sqlite3_bind_text(queryStatement,1,prefixPattern.utf8String,-1,nil)
               sqlite3_bind_int(queryStatement, 2, Int32(limit))

               while sqlite3_step(queryStatement) == SQLITE_ROW {
                   if let cString = sqlite3_column_text(queryStatement, 0) {
                                  results.append(String(cString: cString))
                              }
                          }
           } else {
               print("SELECT statement is failed.")
           }
           sqlite3_finalize(queryStatement)
           return results
       }

}

