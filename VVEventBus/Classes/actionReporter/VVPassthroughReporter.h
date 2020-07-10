//
//  VVPassthroughReporter.h
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/9.
//

#import <Foundation/Foundation.h>
#import "VVActionReporter.h"

NS_ASSUME_NONNULL_BEGIN
@class VVCompoundDisposable;

@interface VVPassthroughReporter : NSObject <VVActionReporter>

- (instancetype)initWithReporter:(id<VVActionReporter>)reporter
                        disposable:(VVCompoundDisposable *)disposable;

@end

NS_ASSUME_NONNULL_END
