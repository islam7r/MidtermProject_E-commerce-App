//
//  ProfileDetailViewController.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 22.03.25.
//

import UIKit


protocol ChangeUserInfo{
    func didChangeUserInfo(name: String, email: String)
}

class ProfileDetailViewController: UIViewController{
    @IBOutlet weak var imageBgView: UIView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var saveButton: BaseButton!
    
    var delegate: ChangeUserInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Information"
        
        imageBgView.layer.cornerRadius = imageBgView.frame.height / 2
        imageBgView.clipsToBounds = true
        
        nameTextField.text = UserManager.shared.getUser().first?.name
        emailTextField.text = UserManager.shared.getUser().first?.email
        
        let hideKeyboardTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardTapGestureRecognizer)
        
        
        
        textFieldTyping(with: nameTextField)
        textFieldTyping(with: emailTextField)
        
    }
    
    @objc private func textFieldTapped(){
        updateRegisterButton(isValid: checkValidation())
    }
    private func textFieldTyping(with textField: UITextField) {
        textField.addTarget(self, action: #selector(textFieldTapped), for: .editingChanged)
    }
    @objc private func hideKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func saveButtonClicked(_ sender: BaseButton){
        if requirementValidation() != nil{
            showAlert(title: "Error", message: requirementValidation()!)
        }else{
            UserManager.shared.removeUser()
            if let name = nameTextField.text, let email = emailTextField.text{
                delegate?.didChangeUserInfo(name: name, email: email)
                UserManager.shared.setUser(UserInfoModel(name: name, email: email))
            }
            
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}

extension ProfileDetailViewController{
    
    private func checkValidation() -> Bool{
        guard let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else { return false }
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else { return false }
        return true
    }
    
    private func requirementValidation() -> String?{
        
        if let userName = nameTextField.text{
            
            if !userName.contains( " "){
                return "Username must contain at least two words"
            }
        }
        
        if let email = emailTextField.text{
            if !email.contains( "@"), !email.contains("."){
                return "Email is not valid. Try to add '@' or '.'"
            }
        }
        
        return nil
    }
    
    private func updateRegisterButton(isValid: Bool){
        if isValid{
            saveButton.isEnabled = true
        }else{
            saveButton.isEnabled = false
        }
    }
    
    private func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}
