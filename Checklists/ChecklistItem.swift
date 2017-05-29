//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Tran Minh Thy on 26/5/17.
//  Copyright © 2017 Tran Minh Thy. All rights reserved.
//

import Foundation
class ChecklistItem: NSObject, NSCoding{
    var text=""
    var checked = false
    func toggleChecked(){
        checked = !checked
    }
    required init?(coder aDecoder: NSCoder) {
        //Reverse from the file 
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        
        super.init()
    }
    override init(){
        checked = false
        super.init()
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
    }
}
