//
//  ScreenThongTinOTo.swift
//  appFood
//
//  Created by Nguyễn Thị Hạ on 05/08/2023.
//

import UIKit


class ScreenThongTinOTo: UIViewController {
    
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var txtgia: UITextField!
    @IBOutlet weak var txtloai: UITextField!
    @IBOutlet weak var txthang: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        // Do any additional setup after loading the view.
        
        if let userData = UserDefaults.standard.value(forKey: "userDatakey") as? [String: Any] {
            if let username = userData["username"] as? String,
               let password = userData["password"] as? String,
               let isAdmin = userData["isAdmin"] as? Bool {
                btnEdit.isHidden = !isAdmin
                btnRemove.isHidden = !isAdmin
                txtgia.isUserInteractionEnabled = false
                txthang.isUserInteractionEnabled = false
                txtloai.isUserInteractionEnabled = false
            }
        }
    }
    func setupView(){
        imgCar.image = UIImage(data: car!.img)
        txtgia.text = car?.tien
        txthang.text = car?.hang
        txtloai.text = car?.loai
    }
    
    
    @IBAction func tapOnEdit(_ sender: Any) {
        if let image = imgCar.image,
           let imageData = image.pngData() { // hoặc có thể dùng image.jpegData(compressionQuality:) nếu muốn chuyển thành JPEG
            let dataCar = Car(hang: txthang.text ?? "", loai: txtloai.text ?? "", img: imageData, tien: txtgia.text ?? "")
            SessionData.share.carData = dataCar
            let sb = UIStoryboard(name: "Storyboard", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "screenEdit")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func tapOnRemove(_ sender: Any) {
        arrayCar.remove(at: selectedIndex!)
        let defaults = UserDefaults.standard
        let encodedData = try? JSONEncoder().encode(arrayCar)
        defaults.set(encodedData, forKey: "carArray")
        
        NotificationCenter.default.post(name: NSNotification.Name("ReloadDataNotification"), object: nil)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "screenCar")
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
