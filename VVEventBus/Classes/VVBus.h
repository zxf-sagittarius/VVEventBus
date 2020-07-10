//
//  VVBus.h
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/6.
//

#import <Foundation/Foundation.h>
#import "VVActionReporter.h"
#import "VVEvent.h"
#import "VVDisposable.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBus : NSObject

- (VVDisposable *)hitEvent:(VVEvent *)event;
- (VVDisposable *)hitEvent:(VVEvent *)event next:(nullable void(^)(id _Nullable value))next;

// target-action 方式注册
- (void)registAction:(nonnull NSString *)action
              target:(nonnull id)target
             onEvent:(nonnull NSString *)event;

// block 方式注册
- (void)registAction:(nonnull VVDisposable  * _Nullable (^)(id<VVActionReporter> _Nonnull reporter))action
             onEvent:(nonnull NSString *)event;

@end

NS_ASSUME_NONNULL_END
