//
//  VVActionSubscriber.h
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VVCompoundDisposable, VVEvent;

@protocol VVActionSubscriber <NSObject>

@required
@property (nonatomic, weak) id poster;
@property (nonatomic, weak) VVEvent *event;
- (void)sendNext:(nullable id)value;
- (void)sendCompleted;
- (void)didSubscribeAction:(VVCompoundDisposable *)disposable;

@end

@interface VVActionSubscriber : NSObject <VVActionSubscriber>

+ (instancetype)subscriberWithPoster:(id)poster
                               event:(VVEvent *)event
                                next:(nullable void (^)(id x))next
                           completed:(nullable void (^)(void))completed;

@end

NS_ASSUME_NONNULL_END
