//
//  VVCompoundDisposable.m
//  VVEventBus
//
//  Created by zxf-sagittarius on 2020/7/8.
//

#import "VVCompoundDisposable.h"
#import <pthread/pthread.h>

@interface VVCompoundDisposable () {
    pthread_mutex_t _mutex;
    BOOL _disposed;
    NSMutableArray *_disposables;
}
@end

@implementation VVCompoundDisposable

- (BOOL)disposed {
    pthread_mutex_lock(&_mutex);
    BOOL disposed = _disposed;
    pthread_mutex_unlock(&_mutex);
    return disposed;
}

+ (instancetype)compoundDisposable {
    return [[self alloc] initWithDisposables:nil];
}

+ (instancetype)compoundDisposableWithDisposables:(NSArray *)disposables {
    return [[self alloc] initWithDisposables:disposables];
}

- (instancetype)init {
    
    if (self = [super init]) {
        pthread_mutex_init(&_mutex, NULL);
        _disposables = @[].mutableCopy;
    }
    return self;
}

- (instancetype)initWithDisposables:(NSArray <VVDisposable *> *)otherDisposables {
    if (self = [self init]) {
        if (otherDisposables) {
            [_disposables addObjectsFromArray:otherDisposables];
        }
    }
    return self;;
}

- (instancetype)initWithDisposeBlock:(void (^)(void))block {
    VVDisposable *disposable = [VVDisposable disposableWithBlock:block];
    return [self initWithDisposables:@[disposable]];
}

- (void)dealloc {
    _disposables = nil;
    pthread_mutex_destroy(&_mutex);
}

#pragma mark -- public methods
- (void)addDisposable:(VVDisposable *)disposable {
    if (disposable == nil || disposable.disposed) {
        return;
    }
    
    BOOL shouldDispose = NO;
    
    pthread_mutex_lock(&_mutex);
    if (_disposed) {
        shouldDispose = YES;
    } else {
        [_disposables addObject:disposable];
    }
    pthread_mutex_unlock(&_mutex);
    
    if (shouldDispose) {
        [disposable dispose];
    }
}

- (void)removeDisposable:(VVDisposable *)disposable {
    if (disposable == nil) {
        return;
    }
    pthread_mutex_lock(&_mutex);
    [_disposables removeObject:disposable];
    pthread_mutex_unlock(&_mutex);
}

- (void)dispose {
    
    NSArray *disposes = nil;
    pthread_mutex_lock(&_mutex);
    _disposed = YES;
    disposes = _disposables;
    _disposables = nil;
    pthread_mutex_unlock(&_mutex);
    
    if (disposes == nil) {
        return;
    }
    
    for (int i = 0; i < disposes.count; i ++) {
        VVDisposable *current = disposes[i];
        [current dispose];
    }
}

@end
