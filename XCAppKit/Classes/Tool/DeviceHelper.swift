//
//  DeviceHelper.swift
//  HsAppKit
//
//  Created by 陈品 on 2024/5/8.
//

import Foundation

fileprivate var currentDeviceId = ""

public class DeviceHelper {
    
    public static func deviceId() -> String {
        
        if currentDeviceId.isNotEmpty {
            return currentDeviceId
        }
        
        if let udid = HsKeyChainItemWrapper.hsUdid() {
            currentDeviceId = udid
            HsKeyChainItemWrapper.saveUdid(udid)
            return udid
        }
        
        if let idfa = HsIDFAHelper.idfa() {
            currentDeviceId = idfa
            HsKeyChainItemWrapper.saveUdid(idfa)
            return idfa
        }
        
        if let uuid = UIDevice.current.identifierForVendor?.uuidString {
            currentDeviceId = uuid
            HsKeyChainItemWrapper.saveUdid(uuid)
            return uuid
        }
        
        currentDeviceId = UUID().uuidString
        HsKeyChainItemWrapper.saveUdid(currentDeviceId)
        
        return currentDeviceId
    }
}

