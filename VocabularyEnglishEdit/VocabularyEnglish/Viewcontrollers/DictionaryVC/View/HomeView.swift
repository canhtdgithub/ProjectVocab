//
//  HomeView.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/10/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

protocol MyViewDelegate {
    func didTapButton(viewController: UIViewController)
}


class HomeView: UIView {
    var dele: MyViewDelegate?
    var home = [HomeLists]()
    
    @IBOutlet weak var collection: UICollectionView!
  
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadDataHome()
       
    }
    
    override func awakeFromNib() {
       collection.register(HomeCollectionViewCell.nib(), forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
    }
    
    func loadDataHome() {
        home.append(HomeLists(name: "Favourite", view: FavouriteViewController()))
        home.append(HomeLists(name: "Games", view: ListGameViewController()))
    }
   
    
}

extension HomeView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return home.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as! HomeCollectionViewCell
        cell.nameLabel.text = home[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        dele?.didTapButton(viewController: home[indexPath.row].view)
        
        
    }


}
