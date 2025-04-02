//
//  CategoryTableViewCell.swift
//  MidtermProjectATL
//
//  Created by Islam Rzayev on 20.03.25.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var showAllButton: UIButton!
    
    var items: [CategoryCollectionViewCell.item] = []

    let layout = UICollectionViewFlowLayout()
    
    var showAllTapped: (() -> ())? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
        
        
        layout.scrollDirection = .horizontal
        
        layout.minimumLineSpacing = 21
        layout.sectionInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        
        var buttonConfig = UIButton.Configuration.filled()
        buttonConfig.title = "Show All"
        buttonConfig.baseBackgroundColor = .clear
        buttonConfig.baseForegroundColor = .black
        buttonConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 14, weight: .ultraLight)
            return outgoing
        })
        
        showAllButton.configuration = buttonConfig
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layout.invalidateLayout()
        layout.itemSize = .init(width: collectionView.frame.width / 5 , height: collectionView.frame.height)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

            
    }
    @IBAction func showAllButtonClicked(_ sender: Any) {
        showAllTapped?()
    }
    
}

extension CategoryTableViewCell{
    struct item{
        var items: [CategoryCollectionViewCell.item]
    }
    
    func configure(_ item: item){
        self.items = item.items
    }
}

extension CategoryTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
        cell.configure(self.items[indexPath.row])
        return cell
    }
}

extension CategoryTableViewCell: UICollectionViewDelegate{
    
}

