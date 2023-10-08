//
//  KJAlertController.swift
//  KuJiangReader
//
//  Created by xucheng on 2018/5/28.
//  Copyright © 2018年 陈品. All rights reserved.
//

import UIKit

public class AlertController: NSObject {

    private var builder:Builder
    
    private init(builder:Builder) {
        self.builder = builder
        super.init()
    }
    
    public func show() {
        let alert = UIAlertController(title: self.builder.params.title, message: self.builder.params.message, preferredStyle: self.builder.params.style!)
        //是否添加按钮
        //取消按钮
        if self.builder.params.cancelTitle != nil {
            alert.addAction(UIAlertAction(title: self.builder.params.cancelTitle, style: UIAlertAction.Style.cancel, handler: self.builder.params.cancelHandler))
        }
        //确定按钮
        if self.builder.params.confirmTitle != nil {
            alert.addAction(UIAlertAction(title: self.builder.params.confirmTitle, style: UIAlertAction.Style.default, handler: self.builder.params.confirmHandler))
        }
        
        //显示
        self.builder.params.controller?.present(alert, animated: true, completion: nil)
    }
    
    public class AlertParams: NSObject {
        var controller:UIViewController?
        var title:String?
        var message:String?
        var confirmTitle:String?
        var confirmHandler:((UIAlertAction)->Swift.Void)?
        var cancelTitle:String?
        var cancelHandler:((UIAlertAction)->Swift.Void)?
        var style:UIAlertController.Style?
        
        init(_ controller:UIViewController) {
            super.init()
            self.controller = controller;
        }
    }
    
    //构建者
    public class Builder: NSObject {
        var params:AlertParams
        public init(controller:UIViewController) {
            self.params = AlertParams(controller)
            super.init()
            
            self.params.style = UIAlertController.Style.alert
        }
        
        public func title(_ title:String) -> Builder {
            self.params.title = title
            return self
        }
        
        public func message(_ message:String) -> Builder {
            self.params.message = message
            return self
        }
        
        public func confirmTitle(_ confirmTitle:String) -> Builder {
            self.params.confirmTitle = confirmTitle
            return self
        }
        
        public func confirmHandler(_ confirmHandler:@escaping ((UIAlertAction)->Swift.Void)) -> Builder {
            self.params.confirmHandler = confirmHandler
            return self
        }
        
        public func cancelTitle(_ cancelTitle:String) -> Builder {
            self.params.cancelTitle = cancelTitle
            return self
        }
        
        public func cancelHandler(_ cancelHandler:@escaping ((UIAlertAction)->Swift.Void)) -> Builder {
            self.params.cancelHandler = cancelHandler
            return self
        }
        
        public func style(_ style:UIAlertController.Style) -> Builder {
            self.params.style = style
            return self
        }
        
        public func build() -> AlertController {
            return AlertController(builder: self)
        }
        
    }
}
