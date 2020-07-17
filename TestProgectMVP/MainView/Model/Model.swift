//
//  Model.swift
//  TestProgectMVP
//
//  Created by Всеволод Андрющенко on 17.07.2020.
//  Copyright © 2020 Всеволод Андрющенко. All rights reserved.
//

import Foundation


struct ResultModel {
    var type: TypeData
    var value: Any
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
