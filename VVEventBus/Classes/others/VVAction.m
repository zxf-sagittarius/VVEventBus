//
//  VVAction.m
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/6.
//

#import "VVAction.h"

@interface VVAction ()

@property (nonatomic, copy) VVDisposable * _Nonnull (^actionBlock)(id<VVActionSubscriber> _Nonnull subscriber);

@end

@implementation VVAction

+ (instancetype)actionWithBlock:(VVDisposable * _Nonnull (^)(id<VVActionSubscriber> _Nonnull))actionBlock {
    VVAction *action = [[VVAction alloc] init];
    action.actionBlock = [actionBlock copy];
    return action;
}

- (void)dealloc {
    _actionBlock = nil;
}

- (VVDisposable *)execute:(id<VVActionSubscriber>)subscriber {
    
    VVDisposable * (^actionBlock)(VVActionSubscriber * subscriber) = [self.actionBlock copy];
    VVDisposable *disposable = nil;
    // block 形式
    if (actionBlock) {
        disposable = actionBlock(subscriber);
    }
    // target-action方式
    if (self.target && [self.target respondsToSelector:self.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:subscriber];
#pragma clang diagnostic pop
    }
    return disposable;
}

@end
