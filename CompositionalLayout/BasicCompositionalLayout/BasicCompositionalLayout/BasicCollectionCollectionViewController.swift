//
//  BasicCollectionCollectionViewController.swift
//  BasicCompositionalLayout
//
//  Created by taehy.k on 2022/06/21.
//

import UIKit

private let reuseIdentifier = "Cell"

class BasicCollectionCollectionViewController: UICollectionViewController {
    
    private var items = [
        "item1", "item2", "item3", "item4", "item5", "item6",
        "item7", "item8", "item9", "item10", "item11", "item12",
        "item13", "item14", "item15", "item16", "item17", "item18",
        "item19", "item20", "item21", "item22", "item23", "item24",
    ]
    let spacing: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.setCollectionViewLayout(generateLayout(), animated: false)
    }
    
    // section
    // group -> horizontal, vertical
    // item
    private func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(70)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )
        group.contentInsets = NSDirectionalEdgeInsets(
            top: spacing, leading: spacing, bottom: 0, trailing: spacing
        )
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BasicCollectionViewCell
    
        // Configure the cell
        cell.label.text = items[indexPath.item]
    
        return cell
    }
}
