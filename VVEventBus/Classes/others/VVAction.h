//
//  VVAction.h
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/6.
//

#import <Foundation/Foundation.h>
#import "VVActionReporter.h"

NS_ASSUME_NONNULL_BEGIN

@class VVDisposable;

@interface VVAction : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

+ (instancetype)actionWithBlock:(VVDisposable *(^)(id<VVActionReporter>_Nonnull reporter))actionBlock;

- (VVDisposable *)execute:(id<VVActionReporter>)reporter;

@end

NS_ASSUME_NONNULL_END
