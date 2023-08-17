//
//  ScreenThem.swift
//  appFood
//
//  Created by Nguyễn Thị Hạ on 04/08/2023.
//

import UIKit
import Photos
var choosAvatar: Data?
class ScreenThem: UIViewController {
    
    @IBOutlet weak var imgXe: UIImageView!
    @IBOutlet weak var txtGiaTien: UITextField!
    @IBOutlet weak var txtLoaiXe: UITextField!
    @IBOutlet weak var txtHangXe: UITextField!
    let imgPicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImg()
        // Do any additional setup after loading the view.
    }
    func setupImg(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        
        imgXe.addGestureRecognizer(tapGesture)
    }
    @objc func chooseImage(){
        let alert = UIAlertController(title: "Choose your image", message: nil, preferredStyle: .actionSheet)
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
    
    @IBAction func addXe(_ sender: Any) {
        if txtHangXe.text == "" || txtLoaiXe.text == "" || txtGiaTien.text == "" {
            let alert = UIAlertController(title: nil, message: "Bạn cần nhập đủ thông tin", preferredStyle: .actionSheet)
//            let action = UIAlertAction(title: "OK", style: .default) { action in
//                self.dismiss(animated: true)
//            }
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
           // alert.addAction(action)
            alert.addAction(actionCancel)
            present(alert, animated: true)
            
        }
        
        guard let hangXe = txtHangXe.text, let loaiXe = txtLoaiXe.text, let giaTien = txtGiaTien.text, let imageData = choosAvatar else {
            return
        }
        let image = UIImage(data: imageData)
        guard let imageData = image?.pngData() else {
            return
        }
        let car = Car(hang: "\(hangXe)", loai: "\(loaiXe)", img: imageData, tien: "\(giaTien)")
        arrayCar.append(car)
        //luu mang
        let defaults = UserDefaults.standard
        let encodeData = try? JSONEncoder().encode(arrayCar)
        defaults.set(encodeData, forKey: "carArray")
        
        txtHangXe.text = ""
        txtLoaiXe.text = ""
        txtGiaTien.text = ""
        imgXe.image = UIImage(named: "placeholder")
        
         NotificationCenter.default.post(name: NSNotification.Name("ReloadDataNotification"), object: nil)
        navigationController?.popViewController(animated: true)
        
    }
}
extension ScreenThem: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chooseImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            choosAvatar = chooseImage.pngData()
            imgXe.image = UIImage(data: choosAvatar!)
//            guard let hangXe = txtHangXe.text, let loaiXe = txtLoaiXe.text, let giaTien = txtGiaTien.text, let imageData = choosAvatar else {
//                return
//            }
            
            dismiss(animated: true)
        }
    }
}
