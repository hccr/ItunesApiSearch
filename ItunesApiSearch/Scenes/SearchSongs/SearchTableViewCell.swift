//
//  SearchTableViewCell.swift
//  ItunesApiSearch
//
//  Created by Harold Campuzano Rivera on 23/12/19.
//  Copyright © 2019 harold-campuzano. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var nombreArtista: UILabel!
    @IBOutlet weak var nombreCancion: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
