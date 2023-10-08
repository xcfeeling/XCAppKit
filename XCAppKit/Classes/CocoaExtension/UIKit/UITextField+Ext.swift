//
//  UITextField.swift
//  AppKit
//
//  Created by xucheng on 2022/3/4.
//

import UIKit

public extension UITextField {

    /// 代理
    /// - Parameter delegate: 代理
    /// - Returns: 自身
    @discardableResult
    public func delegate(_ delegate: UITextFieldDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    /// 文本
    /// - Parameter text: 文本
    /// - Returns: 自身
    @discardableResult
    public func text(_ text: String?) -> Self {
        self.text = text
        return self
    }

    /// 字体 默认系统 12pt 字体
    /// - Parameter font: 字体
    /// - Returns: 自身
    @discardableResult
    public func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }

    /// 文本颜色
    /// - Parameter color: 颜色
    /// - Returns:  自身
    @discardableResult
    public func textColor(_ color: UIColor?) -> Self {
        textColor = color
        return self
    }

    /// 对齐方式  默认靠左
    /// - Parameter alignment: 对齐方式
    /// - Returns: 自身
    @discardableResult
    public func alignment(_ alignment: NSTextAlignment = .left) -> Self {
        textAlignment = alignment
        return self
    }

    /// 键盘样式
    /// - Parameter type: 键盘样式
    /// - Returns: 自身
    @discardableResult
    public func keyboardType(_ type: UIKeyboardType) -> Self {
        keyboardType = type
        return self
    }

    /// 文本加密 默认 false
    /// - Parameter isSecure: 是否加密
    /// - Returns: 自身
    @discardableResult
    public func isSecureText(_ isSecure: Bool = false) -> Self {
        isSecureTextEntry = isSecure
        return self
    }

    ///  添加下划线
    func setUnderLine() {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor(hex: 0xf7f7f7).cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
