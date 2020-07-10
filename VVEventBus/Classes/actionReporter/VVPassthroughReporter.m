//
//  VVPassthroughReporter.m
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/9.
//

#import "VVPassthroughReporter.h"
#import "VVCompoundDisposable.h"

@interface VVPassthroughReporter ()

@property (nonatomic, strong, readonly) id<VVActionReporter> innerReporter;

@property (nonatomic, strong, readonly) VVCompoundDisposable *disposable;

@end


@implementation VVPassthroughReporter

@synthesize poster, event;

- (instancetype)initWithReporter:(id<VVActionReporter>)reporter
                        disposable:(VVCompoundDisposable *)disposable {
    if (self = [super init]) {
        
        _innerReporter = reporter;
        _disposable = disposable;
        self.poster = reporter.poster;
        self.event = reporter.event;
        [self.innerReporter tailAction:self.disposable];
    }
    return self;
}

- (void)reportEvent:(id)value {
    if (self.disposable.disposed) return;
    [self.innerReporter reportEvent:value];
}


- (void)reportCompleted {
    if (self.disposable.disposed) return;
    [self.innerReporter reportCompleted];
}

- (void)tailAction:(nonnull VVCompoundDisposable *)disposable {
    if (disposable != self.disposable) {
        [self.disposable addDisposable:disposable];
    }
}

@end
