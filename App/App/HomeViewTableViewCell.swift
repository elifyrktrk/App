//
//  HomeViewTableViewCell.swift
//  App
//
//  Created by Elif Yürektürk on 1.12.2023.
//

import UIKit

public class HomeViewTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var content: UITextView!
    

    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    public func configure(profilePic: String?, name: String, handle: String, content: String) {
        self.content.text = content
        self.handle.text = "@" + handle // handle değişkenini @ işaretiyle birleştir
        self.name.text = name
        
        if((profilePic) != nil)
        {
            let imageData = NSData(contentsOf: NSURL(string:profilePic!)! as URL)
            self.profilePic.image = UIImage(data:imageData! as Data)
            
        }
        else
        {
            self.profilePic.image = UIImage(named: "handle")
        }
        
    }
   
    
}
