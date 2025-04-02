//
//  BannerTableViewCell.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 20.03.25.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [BannerCollectionViewCell.item] = []

    let layout = UICollectionViewFlowLayout()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BannerCollectionViewCell.nib, forCellWithReuseIdentifier: BannerCollectionViewCell.reuseIdentifier)
        
        
       
        layout.scrollDirection = .horizontal
        layout.sectionInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layout.invalidateLayout()
        layout.itemSize = CGSize(width: collectionView.frame.width - 48, height: collectionView.frame.height )
            
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension BannerTableViewCell{
    struct item{
        var items: [BannerCollectionViewCell.item]
    }
    func configure(_ item: item){
        self.items = item.items
    }
}


extension BannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.reuseIdentifier, for: indexPath) as? BannerCollectionViewCell else {return UICollectionViewCell() }
        cell.configure(self.items[indexPath.row])
        return cell
    }
}
