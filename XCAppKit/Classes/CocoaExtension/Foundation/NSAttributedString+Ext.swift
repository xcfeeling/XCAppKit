//
//  NSAttributedString+Ext.swift
//  KuJiangNovel
//
//  Created by xucheng on 2018/9/19.
//  Copyright © 2018年 陈品. All rights reserved.
//

import Foundation

public extension NSAttributedString {
    func parserPageRange(rect: CGRect) -> [NSRange] {
        // 记录
        var rangeArray:[NSRange] = []

        // 拼接字符串
        let frameSetter = CTFramesetterCreateWithAttributedString(self as CFAttributedString)

        let path = CGPath(rect: rect, transform: nil)

        var range = CFRangeMake(0, 0)

        var rangeOffset:NSInteger = 0

        repeat {
            let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(rangeOffset, 0), path, nil)

            range = CTFrameGetVisibleStringRange(frame)

            rangeArray.append(NSRange(location: rangeOffset, length: range.length))

            rangeOffset += range.length
        }while(range.location + range.length < self.length)

        return rangeArray
    }
}
