//
//  VVBusStations.h
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VVEvent, VVAction;
@interface VVBusStations : NSObject

- (void)addAction:(VVAction *)action forEvent:(NSString *)event;

- (NSArray <VVAction *> *)actionsOnEvent:(VVEvent *)event;

@end

NS_ASSUME_NONNULL_END
