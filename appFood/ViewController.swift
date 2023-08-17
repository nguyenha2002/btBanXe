//
//  ViewController.swift
//  appFood
//
//  Created by Nguyễn Thị Hạ on 03/08/2023.
//

import UIKit

var user = [User]()

class ViewController: UIViewController {

    @IBOutlet weak var adminSwitch: UISwitch!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextFeild: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func showAlert(message: String){
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    @IBAction func tapOnRegister(_ sender: Any) {
        guard let username = usernameTextFeild.text, let password = passwordTextField.text
        else{
            return
        }
        let isAdmin = adminSwitch.isOn
        if usernameTextFeild.text == ""{
            showAlert(message: "Please enter your username")
        }
        if passwordTextField.text == ""{
            showAlert(message: "Please enter your password")
        }
        if userExists(username: username){
            showAlert(message: "User already exists")
        }
        else{
            saveUser(username: username, password: password, isAdmin: adminSwitch.isOn)
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(identifier: "tabbar")
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
            usernameTextFeild.text = ""
            passwordTextField.text = ""
            
        }
    }
    
    @IBAction func tapOnLogin(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "screenLogin")
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    func userExists(username: String) -> Bool {
        if let userData = UserDefaults.standard.dictionary(forKey: "userDatakey") as? [String: Any],
           let existingUsername = userData["username"] as? String {
             return existingUsername == username
        }
        return false
    
    }
    
    func saveUser(username: String, password: String, isAdmin: Bool){
        let userData = ["username": username, "password": password, "isAdmin": isAdmin] as? [String: Any]
        UserDefaults.standard.set(userData, forKey: "userDatakey")
    }
    
}

