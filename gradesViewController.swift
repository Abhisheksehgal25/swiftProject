//
//  gradesViewController.swift
//  CollageApp
//
//  Created by Abhishek Sehgal on 10/05/23.
//

import UIKit
import Firebase
import FirebaseDatabase


class gradesViewController: UIViewController {
    
    
    var documentIdArray = [String]()
    @IBOutlet weak var firstSem: UILabel!
    @IBOutlet weak var secondSem: UILabel!
    @IBOutlet weak var thirdSem: UILabel!
    @IBOutlet weak var fourthSem: UILabel!
    @IBOutlet weak var fifthSem: UILabel!
    @IBOutlet weak var sixthSem: UILabel!
    @IBOutlet weak var seventhSem: UILabel!
    @IBOutlet weak var eigthSem: UILabel!
    @IBOutlet weak var CGPA: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func getResultClicked(_ sender: Any) {
        
        
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Abhishek_Result").addSnapshotListener { [self] (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
                        
                        var array = [String]()
                        array = document.get("score") as! [String]
                        
                        firstSem.text = array[0]
                        secondSem.text = "2nd sem : " + array[1]
                        thirdSem.text = "3rd sem : " + array[2]
                        fourthSem.text = "4th sem : " + array[3]
                        fifthSem.text = "5th sem : " + array[4]
                        sixthSem.text = "6st sem : " + array[5]
                        seventhSem.text = "7th sem : " + array[6]
                        eigthSem.text = "8th sem : " + array[7]
                        
                        print(firstSem.text)
//                        let firstnum = Int(firstSem.text!)
//                        print(firstnum)
                        
                        if let firstnum = Int(array[0]){
                            if  let secndnum = Int(array[1]) {
                                
                               let ans = firstnum * secndnum
                                
                                print(ans)
                            }
                        }
                       
                        if let cgpa = document.get("cgpa") as? String {
                            CGPA.text = "OVERALL CGPA: " + cgpa
                            print(CGPA.text)
                            let myInt3 = (cgpa as NSString).integerValue
                            print(myInt3)
                        }
                        
                
                    }
                    
                }
            }
        }
    }
    
    
}
    
    
