//
//  DataModel.swift
//  TestProgectMVP
//
//  Created by Всеволод Андрющенко on 16.07.2020.
//  Copyright © 2020 Всеволод Андрющенко. All rights reserved.
//

import Foundation


enum TypeData:Hashable {
    case text, image, selector
}

class JsonParseService {
    
    
    //MARK: - Public method
    func convertJson(json: Any) -> [ResultModel]  {
        var valueDictionary: Dictionary<TypeData, Any> = [:]
        //var result:
        var resultKey: [String] = []
        
        let datas = json as! Dictionary<String, Any>
        for data in datas {
            if data.key == "data" {
                parseData(data, &valueDictionary)
            }
            
            if data.key == "view" { // получили список отобраджения
                let body = data.value as! Array<String>
                for value in body {
                    resultKey.append(value)
                    
                }
            }
        }
        
        return createResultMass(value: valueDictionary, keyList: resultKey)
    }
    
    
    //MARK: - Private method
    fileprivate func createResultMass(value: Dictionary<TypeData, Any>, keyList: [String]) -> [ResultModel] {
    
        var result: [ResultModel] = []
        
        for elem in keyList {
            switch elem {
            case "hz":
                let value = ResultModel(type: .text, value: value[.text] as Any)
                result.append(value)
            case "picture":
                let value = ResultModel(type: .image, value: value[.image] as Any)
                result.append(value)
            case "selector":
                let value = ResultModel(type: .selector, value: value[.selector] as Any)
                result.append(value)
            default:
                print("not fount")
            }
        }
        return result
    }
    
    fileprivate func parseData(_ data: Dictionary<String, Any>.Element, _ valueDictionary: inout [TypeData : Any]) {
        let body = data.value as! Array<Dictionary<String, Any>>
        for value in body {
            let key = value["name"] as! String
            switch key {
            case "hz":
                let text = value["data"] as! Dictionary<String, Any>
                let textData = TextData(text: text["text"] as! String)
                valueDictionary.updateValue(textData, forKey: .text)
            case "picture":
                let img = value["data"] as! Dictionary<String, Any>
                let imgData = ImageData (url: img["url"] as! String, text: img["text"] as! String)
                valueDictionary.updateValue(imgData, forKey: .image)
            case "selector":
                let selector = value["data"] as! Dictionary<String, Any>
                var massVariant: [SelectorVariant] = []
                var selectedID: Int = 0
                for elem in selector {
                    if elem.key == "variants" {
                        let value = elem.value as! Array<Dictionary<String, Any>>
                        for v in value {
                            let id = v["id"] as! Int
                            let text = v["text"] as! String
                            let variant = SelectorVariant(id: id, text: text)
                            massVariant.append(variant)
                        }
                    }
                    if elem.key == "selectedId" {
                        selectedID = elem.value as! Int
                    }
                }
                let buffSelector = SelectorData(selectedId: selectedID, variants: massVariant)
                valueDictionary.updateValue(buffSelector, forKey: .selector )
            default:
                print("not found")
            }
        }
    }
}

