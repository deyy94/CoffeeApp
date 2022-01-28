//
//  CellController.swift
//  coffeAppNetec
//
//  Created by Arlen Peña on 03/09/20.
//  Copyright © 2020 Arlen Peña. All rights reserved.
//

import UIKit

class CellController: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblNameCategory: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
