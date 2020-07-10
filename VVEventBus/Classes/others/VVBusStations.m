//
//  VVBusStations.m
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/8.
//

#import "VVBusStations.h"
#import "VVEvent.h"

@interface VVBusStations ()

@property (nonatomic, strong) NSMutableDictionary *stations;

@end

@implementation VVBusStations

- (NSMutableDictionary *)stations {
    if (!_stations) {
        _stations = @{}.mutableCopy;
    }
    return _stations;
}

- (void)addAction:(VVAction *)action forEvent:(NSString *)event {
    
    NSMutableArray * actions = [self.stations objectForKey:event];
    if (!actions || ![actions isKindOfClass:[NSMutableArray class]]) {
        actions = [[NSMutableArray alloc] init];
    }
    if (action) {
        [actions addObject: action];
        [self.stations setValue:actions forKey:event];
    }
}

- (NSArray <VVAction *> *)actionsOnEvent:(VVEvent *)event {
    return [self.stations objectForKey:event.name];
}


@end
