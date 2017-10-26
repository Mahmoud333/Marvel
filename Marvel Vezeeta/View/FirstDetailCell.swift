//
//  FirstDetailCell.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/22/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import Kingfisher

class FirstDetailCell: UITableViewCell {
    @IBOutlet weak var imageV: AverageColorImageV!
    
    @IBOutlet weak var descLbl: UILabel!
    
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }

    func configuerCell(desc: String, name: String){

        descLbl.text = desc
        nameLbl.text = name
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
