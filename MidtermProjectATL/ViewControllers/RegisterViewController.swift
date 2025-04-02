//
//  RegisterViewController.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 20.03.25.
//

import UIKit



class RegisterViewController: UIViewController{
    @IBOutlet weak var usernameTextField: BaseTextField!
    @IBOutlet weak var emailTextField: BaseTextField!
    @IBOutlet weak var passwordTextField: BaseTextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let unhideButton = UIButton(type: .system)
    var isUnhiddenPassword: Bool = false
    
    var userInfoModel: UserInfoModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        unhideButton.addTarget(self, action: #selector(unhideButtonTapped), for: .touchUpInside)
        unhidePassword()
        updateRegisterButton(isValid: checkValidation())
        let hideKeyboardTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(hideKeyboardTapGestureRecognizer)
        
        textFieldTyping(with: usernameTextField)
        textFieldTyping(with: emailTextField)
        textFieldTyping(with: passwordTextField)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateRegisterButton(isValid: checkValidation())
        textFieldTyping(with: usernameTextField)
        textFieldTyping(with: emailTextField)
        textFieldTyping(with: passwordTextField)

    }
    
    @objc private func textFieldTapped(){
        updateRegisterButton(isValid: checkValidation())
    }
    @objc private func hideKeyboard(){
        view.endEditing(true)
    }
    @objc private func unhideButtonTapped(){
        isUnhiddenPassword.toggle()
        unhidePassword()
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        if requirementValidation() != nil{
            showAlert(title: "Error", message: requirementValidation()!)
        }
        if let vc = storyboard?.instantiateViewController(withIdentifier: "BaseTabBar") as? BaseTabBar {
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            
            self.present(vc, animated: true)
        }
        
        if let userName = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text {
          
            
            UserManager.shared.setUser(UserInfoModel(name: userName, email: email, password: password))
            
        }
        
        
    }
}


extension RegisterViewController{
    
    private func checkValidation() -> Bool{
        guard let name = usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty else { return false }
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else { return false }
        guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !password.isEmpty else { return false }
        return true
    }
    
    private func requirementValidation() -> String?{
        
        if let userName = usernameTextField.text{
            
            if !userName.contains( " "){
                return "Username must contain at least two words"
            }
        }
        
        if let email = emailTextField.text{
            if !email.contains( "@"), !email.contains("."){
                return "Email is not valid. Try to add '@' or '.'"
            }
        }
        
        if let password = passwordTextField.text{
            if password.count < 6{
                return "Password must be at least 6 characters long"
            }
        }
        return nil
    }
    
    private func updateRegisterButton(isValid: Bool){
        if isValid{
            registerButton.isEnabled = true
        }else{
            registerButton.isEnabled = false
        }
    }
    
    private func showAlert(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    private func unhidePassword(){
        unhideButton.setImage(UIImage(systemName: isUnhiddenPassword ? "eye" : "eye.slash" ), for: .normal)
        unhideButton.tintColor = UIColor.black.withAlphaComponent(0.5)
        unhideButton.addTarget(self, action: #selector(unhideButtonTapped), for: .touchUpInside)
        unhideButton.frame = .init(x: 0, y: 0, width: 20, height: 20)
        passwordTextField.rightView = unhideButton
        passwordTextField.rightViewMode = .always
        
        if isUnhiddenPassword{
            passwordTextField.isSecureTextEntry = false
        }else{
            passwordTextField.isSecureTextEntry = true
        }
        
    }
    
    private func textFieldTyping(with textField: UITextField) {
        textField.addTarget(self, action: #selector(textFieldTapped), for: .editingChanged)
    }
    
    
}
