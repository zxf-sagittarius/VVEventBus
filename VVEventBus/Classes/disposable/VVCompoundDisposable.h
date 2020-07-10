//
//  VVCompoundDisposable.h
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/8.
//

#import "VVDisposable.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVCompoundDisposable : VVDisposable

+ (instancetype)compoundDisposable;
+ (instancetype)compoundDisposableWithDisposables:(nullable NSArray<VVDisposable *> *)disposables;
- (void)addDisposable:(nullable VVDisposable *)disposable;
- (void)removeDisposable:(nullable VVDisposable *)disposable;

@end

NS_ASSUME_NONNULL_END
