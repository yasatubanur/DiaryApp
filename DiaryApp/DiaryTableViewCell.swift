//
//  DiaryTableViewCell.swift
//  DiaryApp
//
//  Created by Tuba Nur YAŞA on 7.04.2022.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
