//
//  ProfileTableViewCell.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 21.03.25.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ProfileTableViewCell{
    struct item{
        var leftImageName:String
        var title:String
    }
    
    func configure(_ item: item){
        leftImageView.image = UIImage(systemName: item.leftImageName)
        titleLabel.text = item.title
    }
}
