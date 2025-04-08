//
//  HsIDFAHelper.h
//  HsAppKit
//
//  Created by 陈品 on 2024/4/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HsIDFAHelper : NSObject

/**
 获取设备的 IDFA

 @return idfa
 */
+ (nullable NSString *)idfa;

@end

NS_ASSUME_NONNULL_END
