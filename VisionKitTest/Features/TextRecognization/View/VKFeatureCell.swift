//
//  VKFeatureCell.swift
//  VisionKitTest
//
//  Created by Thomas Woodfin on 6/9/22.
//

import UIKit

class VKFeatureCell: UITableViewCell {
    
    static let identifier = "VKFeatureCell"
    
    @IBOutlet weak private var titleLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configuerCell(data: String){
        titleLbl.text = data
    }

}
