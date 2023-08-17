//
//  User.swift
//  appFood
//
//  Created by Nguyễn Thị Hạ on 03/08/2023.
//

import Foundation
import UIKit

struct User {
    let username: String
    let password: String
    let isAdmin: Bool
}

//class Car: Codable {
//    var hang = ""
//    var loai = ""
//    var img: UIImage
//    var tien = ""
//
//    init(hang: String = "", loai: String = "", img: UIImage, tien: String = "") {
//        self.hang = hang
//        self.loai = loai
//        self.img = img
//        self.tien = tien
//    }
//}
class Car: Codable {
    var hang: String
    var loai: String
    var img: Data
    var tien: String
    
    init(hang: String = "", loai: String = "", img: Data, tien: String = "") {
        self.hang = hang
        self.loai = loai
        self.img = img
        self.tien = tien
    }
    
    var image: UIImage? {
        return UIImage(data: img)
    }
    
    enum CodingKeys: String, CodingKey {
        case hang
        case loai
        case img
        case tien
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hang = try container.decode(String.self, forKey: .hang)
        loai = try container.decode(String.self, forKey: .loai)
        img = try container.decode(Data.self, forKey: .img)
        tien = try container.decode(String.self, forKey: .tien)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hang, forKey: .hang)
        try container.encode(loai, forKey: .loai)
        try container.encode(img, forKey: .img)
        try container.encode(tien, forKey: .tien)
    }
}

class SessionData{
    static let share = SessionData()
    var carData: Car?
}
