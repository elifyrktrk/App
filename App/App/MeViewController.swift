//
//  MeViewController.swift
//  App
//
//  Created by Elif Yürektürk on 23.12.2023.
//

import UIKit

class MeViewController: UIViewController {

    @IBOutlet weak var contentsContainer: UIView!
    @IBOutlet weak var likesContainer: UIView!
    @IBOutlet weak var mediaContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
  
    @IBAction func showComponents(_ sender: AnyObject) {
        
        if(sender.selectedSegmentIndex == 0)
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.contentsContainer.alpha = 1
                self.mediaContainer.alpha = 0
                self.likesContainer.alpha = 0
            })
        }
        else if(sender.selectedSegmentIndex == 1)
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.mediaContainer.alpha = 1
                self.contentsContainer.alpha = 0
                self.likesContainer.alpha = 0
            })
        }
        else
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.likesContainer.alpha = 1
                self.contentsContainer.alpha = 0
                self.mediaContainer.alpha = 0
            })
        }
        
    }
    
}
