//
//  VVActionSubscriber.m
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/8.
//

#import "VVActionSubscriber.h"
#include "VVEvent.h"
#import "VVCompoundDisposable.h"

@interface VVActionSubscriber ()

@property (nonatomic, copy) void(^next)(id value);
@property (nonatomic, copy) void(^completed)(void);

@property (nonatomic, strong) VVCompoundDisposable *disposable;

@end

@implementation VVActionSubscriber

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

+ (instancetype)subscriberWithPoster:(id)poster
                               event:(VVEvent *)event
                                next:(void (^)(id x))next
                           completed:(void (^)(void))completed{
    
    VVActionSubscriber *actionSubscriber = [[VVActionSubscriber alloc] init];
    actionSubscriber.next = [next copy];
    actionSubscriber.completed = [completed copy];
    actionSubscriber.poster = poster;
    actionSubscriber.event = event;
    return actionSubscriber;
}

#pragma VVActionSubscriber

@synthesize event;

@synthesize poster;

- (void)didSubscribeAction:(nonnull VVCompoundDisposable *)disposable {
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

- (void)sendCompleted {
    @synchronized (self) {
        void(^completedBlock)(void) = [self.completed copy];
        [self.disposable dispose];
        if (completedBlock) {
            completedBlock();
        }
    }
}

- (void)sendNext:(nullable id)value {
    @synchronized (self) {
        void(^nextBlock)(id value) = [self.next copy];
        if (nextBlock) {
            nextBlock(value);
        }
    }
}

@end
