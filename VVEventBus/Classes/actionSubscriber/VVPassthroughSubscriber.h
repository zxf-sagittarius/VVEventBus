//
//  VVPassthroughSubscriber.h
//  VVEventBus
//
//  Created by zxfei on 2020/7/9.
//

#import <Foundation/Foundation.h>
#import "VVActionSubscriber.h"

NS_ASSUME_NONNULL_BEGIN
@class RACCompoundDisposable;

@interface VVPassthroughSubscriber : NSObject <VVActionSubscriber>

- (instancetype)initWithSubscriber:(id<VVActionSubscriber>)subscriber
                        disposable:(RACCompoundDisposable *)disposable;

@end

NS_ASSUME_NONNULL_END
