//
//  NetworkBookmark.swift
//  MachumCafe
//
//  Created by HannaJeon on 2017. 4. 28..
//  Copyright © 2017년 Febrix. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkBookmark {
    
    private static let url = URLpath.getURL()
    
    // MARK: 즐겨찾기 목록 데이터모델에 저장
    static func getMyBookmark(userId: String, callback: @escaping (_ message: Bool, _ modelCafe: [ModelCafe], _ userBookmark: [String]) -> Void) {
        var modelCafe = [ModelCafe]()
        
        Alamofire.request("\(url)/api/v1/bookmark/\(userId)").responseJSON { (response) in
            let res = JSON(data: response.data!)
            let message = res["message"].boolValue
            let cafes = res["cafe"].arrayValue
            
            let _ = cafes.map {
                let cafe = $0.dictionaryValue
                
                if let id = cafe["_id"]?.stringValue,
                let name = cafe["name"]?.stringValue,
                let address = cafe["address"]?.stringValue,
                let latitude = cafe["latitude"]?.doubleValue,
                let longitude = cafe["longitude"]?.doubleValue,
                let category = cafe["category"]?.arrayValue.map({ $0.stringValue }),
                let imagesURL = cafe["imagesURL"]?.arrayValue.map({ $0.stringValue }) {
                    let tel = cafe["tel"]?.stringValue
                    let hours = cafe["hours"]?.stringValue
                    let menu = cafe["menu"]?.stringValue
                    modelCafe.append(ModelCafe(id: id, name: name, tel: tel, address: address, hours: hours, latitude: latitude, longitude: longitude, category: category, menu: menu, imagesURL: imagesURL))
                }
            }
            let userBookmark = res["userBookmark"].arrayValue.map{ $0.stringValue }
            callback(message, modelCafe, userBookmark)
        }
    }

    // MARK: 즐겨찾기 추가 & 삭제
    static func setMyBookmark(userId: String, cafeId: String, callback: @escaping (_ message: Bool, _ description: String) -> Void) {
        let parameters : Parameters = ["cafeId" : cafeId]
        
        Alamofire.request("\(url)/api/v1/bookmark/\(userId)", method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON { (response) in
            var message = Bool()
            var description = String()
            
            let res = JSON(data: response.data!).dictionary
            if let resMessage = res?["message"]?.boolValue,
            let resDescription = res?["description"]?.stringValue {
                message = resMessage
                description = resDescription
            }
            callback(message, description)
        }
    }
    
}
