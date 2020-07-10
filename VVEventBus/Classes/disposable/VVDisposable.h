//
//  VVDisposable.h
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VVDisposable : NSObject

@property (nonatomic, assign, readonly) BOOL disposed;

+ (instancetype)disposableWithBlock:(void(^)(void))block;

- (void)dispose;

@end

NS_ASSUME_NONNULL_END
