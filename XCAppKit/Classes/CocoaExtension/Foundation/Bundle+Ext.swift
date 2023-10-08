//
//  Bundle+Ext.swift
//  AppKit
//
//  Created by xucheng on 2022/1/14.
//

import Foundation

extension Bundle {
    public static func bundleNamed(_ modularName: String) -> Bundle? {
        guard let bundlePath = Bundle.main.path(forResource: modularName, ofType: "bundle") , let bundle = Bundle(path: bundlePath) else {
            return nil
        }
        return bundle
    }
    
    public func imageNamed(_ name: String) -> UIImage? {
        let image = UIImage(named: name, in: self, compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        return image
    }
    
    public var version: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
    
    public var buildVersion: String {
        return infoDictionary?[kCFBundleVersionKey as String] as? String ?? "Unknown"
    }
    
    public var executable: String {
        return infoDictionary?[kCFBundleExecutableKey as String] as? String ?? "Unknown"
    }
    
    public var bundleId: String {
        return infoDictionary?[kCFBundleIdentifierKey as String] as? String ?? "Unknown"
    }
}
