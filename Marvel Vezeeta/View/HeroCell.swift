//
//  HeroCell.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/22/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class HeroCell: UITableViewCell {
    
    @IBOutlet weak var HeroIV: UIImageView!
    @IBOutlet weak var heroTitle: UILabel!
    @IBOutlet weak var lbelContainerV: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        heroTitle.layer.cornerRadius = 5
        lbelContainerV.layer.cornerRadius = 5
        lbelContainerV.layer.shadowColor = UIColor.black.cgColor
        lbelContainerV.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        lbelContainerV.layer.shadowRadius = 4.0;
        lbelContainerV.layer.shadowOpacity = 1.0;
        
        HeroIV.image = UIImage()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configuerCell(character: Character) {
        heroTitle.text = character.name
        
        let url = URL(string: character.thumbNail)
        HeroIV.kf.setImage(with: url)
        
        /*
        Alamofire.request(url).responseData { (response) in
            print(response)
            if let data = response.value {
                let img = UIImage(data: response.value!)
                self.HeroIV.image = img
                
            }
        }*/
    }
}
