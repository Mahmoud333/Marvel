//
//  PhotoVC.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/24/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoVC: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageV: AverageColorImageV!
    @IBOutlet weak var descLbl: UITextView!
    
    var story: RelatedStories?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.cornerRadius = 5
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 1.5, height: 3.5)
        containerView.layer.shadowOpacity = 0.7
        containerView.layer.shadowRadius = 3.0
        containerView.clipsToBounds = false
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if story != nil {
            
            if story!.thumbNail == "null.null" {
                self.imageV.image = UIImage(named: "wc-placeholder")
            } else {
                let url = URL(string: story!.thumbNail)
                imageV.kf.setImage(with: url)
            }

        
            descLbl.text = story!.title
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
