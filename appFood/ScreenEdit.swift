//
//  ScreenEdit.swift
//  appFood
//
//  Created by Nguyễn Thị Hạ on 05/08/2023.
//

import UIKit

class ScreenEdit: UIViewController {
    
    @IBOutlet weak var txtGiaTien: UITextField!
    @IBOutlet weak var txtLoai: UITextField!
    @IBOutlet weak var txtHang: UITextField!
    @IBOutlet weak var img: UIImageView!
    let imgPicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
        setupImg()
        print(selectedIndex)
        
    }
    func setupImg(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseImg))
        img.addGestureRecognizer(tapGesture)
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
    func setupView(){
        if let data = SessionData.share.carData{
            txtHang.text = data.hang
            txtLoai.text = data.loai
            txtGiaTien.text = data.tien
            img.image = UIImage(data: data.img)

        }
//        if let selectedCarIndex = selectedCarIndex {
//               let selectedCar = arrayCar[selectedCarIndex]
//               txtHang.text = selectedCar.hang
//               txtLoai.text = selectedCar.loai
//               txtGiaTien.text = selectedCar.tien
//               img.image = UIImage(data: selectedCar.img)
//           }
        
    }
    
    @IBAction func tapOnOk(_ sender: Any) {
        guard let hangXe = txtHang.text, let loaiXe = txtLoai.text, let giaTien = txtGiaTien.text else {
            return
        }
        let imgage: UIImage?
        if let choosAvatar = choosAvatar {
            imgage = UIImage(data: choosAvatar)
        } else {
            imgage = UIImage(data: SessionData.share.carData?.img ?? Data())
        }

        guard let imageData = imgage?.pngData() else {
            return
        }
        //        if let data = SessionData.share.carData{
        //            let image = UIImage(data: data.img)
        //            guard let imageData = image?.pngData() else{return}
        //
        //            data.hang = hangXe
        //            data.loai = loaiXe
        //            data.img = imageData
        //            data.tien = giaTien
        let updatedCar = Car(hang: hangXe, loai: loaiXe, img: imageData, tien: giaTien)
        arrayCar[selectedIndex!] = updatedCar
        let defaults = UserDefaults.standard
        let encodedData = try? JSONEncoder().encode(arrayCar)
        defaults.set(encodedData, forKey: "carArray")
        
        NotificationCenter.default.post(name: NSNotification.Name("ReloadDataNotification"), object: nil)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "screenCar")
        navigationController?.pushViewController(vc, animated: true)
        
    }
}


extension ScreenEdit: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chooseImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            choosAvatar = chooseImage.pngData()
            img.image = UIImage(data: choosAvatar!)

            }
            dismiss(animated: true)
        }
    }
