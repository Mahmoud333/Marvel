//
//  SearchVC.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/23/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import Kingfisher

class SearchVC: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var characterss = [Character]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(BasicTableCell.self, forCellReuseIdentifier: "BasicTableCell")
        

        
        searchBar.delegate = self
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText != nil {
            SearchService.instance.fetchHerosWithThis(string: searchText.replacingOccurrences(of: " ", with: "%20"), limit: 7) { (chars) in
                self.characterss = chars
                self.tableView.reloadData()
            }
        }
        
    }

    
    @IBAction func cancelTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension SearchVC: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BasicTableCell", for: indexPath) as? BasicTableCell {

            cell.imageView?.image = UIImage()
            
            let url = URL(string: characterss[indexPath.row].thumbNail)
            cell.imageView?.kf.setImage(with: url)//sd_setImage(with: url)
            
            cell.textLabel?.text = characterss[indexPath.row].name
            cell.textLabel?.textColor = UIColor.white
            cell.backgroundColor = UIColor.clear
            
            return cell
        }
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterss.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
