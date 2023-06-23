//
//  FeedCell.swift
//  CollageApp
//
//  Created by Abhishek Sehgal on 14/05/23.
//

import UIKit
import Firebase

class FeedCell: UITableViewCell {

    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var documentIdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func likeBtnClicked(_ sender: Any) {
        
        let fireStoreDatabase = Firestore.firestore()
                
                if let likeCount = Int(likeLabel.text!) {
                    
                    let likeStore = ["likes" : likeCount + 1] as [String : Any]
                    
                    fireStoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)

                }

        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
