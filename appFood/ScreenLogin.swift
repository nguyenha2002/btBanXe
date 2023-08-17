//
//  ScreenLogin.swift
//  appFood
//
//  Created by Nguyễn Thị Hạ on 03/08/2023.
//

import UIKit

class ScreenLogin: ViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        if let userData = UserDefaults.standard.value(forKey: "userDatakey") as? [String: Any],
                   let username = userData["username"] as? String,
                   let password = userData["password"] as? String,
                   username == txtUsername.text,
                   password == txtPassword.text {
                  
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "tabbar")
           // vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
            txtUsername.text = ""
            txtPassword.text = ""
               } else {
                   showAlert(message: "Đăng nhập không thành công")
               }
    }
    
}
