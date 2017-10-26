//
//  ViewController.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/21/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var NoInternetImageV: UIImageView!
    
    var characterss = [Character]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rand = Int(arc4random_uniform(2) + 1)
        print("Rand: " + "\(rand)")
        NoInternetImageV.image = UIImage(named: "nointernet\(rand)")
        
        
        navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        navigationController?.navigationBar.layer.shadowRadius = 3.0;
        navigationController?.navigationBar.layer.shadowOpacity = 1.0;
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shouldRasterize = true
        
        
        //Set Marvel Icon
        let marvelIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        marvelIcon.image = UIImage(named: "icn-nav-marvel")
        self.navigationItem.titleView = marvelIcon
        
        self.navigationController?.navigationBar.isTranslucent = false

        
        tableView.delegate = self
        tableView.dataSource = self
        
        CharactersService.instance.fetchCharacters(limit: 10, offSet: 0) { (characters) in
            self.characterss.append(contentsOf: characters)
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue_DETAIL {
            if let vc = segue.destination as? DetailVC {
                vc.character = sender as! Character
            }
        }
    }

    @IBAction func searchBtnTapped(_ sender: Any) {

    }
    
    func fetchAnotherHeros() {
        CharactersService.instance.fetchCharacters(limit: 10, offSet: characterss.count) { (characters) in
            self.characterss.append(contentsOf: characters)
            self.tableView.reloadData()
        }
    }
    
    
}

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as? HeroCell {
            
            cell.configuerCell(character: characterss[indexPath.row])
            
            return cell
        }
        return UITableViewCell()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterss.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let character = characterss[indexPath.row]
        
        performSegue(withIdentifier: Segue_DETAIL, sender: character)
        
    }
    

    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .white)
            spinner.startAnimating()
            
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(50))
            spinner.backgroundColor = UIColor.black
            
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            
            fetchAnotherHeros()
        }
    }
}
