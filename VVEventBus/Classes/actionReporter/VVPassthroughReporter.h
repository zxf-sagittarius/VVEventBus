//
//  VVPassthroughReporter.h
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/9.
//

#import <Foundation/Foundation.h>
#import "VVActionReporter.h"

NS_ASSUME_NONNULL_BEGIN
@class RACCompoundDisposable;

@interface VVPassthroughReporter : NSObject <VVActionReporter>

- (instancetype)initWithReporter:(id<VVActionReporter>)reporter
                        disposable:(RACCompoundDisposable *)disposable;

@end

NS_ASSUME_NONNULL_END
