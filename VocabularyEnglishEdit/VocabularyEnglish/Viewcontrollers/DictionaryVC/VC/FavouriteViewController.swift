//
//  FavouriteViewController.swift
//  VocabularyEnglish
//
//  Created by Cata on 9/10/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class FavouriteViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var favourite: [Word3000Common]?
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
//    convenience init(data: [Any]) {
//        self.init(data: data)
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.register(WordCommonTableViewCell.nib(), forCellReuseIdentifier: WordCommonTableViewCell.identifier)
        
        self.favourite = favourites
    }


}

extension FavouriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourite?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: WordCommonTableViewCell.identifier, for: indexPath) as! WordCommonTableViewCell
        cell.config(value: favourite![indexPath.row])
        return cell
    }
    
    
}
