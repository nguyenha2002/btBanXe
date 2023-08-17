//
//  ScreenThongTinMotor.swift
//  appFood
//
//  Created by Nguyễn Thị Hạ on 06/08/2023.
//

import UIKit

class ScreenThongTinMotor: UIViewController {
    
    @IBOutlet weak var btnXoaMotor: UIButton!
    @IBOutlet weak var btnSuaMotor: UIButton!
    @IBOutlet weak var txtGiaMotor: UITextField!
    @IBOutlet weak var txtLoaiMotor: UITextField!
    @IBOutlet weak var txtHangMotor: UITextField!
    @IBOutlet weak var imgMotor: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
        if let userData = UserDefaults.standard.value(forKey: "userDatakey") as? [String: Any]{
           if let isAdmin = userData["isAdmin"] as? Bool {
               if !isAdmin {
                   btnSuaMotor.isHidden = true
                   btnXoaMotor.isHidden = true
               }
                   txtGiaMotor.isUserInteractionEnabled = false
                   txtHangMotor.isUserInteractionEnabled = false
                   txtLoaiMotor.isUserInteractionEnabled = false
           }
        }
    }
    func setupView(){
        txtGiaMotor.text = motor?.tienMotor
        txtHangMotor.text = motor?.hangMotor
        txtLoaiMotor.text = motor?.loaiMotor
        imgMotor.image = UIImage(data: motor!.imgMotor)
    }
    
    @IBAction func btnTapOnSua(_ sender: Any) {
        let sb = UIStoryboard(name: "Storyboard", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "screenEditMotor")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnTapOnXoa(_ sender: Any) {
        arrayMotorbike.remove(at: motorIndex!)
        let defaults = UserDefaults.standard
        let encodeData = try? JSONEncoder().encode(arrayMotorbike)
        defaults.set(encodeData, forKey: "motorArray")
        NotificationCenter.default.post(name: Notification.Name("ReloadDataNotification"), object: nil)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "screenMotorbike")
        navigationController?.pushViewController(vc, animated: true)
    }
}
