//
//  UIImageView+Ext.swift
//  AppKit
//
//  Created by xucheng on 2022/11/10.
//

import UIKit
import Nuke

public extension UIImageView {
    public func asAvatar(cornerRadius: CGFloat = 4) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
    }
    
    public func setImage(
        with url: String?,
        placeholder: UIImage? = nil,
        priority: ImageRequest.Priority = .normal
    ) {
        guard let urlString = url, let imageUrl = URL(string: urlString) else {
            self.image = placeholder
            return
        }

        let request = ImageRequest(url: imageUrl, priority: priority)

        let options = ImageLoadingOptions(
            placeholder: placeholder,
            transition: .fadeIn(duration: 0.3)
        )

        Nuke.loadImage(with: request, options: options, into: self)

    }
}

