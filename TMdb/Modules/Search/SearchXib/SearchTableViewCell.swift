//
//  TableViewCell.swift
//  TMdb
//
//  Created by Tony Michael on 01/03/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var movieGenre: UILabel!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
