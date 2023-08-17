//
//  ScreenMotobike.swift
//  appFood
//
//  Created by Nguyễn Thị Hạ on 04/08/2023.
//

import UIKit
var motor: Motorbike?
var motorIndex: Int?
var arrayMotorbike = [Motorbike]()
class ScreenMotorbike: UIViewController {
    var hasAddedNewData = false
    @IBOutlet weak var btnThem: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTableView()
        bindDataMotor()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableViewData), name: NSNotification.Name("ReloadDataNotification"), object: nil)
        
        if let userData = UserDefaults.standard.value(forKey: "userDatakey") as? [String: Any]{
            if let username = userData["username"] as? String,
               let password = userData["password"] as? String,
               let isAdmin = userData["isAdmin"] as? Bool {
                btnThem.isHidden = !isAdmin
                let defaults = UserDefaults.standard
                if let encodeData = defaults.object(forKey: "motorArray") as? Data{
                    arrayMotorbike = try! JSONDecoder().decode([Motorbike].self, from: encodeData)
                }
            }
        }
    }
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "MotorbikeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "motorbikeCell")
        
    }
    @objc func reloadTableViewData(){
        tableView.reloadData()
    }
//    func bindDataMotor(){
//        let image = UIImage(named: "wave")
//        let image1 = image?.pngData()
//        let a1 = Motorbike(hangMotor: "HONDA", loaiMotor: "Wave alpha", tienMotor: "17,032,400 VND", imgMotor: image1!)
//
//        arrayMotorbike.append(a1)
//        tableView.reloadData()
//    }
    func bindDataMotor(){
       
            if hasAddedNewData {
                return
            }
            arrayMotorbike.removeAll()
            
            let image = UIImage(named: "wave")
            let image1 = image?.pngData()
            let a1 = Motorbike(hangMotor: "HONDA", loaiMotor: "Wave alpha", tienMotor: "17,032,400 VND", imgMotor: image1!)
            
            arrayMotorbike.append(a1)
            tableView.reloadData()
        }
    

    @IBAction func btnThemMotorbike(_ sender: Any) {
        hasAddedNewData = true
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "screenThemMotorbike")
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
extension ScreenMotorbike: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMotorbike.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "motorbikeCell") as? MotorbikeCell
        let data = arrayMotorbike[indexPath.row]
        
        cell?.lbHangMotorbike.text = data.hangMotor
        cell?.lbLoaiMotorbike.text = data.loaiMotor
        cell?.lbGiaMotorbike.text = data.tienMotor
        cell?.imgMotorbike.image = UIImage(data: data.imgMotor)
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 195
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        motor = arrayMotorbike[indexPath.row]
        motorIndex = indexPath.row
        
        let sb = UIStoryboard(name: "Storyboard", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "screenThongTinMotor")
        navigationController?.pushViewController(vc, animated: true)
    }
}
