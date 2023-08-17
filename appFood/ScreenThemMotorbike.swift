//
//  ScreenThemMotorbike.swift
//  appFood
//
//  Created by Nguyễn Thị Hạ on 06/08/2023.
//

import UIKit

class ScreenThemMotorbike: UIViewController {
    let imgPicker = UIImagePickerController()
    @IBOutlet weak var imgMotor: UIImageView!
    @IBOutlet weak var txtGiaMotor: UITextField!
    @IBOutlet weak var txtLoaiMotor: UITextField!
    @IBOutlet weak var txtHangMotor: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImg()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTapOnAdd(_ sender: Any) {
        if txtHangMotor.text == "" || txtLoaiMotor.text == "" || txtGiaMotor.text == "" {
            let alert = UIAlertController(title: nil, message: "Bạn cần nhập đủ thông tin", preferredStyle: .actionSheet)
//            let action = UIAlertAction(title: "OK", style: .default) { action in
//                self.dismiss(animated: true)
//            }
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
            //alert.addAction(action)
            alert.addAction(actionCancel)
            present(alert, animated: true)
            
        }
        
        guard let hangMotor1 = txtHangMotor.text, let loaiMotor1 = txtLoaiMotor.text, let giaMotor1 = txtGiaMotor.text, let imageData = choosAvatar else {
            return
        }
        let img = UIImage(data: imageData)
        guard let imageData = img?.pngData() else {
            return
        }
        let motor = Motorbike(hangMotor: hangMotor1, loaiMotor: loaiMotor1, tienMotor: giaMotor1, imgMotor: imageData)
        arrayMotorbike.append(motor)
        
        let defaults = UserDefaults.standard
        let encodeData = try? JSONEncoder().encode(arrayMotorbike)
        defaults.set(encodeData, forKey: "motorArray")
        
        txtGiaMotor.text = ""
        txtHangMotor.text = ""
        txtLoaiMotor.text = ""
        imgMotor.image = UIImage(named: "placeholder")
        
        NotificationCenter.default.post(name: Notification.Name("ReloadDataNotification"), object: nil)
        navigationController?.popViewController(animated: true)
        
    }
    func setupImg(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imgMotor.addGestureRecognizer(tapGesture)
    }
    @objc func chooseImage(){
        let alert = UIAlertController(title: "Choose your Image", message: nil, preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Photo Library", style: .default) { action in
            self.imgPicker.sourceType = .photoLibrary
            self.imgPicker.delegate = self
            self.present(self.imgPicker, animated: true)
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }

}
extension ScreenThemMotorbike: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chooseImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            choosAvatar = chooseImage.pngData()
            imgMotor.image = UIImage(data: choosAvatar!)
            dismiss(animated: true)
        }
    }
}
