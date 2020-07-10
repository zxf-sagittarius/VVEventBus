//
//  VVEvent.m
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/6.
//

#import "VVEvent.h"
#import "VVPassthroughSubscriber.h"
#import "VVCompoundDisposable.h"
#import "VVAction.h"

@interface VVEvent () {
    NSMutableDictionary *_params;
}

@property (nonatomic, strong) NSMutableArray<id <VVActionSubscriber>> *subscribers;

@property (nonatomic, strong) VVCompoundDisposable *compoundDisposable;

@end

@implementation VVEvent

- (instancetype)init
{
    self = [super init];
    if (self) {
        _compoundDisposable = [VVCompoundDisposable compoundDisposable];
    }
    return self;
}

- (NSDictionary *)params {
    return _params ? [_params copy] : nil;
}

- (void)setParam:(NSString *)param forKey:(NSString *)key {
    if (!_params) {
        _params = @{}.mutableCopy;
    }
    [_params setValue:param forKey:key];
}

- (instancetype)initWithEvent:(NSString *)event identifier:(NSString *)identifier poster:(id)poster {
    if (self = [super init]) {
        _name = event;
        _identifier = identifier;
        _poster = poster;
    }
    return self;
}

- (VVCompoundDisposable *)execute:(NSArray <VVAction *> *)actions {
    return [self execute:actions next:nil];
}

- (VVCompoundDisposable *)execute:(NSArray <VVAction *> *)actions
                      next:(nullable void (^)(id _Nullable value))next {
    
    for (int i = 0; i < actions.count; i ++) {
        VVAction *action = actions[i];
        
        VVCompoundDisposable *currentDisposable = [VVCompoundDisposable compoundDisposable];
        VVActionSubscriber *innerSubscriber = [VVActionSubscriber subscriberWithPoster:self.poster
                                                                              event:self next:next
                                                                          completed:^{
            [currentDisposable dispose];
        }];
        VVPassthroughSubscriber *subscriber = [[VVPassthroughSubscriber alloc] initWithSubscriber:innerSubscriber disposable:currentDisposable];
        VVDisposable *disposable = [action execute:subscriber];
        [currentDisposable addDisposable:disposable];
        
        if (!currentDisposable.disposed) {
            [self.compoundDisposable addDisposable:currentDisposable];
        }
    }
    return self.compoundDisposable;
}

- (void)dealloc {
    [self.compoundDisposable dispose];
}

@end
