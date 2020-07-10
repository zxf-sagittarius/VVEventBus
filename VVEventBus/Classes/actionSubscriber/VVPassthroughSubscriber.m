//
//  VVPassthroughSubscriber.m
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/9.
//

#import "VVPassthroughSubscriber.h"
#import "VVCompoundDisposable.h"

@interface VVPassthroughSubscriber ()

@property (nonatomic, strong, readonly) id<VVActionSubscriber> innerSubscriber;

@property (nonatomic, strong, readonly) VVCompoundDisposable *disposable;

@end


@implementation VVPassthroughSubscriber

@synthesize poster, event;

- (instancetype)initWithSubscriber:(id<VVActionSubscriber>)subscriber
                        disposable:(VVCompoundDisposable *)disposable {
    if (self = [super init]) {
        
        _innerSubscriber = subscriber;
        _disposable = disposable;
        self.poster = subscriber.poster;
        self.event = subscriber.event;
        [self.innerSubscriber didSubscribeAction:self.disposable];
    }
    return self;
}

- (void)sendNext:(id)value {
    if (self.disposable.disposed) return;
    [self.innerSubscriber sendNext:value];
}


- (void)sendCompleted {
    if (self.disposable.disposed) return;
    [self.innerSubscriber sendCompleted];
}

- (void)didSubscribeAction:(nonnull VVCompoundDisposable *)disposable {
    if (disposable != self.disposable) {
        [self.disposable addDisposable:disposable];
    }
}

@end
