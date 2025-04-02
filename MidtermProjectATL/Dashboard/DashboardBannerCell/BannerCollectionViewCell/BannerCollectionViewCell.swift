//
//  BannerCollectionViewCell.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 20.03.25.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hashTagLabel: UILabel!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension BannerCollectionViewCell{
    struct item{
        let hashTag: String
        let imageName: String
        let title: String
        let subtitle: String
    }
    
    func configure(_ item: item){
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        hashTagLabel.text = item.hashTag
        bannerImageView.image = UIImage(named: item.imageName)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
    }
}
