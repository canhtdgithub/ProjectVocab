//
//  SettingTableViewCell.swift
//  VocabularyEnglish
//
//  Created by Cata on 8/24/20.
//  Copyright © 2020 Cata. All rights reserved.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageIcon: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func config(list: ListItems) {
        imageIcon.image = list.image
        nameLabel.text = list.name
    }
    
    
}
