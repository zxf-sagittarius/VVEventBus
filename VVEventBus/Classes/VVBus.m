//
//  VVBus.m
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/6.
//

#import "VVBus.h"
#import "VVAction.h"
#import "VVBusStations.h"
#import "VVEvent.h"
#import "VVCompoundDisposable.h"

@interface VVBus ()

@property (nonatomic, strong) VVBusStations *stations;

@end

@implementation VVBus

- (VVBusStations *)stations {
    if (!_stations) {
        _stations = [[VVBusStations alloc] init];
    }
    return _stations;
}

- (void)registAction:(VVDisposable * _Nullable (^)(id<VVActionReporter> _Nonnull))action onEvent:(NSString *)event {
    if (action && event) {
        VVAction *act = [VVAction actionWithBlock:action];
        [self.stations addAction:act forEvent:event];
    }
}

- (void)registAction:(NSString *)action target:(id)target onEvent:(NSString *)event {
    if (action && target && event) {
        VVAction *act = [[VVAction alloc] init];
        act.target = target;
        act.selector = NSSelectorFromString(action);
        [self.stations addAction:act forEvent:event];
    }
}

- (VVDisposable *)hitEvent:(VVEvent *)event {
    return [self hitEvent:event next:nil];
}

- (VVDisposable *)hitEvent:(VVEvent *)event next:(nullable void(^)(id _Nullable value))next {
    NSArray *actions = [self.stations actionsOnEvent:event];
    VVCompoundDisposable *disposable = [event execute:actions next:next];
    return disposable;
}

- (void)dealloc {
    _stations = nil;
}


@end
