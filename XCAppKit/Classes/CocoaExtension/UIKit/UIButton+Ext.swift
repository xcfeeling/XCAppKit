//
//  UIButton+Ext.swift
//  KuJiangNovel
//
//  Created by xucheng on 2018/9/6.
//  Copyright © 2018年 陈品. All rights reserved.
//

import UIKit

private var ExtendEdgeInsetsKey: Void?

public extension UIButton {

    func horizontalImageAndTitle(spacing: CGFloat) {
        self.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -spacing / 2, bottom: 0, right: spacing / 2)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: spacing / 2, bottom: 0, right: -spacing / 2)
    }

    /// 设置此属性即可扩大响应范围, 分别对应上左下右
    /// 优势：与Auto-Layout无缝配合
    /// 劣势：View Debugger 查看不到增加的响应区域有多大，
    var extendEdgeInsets: UIEdgeInsets {
        get {
            return objc_getAssociatedObject(self, &ExtendEdgeInsetsKey) as? UIEdgeInsets ?? UIEdgeInsets.zero
        }
        set {
            objc_setAssociatedObject(self, &ExtendEdgeInsetsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    override open func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if UIEdgeInsetsEqualToEdgeInsets(extendEdgeInsets, .zero) || !self.isEnabled || self.isHidden || self.alpha < 0.01 {
            return super.point(inside: point, with: event)
        }
        let newRect = extendRect(bounds, extendEdgeInsets)
        return newRect.contains(point)
    }

    private func extendRect(_ rect: CGRect, _ edgeInsets: UIEdgeInsets) -> CGRect {
        let x = rect.minX - edgeInsets.left
        let y = rect.minY - edgeInsets.top
        let w = rect.width + edgeInsets.left + edgeInsets.right
        let h = rect.height + edgeInsets.top + edgeInsets.bottom
        return CGRect(x: x, y: y, width: w, height: h)
    }
    
    func actionHandler(action:(() -> Void)? = nil) {
        struct __ { static var action :(() -> Void)? }
        if action != nil { __.action = action }
        else { __.action?() }
    }
    @objc private func triggerActionHandler() {
        self.actionHandler()
    }
    func actionHandler(controlEvents control :UIControl.Event, ForAction action:@escaping () -> Void) {
        self.actionHandler(action: action)
        self.addTarget(self, action: #selector(triggerActionHandler), for: control)
    }
}

public extension UIButton {

    func alignVertical(spacing: CGFloat) {
        let edgeOffset = spacing / 2
        
        guard let imageSize = self.imageView?.image?.size,
            let text = self.titleLabel?.text,
            let font = self.titleLabel?.font
            else {
                return
        }
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
        
        let totalHeight = imageSize.height + titleSize.height + spacing
        
        let width = max(imageSize.width, titleSize.width)
        
        self.imageEdgeInsets = UIEdgeInsets(top: -(totalHeight - imageSize.height - edgeOffset), left: 0.0, bottom: 0.0, right: -titleSize.width)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(totalHeight - titleSize.height - edgeOffset), right: 0)
    }
    
    func alignHorizontal2(spacing: CGFloat, imageFirst: Bool) {
        let edgeOffset = spacing / 2
        if imageFirst {
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -edgeOffset,
                                           bottom: 0,
                                           right: edgeOffset)
            titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: edgeOffset,
                                           bottom: 0,
                                           right: -edgeOffset)
        } else {
            guard let imageSize = self.imageView?.image?.size,
                let text = self.titleLabel?.text,
                let font = self.titleLabel?.font
                else {
                    return
            }
            let labelString = NSString(string: text)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: titleSize.width + edgeOffset,
                                           bottom: 0,
                                           right: -titleSize.width - edgeOffset)
            titleEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -imageSize.width - edgeOffset,
                                           bottom: 0,
                                           right: imageSize.width + edgeOffset)
        }

        // increase content width to avoid clipping
        contentEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset, bottom: 0, right: edgeOffset)
    }

    func alignHorizontal(spacing: CGFloat, imageFirst: Bool) {
        let edgeOffset = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0,
                                       left: -edgeOffset,
                                       bottom: 0,
                                       right: edgeOffset)
        titleEdgeInsets = UIEdgeInsets(top: 0,
                                       left: edgeOffset,
                                       bottom: 0,
                                       right: -edgeOffset)

        if !imageFirst {
            self.transform = CGAffineTransform(scaleX: -1, y: 1)
            imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
            titleLabel?.transform = CGAffineTransform(scaleX: -1, y: 1)
        }

        // increase content width to avoid clipping
        contentEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset, bottom: 0, right: edgeOffset)
    }

}

public class PassableUIButton: UIButton {
    public var params: [String : Any]

    override init(frame: CGRect) {
        self.params = [:]
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        self.params = [:]
        super.init(coder: aDecoder)
    }
}

