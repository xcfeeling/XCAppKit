//
//  HsIDFAHelper.m
//  HsAppKit
//
//  Created by 陈品 on 2024/4/26.
//

#import "HsIDFAHelper.h"

@implementation HsIDFAHelper

+ (id)idfaManager {
    Class ASIdentifierManagerClass = NSClassFromString(@"ASIdentifierManager");
    SEL sharedManagerSelector = NSSelectorFromString(@"sharedManager");
    if (![ASIdentifierManagerClass respondsToSelector:sharedManagerSelector]) {
        return nil;
    }

    id sharedManager = ((id (*)(id, SEL))[ASIdentifierManagerClass methodForSelector:sharedManagerSelector])(ASIdentifierManagerClass, sharedManagerSelector);
    return sharedManager;
}

+ (BOOL)isEnableIDFA {
    if (@available(iOS 14.5, *)) {
        Class ATTrackingManagerClass = NSClassFromString(@"ATTrackingManager");
        SEL trackingAuthorizationStatusSelector = NSSelectorFromString(@"trackingAuthorizationStatus");
        if (![ATTrackingManagerClass respondsToSelector:trackingAuthorizationStatusSelector]) {
            return NO;
        }
        NSInteger status = ((NSInteger (*)(id, SEL))[ATTrackingManagerClass methodForSelector:trackingAuthorizationStatusSelector])(ATTrackingManagerClass, trackingAuthorizationStatusSelector);
        return status == 3;
    }

    id idfaManager = [self idfaManager];
    SEL isEnableIDFASelector = NSSelectorFromString(@"isAdvertisingTrackingEnabled");
    if (![idfaManager respondsToSelector:isEnableIDFASelector]) {
        return NO;
    }

    BOOL isEnable = ((BOOL (*)(id, SEL))[idfaManager methodForSelector:isEnableIDFASelector])(idfaManager, isEnableIDFASelector);
    return isEnable;
}

+ (NSString *)idfa {
    if (![self isEnableIDFA]) {
        return nil;
    }

    id idfaManager = [self idfaManager];
    SEL advertisingIdentifierSelector = NSSelectorFromString(@"advertisingIdentifier");
    if (![idfaManager respondsToSelector:advertisingIdentifierSelector]) {
        return nil;
    }

    NSUUID *uuid = ((NSUUID * (*)(id, SEL))[idfaManager methodForSelector:advertisingIdentifierSelector])(idfaManager, advertisingIdentifierSelector);
    NSString *idfa = [uuid UUIDString];
    // 在 iOS 10.0 以后，当用户开启限制广告跟踪，advertisingIdentifier 的值将是全零
    // 00000000-0000-0000-0000-000000000000
    if ([idfa hasPrefix:@"00000000"]) {
        return nil;
    }
    
    return idfa;
}

@end
