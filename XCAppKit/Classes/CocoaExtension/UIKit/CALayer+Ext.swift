//
//  CALayer+Ext.swift
//  AppKit
//
//  Created by xucheng on 2022/3/4.
//

import UIKit

public extension CALayer {

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
    public func backColor(_ color: UIColor) -> Self {
        backgroundColor = color.cgColor
        return self
    }

    /// 是否隐藏
    /// - Parameter isHidden: 是否隐藏
    /// - Returns: 自身
    @discardableResult
    public func isHidden(_ isHidden: Bool) -> Self {
        self.isHidden = isHidden
        return self
    }

    /// 圆角 默认裁剪
    /// - Parameter radius: 圆角
    /// - Parameter mask: 是否裁剪
    /// - Returns: 自身
    @discardableResult
    public func corner(_ radius: CGFloat, mask: Bool = true) -> Self {
        cornerRadius = radius
        masksToBounds = mask
        return self
    }

    /// 边框宽度
    /// - Parameter width: 宽度
    /// - Returns: 自身
    @discardableResult
    public func borderWidth(_ width: CGFloat) -> Self {
        borderWidth = width
        return self
    }

    /// 边框颜色
    /// - Parameter color: 颜色
    /// - Returns: 自身
    @discardableResult
    public func borderColor(_ color: UIColor) -> Self {
        borderColor = color.cgColor
        return self
    }

    /// 添加到父视图
    /// - Parameter superView: 父视图
    /// - Returns: 自身
    @discardableResult
    public func addLayerTo(_ superView: UIView) -> Self {
        superView.layer.addSublayer(self)
        return self
    }
}


public extension CALayer {

    /// 基础动画配置 默认配置: 执行 1 次 时长 2s 无延迟 效果慢进慢出
    /// - Parameters:
    ///   - keyPath: 动画类型
    ///   - fromValue: 开始值
    ///   - toValue: 结束值
    ///   - duration: 动画持续时间 单位 s
    ///   - delay: 延迟时间 单位 s
    ///   - repeatCount: 动画重复次数
    ///   - fillMode: 动画填充模式 默认 forwards
    ///   - speed: 动画速度 默认 1.0 若速度为 0 且设置对应的 timeOffset 则可暂停动画
    ///   - timeOffset: 附加的偏移量 默认 0
    ///   - repeatDuration: 动画重复的时长 默认 0
    ///   - autoreverses: 动画结束是否自动反向运动 默认 false
    ///   - isCumulative: 是否累计动画 默认 false
    ///   - removedOnCompletion: 结束后是否回到原状态 默认 false
    ///   - option: 动画的控制方式
    ///   - animationKey: 控制动画执行对应的key
    public func basicAnimationKeyPath(
        keyPath: String,
        fromValue: Any?,
        toValue: Any?,
        duration: TimeInterval = 2.0,
        delay: TimeInterval = 0,
        repeatCount: Float = 1,
        fillMode: CAMediaTimingFillMode = .forwards,
        speed: Float = 1.0,
        timeOffset: TimeInterval = 0,
        repeatDuration: TimeInterval = 0,
        autoreverses: Bool = false,
        isCumulative: Bool = false,
        removedOnCompletion: Bool = false,
        option: CAMediaTimingFunctionName = .default,
        animationKey: String?
    ) {
        let animation: CABasicAnimation = CABasicAnimation()
        animation.beginTime = delay + self.convertTime(CACurrentMediaTime(), to: nil)

        if let fValue = fromValue { animation.fromValue = fValue }
        if let tValue = toValue { animation.toValue = tValue }

        animation.keyPath = keyPath
        animation.duration = duration
        animation.fillMode = fillMode
        animation.repeatCount = repeatCount
        animation.autoreverses = autoreverses

        animation.speed = speed
        animation.timeOffset = timeOffset
        animation.repeatDuration = repeatDuration

        animation.isCumulative = isCumulative
        animation.isRemovedOnCompletion = removedOnCompletion
        animation.timingFunction = CAMediaTimingFunction(name: option)
        self.add(animation, forKey: animationKey)
    }
}

public extension CAShapeLayer {

    /// 设置路径 决定了其形状
    /// - Parameters:
    ///   - path: 路径
    /// - Returns: 自身
    @discardableResult
    public func path(_ path: CGPath) -> Self {
        self.path = path
        return self
    }

    /// 填充色
    /// - Parameters:
    ///   - color: 填充色
    /// - Returns: 自身
    @discardableResult
    public func fillColor(_ color: UIColor) -> Self {
        self.fillColor = color.cgColor
        return self
    }

    /// 线条颜色
    /// - Parameters:
    ///   - color: 线条颜色
    /// - Returns: 自身
    @discardableResult
    public func strokeColor(_ color: UIColor) -> Self {
        self.strokeColor = color.cgColor
        return self
    }

    /// path 终点样式 butt(无样式) round(圆形) square(方形)
    /// - Parameters:
    ///   - cap: 终点样式
    /// - Returns: 自身
    @discardableResult
    public func lineCap(_ cap: CAShapeLayerLineCap) -> Self {
        self.lineCap = cap
        return self
    }

    /// 路径连接部分的拐角样式 miter(尖状) round(圆形) bevel(平形)
    /// - Parameters:
    ///   - join: 拐角样式
    /// - Returns: 自身
    @discardableResult
    public func lineJoin(_ join: CAShapeLayerLineJoin) -> Self {
        self.lineJoin = join
        return self
    }
}

