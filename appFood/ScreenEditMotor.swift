//
//  ScreenEditMotor.swift
//  appFood
//
//  Created by Nguyễn Thị Hạ on 07/08/2023.
//

import UIKit

class ScreenEditMotor: UIViewController {
    let imgPicker = UIImagePickerController()
    
    @IBOutlet weak var txtGiaMotor: UITextField!
    @IBOutlet weak var txtLoaiMotor: UITextField!
    @IBOutlet weak var txtHangMotor: UITextField!
    @IBOutlet weak var imgMotor: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupImg()
        // Do any additional setup after loading the view.
        
    }
    func setupView(){
        txtGiaMotor.text = motor?.tienMotor
        txtHangMotor.text = motor?.hangMotor
        txtLoaiMotor.text = motor?.loaiMotor
        imgMotor.image = UIImage(data: motor!.imgMotor)
    }
    func setupImg(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImg))
        imgMotor.addGestureRecognizer(tapGesture)
    }
    @objc func chooseImg(){
        let alert = UIAlertController(title: "Choose image", message: nil, preferredStyle: .actionSheet)
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
    @IBAction func btnTapOnOk(_ sender: Any) {
        guard let hangMotor = txtHangMotor.text, let loaiMotor = txtLoaiMotor.text, let giaMotor = txtGiaMotor.text else{return}
        let image:UIImage?
        if let chooseAvatar = choosAvatar{
            image = UIImage(data: chooseAvatar)
        }else{
            image = UIImage(data: motor!.imgMotor ?? Data())
        }
        guard let imageData = image?.pngData() else{
            return
        }
        let updateMotor = Motorbike(hangMotor: hangMotor, loaiMotor: loaiMotor, tienMotor: giaMotor, imgMotor: imageData)
        arrayMotorbike[motorIndex!] = updateMotor
        
        let defaults = UserDefaults.standard
        let encodeData = try? JSONEncoder().encode(arrayMotorbike)
        defaults.set(encodeData, forKey: "motorArray")
        NotificationCenter.default.post(name: Notification.Name("ReloadDataNotification"), object: nil)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "screenMotorbike")
        navigationController?.pushViewController(vc, animated: true)
        
    }
    

}
extension ScreenEditMotor: UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chooseImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            choosAvatar = chooseImage.pngData()
            imgMotor.image = UIImage(data: choosAvatar!)
        }
        dismiss(animated: true)
    }
}
