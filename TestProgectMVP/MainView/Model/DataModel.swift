//
//  DataModel.swift
//  TestProgectMVP
//
//  Created by Всеволод Андрющенко on 16.07.2020.
//  Copyright © 2020 Всеволод Андрющенко. All rights reserved.
//

import Foundation


struct DataModel {
    var name: String
    var data: String
    
    var view: [String]
    
    static func convertJson(json: Any) {
        
        let datas = json as! Array<Dictionary<String, Any>>
        for data in datas {
            
        }
    }
}


struct TextData {
    var text: String
}


struct ImageData {
    var url: String
    var text: String
}


struct SelectorData {
    var selectedId: Int
    var variants: [SelectorVariant]
}


struct SelectorVariant {
    var id: Int
    var text: String
}
