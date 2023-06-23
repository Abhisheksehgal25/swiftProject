

import UIKit
import LocalAuthentication
import Firebase

class ViewController: UIViewController {
    
   
    @IBOutlet weak var CollectionView: UICollectionView!
    @IBOutlet weak var sessionText: UITextField!
    @IBOutlet weak var instituteText: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var login: UIButton!
    @IBOutlet weak var passwordError: UILabel!
    @IBOutlet weak var usernameError: UILabel!
    @IBOutlet weak var instituteError: UILabel!
    @IBOutlet weak var sessionError: UILabel!
    
    @IBOutlet weak var pageController: UIPageControl!
    var institutePickerView = UIPickerView()
    var sessionPickerView = UIPickerView()
    
    let institute = ["CUSMS","CUIT","CSPC","CSCA","CCP","PHD","GESE","CBS","CCSM","CSHSU","CSHSU","CCSRM","CCAE"]
    let session = ["2005-06","2006-07","2007-08","2008-09","2009-10","2010-11","2011-12","2012-13","2013-14","2014-15","2015-16","2016-17","2017-18","2018-019","20019-20","2021-22","2022-23"]
   
    
    var currentcellIndex = 0
    var imgScroll = ["clg1","clg2","clg3","clg4"]
    var timer:Timer?
    @IBAction func passwordTF(_ sender: Any) {
     
        if let password = password.text
        {
            if let errorMsg = invalidPassword(password)
            {
                passwordError.text = errorMsg
                passwordError.isHidden = false
            }
            else
            {
                passwordError.isHidden = true
            }
        }
        checkForValidForm()
    }
    func invalidPassword(_ value : String) -> String?
    {
        if value.count < 8
        {
            return "Password must be at least 8 characters"
        }
        return nil
    }
    @IBAction func usernameTF(_ sender: Any) {
        if let username = userNameTextField.text
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
    func invalidUsername(_ value : String) -> String?
    {
       // validate email
        return nil
    }
    
    @IBAction func login(_ sender: Any) {
        
        if instituteText.text!.isEmpty {
            Alert(titlemsg: "ERROR!", msg: "INSTITUTE NOT FOUND")

        }
        else if sessionText.text!.isEmpty {
            Alert(titlemsg: "ERROR!", msg: "SESSION NOT FOUND")

        }
        else if userNameTextField.text != "" && password.text != ""
        {
            let Emaildata = self.userNameTextField.text
            Auth.auth().signIn(withEmail: userNameTextField.text! , password: password.text!){ (authdata ,error) in
                if error != nil {
                    self.Alert(titlemsg: "ERROR", msg: "USERNAME OR PASSWORD NOT FOUND")
                }
            else
                {
                        let authContext = LAContext()
                        
                        var error: NSError?
                    

                        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){
                            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { (success, error) in
                                if success == true {
                                    //successful auth
                                    DispatchQueue.main.async {
                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as! SecondViewController
                                        vc.data = Emaildata!
                                        self.navigationController?.pushViewController(vc, animated: true)
                                     //   self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                                    }
                                }
                                else {
                                    DispatchQueue.main.async {
                                        self.Alert(titlemsg: "ERROR!", msg: "SESSION NOT FOUND")
                                    }
                                }
                            }
                            
                            
                        }

                self.reset()
                }
            }
        }
      
    }
    
    @IBAction func forgetPassword(_ sender: Any) {
        reset()
    }
    func checkForValidForm()
    {
        if usernameError.isHidden && passwordError.isHidden &&  instituteError.isHidden && sessionError.isHidden
        {
            login.isEnabled = true
        }
        else
        {
            login.isEnabled = false
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognize = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognize)
        reset()
        
        
        password.isSecureTextEntry = true
        instituteText.inputView = institutePickerView
        sessionText.inputView = sessionPickerView
        
        userNameTextField.placeholder = "Enter UserName"
        password.placeholder = "Enter Password"
        instituteText.placeholder = "Select Institute"
        sessionText.placeholder = "Select Session"
        
       // userNameTextField.delegate = self
        institutePickerView.delegate = self
        institutePickerView.dataSource = self
        sessionPickerView.delegate = self
        sessionPickerView.dataSource = self
        
        institutePickerView.tag = 1
        sessionPickerView.tag = 2
        
        
        // timer for image scroll
        pageController.numberOfPages = imgScroll.count
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
         
    }
    
    @objc func slideToNext(){
        
        if currentcellIndex < imgScroll.count-1
        {
            currentcellIndex = currentcellIndex + 1
        }
        
        else
        {
            currentcellIndex = 0
        }
        pageController.currentPage = currentcellIndex
        CollectionView.scrollToItem(at: IndexPath(item: currentcellIndex, section: 0), at: .right, animated: true)
    }
    
    
    @objc func hideKeyboard(){
        view.endEditing(true)
        
    }
    func reset(){
        usernameError.isHidden = true
        passwordError.isHidden = true
        instituteError.isHidden = true
        sessionError.isHidden = true
        login.isEnabled = false
        userNameTextField.text = ""
        password.text = ""
        instituteText.text = ""
        sessionText.text = ""
        
    }
    func Alert(titlemsg: String ,msg : String  )
    {   let alert = UIAlertController(title: titlemsg , message: msg , preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in
        }
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UIPickerViewDelegate , UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return institute.count
        case 2:
            return session.count
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return institute[row]
        case 2:
            return session[row]
        default:
            return "Data not found"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            instituteText.text = institute[row]
            //instituteText.resignFirstResponder()
        case 2:
            sessionText.text = session[row]
            //sessionText.resignFirstResponder()
        default:
            return
        }
    }


}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgScroll.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell = CollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MYCollectionViewCell
        Cell.image.image = UIImage(named: imgScroll[indexPath.row])
        return Cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: CollectionView.frame.width, height: CollectionView.frame.height)
    }

}

