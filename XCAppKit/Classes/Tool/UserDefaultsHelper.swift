//
//  UserDefaultsHelper.swift
//  KuJiangNovel
//
//  Created by 陈品 on 2018/9/7.
//  Copyright © 2018年 陈品. All rights reserved.
//

import Foundation

public class UserDefaultsHelper {
    // MARK: - - 清理 NSUserDefaults

    /// 清空 NSUserDefaults
    public class func UserDefaultsClear() {
        let defaults:UserDefaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()

        for key in dictionary.keys {
            defaults.removeObject(forKey: key)
            defaults.synchronize()
        }
    }

    /// 删除 对应Key 的值
    public class func removeObjectForKey(_ key:String) {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
        defaults.synchronize()
    }

    // MARK: - - 存

    /// 存储Object
    public class func setObject(_ value:Any?, key:String) {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }

    /// 存储String
    public class func setString(_ value:String?, key:String) {
        UserDefaultsHelper.setObject(value, key: key)
    }

    /// 存储NSInteger
    public class func setInteger(_ value:NSInteger, key:String) {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }

    /// 存储Bool
    public class func setBool(_ value:Bool, key:String) {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }

    /// 存储Float
    public class func setFloat(_ value:Float, key:String) {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }

    /// 存储Double
    public class func setDouble(_ value:Double, key:String) {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }

    /// 存储URL
    public class func setURL(_ value:URL?, key:String) {
        let defaults:UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }

    // MARK: - - 取

    /// 获取Object
    public class func objectForKey(_ key:String) -> Any? {
        let defaults:UserDefaults = UserDefaults.standard
        return defaults.object(forKey: key)
    }

    /// 获取String
    public class func stringForKey(_ key:String) -> String {
        let defaults:UserDefaults = UserDefaults.standard
        let string = defaults.object(forKey: key) as? String
        return string ?? ""
    }

    /// 获取Bool
    public class func boolForKey(_ key:String) -> Bool {
        let defaults:UserDefaults = UserDefaults.standard
        return defaults.bool(forKey: key)
    }

    /// 获取NSInteger
    public class func integerForKey(_ key:String) -> Int {
        let defaults:UserDefaults = UserDefaults.standard
        return defaults.integer(forKey: key)
    }

    /// 获取Float
    public class func floatForKey(_ key:String) -> Float {
        let defaults:UserDefaults = UserDefaults.standard
        return defaults.float(forKey: key)
    }

    /// 获取Double
    public class func doubleForKey(_ key:String) -> Double {
        let defaults:UserDefaults = UserDefaults.standard
        return defaults.double(forKey: key)
    }

    /// 获取URL
    public class func URLForKey(_ key:String) -> URL? {
        let defaults:UserDefaults = UserDefaults.standard
        return defaults.url(forKey: key)
    }
}
