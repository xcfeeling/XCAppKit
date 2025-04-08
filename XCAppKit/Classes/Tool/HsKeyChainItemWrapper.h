//
//  HsKeyChainItemWrapper.h
//  HsAppKit
//
//  Created by 陈品 on 2024/5/8.
//

#import <Foundation/Foundation.h>

extern  NSString * const kHsService;
extern  NSString * const kHsUdidAccount;

NS_CLASS_AVAILABLE_IOS(8_0)
@interface HsKeyChainItemWrapper : NSObject

+ (NSString *)hsUdid;
+ (NSString *)saveUdid:(NSString *)udid;

+ (BOOL)saveOrUpdatePassword:(NSString *)password account:(NSString *)account service:(NSString *)service ;
+ (NSDictionary *)fetchPasswordWithAccount:(NSString *)account service:(NSString *)service ;
+ (BOOL)deletePasswordWithAccount:(NSString *)account service:(NSString *)service ;

+ (BOOL)saveOrUpdatePassword:(NSString *)password account:(NSString *)account service:(NSString *)service accessGroup:(NSString *)accessGroup;
+ (NSDictionary *)fetchPasswordWithAccount:(NSString *)account service:(NSString *)service accessGroup:(NSString *)accessGroup;
+ (BOOL)deletePasswordWithAccount:(NSString *)account service:(NSString *)service accessGroup:(NSString *)accessGroup;

@end
