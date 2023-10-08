//
//  UIColor+Ext.swift
//  AppKit
//
//  Created by xucheng on 2022/11/10.
//

import UIKit

// MARK: - - kHexColor
public func kHexColor(_ hexValue: Int, _ alpha: CGFloat = 1) -> UIColor {
    return UIColor(hex: hexValue, alpha: alpha)
}

public extension UIColor {
    convenience init(hex: Int) {
        let components = (
                R: CGFloat((hex >> 16) & 0xff) / 255,
                G: CGFloat((hex >> 08) & 0xff) / 255,
                B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
    convenience init(hex: Int, alpha: CGFloat) {
        let components = (
                R: CGFloat((hex >> 16) & 0xff) / 255,
                G: CGFloat((hex >> 08) & 0xff) / 255,
                B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: alpha)
    }
    
    convenience init?(hexString: String) {
        var formattedString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if formattedString.hasPrefix("#") {
            formattedString.remove(at: formattedString.startIndex)
        }
        
        if formattedString.hasPrefix("0X") {
            formattedString.remove(at: formattedString.startIndex)
            formattedString.remove(at: formattedString.startIndex)
        }
        
        if formattedString.count != 6 {
            return nil
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: formattedString).scanHexInt64(&rgbValue)
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    class func dynamicColor(light: UIColor, dark: UIColor) -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor { $0.userInterfaceStyle == .dark ? dark : light }
        } else {
            // Fallback on earlier versions
            return light
        }
    }
    
    class func kBackgroundColor() -> UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    
    //返回随机颜色
    class var randomColor:UIColor{
           get
           {
               let red = CGFloat(arc4random()%256)/255.0
               let green = CGFloat(arc4random()%256)/255.0
               let blue = CGFloat(arc4random()%256)/255.0
               return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
           }
       }
}
