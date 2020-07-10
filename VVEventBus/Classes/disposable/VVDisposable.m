//
//  VVDisposable.m
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/8.
//

#import "VVDisposable.h"

@interface VVDisposable ()

@property (nonatomic, copy) void (^disposeBlock)(void);

@end

@implementation VVDisposable

- (BOOL)disposed {
    return _disposeBlock == nil;
}

- (instancetype)initWithDisposeBlock:(void (^)(void))block {
    NSCParameterAssert(block != nil);

    self = [super init];
    _disposeBlock = block;

    return self;
}

+ (instancetype)disposableWithBlock:(void (^)(void))block {
    return [[self alloc] initWithDisposeBlock:block];
}

- (void)dispose {
    if (_disposeBlock != nil) {
        _disposeBlock();
    }
}

- (void)dealloc {
    if (_disposeBlock != nil) {
        _disposeBlock = nil;
    }
}

@end
