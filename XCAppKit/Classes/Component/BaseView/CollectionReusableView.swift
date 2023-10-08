//
//  CollectionReusableView.swift
//  Common
//
//  Created by xucheng on 2022/11/18.
//

import Foundation

final public class CollectionReusableView<V: ItemView>: UICollectionReusableView {
    
    private let view: V

    public override init(frame: CGRect) {
        view = .init()
        super.init(frame: frame)
        
        addSubview(view)
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
    
    deinit {
        logDebug("\(type(of: self)): Deinited")
        logResourcesCount()
    }
}
