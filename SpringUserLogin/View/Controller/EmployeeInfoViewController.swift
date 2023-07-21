//
//  EmployeeInfoViewController.swift
//  SpringUserLogin
//
//  Created by MD Faizan on 20/07/23.
//

import UIKit

class EmployeeInfoViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextFeild: UITextField!
    @IBOutlet weak var ageTextFeild: UITextField!
    @IBOutlet weak var addressTextFeild: UITextField!
    @IBOutlet weak var cityTextFeild: UITextField!
    
    
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var ageError: UILabel!
    @IBOutlet weak var addressError: UILabel!
    @IBOutlet weak var cityError: UILabel!
    
    @IBOutlet weak var submitInfoButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    func resetForm() {
        
        submitInfoButton.isEnabled = false
        
        nameError.isHidden = false
        ageError.isHidden = false
        addressError.isHidden = false
        cityError.isHidden = false
        
        
        
        nameTextFeild.text = ""
        ageTextFeild.text = ""
        addressTextFeild.text = ""
        cityTextFeild.text = ""
        
        nameError.text = "Require"
        ageError.text = "Require"
        addressError.text = "Require"
        cityError.text = "Require"
        
    }
    
    
    
    
    @IBAction func nameChanged(_ sender: UITextField) {
        
        if let name = nameTextFeild.text {
            
            if let errorMassege = invalidName(name){
                
                nameError.text = errorMassege
                nameError.isHidden = false
            }else{
                nameError.isHidden = true
            }
            
        }
        
    }
    
    
    func invalidName(_ value:String) -> String? {
        
        let reqularExpression = "^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value)
        {
            return "Invalid UserName"
        }
        
        return nil
        
        
    }
    
    
    @IBAction func ageChanged(_ sender: UITextField) {
        
        if let age = ageTextFeild.text {
            
            if let errorMassege = invalidAge(age){
                
                ageError.text = errorMassege
                ageError.isHidden = false
            }else{
                ageError.isHidden = true
            }
            
        }
        
    }
    
    
    func invalidAge(_ value:String) -> String? {
        
        let ageData = Int(value) ?? 0
        if !(ageData < 120 && ageData  > 1) {
            return "type correct input"
        }
        
        return nil
        
    }
    
    
    
    
    
    
    @IBAction func addressChanged(_ sender: UITextField) {
        
        if let age = addressTextFeild.text {
            
            if let errorMassege = invalidAge(age){
                
                ageError.text = errorMassege
                ageError.isHidden = false
            }else{
                ageError.isHidden = true
            }
            
        }
        
    }
    
    
    func invalidAddress(_ value:String) -> String? {
        
        let reqularExpression = "^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value)
        {
            return "Invalid address"
        }
        
        return nil
        
    }
    
    
    
    
    @IBAction func cityChanged(_ sender: UITextField) {
        
        if let age = cityTextFeild.text {
            
            if let errorMassege = invalidCity(age){
                
                cityError.text = errorMassege
                cityError.isHidden = false
            }else{
                cityError.isHidden = true
            }
            
        }
        
    }
    
    func invalidCity(_ value:String) -> String? {
        
        let reqularExpression = "^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", reqularExpression)
        if !predicate.evaluate(with: value)
        {
            return "Invalid city"
        }
        
        return nil
        
    }
    
    
}
