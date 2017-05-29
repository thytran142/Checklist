//
//  DataModel.swift
//  Checklists
//
//  Created by Tran Minh Thy on 30/5/17.
//  Copyright © 2017 Tran Minh Thy. All rights reserved.
//

import Foundation
class DataModel {
    var lists = [Checklist]()
    init(){
        loadChecklists()
    }
    func documentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func dataFilePath() -> URL{
        return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    func saveChecklists(){
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.write(to: dataFilePath(), atomically: true)
    }
    func loadChecklists(){
        let path = dataFilePath()
        print("File Path is \(dataFilePath())")
        print("Document Directory is \(documentsDirectory())")
        if let data = try? Data(contentsOf: path){
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
            lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
            unarchiver.finishDecoding()
        }
    }

}
