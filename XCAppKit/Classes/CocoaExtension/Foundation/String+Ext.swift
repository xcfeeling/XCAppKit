//
//  String+Ext.swift
//  KuJiangNovel
//
//  Created by xucheng on 2018/9/5.
//  Copyright © 2018年 陈品. All rights reserved.
//

import Foundation
import CommonCrypto
import CryptoKit

public extension String {
    /**
     String 的 length
     
     - returns: Int
     */
//    var length:Int {
//        return (self as NSString).length
//    }
//
    public var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }

    //Range转换为NSRange
    public func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }

    //NSRange转换为Range
//    func range(from nsRange: NSRange) -> Range<String.Index>? {
//        return Range(nsRange, in: self)
//    }
//
//    func trim() -> String {
//        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//    }

    public func trimTheExtraSpaces() -> String {
        return self.replacing(pattern: "\\s*\\n+\\s*", template: "\n　　")
    }

    /// 计算字符串大小
    public func size(font:UIFont, constrainedToSize:CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) -> CGSize {
        let string:NSString = self as NSString

        return string.boundingRect(with: constrainedToSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font:font], context: nil).size
    }

    /// 正则替换字符
    public func replacing(pattern:String, template:String) -> String {
        if isEmpty { return self }

        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)

            return regularExpression.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: self.length), withTemplate: template)
        } catch { return self }
    }

    /// 正则搜索相关字符位置
    public func matches(pattern:String) -> [NSTextCheckingResult] {
        if isEmpty { return [] }

        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)

            return regularExpression.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: length))
        } catch { return [] }
    }

    /// 是否存在正则匹配到的内容
    public func isExist(pattern:String) -> Bool {
        let result:[NSTextCheckingResult] = matches(pattern: pattern)

        return !result.isEmpty
    }

    public func replacePhone() -> String {
        if isEmpty { return self }

        let start = self.index(self.startIndex, offsetBy: 3)
        let end = self.index(self.startIndex, offsetBy: 7)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return self.replacingCharacters(in: range, with: "****")
    }
    
    public var isNotEmpty: Bool {
        return self.isEmpty == false
    }
    
    /// 截取特定范围的字符串 索引从 0 开始
    /// - Parameters:
    ///   - location: 开始的索引位置
    ///   - length: 截取长度
    /// - Returns: 字符串
    public func substring(at location: Int, length: Int) -> String {
        if location > self.count || (location+length > self.count) {
            assert(location < self.count && location+length <= self.count, "越界, 检查设置的范围")
        }
        var subStr: String = ""
        for idx in location..<(location+length) {
            subStr += self[self.index(self.startIndex, offsetBy: idx)].description
        }
        return subStr
    }
    
    
    /// 段落格式化
    /// - Returns: <#description#>
    public func stringByParagraphUnTrim() -> String {
        let scanner = Scanner(string: self)
        scanner.charactersToBeSkipped = nil
        let result = NSMutableString()
        var temp: NSString?

        let newLineAndWhitespaceCharacters = CharacterSet.newlines
        // Scan
        while !scanner.isAtEnd {
            // Get non new line or whitespace characters
            scanner.scanUpToCharacters(from: newLineAndWhitespaceCharacters, into: &temp)
            if let nonWhitespace = temp {
                result.append("　　")
                result.append(nonWhitespace as String)
            }

            // Replace with \n
            if scanner.scanCharacters(from: newLineAndWhitespaceCharacters, into: nil) {
                if result.length > 0 && !scanner.isAtEnd {
                    result.append("\n")
                }
            }
        }

        return result as String
    }
}

// MARK:- 0：字符串基本的扩展
public extension String {

   // MARK: 0.2、判断是否包含某个子串
   /// 判断是否包含某个子串
   /// - Parameter find: 子串
   /// - Returns: Bool
    public func contains(find: String) -> Bool {
       return self.range(of: find) != nil
   }

   // MARK: 0.3、判断是否包含某个子串 -- 忽略大小写
   ///  判断是否包含某个子串 -- 忽略大小写
   /// - Parameter find: 子串
   /// - Returns: Bool
    public func containsIgnoringCase(find: String) -> Bool {
       return self.range(of: find, options: .caseInsensitive) != nil
   }

   // MARK: 0.4、字符串转 Base64
   /// 字符串转 Base64
    public var base64: String? {
       guard let plainData = (self as NSString).data(using: String.Encoding.utf8.rawValue) else {
           return nil
       }
       let base64String = plainData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
       return base64String
   }

   // MARK: 0.5、将16进制字符串转为Int
   /// 将16进制字符串转为Int
    public var hexInt: Int {
       return Int(self, radix: 16) ?? 0
   }

   // MARK: 0.6、判断是不是九宫格键盘
   /// 判断是不是九宫格键盘
    public func isNineKeyBoard() -> Bool {
       let other : NSString = "➋➌➍➎➏➐➑➒"
       let len = self.count
       for _ in 0..<len {
           if !(other.range(of: self).location != NSNotFound) {
               return false
           }
       }
       return true
   }

   // MARK: 0.7、字符串转 UIViewController
   /// 字符串转 UIViewController
   /// - Returns: 对应的控制器
   @discardableResult
    public func toViewController() -> UIViewController? {
       // 1.动态获取命名空间
       let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
       // 2.将字符串转换为类
       // 2.1.默认情况下命名空间就是项目的名称，但是命名空间的名称是可以更改的
       guard let Class: AnyClass = NSClassFromString(namespace + "." + self) else {
           return nil
       }
       // 3.通过类创建对象
       // 3.1.将AnyClass 转化为指定的类
       let vcClass = Class as! UIViewController.Type
       // 4.通过class创建对象
       let vc = vcClass.init()
       return vc
   }

   // MARK: 0.8、字符串转 AnyClass
   /// 字符串转 AnyClass
   /// - Returns: 对应的 Class
   @discardableResult
    public func toClass() -> AnyClass? {
       // 1.动态获取命名空间
       let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
       // 2.将字符串转换为类
       // 2.1.默认情况下命名空间就是项目的名称，但是命名空间的名称是可以更改的
       guard let Class: AnyClass = NSClassFromString(namespace + "." + self) else {
           return nil
       }
       return Class
   }
    
    // MARK: 1.11、JSON 字符串 ->  Dictionary
     /// JSON 字符串 ->  Dictionary
     /// - Returns: Dictionary
     func jsonStringToDictionary() -> Dictionary<String, Any>? {
         let jsonString = self
         let jsonData: Data = jsonString.data(using: .utf8)!
         let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
         if dict != nil {
             return (dict as! Dictionary<String, Any>)
         }
         return nil
     }
     
     // MARK: 1.12、JSON 字符串 -> Array
     /// JSON 字符串 ->  Array
     /// - Returns: Array
     func jsonStringToArray() -> Array<Any>? {
         let jsonString = self
         let jsonData:Data = jsonString.data(using: .utf8)!
         let array = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
         if array != nil {
             return (array as! Array<Any>)
         }
         return nil
     }
}

// MARK:- 二、iOS CharacterSet（字符集）
/**
 CharacterSet是在Foundation框架下的一个结构体，用于搜索操作的一组Unicode字符值。官方的API地址：https://developer.apple.com/documentation/foundation/characterset
 概述
 字符集表示一组符合unicode的字符。基础类型使用字符集将字符组合在一起进行搜索操作，以便在搜索期间可以找到任何特定的字符集。
 这种类型提供了“写时复制”的行为，并且还连接到Objective-C NSCharacterSet类。
 总之就是将unicode字符，按组分类，便于搜索查找，验证字符串。通常我们在一些场景下会用到一个字符串是否包含某种特定字符，比如判断密码是否只包含数字，检查url是否有不规范字符，删除多余空格等操作

 属性                                    描述
 CharacterSet.alphanumerics

 controlCharacters:                     控制符
 whitespaces:                           空格
 whitespacesAndNewlines:                空格和换行
 decimalDigits:                         0-9的数字，也不包含小数点
 letters:                               所有英文字母，包含大小写 65-90 97-122
 lowercaseLetters:                      小写英文字母 97-122
 uppercaseLetters:                      大写英文字母 65-90
 nonBaseCharacters:                     非基础字符 M*
 alphanumerics:                         字母和数字的组合，包含大小写, 不包含小数点
 decomposables:                         可分解
 illegalCharacters:                     不合规字符，没有在Unicode 3.2 标准中定义的字符
 punctuationCharacters:                 标点符号，连接线，引号什么的 P*
 capitalizedLetters:                    字母，首字母大写，Lt类别
 symbols:                               符号，包含S* 所有内容，运算符，货币符号什么的
 newlines:                              返回一个包含换行符的字符集，U+000A ~ U+000D, U+0085, U+2028, and U+2029
 urlUserAllowed:
 urlPasswordAllowed:
 urlHostAllowed:
 urlPathAllowed:
 urlQueryAllowed:
 urlFragmentAllowed:
 bitmapRepresentation:
 inverted:                               相反的字符集。例如 CharacterSet.whitespaces.inverted 就是没有空格
*/
public extension String {

    // MARK: 2.1、去除字符串前后的 空格
    /// 去除字符串前后的换行和换行
    public var removeBeginEndAllSapcefeed: String {
        let resultString = self.trimmingCharacters(in: CharacterSet.whitespaces)
        return resultString
    }

    // MARK: 2.2、去除字符串前后的 换行
    /// 去除字符串前后的 换行
    public var removeBeginEndAllLinefeed: String {
        let resultString = self.trimmingCharacters(in: CharacterSet.newlines)
        return resultString
    }

    // MARK: 2.3、去除字符串前后的 换行和空格
    /// 去除字符串前后的 换行和空格
    public var removeBeginEndAllSapceAndLinefeed: String {
        var resultString = self.trimmingCharacters(in: CharacterSet.whitespaces)
        resultString = resultString.trimmingCharacters(in: CharacterSet.newlines)
        return resultString
    }

    // MARK: 2.4、去掉所有空格
    /// 去掉所有空格
    public var removeAllSapce: String {
        return replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }

    // MARK: 2.5、去掉所有换行
    /// 去掉所有换行
    public var removeAllLinefeed: String {
        return replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
    }

    // MARK: 2.6、去掉所有空格 和 换行
    /// 去掉所有的空格 和 换行
    public var removeAllLineAndSapcefeed: String {
        // 去除所有的空格
        var resultString = replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        // 去除所有的换行
        resultString = resultString.replacingOccurrences(of: "\n", with: "", options: .literal, range: nil)
        return resultString
    }

    // MARK: 2.7、是否是 0-9 的数字，也不包含小数点
    /// 是否是 0-9 的数字，也不包含小数点
    /// - Returns: 结果
    public func isValidNumber() -> Bool {
        /// 0-9的数字，也不包含小数点
        let rst: String = self.trimmingCharacters(in: .decimalDigits)
        if rst.count > 0 {
            return false
        }
        return true
    }

    // MARK: 2.8、url进行编码
    /// url 进行编码
    /// - Returns: 返回对应的URL
    public func urlValidate() -> URL {
        return URL(string: self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) ?? "")!
    }

    // MARK: 2.9、某个字符使用某个字符替换掉
    /// 某个字符使用某个字符替换掉
    /// - Parameters:
    ///   - removeString: 原始字符
    ///   - replacingString: 替换后的字符
    /// - Returns: 替换后的整体字符串
    public func removeSomeStringUseSomeString(removeString: String, replacingString: String = "") -> String {
        return replacingOccurrences(of: removeString, with: replacingString)
    }

    // MARK: 2.10、使用正则表达式替换某些子串
    /// 使用正则表达式替换
    /// - Parameters:
    ///   - pattern: 正则
    ///   - with: 用来替换的字符串
    ///   - options: 策略
    /// - Returns: 返回替换后的字符串
    public func pregReplace(pattern: String, with: String,
                 options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                          range: NSMakeRange(0, self.count),
                                          withTemplate: with)
    }

    // MARK: 2.11、删除指定的字符
    /// 删除指定的字符
    /// - Parameter characterString: 指定的字符
    /// - Returns: 返回删除后的字符
    public func removeCharacter(characterString: String) -> String {
        let characterSet = CharacterSet(charactersIn: characterString)
        return trimmingCharacters(in: characterSet)
    }
}

// MARK:- 三、字符串的转换
public extension String {

    // MARK: 3.1、字符串 转 CGFloat
    /// 字符串 转 Float
    /// - Returns: CGFloat
    public func toCGFloat() -> CGFloat? {
        if let doubleValue = Double(self) {
            return CGFloat(doubleValue)
        }
        return nil
    }

    // MARK: 3.2、字符串转 bool
    /// 字符串转 bool
    public var bool: Bool? {
        switch self.lowercased() {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }

    // MARK: 3.3、字符串转 Int
    /// 字符串转 Int
    /// - Returns: Int
    public func toInt() -> Int? {
        if let num = NumberFormatter().number(from: self) {
            return num.intValue
        } else {
            return nil
        }
    }

    // MARK: 3.4、字符串转 Double
    /// 字符串转 Double
    /// - Returns: Double
    public func toDouble() -> Double? {
        if let num = NumberFormatter().number(from: self) {
            return num.doubleValue
        } else {
            return nil
       }
    }

    // MARK: 3.5、字符串转 Float
    /// 字符串转 Float
    /// - Returns: Float
    public func toFloat() -> Float? {
        if let num = NumberFormatter().number(from: self) {
            return num.floatValue
        } else {
            return nil
        }
    }

    // MARK: 3.6、字符串转 Bool
    /// 字符串转 Bool
    /// - Returns: Bool
    public func toBool() -> Bool? {
        let trimmedString = lowercased()
        if trimmedString == "true" || trimmedString == "false" {
            return (trimmedString as NSString).boolValue
        }
        return nil
    }

    // MARK: 3.7、字符串转 NSString
    /// 字符串转 NSString
    public var toNSString: NSString {
        return self as NSString
    }
}

// MARK:- 四、字符串UI的处理

extension String {

    // MARK: 4.1、对字符串(多行)指定出字体大小和最大的 Size，获取 (Size)
    /// 对字符串(多行)指定出字体大小和最大的 Size，获取展示的 Size
    /// - Parameters:
    ///   - font: 字体大小
    ///   - size: 字符串的最大宽和高
    /// - Returns: 按照 font 和 Size 的字符的Size
    public func rectSize(font: UIFont, size: CGSize) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        /**
         usesLineFragmentOrigin: 整个文本将以每行组成的矩形为单位计算整个文本的尺寸
         usesFontLeading:
         usesDeviceMetrics:
         @available(iOS 6.0, *)
         truncatesLastVisibleLine:
         */
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect: CGRect = self.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        return rect.size
    }

    // MARK: 4.2、对字符串(多行)指定字体及Size，获取 (高度)
    /// 对字符串指定字体及Size，获取 (高度)
    /// - Parameters:
    ///   - font: 字体的大小
    ///   - size: 字体的size
    /// - Returns: 返回对应字符串的高度
    public func rectHeight(font: UIFont, size: CGSize) -> CGFloat {
        return rectSize(font: font, size: size).height
    }

    // MARK: 4.3、对字符串(多行)指定字体及Size，获取 (宽度)
    /// 对字符串指定字体及Size，获取 (宽度)
    /// - Parameters:
    ///   - font: 字体的大小
    ///   - size: 字体的size
    /// - Returns: 返回对应字符串的宽度
    public func rectWidth(font: UIFont, size: CGSize) -> CGFloat {
        return rectSize(font: font, size: size).width
    }

    // MARK: 4.4、对字符串(单行)指定字体，获取 (Size)
    /// 对字符串(单行)指定字体，获取 (Size)
    /// - Parameter font: 字体的大小
    /// - Returns: 返回单行字符串的 size
    public func singleLineSize(font: UIFont) -> CGSize {
        let attrs = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attrs as [NSAttributedString.Key: Any])
    }

    // MARK: 4.5、对字符串(单行)指定字体，获取 (width)
    /// 对字符串(单行)指定字体，获取 (width)
    /// - Parameter font: 字体的大小
    /// - Returns: 返回单行字符串的 width
    public func singleLineWidth(font: UIFont) -> CGFloat {
        let attrs = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attrs as [NSAttributedString.Key: Any]).width
    }

    // MARK: 4.6、对字符串(单行)指定字体，获取 (Height)
    /// 对字符串(单行)指定字体，获取 (height)
    /// - Parameter font: 字体的大小
    /// - Returns: 返回单行字符串的 height
    public func singleLineHeight(font: UIFont) -> CGFloat {
        let attrs = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: attrs as [NSAttributedString.Key: Any]).height
    }
}

// MARK:- 八、字符串的一些正则校验
extension String {

    // MARK: 8.1、判断是否全是空白,包括空白字符和换行符号，长度为0返回true
    /// 判断是否全是空白,包括空白字符和换行符号，长度为0返回true
    public var isBlank: Bool {
        return trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines) == ""
    }

    // MARK: 8.2、判断是否全十进制数字，长度为0返回false
    /// 判断是否全十进制数字，长度为0返回false
    public var isDecimalDigits: Bool {
        if isEmpty {
            return false
        }
        // 去除什么的操作
        return trimmingCharacters(in: NSCharacterSet.decimalDigits) == ""
    }

    // MARK: 8.3、判断是否是整数
    /// 判断是否是整数
    public var isPureInt: Bool {
        let scan: Scanner = Scanner(string: self)
        var n: Int = 0
        return scan.scanInt(&n) && scan.isAtEnd
    }

    // MARK: 8.4、判断是否是Float,此处Float是包含Int的，即Int是特殊的Float
    /// 判断是否是Float，此处Float是包含Int的，即Int是特殊的Float
    public var isPureFloat: Bool {
        let scan: Scanner = Scanner(string: self)
        var n: Float = 0.0
        return scan.scanFloat(&n) && scan.isAtEnd
    }

    // MARK: 8.5、判断是否全是字母，长度为0返回false
    /// 判断是否全是字母，长度为0返回false
    public var isLetters: Bool {
        if isEmpty {
            return false
        }
        return trimmingCharacters(in: NSCharacterSet.letters) == ""
    }

    // MARK: 8.6、判断是否是中文, 这里的中文不包括数字及标点符号
    /// 判断是否是中文, 这里的中文不包括数字及标点符号
    public var isChinese: Bool {
        let mobileRgex = "(^[\u{4e00}-\u{9fef}]+$)"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
        return checker.evaluate(with: self)
    }

    // MARK: 8.7、是否是有效昵称，即允许“中文”、“英文”、“数字”
    /// 是否是有效昵称，即允许“中文”、“英文”、“数字”
    public var isValidNickName: Bool {
        let rgex = "(^[\u{4e00}-\u{9faf}_a-zA-Z0-9]+$)"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", rgex)
        return checker.evaluate(with: self)
    }

    // MARK: 8.8、判断是否是有效的手机号码
    /// 判断是否是有效的手机号码
    public var isValidMobile: Bool {
        let mobileRgex = "^((13[0-9])|(14[5,7])|(15[0-3,5-9])|(17[0,3,5-8])|(18[0-9])|166|195|198|199)\\d{8}$"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
        return checker.evaluate(with: self)
    }

    // MARK: 8.9、判断是否是有效的电子邮件地址
    /// 判断是否是有效的电子邮件地址
    public var isValidEmail: Bool {
        let mobileRgex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
        return checker.evaluate(with: self)
    }

    // MARK: 8.10、判断是否有效的身份证号码，不是太严格
    /// 判断是否有效的身份证号码，不是太严格
    public var isValidIDCardNumber: Bool {
        let mobileRgex = "^(\\d{15})|((\\d{17})(\\d|[X]))$"
        let checker: NSPredicate = NSPredicate(format: "SELF MATCHES %@", mobileRgex)
        return checker.evaluate(with: self)
    }

    // MARK: 8.11、严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
    /// 严格判断是否有效的身份证号码,检验了省份，生日，校验位，不过没检查市县的编码
    public var isValidIDCardNumStrict: Bool {
        let str = trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        let len = str.count
        if !str.isValidIDCardNumber {
            return false
        }
        // 省份代码
        let areaArray = ["11", "12", "13", "14", "15", "21", "22", "23", "31", "32", "33", "34", "35", "36", "37", "41", "42", "43", "44", "45", "46", "50", "51", "52", "53", "54", "61", "62", "63", "64", "65", "71", "81", "82", "91"]
        if !areaArray.contains(str.sub(to: 2)) {
            return false
        }
        var regex = NSRegularExpression()
        var numberOfMatch = 0
        var year = 0
        switch len {
        case 15:
            // 15位身份证
            // 这里年份只有两位，00被处理为闰年了，对2000年是正确的，对1900年是错误的，不过身份证是1900年的应该很少了
            year = Int(str.sub(start: 6, length: 2))!
            if isLeapYear(year: year) { // 闰年
                do {
                    // 检测出生日期的合法性
                    regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$", options: .caseInsensitive)
                } catch {}
            } else {
                do {
                    // 检测出生日期的合法性
                    regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$", options: .caseInsensitive)
                } catch {}
            }
            numberOfMatch = regex.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, len))

            if numberOfMatch > 0 {
                return true
            } else {
                return false
            }
        case 18:
            // 18位身份证
            year = Int(str.sub(start: 6, length: 4))!
            if isLeapYear(year: year) {
                // 闰年
                do {
                    // 检测出生日期的合法性
                    regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$", options: .caseInsensitive)
                } catch {}
            } else {
                do {
                    // 检测出生日期的合法性
                    regex = try NSRegularExpression(pattern: "^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$", options: .caseInsensitive)
                } catch {}
            }
            numberOfMatch = regex.numberOfMatches(in: str, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, len))
            if numberOfMatch > 0 {
                var s = 0
                let jiaoYan = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3]
                for i in 0 ..< 17 {
                    if let d = Int(str.slice(i ..< (i + 1))) {
                        s += d * jiaoYan[i % 10]
                    } else {
                        return false
                    }
                }
                let Y = s % 11
                let JYM = "10X98765432"
                let M = JYM.sub(start: Y, length: 1)
                if M == str.sub(start: 17, length: 1) {
                   return true
                } else {
                    return false
                }
            } else {
                return false
            }
        default:
            return false
        }
    }
        
    // MARK: 8.12、校验字符串位置是否合理，并返回String.Index
    /// 校验字符串位置是否合理，并返回String.Index
    /// - Parameter original: 位置
    /// - Returns: String.Index
    public func validIndex(original: Int) -> String.Index {
        switch original {
        case ...startIndex.utf16Offset(in: self):
             return startIndex
        case endIndex.utf16Offset(in: self)...:
             return endIndex
        default:
             return index(startIndex, offsetBy: original)
        }
    }

    // MARK: 8.13、隐藏手机号中间的几位
    /// 隐藏手机号中间的几位
    /// - Parameter combine: 隐藏的字符串(替换的类型)
    /// - Returns: 返回隐藏的手机号
    public func hidePhone(combine: String = "****") -> String {
         if self.count >= 11 {
            let pre = self.sub(start: 0, length: 3)
            let post = self.sub(start: 7, length: 4)
            return pre + combine + post
        } else {
            return self
        }
    }

    // MARK:- private 方法
    // MARK: 是否是闰年
    /// 是否是闰年
    /// - Parameter year: 年份
    /// - Returns: 返回是否是闰年
    private func isLeapYear(year: Int) -> Bool {
        if year % 400 == 0 {
            return true
        } else if year % 100 == 0 {
            return false
        } else if year % 4 == 0 {
            return true
        } else {
            return false
        }
    }
}

// MARK:- 九、字符串截取的操作
extension String {

    // MARK: 9.1、截取字符串从开始到 index
    /// 截取字符串从开始到 index
    /// - Parameter index: 截取到的位置
    /// - Returns: 截取后的字符串
    public func sub(to index: Int) -> String {
        let end_Index = validIndex(original: index)
        return String(self[startIndex ..< end_Index])
    }

    // MARK: 9.2、截取字符串从index到结束
    /// 截取字符串从index到结束
   /// - Parameter index: 截取结束的位置
    /// - Returns: 截取后的字符串
    public func sub(from index: Int) -> String {
        let start_index = validIndex(original: index)
        return String(self[start_index ..< endIndex])
    }

    // MARK: 9.3、获取指定位置和长度的字符串
    /// 获取指定位置和大小的字符串
    /// - Parameters:
    ///   - start: 开始位置
    ///   - length: 长度
    /// - Returns: 截取后的字符串
    public func sub(start: Int, length: Int = -1) -> String {
        var len = length
        if len == -1 {
            len = count - start
        }
        let st = index(startIndex, offsetBy: start)
        let en = index(st, offsetBy: len)
        let range = st ..< en
        return String(self[range]) // .substring(with:range)
    }

    // MARK: 9.4、切割字符串(区间范围 前闭后开)
    /**
     https://blog.csdn.net/wang631106979/article/details/54098910
     CountableClosedRange：可数的闭区间，如 0...2
     CountableRange：可数的开区间，如 0..<2
     ClosedRange：不可数的闭区间，如 0.1...2.1
     Range：不可数的开居间，如 0.1..<2.1
     */
    /// 切割字符串(区间范围 前闭后开)
    /// - Parameter range: 范围
    /// - Returns: 切割后的字符串
    public func slice(_ range: CountableRange<Int>) -> String { // 如 sliceString(2..<6)
        /**
         upperBound（上界）
         lowerBound（下界）
         */
        let startIndex = validIndex(original: range.lowerBound)
        let endIndex = validIndex(original: range.upperBound)
        guard startIndex < endIndex else {
            return ""
        }
        return String(self[startIndex ..< endIndex])
    }

    // MARK: 9.5、用整数返回子字符串开始的位置
    /// 用整数返回子字符串开始的位置
    /// - Parameter sub: 字符串
    /// - Returns: 返回字符串的位置
    public func position(of sub: String) -> Int {
        if sub.isEmpty {
            return 0
        }
        var pos = -1
        if let range = self.range(of: sub) {
            if !range.isEmpty {
                pos = distance(from: startIndex, to: range.lowerBound)
            }
        }
        return pos
    }
}

// MARK:- 十、字符串编码的处理
extension String {

    // MARK: 10.1、特殊字符编码处理urlEncoded
    /// url编码 默认urlQueryAllowed
    public func urlEncoding(characters: CharacterSet = .urlQueryAllowed) -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
        characters)
        return encodeUrlString ?? ""
    }

    // MARK:- 10.2、url编码 Alamofire AFNetworking 处理方式 推荐使用
    /// url编码 Alamofire AFNetworking 处理方式 推荐使用
    public var urlEncoded: String {
        // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
    
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
    allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
        allowedCharacterSet)
        return encodeUrlString ?? ""
    }

    // MARK: 10.3、url编码 会对所有特殊字符做编码  特殊情况下使用
    /// url编码 会对所有特殊字符做编码  特殊情况下使用
    public var urlAllEncoded: String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;=/?_-.~"
    
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
    allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
        allowedCharacterSet)
        return encodeUrlString ?? ""
    }
}
