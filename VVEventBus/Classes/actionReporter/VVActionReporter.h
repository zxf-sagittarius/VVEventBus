//
//  VVActionReporter.h
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VVCompoundDisposable, VVEvent;

@protocol VVActionReporter <NSObject>

@required
@property (nonatomic, weak) id poster;
@property (nonatomic, weak) VVEvent *event;
- (void)reportEvent:(nullable id)value;
- (void)reportCompleted;
- (void)tailAction:(VVCompoundDisposable *)disposable;

@end

@interface VVActionReporter : NSObject <VVActionReporter>

+ (instancetype)reporterWithPoster:(id)poster
                               event:(VVEvent *)event
                                next:(nullable void (^)(id x))next
                           completed:(nullable void (^)(void))completed;

@end

NS_ASSUME_NONNULL_END
