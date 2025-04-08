//
//  Method.swift
//  ReadLib
//
//  Created by 陈品 on 2020/11/3.
//  Copyright © 2020 陈品. All rights reserved.
//

import Foundation

// MARK: - - Debug log
public func DebugLog<T>(_ message: T,
                    file: String = #file,
                  method: String = #function,
                    line: Int = #line) {
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}

// MARK: - - Fonts
public func kPingFangFont(_ fontSize:CGFloat) -> UIFont {
    guard let font = UIFont(name: "PingFangSC-Regular", size: fontSize) else { return UIFont.systemFont(ofSize: fontSize) }
    return font
}

public func kPingFangMediumFont(_ fontSize:CGFloat) -> UIFont {
    guard let font = UIFont(name: "PingFangSC-Medium", size: fontSize) else { return UIFont.systemFont(ofSize: fontSize) }
    return font
}

public func kPingFangLightFont(_ fontSize:CGFloat) -> UIFont {
    guard let font = UIFont(name: "PingFangSC-Light", size: fontSize) else { return UIFont.systemFont(ofSize: fontSize) }
    return font
}

// MARK: - - 尺寸计算 以iPhone6为比例
public func kScaleFrom_iPhone6_Desgin(_ _X_:CGFloat) -> CGFloat {
    return _X_ * (kScreenWidth / 375)
}

public func kScaleHeight(width:CGFloat, height:CGFloat) -> CGFloat {
    return kScreenWidth * (height / width)
}

public func kAutoFontSize(_ fontSize: CGFloat) -> CGFloat {
    return kScreenWidth < 375 ? (fontSize - 1) : (kScreenWidth > 375 ? (fontSize + 1) :fontSize)
}

// MARK: - - 创建分割线
/// 给一个视图创建添加一条分割线 高度 : HJSpaceLineHeight
public func SpaceLineSetup(view:UIView, color:UIColor? = nil) -> UIView {
    let spaceLine = UIView()

    spaceLine.backgroundColor = color != nil ? color : UIColor.lightGray

    view.addSubview(spaceLine)

    return spaceLine
}

// MARK: - - 获取时间

public let FORMAT_YEAR = "yyyy"
public let FORMAT_MONTH_DAY = "MM月dd日"
public let FORMAT_MONTH = "yyyy-MM";
public let FORMAT_DATE = "yyyy-MM-dd";
public let FORMAT_TIME = "HH:mm";
public let FORMAT_MONTH_DAY_TIME = "MM月dd日 hh:mm";
public let FORMAT_DATE_TIME = "yyyy-MM-dd HH:mm"
public let FORMAT_DATE_TIME_SECOND = "yyyy-MM-dd HH:mm:ss"
public let FORMAT_DATE_TIME_HOUR = "yyyy年MM月dd日 HH点"

/// 获取当前时间传入 时间格式 "YYYY-MM-dd-HH-mm-ss"
public func GetCurrentTimerString(dateFormat:String) -> String {
    let dateformatter = DateFormatter()
    dateformatter.locale = Locale(identifier: "en_US_POSIX")

    dateformatter.dateFormat = dateFormat

    return dateformatter.string(from: Date())
}

/// 将 时间 根据 类型 转成 时间字符串
public func GetTimerString(dateFormat:String, date:Date) -> String {
    let dateformatter = DateFormatter()
    dateformatter.locale = Locale(identifier: "en_US_POSIX")

    dateformatter.dateFormat = dateFormat

    return dateformatter.string(from: date)
}

/// 获取当前的 TimeIntervalSince1970 时间字符串
public func GetCurrentTimeIntervalSince1970String() -> String {
    return String(format: "%.0f", Date().timeIntervalSince1970)
}

// MARK: - 获取渐变layer
public func getGradientLayerWithColors(colors:[Any], locations: [NSNumber], startPoint: CGPoint, endPoint: CGPoint, frame: CGRect) -> CAGradientLayer {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors            = colors
    gradientLayer.locations         = locations
    gradientLayer.startPoint        = startPoint
    gradientLayer.endPoint          = endPoint
    gradientLayer.frame             = frame

    return gradientLayer
}

// MARK: - 字数转换
public func kWordsNumToThousand(number: Int) -> String {
    var numberStr = ""

    if number > 10000 {
        numberStr = String(format: "%.1f万字", CGFloat(number) / 10000)
    } else {
        numberStr = String(format: "%d字", number)
    }

    return numberStr
}

// MARK: - 加锁
public func synchronized(lock: AnyObject, closure: () -> Void) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

/// UTC时间转换成本地时间
public func getLocalDate(from UTCDate: String) -> String {
        
    let dateFormatter = DateFormatter.init()

    // UTC 时间格式
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let utcTimeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.timeZone = utcTimeZone

    guard let dateFormatted = dateFormatter.date(from: UTCDate) else {
        return ""
    }

    // 输出格式
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = "MM.dd,yyyy"
    let dateString = dateFormatter.string(from: dateFormatted)

    return dateString
}

public func getCurrentTimeString() -> NSString {
    let nowTime = NSDate().timeIntervalSince1970 * 1000
    let timeSp = String(nowTime)
    return  timeSp as NSString
}
