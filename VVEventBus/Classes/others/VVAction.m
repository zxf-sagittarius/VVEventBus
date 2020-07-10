//
//  VVAction.m
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/6.
//

#import "VVAction.h"

@interface VVAction ()

@property (nonatomic, copy) VVDisposable * _Nonnull (^actionBlock)(id<VVActionReporter> _Nonnull reporter);

@end

@implementation VVAction

+ (instancetype)actionWithBlock:(VVDisposable * _Nonnull (^)(id<VVActionReporter> _Nonnull))actionBlock {
    VVAction *action = [[VVAction alloc] init];
    action.actionBlock = [actionBlock copy];
    return action;
}

- (void)dealloc {
    _actionBlock = nil;
}

- (VVDisposable *)execute:(id<VVActionReporter>)reporter {
    
    VVDisposable * (^actionBlock)(VVActionReporter * reporter) = [self.actionBlock copy];
    VVDisposable *disposable = nil;
    // block 形式
    if (actionBlock) {
        disposable = actionBlock(reporter);
    }
    // target-action方式
    if (self.target && [self.target respondsToSelector:self.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.target performSelector:self.selector withObject:reporter];
#pragma clang diagnostic pop
    }
    return disposable;
}

@end
