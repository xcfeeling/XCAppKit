//
//  CollectionViewCell.swift
//  Common
//
//  Created by xucheng on 2022/11/18.
//

import UIKit

final public class CollectionViewCell<V: ItemView>: UICollectionViewCell {
    
    private let view: V

    public override init(frame: CGRect) {
        view = .init()
        super.init(frame: frame)
        
        contentView.addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func configure(obj: Any, indexPath: IndexPath) {
        view.configure(obj: obj, indexPath: indexPath)
    }
}
