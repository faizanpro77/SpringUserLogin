//
//  LoginViewController.swift
//  SpringUserLogin
//
//  Created by MD Faizan on 20/07/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var passwordError: UILabel!
    
    
    
    @IBOutlet weak var logginButton: UIButton!
    
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .gray
        return indicator
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoader()
        // Do any additional setup after loading the view.
        if isUserLoggedIn() {
            //Navigation to the main page
            
            self.navigateToHomeController()
            
        }
        //resetForm()
        //Setting default id password for easy use
        nameTextField.text = "eve.holt@reqres.in"
        passwordTextField.text = "12345sdjkU"
        nameError.isHidden = true
        passwordError.isHidden = true
    }
    
    private func setupLoader() {
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.view.isUserInteractionEnabled = false
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    func navigateToHomeController() {
        DispatchQueue.main.async {
            let EmployeeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(EmployeeVC, animated: true)
            
        }
    }
    
    
    func isUserLoggedIn() -> Bool {
        guard let token = UserDefaults.standard.string(forKey: token),
              !token.isEmpty else {
            return false
        }
        return true
    }
    
    func resetForm() {
        
        logginButton.isEnabled = false
        
        nameError.isHidden = false
        passwordError.isHidden = false
        
        
        nameTextField.text = ""
        passwordTextField.text = ""
        
        nameError.text = "Require"
        passwordError.text = "Require"
        
    }
    
    
    
    @IBAction func nameChanged(_ sender: UITextField) {
        
        if let name = nameTextField.text {
            
            if let errorMassege = isValidEmail(name) {
                
                nameError.text = errorMassege
                nameError.isHidden = false
            }else{
                nameError.isHidden = true
            }
            
        }
        
        checkForValidForm()
        
        
    }
    
    func isValid(_ value:String) -> String? {
        value.isEmpty ? "Invalid UserName" : nil
    }
    
    func isValidEmail(_ value:String) -> String? {
        
        let reqularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value)
        {
            return "Invalid Email Address"
        }
        
        return nil
    }
    
    
    
    @IBAction func passwordChanged(_ sender: UITextField) {
        
        
        if let password = passwordTextField.text {
            
            if let errorMassege = invalidPassword(password){
                
                passwordError.text = errorMassege
                passwordError.isHidden = false
            }else{
                passwordError.isHidden = true
            }
            
        }
        
        checkForValidForm()
    }
    
    
    
    
    func invalidPassword(_ value:String) -> String? {
        
        if value.count < 8 {
            return "password must contain at least 8 digits"
        }
        
        if containsDigit(value)
        {
            return "Password must contain at least 1 digit"
        }
        
        if containsLowerCase(value)
        {
            return "Password must contain at least 1 lowercase"
        }
        if containsUpperCase(value)
        {
            return "Password must contain at least 1 uppercase"
        }
        
        return nil
    }
    
    func containsLowerCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsUpperCase(_ value: String) -> Bool
    {
        let reqularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    func containsDigit(_ value: String) -> Bool
    {
        let reqularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        return !predicate.evaluate(with: value)
    }
    
    
    func checkForValidForm(){
        if nameError.isHidden && passwordError.isHidden {
            logginButton.isEnabled = true
        }else {
            logginButton.isEnabled = false
        }
        
    }
    
    
    @IBAction func submitAction(_ sender: UIButton) {
        self.showLoader()
        NetworkManager.shared.loginWith(email: nameTextField.text ?? defaultEmail, password: passwordTextField.text ?? defaultPassword) { result in
            self.hideLoader()
            switch result {
            case .success(let response):
                UserDefaults.standard.set(response.token, forKey: token)
                print("API call successful. Response: \(response.token)")
                DispatchQueue.main.async {
                    self.resetForm()
                }
                
                self.navigateToHomeController()
                
            case .failure(let error):
                print("Error occurred: \(error)")
            }
        }
        
        
    }
}

