//
//  DetailsRelatedLinksCell.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/22/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit

class DetailsRelatedLinksCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var data = ["Detail", "Wiki", "Comiclink"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.register(BasicTableCell.self, forCellReuseIdentifier: "BasicTableCell")

        tableView.delegate = self
        tableView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BasicTableCell") as? BasicTableCell {
            
            cell.textLabel?.text = data[indexPath.row]
            cell.textLabel?.textColor = UIColor.white
            cell.accessoryView = UIImageView(image: UIImage(named: "icn-cell-disclosure"))
            cell.backgroundColor = UIColor.clear
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
