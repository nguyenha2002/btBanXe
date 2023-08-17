//
//  ScreenCar.swift
//  appFood
//
//  Created by Nguyễn Thị Hạ on 04/08/2023.
//

import UIKit
var arrayCar = [Car]()
var car: Car?
var selectedIndex: Int?
class ScreenCar: UIViewController {
    @IBOutlet weak var btnThem: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        bindData()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionViewData), name: NSNotification.Name("ReloadDataNotification"), object: nil)
        // Do any additional setup after loading the view.
        if let userData = UserDefaults.standard.value(forKey: "userDatakey") as? [String: Any] {
            if let username = userData["username"] as? String,
                let password = userData["password"] as? String,
                let isAdmin = userData["isAdmin"] as? Bool {
                btnThem.isHidden = !isAdmin
                // Perform any additional actions with the user data
                let defaults = UserDefaults.standard
                    if let encodedData = defaults.object(forKey: "carArray") as? Data {
                        arrayCar = try! JSONDecoder().decode([Car].self, from: encodedData)

                 }
            }
        }
    }
    func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "CarCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "carCell")
        
        let header = UINib(nibName: "CellHeader", bundle: nil)
        collectionView.register(header, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "cellHeader")
    }
    func bindData(){
        let image1 = UIImage(named: "VinFast Fadil")
        let imageData1 = image1?.pngData()
        let a1 = Car(hang: "VinFast", loai: "VinFast Fadil", img: imageData1!, tien: "212900000.1 vnd")

        let image2 = UIImage(named: "VinFast Premium")
        let imageData2 = image2?.pngData()
        let a2 = Car(hang: "VinFast", loai: "VinFast Premium", img: imageData2!, tien: "670000000.56 vnd")

        let image3 = UIImage(named: "VinFast President")
        let imageData3 = image3?.pngData()
        let a3 = Car(hang: "VinFast", loai: "VinFast President", img: imageData3!, tien: "569000000 vnd")

        let image4 = UIImage(named: "toyota-hiace")
        let imageData4 = image4?.pngData()
        let a4 = Car(hang: "Toyota", loai: "Toyota-hiace", img: imageData4!, tien: "700453333.89 vnd")

        let image5 = UIImage(named: "Mazda Cx 3 Sport Utility")
        let imageData5 = image5?.pngData()
        let a5 = Car(hang: "Mazda", loai: "Mazda Cx 3 Sport Utility", img: imageData5!, tien: "654000098.76555 vnd")

        let image6 = UIImage(named: "Mazda-MX5-RF-fiyat-16")
        let imageData6 = image6?.pngData()
        let a6 = Car(hang: "Mazda", loai: "Mazda-MX5-RF-fiyat-16", img: imageData6!, tien: "670000000.56 vcd")
        
        arrayCar.append(a1)
        arrayCar.append(a2)
        arrayCar.append(a3)
        arrayCar.append(a4)
        arrayCar.append(a5)
        arrayCar.append(a6)
        
        collectionView.reloadData()
    }
   @objc func reloadCollectionViewData() {
        collectionView.reloadData()
    }
    
    @IBAction func tapOnThem(_ sender: Any) {
       // arrayCar.removeAll()
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "screenThem")
        navigationController?.pushViewController(vc, animated: true)
    }
    

}
extension ScreenCar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carCell", for: indexPath) as! CarCell
        let data = arrayCar[indexPath.item]
        cell.lbHang.text = data.hang
        cell.img.image = UIImage(data: data.img)
        cell.lbLoai.text = data.loai
        cell.lbGiaTien.text = "\(data.tien)"
        cell.view.layer.cornerRadius = 20
        cell.view.layer.masksToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (view.frame.width - 30)/2
        return CGSize(width: w, height: w)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind{
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cellHeader", for: indexPath) as! CellHeader
            return header
        default:
            return UICollectionReusableView()
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let w = view.frame.width - 20
        return CGSize(width: w, height:30)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < arrayCar.count {
            let selectedCar = arrayCar[indexPath.item]
            car = selectedCar
            selectedIndex = indexPath.item
            let sb = UIStoryboard(name: "Storyboard", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "screenThongTinOTo")
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
