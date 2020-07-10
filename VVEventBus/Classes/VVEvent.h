//
//  VVEvent.h
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VVCompoundDisposable, VVAction;
@interface VVEvent : NSObject

@property (nonatomic, copy, readonly) NSString *name;

@property (nonatomic, copy, readonly) NSString *identifier;

@property (nonatomic, weak, readonly) id poster;

- (NSDictionary *)params;

- (void)setParam:(NSString *)param forKey:(NSString *)key;

- (instancetype)initWithEvent:(NSString *)event
                   identifier:(nullable NSString *)identifier
                       poster:(nonnull id)poster;

- (VVCompoundDisposable *)execute:(NSArray <VVAction *> *)actions;

- (VVCompoundDisposable *)execute:(NSArray <VVAction *> *)actions
                      next:(nullable void (^)(id _Nullable value))next;

@end

NS_ASSUME_NONNULL_END
