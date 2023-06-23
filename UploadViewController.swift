//
//  UploadViewController.swift
//  CollageApp
//
//  Created by Abhishek Sehgal on 13/05/23.
//

import UIKit
import Firebase

class UploadViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var captionView: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var upload: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let gestureRecognize = UITapGestureRecognizer(target: self, action: #selector(chooseImg))
        imageView.addGestureRecognizer(gestureRecognize)
       
    }
    @objc func chooseImg(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController , didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true , completion: nil)
    }
    func makeAlert(titleInput: String, messageInput: String) {
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
           let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
           alert.addAction(okButton)
           self.present(alert, animated: true, completion: nil)
       }
    @IBAction func uploadClicked(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let mediaFolder = storageReference.child("media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5)
        {
            let uuid = UUID().uuidString
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data , metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                }else
                {
                    imageReference.downloadURL { (url, error) in
                        
                        if error == nil {
                            let imageUrl = url?.absoluteString
                         
                            
                          //DATABASE
                            
                          let firestoreDatabase = Firestore.firestore()
                            
                          var firestoreReference : DocumentReference? = nil
                            
                          let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.captionView.text!,"date" : FieldValue.serverTimestamp() , "likes" : 0 ] as [String : Any]

                        firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                     if error != nil {
                                                               
                                      self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error")
                                                               
                                     }
                                      else {
                                                                                           
                                             self.imageView.image = UIImage(named: "select.png")
                                             self.captionView.text = ""
                                             self.tabBarController?.selectedIndex = 0
                                                                                           
                                           }
                            })
                        }
                    }
                        
                    
                }
            }
        }
        
    }
    
    

}

