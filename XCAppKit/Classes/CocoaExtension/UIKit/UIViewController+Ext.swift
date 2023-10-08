//
//  UIViewController+Ext.swift
//  KuJiangNovel
//
//  Created by xucheng on 2018/8/22.
//  Copyright © 2018年 陈品. All rights reserved.
//

import UIKit

public extension UIViewController {
    private struct RuntimeKey {
        static var snapshot = "snapshot"
        static var interactivePopTransition = "interactivePopTransition"
        static var statusBarHidden = "statusBarHidden"
        static var statusBarStyle = "statusBarStyle"
    }

    @objc var snapshot: UIView? {
        get {
            return objc_getAssociatedObject(self, &RuntimeKey.snapshot) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &RuntimeKey.snapshot, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc var interactivePopTransition: UIPercentDrivenInteractiveTransition? {
        get {
            return objc_getAssociatedObject(self, &RuntimeKey.interactivePopTransition) as? UIPercentDrivenInteractiveTransition
        }
        set {
            objc_setAssociatedObject(self, &RuntimeKey.interactivePopTransition, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    @objc var statusBarHidden: Bool {
        get {
            return objc_getAssociatedObject(self, &RuntimeKey.statusBarHidden) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &RuntimeKey.statusBarHidden, newValue, .OBJC_ASSOCIATION_ASSIGN)
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    @objc var statusBarStyle: UIStatusBarStyle {
        get {
            let rawValue = objc_getAssociatedObject(self, &RuntimeKey.statusBarStyle) as? Int ?? UIStatusBarStyle.default.rawValue

            return UIStatusBarStyle(rawValue: rawValue) ?? UIStatusBarStyle.default
        }
        set {
            objc_setAssociatedObject(self, &RuntimeKey.statusBarStyle, newValue.rawValue, .OBJC_ASSOCIATION_ASSIGN)
            setNeedsStatusBarAppearanceUpdate()
        }
    }
}
