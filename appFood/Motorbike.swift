//
//  Motorbike.swift
//  appFood
//
//  Created by Nguyễn Thị Hạ on 06/08/2023.
//

import Foundation
import UIKit

class Motorbike: Codable {
    var hangMotor: String
    var loaiMotor: String
    var tienMotor: String
    var imgMotor: Data
    init(hangMotor: String, loaiMotor: String, tienMotor: String, imgMotor: Data) {
        self.hangMotor = hangMotor
        self.loaiMotor = loaiMotor
        self.tienMotor = tienMotor
        self.imgMotor = imgMotor
    }
    var imageMotor: UIImage? {
        return UIImage(data: imgMotor)
    }
    enum CodingKeys: String, CodingKey {
        case hangMotor
        case loaiMotor
        case imgMotor
        case tienMotor
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hangMotor = try container.decode(String.self, forKey: .hangMotor)
        loaiMotor = try container.decode(String.self, forKey: .loaiMotor)
        imgMotor = try container.decode(Data.self, forKey: .imgMotor)
        tienMotor = try container.decode(String.self, forKey: .tienMotor)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hangMotor, forKey: .hangMotor)
        try container.encode(loaiMotor, forKey: .loaiMotor)
        try container.encode(imgMotor, forKey: .imgMotor)
        try container.encode(tienMotor, forKey: .tienMotor)
    }
    
}
