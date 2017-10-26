//
//  DetailVC.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/22/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var character: Character?
    var characterDetails = CharacterDetails()
    
    var comicsContent = [RelatedStories]()
    var seriesContent = [RelatedStories]()
    var storiesContent = [RelatedStories]()
    var eventsContent = [RelatedStories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CollectionsTableCell", bundle: nil), forCellReuseIdentifier: "CollectionsTableCell")
        tableView.register(UINib(nibName: "DetailsRelatedLinksCell", bundle: nil), forCellReuseIdentifier: "DetailsRelatedCell")
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        DetailCharacterService.instance.fetchCharacterDetail(id: character?.id ?? 0) { (Details) in
            self.characterDetails = Details
            self.tableView.reloadData()
            
            print(Details.description, Details.id, Details.name, Details.thumbNail)
            
            
            CharRelatedStoriesServices.instance.fetchRelated(id: Details.id, type: "comics", completion: { (relatedStories) in
                self.comicsContent = relatedStories
                
                CharRelatedStoriesServices.instance.fetchRelated(id: Details.id, type: "series", completion: { (relatedStories) in
                    self.seriesContent = relatedStories
                    
                    
                    CharRelatedStoriesServices.instance.fetchRelated(id: Details.id, type: "stories", completion: { (relatedStories) in
                        self.storiesContent = relatedStories
                        
                        CharRelatedStoriesServices.instance.fetchRelated(id: Details.id, type: "events", completion: { (relatedStories) in
                            self.eventsContent = relatedStories
                            

                            self.tableView.reloadData()
                        })
                    })
                })
            })
        }
        
        //Set back button
        let backItem = UIBarButtonItem()
        backItem.customView?.layer.shadowColor = UIColor.black.cgColor
        backItem.customView?.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        backItem.customView?.layer.shadowRadius = 5.0
        backItem.customView?.layer.shadowOpacity = 5.0
        backItem.customView?.layer.masksToBounds = false

        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 5.0
        self.navigationController?.navigationBar.layer.shadowRadius = 5.5

        navigationItem.backBarButtonItem = backItem

        
        //hide navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(presentDetails), name: NOTIF_SHOW_RELATED_STORY, object: nil)
    }
    
    
    @objc func presentDetails(notif: NSNotification) {
        performSegue(withIdentifier: "SeguePhotoVC", sender: notif.userInfo?["Object"])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SeguePhotoVC" {
            if let vc = segue.destination as? PhotoVC {
                vc.story = sender as? RelatedStories
            }
        }
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if velocity.y > 0.2 {
            //Code will work without the animation block. using animation block incase you need to set any delay to it.
            UIView.animate(withDuration: 2.5, delay: 0.1, options: UIViewAnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                //self.navigationController?.setToolbarHidden(true, animated: true)
                print("Hide")
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 2.5, delay: 0.1, options: UIViewAnimationOptions(), animations: {
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                //self.navigationController?.setToolbarHidden(false, animated: true)
                print("Unhide")
            }, completion: nil)
        }
        
    }
    
}

extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as? FirstDetailCell {
                
                let url = URL(string: characterDetails.thumbNail)
                cell.imageV.kf.setImage(with: url)
                
                cell.imageV.analizeImage(nil, completion: { [unowned self] (colorsArray) in
                    self.view.backgroundColor = colorsArray.first
                })
                
                
                cell.configuerCell(desc: characterDetails.description, name: characterDetails.name)
                
                return cell
            }
        } else if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionsTableCell", for: indexPath) as? CollectionsTableCell {
                
                cell.configuerCell(comics: comicsContent, series: seriesContent, stories: storiesContent, events: eventsContent)
                
                return cell
            }
            
        } else if indexPath.row == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsRelatedCell", for: indexPath) as? DetailsRelatedLinksCell {
                
                
                return cell
            }
            
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 450
        } else if indexPath.row == 1 {
            return 1025
        } else {
            return 190
        }
    }*/
}
