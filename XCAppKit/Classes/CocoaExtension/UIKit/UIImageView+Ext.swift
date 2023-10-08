//
//  UIImageView+Ext.swift
//  AppKit
//
//  Created by xucheng on 2022/11/10.
//

import UIKit
import Kingfisher

public extension UIImageView {
    public func asAvatar(cornerRadius: CGFloat = 4) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
    public func setImage(with
        url: String?,
        placeholder: Placeholder? = nil,
        options: KingfisherOptionsInfo? = nil)
    {
        if let imageUrl = url {
            kf.setImage(with: URL(string: imageUrl), placeholder: placeholder, options: options)
        }
    }
}

