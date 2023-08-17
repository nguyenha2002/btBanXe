//
//  MotorbikeCell.swift
//  appFood
//
//  Created by Nguyễn Thị Hạ on 06/08/2023.
//

import UIKit

class MotorbikeCell: UITableViewCell {

    @IBOutlet weak var lbGiaMotorbike: UILabel!
    @IBOutlet weak var lbLoaiMotorbike: UILabel!
    @IBOutlet weak var imgMotorbike: UIImageView!
    @IBOutlet weak var lbHangMotorbike: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
