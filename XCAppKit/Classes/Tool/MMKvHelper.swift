//
//  MMkvHelper.swift
//  AppKit
//
//  Created by 陈品 on 2022/11/10.
//

import Foundation
import MMKV
import SVProgressHUD

public class MMKvHelper {
    // MARK: - - 清理 MMKV
    
    static let mmkv = MMKV(mmapID: "mmkv", mode: .singleProcess) as! MMKV

    public class func initMMKV() {
        MMKV.initialize(rootDir: nil)
    }
    
    /// 清空
    public class func clearAll() {
        mmkv.clearAll()
    }

    /// 删除 对应Key 的值
    public class func removeObjectForKey(_ key: String) {
        mmkv.removeValue(forKey: key)
    }

    // MARK: - - 存

    /// 存储Object
    public class func setObject(_ value: (NSCoding & NSObjectProtocol)?, key: String) {
        mmkv.set(value, forKey: key)
    }

    /// 存储String
    public class func setString(_ value: String?, key: String) {
        mmkv.set(value ?? "", forKey: key)
    }

    /// 存储NSInteger
    public class func setInt(_ value: Int64, key: String) {
        mmkv.set(value, forKey: key)
    }

    /// 存储Bool
    public class func setBool(_ value: Bool, key: String) {
        mmkv.set(value, forKey: key)
    }

    /// 存储Float
    public class func setFloat(_ value: Float, key: String) {
        mmkv.set(value, forKey: key)
    }

    /// 存储Double
    public class func setDouble(_ value: Double, key: String) {
        mmkv.set(value, forKey: key)
    }

    // MARK: - - 取

    /// 获取Object
    public class func objectForKey(_ key:String, _ type: AnyClass) -> Any? {
        return mmkv.object(of: type, forKey: key)
    }

    /// 获取String
    public class func stringForKey(_ key:String) -> String {
        let string = mmkv.string(forKey: key) ?? ""
        return string
    }

    /// 获取Bool
    public class func boolForKey(_ key:String) -> Bool {
        return mmkv.bool(forKey: key)
    }

    /// 获取NSInteger
    public class func integerForKey(_ key:String) -> Int {
        return Int(mmkv.int64(forKey: key))
    }

    /// 获取Float
    public class func floatForKey(_ key:String) -> Float {
        return mmkv.float(forKey: key)
    }

    /// 获取Double
    public class func doubleForKey(_ key:String) -> Double {
        return mmkv.double(forKey: key)
    }
}
