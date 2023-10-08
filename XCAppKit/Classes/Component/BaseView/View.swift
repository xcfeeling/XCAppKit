//
//  BaseView.swift
//  Player
//
//  Created by xucheng on 2022/11/11.
//

import UIKit

/// 自定义View的基类
open class View: UIView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        makeUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func makeUI() {
        
    }
    
    deinit {
        logDebug("\(type(of: self)): Deinited")
        logResourcesCount()
    }
}
