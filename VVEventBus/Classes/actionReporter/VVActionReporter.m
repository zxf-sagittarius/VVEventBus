//
//  VVActionReporter.m
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/8.
//

#import "VVActionReporter.h"
#include "VVEvent.h"
#import "VVCompoundDisposable.h"

@interface VVActionReporter ()

@property (nonatomic, copy) void(^next)(id value);
@property (nonatomic, copy) void(^completed)(void);

@property (nonatomic, strong) VVCompoundDisposable *disposable;

@end

@implementation VVActionReporter

- (instancetype)init {
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        VVDisposable *disposable = [VVDisposable disposableWithBlock:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            @synchronized (strongSelf) {
                self.next = nil;
                self.completed = nil;
            }
        }];
        _disposable = [VVCompoundDisposable compoundDisposable];
        [_disposable addDisposable:disposable];
    }
    return self;
}

+ (instancetype)reporterWithPoster:(id)poster
                               event:(VVEvent *)event
                                next:(void (^)(id x))next
                           completed:(void (^)(void))completed{
    
    VVActionReporter *actionReporter = [[VVActionReporter alloc] init];
    actionReporter.next = [next copy];
    actionReporter.completed = [completed copy];
    actionReporter.poster = poster;
    actionReporter.event = event;
    return actionReporter;
}

#pragma VVActionReporter

@synthesize event;

@synthesize poster;

- (void)tailAction:(nonnull VVCompoundDisposable *)disposable {
    if (disposable.disposed) return;
    [self.disposable addDisposable:disposable];
    __weak typeof(self) weakSelf = self;
    __weak typeof (disposable) weakDisposable = disposable;
    [disposable addDisposable:[VVDisposable disposableWithBlock:^{
        __strong typeof (weakSelf) strongSelf = weakSelf;
        __strong typeof (weakDisposable) strongDisposable = weakDisposable;
        [strongSelf.disposable removeDisposable:strongDisposable];
    }]];
}

- (void)reportCompleted {
    @synchronized (self) {
        void(^completedBlock)(void) = [self.completed copy];
        [self.disposable dispose];
        if (completedBlock) {
            completedBlock();
        }
    }
}

- (void)reportEvent:(nullable id)value {
    @synchronized (self) {
        void(^nextBlock)(id value) = [self.next copy];
        if (nextBlock) {
            nextBlock(value);
        }
    }
}

@end
