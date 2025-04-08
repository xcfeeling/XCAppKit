//
//  Constant.swift
//  ReadLib
//
//  Created by xucheng on 2020/11/3.
//  Copyright © 2020 陈品. All rights reserved.
//

import Foundation
@_exported import SVProgressHUD
@_exported import RxSwift
@_exported import RxCocoa
@_exported import RxDataSources
@_exported import SnapKit
@_exported import MJRefresh
@_exported import HandyJSON
@_exported import LKDBHelper
@_exported import MMKV

public let kKeyWindow = UIApplication.shared.keyWindow ?? UIWindow()

public var kRootVC: UIViewController {
    return kKeyWindow.rootViewController ?? UIViewController()
}

public let kScreenWidth = UIScreen.main.bounds.width
public let kScreenHeight = UIScreen.main.bounds.height
public let kScreenSize = UIScreen.main.bounds.size

public let kDevice_Is_iPhoneX = (kScreenHeight > 736)
public let kHeight_SafeTop = kDevice_Is_iPhoneX ? CGFloat(24.0) : CGFloat(0.0)
public let kStatusBarHeight = UIApplication.shared.statusBarFrame.height
public let kNavBarHeight = kStatusBarHeight + CGFloat(44.0)
public let kHomeIndicatorHeight: CGFloat = kKeyWindow.safeAreaInsets.bottom ?? (kDevice_Is_iPhoneX ? CGFloat(34.0) : CGFloat(0))
public let kTabBarHeight = kDevice_Is_iPhoneX ? CGFloat(kHomeIndicatorHeight + 49.0) : CGFloat(49.0)

public let kGlobalLeftPadding = kScaleFrom_iPhone6_Desgin(15.0)
