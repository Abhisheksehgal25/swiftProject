//
//  passwordresetViewController.swift
//  clgapp
//
//  Created by Abhishek Sehgal on 16/04/23.
//

import UIKit

class passwordresetViewController: UIViewController {

    @IBOutlet weak var retrypasswordTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var retryError: UILabel!
    @IBOutlet weak var newpasswordError: UILabel!
    @IBOutlet weak var usernameError: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    
    @IBOutlet weak var submit: UIButton!
    
    @IBAction func retrypasswordTF(_ sender: Any) {
        
    }
    @IBAction func usernameText(_ sender: Any) {
        if let username = nameTF.text
        {
            if let errorMsg = invalidUsername(username)
            {
                usernameError.text = errorMsg
                usernameError.isHidden = false
            }
            else
            {
                usernameError.isHidden = true
            }
        }
        checkForValidForm()
    }
  
    func checkForValidForm()
        {
            if usernameError.isHidden && retryError.isHidden &&      newpasswordError.isHidden
            {
                submit.isEnabled = true
            }
            else
            {
                submit.isEnabled = false
            }
        }
    func invalidUsername(_ value : String) -> String?
    {
        if value.count < 10
                {
                    return "Username must be at least 10 digits"
                }
        else if value.count > 10
        {
            return "Username can not be greater than 10 digits"
        }
        return nil
    }
    @IBAction func passwordTF(_ sender: Any) {
        
    }
    @IBAction func submit(_ sender: Any) {
        
    }
    
    
    
    override func viewDidLoad() {
        retryError.isHidden = true
        usernameError.isHidden = true
        newpasswordError.isHidden = true
        super.viewDidLoad()

    }
    
}
