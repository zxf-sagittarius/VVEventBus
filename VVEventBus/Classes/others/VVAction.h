//
//  VVAction.h
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/6.
//

#import <Foundation/Foundation.h>
#import "VVActionSubscriber.h"

NS_ASSUME_NONNULL_BEGIN

@class VVDisposable;

@interface VVAction : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

+ (instancetype)actionWithBlock:(VVDisposable *(^)(id<VVActionSubscriber>_Nonnull subscriber))actionBlock;

- (VVDisposable *)execute:(id<VVActionSubscriber>)subscriber;

@end

NS_ASSUME_NONNULL_END
