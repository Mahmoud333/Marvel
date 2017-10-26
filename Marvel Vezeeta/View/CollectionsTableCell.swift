//
//  CollectionsTableCell.swift
//  Marvel Vezeeta
//
//  Created by Mahmoud Hamad on 10/22/17.
//  Copyright © 2017 Mahmoud SMGL. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionsTableCell: UITableViewCell {

    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    
    var comicsContent = [RelatedStories]()
    var seriesContent = [RelatedStories]()
    var storiesContent = [RelatedStories]()
    var eventsContent = [RelatedStories]()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        comicsCollectionView.delegate = self
        comicsCollectionView.dataSource = self
        
        seriesCollectionView.delegate = self
        seriesCollectionView.dataSource = self
        
        storiesCollectionView.delegate = self
        storiesCollectionView.dataSource = self
        
        eventsCollectionView.delegate = self
        eventsCollectionView.dataSource = self
        
        
        
        comicsCollectionView.register(UINib(nibName: "DetailsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionCell")
        seriesCollectionView.register(UINib(nibName: "DetailsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionCell")
        storiesCollectionView.register(UINib(nibName: "DetailsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionCell")
        eventsCollectionView.register(UINib(nibName: "DetailsCollectionCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionCell")
        

    }


    func configuerCell(comics: [RelatedStories], series: [RelatedStories], stories: [RelatedStories], events:[RelatedStories]){

        self.comicsContent = comics
        self.seriesContent = series
        self.storiesContent = stories
        self.eventsContent = events
        
        comicsCollectionView.reloadData()
        seriesCollectionView.reloadData()
        storiesCollectionView.reloadData()
        eventsCollectionView.reloadData()

        print("comicsContent.count: \(comicsContent.count)")
        print("seriesContent.count: \(seriesContent.count)")
        print("storiesContent.count: \(storiesContent.count)")
        print("eventsContent.count: \(eventsContent.count)")
        


    }
 
}

extension CollectionsTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.tag {
        case 0: return comicsContent.count
        case 1: return seriesContent.count
        case 2: return storiesContent.count
        case 3: return eventsContent.count
        default:
            return 10
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("collectionView cellForItemAt")
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionCell", for: indexPath) as? DetailsCollectionCell {
            
            var usedItem: RelatedStories
            
            switch collectionView.tag {
            case 0: usedItem = comicsContent[indexPath.row]
            case 1: usedItem = seriesContent[indexPath.row]
            case 2: usedItem = storiesContent[indexPath.row] ; print("stories \(usedItem.thumbNail)")
            default:
                usedItem = eventsContent[indexPath.row]
            }
            print("usedItem.name: \(usedItem)")
            
            if usedItem.thumbNail == "null.null" {
                cell.imageV.image = UIImage(named: "wc-placeholder")
            } else {
                let url = URL(string: usedItem.thumbNail)
                cell.imageV.kf.setImage(with: url)//sd_setImage(with: url)//
            }
            cell.titleLbl.text = usedItem.title
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 114, height: 204)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var selectedItem: RelatedStories
        
        switch collectionView.tag {
        case 0: selectedItem = comicsContent[indexPath.row]
        case 1: selectedItem = seriesContent[indexPath.row]
        case 2: selectedItem = storiesContent[indexPath.row] ; print("stories \(selectedItem.thumbNail)")
        default:
            selectedItem = eventsContent[indexPath.row]
        }
        
        NotificationCenter.default.post(name: NOTIF_SHOW_RELATED_STORY, object: nil, userInfo: ["Object": selectedItem])
    }
}


