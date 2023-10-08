//
//  UIView+Ext.swift
//  AppKit
//
//  Created by xucheng on 2022/3/4.
//

import UIKit

public extension UIView {
    
    /// 初始化
    public convenience init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: width, height: height))
    }
    
    /// frame
    /// - Parameter frame: frame
    /// - Returns: 自身
    @discardableResult
    public func frame(_ frame: CGRect) -> Self {
        self.frame = frame
        return self
    }
    
    /// 背景色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func backColor(_ color: UIColor?) -> Self {
        backgroundColor = color
        return self
    }
    
    /// tag 值
    /// - Parameter tag: tag 值
    /// - Returns: 自身
    @discardableResult
    public func tag(_ tag: Int) -> Self {
        self.tag = tag
        return self
    }
    
    /// 是否支持响应 label & imageView 默认 false
    /// - Parameter enabled: 是否支持响应
    /// - Returns: 自身
    @discardableResult
    public func isUserInteractionEnabled(_ enabled: Bool) -> Self {
        isUserInteractionEnabled = enabled
        return self
    }
    
    /// 着色
    /// 具有传递性 即: 传递到子视图 若子视图设置 tintColor 则使用子视图 否则使用父视图的 tintColor
    /// 若父子视图都没设置则使用系统的 tintColor 其中系统默认蓝色 如: 系统按钮默认蓝色背景
    /// 对图片可通过其 UIImage.RenderingMode 中的  alwaysTemplate &  tintColor 达到实现指定色值的图片
    /// - Parameter color: 颜色值
    /// - Returns: 自身
    @discardableResult
    public func tintColor(_ color: UIColor) -> Self {
        tintColor = color
        return self
    }
    
    /// 添加到父视图
    /// - Parameter superView: 父视图
    /// - Returns: 自身
    @discardableResult
    public func addViewTo(_ superView: UIView) -> Self {
        superView.addSubview(self)
        return self
    }
    
    /// 移除所有子View
    public func removeSubviews() {
        for view in subviews {
            view.removeFromSuperview()
        }
    }
}

public extension UIView {
    // MARK: 3.1、x 的位置
    /// x 的位置
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    // MARK: 3.2、y 的位置
    /// y 的位置
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    // MARK: 3.3、height: 视图的高度
    /// height: 视图的高度
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.height = newValue
            frame = tempFrame
        }
    }
    
    // MARK: 3.4、width: 视图的宽度
    /// width: 视图的宽度
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size.width = newValue
            frame = tempFrame
        }
    }
    
    // MARK: 3.5、size: 视图的zize
    /// size: 视图的zize
    var size: CGSize {
        get {
            return frame.size
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.size = newValue
            frame = tempFrame
        }
    }
    
    // MARK: 3.6、centerX: 视图的X中间位置
    /// centerX: 视图的X中间位置
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.x = newValue
            center = tempCenter
        }
    }
    
    // MARK: 3.7、centerY: 视图的Y中间位置
    /// centerY: 视图Y的中间位置
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(newValue) {
            var tempCenter: CGPoint = center
            tempCenter.y = newValue
            center = tempCenter
        }
    }
    
    // MARK: 3.8、center: 视图的中间位置
    /// centerY: 视图Y的中间位置
//    var center: CGPoint {
//        get {
//            return center
//        }
//        set(newValue) {
//            var tempCenter: CGPoint = center
//            tempCenter = newValue
//            center = tempCenter
//        }
//    }
    
    // MARK: 3.9、top 上端横坐标(y)
    /// top 上端横坐标(y)
    var top: CGFloat {
        get {
            return frame.origin.y
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.y = newValue
            frame = tempFrame
        }
    }
    
    // MARK: 3.10、left 左端横坐标(x)
    /// left 左端横坐标(x)
    var left: CGFloat {
        get {
            return frame.origin.x
        }
        set(newValue) {
            var tempFrame: CGRect = frame
            tempFrame.origin.x = newValue
            frame = tempFrame
        }
    }
    
    // MARK: 3.11、bottom 底端纵坐标 (y + height)
    /// bottom 底端纵坐标 (y + height)
    var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set(newValue) {
            frame.origin.y = newValue - frame.size.height
        }
    }
    
    // MARK: 3.12、right 底端纵坐标 (x + width)
    /// right 底端纵坐标 (x + width)
    var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set(newValue) {
            frame.origin.x = newValue - frame.size.width
        }
    }
    
    // MARK: 3.13、origin 点
    /// origin 点
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set(newValue) {
            var tempOrigin: CGPoint = frame.origin
            tempOrigin = newValue
            frame.origin = tempOrigin
        }
    }
}

extension UIView{
    //MARK:- 绘制虚线
    public func drawDashLine(strokeColor: UIColor, lineWidth: CGFloat = 1, lineLength: Int = 5, lineSpacing: Int = 5, isVertical: Bool = false) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineDashPhase = 0 //从哪个位置开始
        //每一段虚线长度 和 每两段虚线之间的间隔
        shapeLayer.lineDashPattern = [NSNumber(value: lineLength), NSNumber(value: lineSpacing)]
        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        if isVertical {
            path.addLine(to: CGPoint(x: 0, y: self.layer.bounds.height))
        } else {
            path.addLine(to: CGPoint(x: self.layer.bounds.width, y: 0))
        }
      
        shapeLayer.path = path
        self.layer.addSublayer(shapeLayer)
    }
    /// radius:切圆角的半径
    /// corner:要切四个角中的哪个角
   public func cornerCut(radius: Int,corner: UIRectCorner){
        let maskPath = UIBezierPath.init(roundedRect: bounds, byRoundingCorners: corner, cornerRadii: CGSize.init(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
    public func setGradientBackground(view: UIView, colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
