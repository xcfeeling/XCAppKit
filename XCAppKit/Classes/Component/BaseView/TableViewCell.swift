//
//  TableViewCell.swift
//  Common
//
//  Created by xucheng on 2022/11/17.
//

import UIKit

final public class TableViewCell<V: ItemView>: UITableViewCell {
    
    public let view: V

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        view = .init()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

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
    
    deinit {
        logDebug("\(type(of: self)): Deinited")
        logResourcesCount()
    }
}
