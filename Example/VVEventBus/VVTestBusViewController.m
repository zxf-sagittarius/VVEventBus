//
//  VVTestBusViewController.m
//  VVEventBus_Example
//
//  Created by zxf-sagittarius on 2020/7/9.
//  Copyright © 2020 zxf-sagittarius. All rights reserved.
//

#import "VVTestBusViewController.h"
#import "VVTestView.h"
#import "VVTestEventDefine.h"

@interface VVTestBusViewController ()

@property (weak, nonatomic) IBOutlet VVTestView *testView;

@end

@implementation VVTestBusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.testView.bus = self.bus;
    
    // block 方式
    [self.bus registAction:^VVDisposable * _Nullable(id<VVActionSubscriber>  _Nonnull subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:@1];
            [subscriber sendCompleted];
        });
        return [VVDisposable disposableWithBlock:^{
            NSLog(@"啦啦啦啦啦啦啦啦 block --------1");
        }];
    } onEvent:VVEventType_Test];
    
    [self.bus registAction:^VVDisposable * _Nullable(id<VVActionSubscriber>  _Nonnull subscriber) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [subscriber sendNext:@2];
            [subscriber sendCompleted];
        });
        return [VVDisposable disposableWithBlock:^{
            NSLog(@"啦啦啦啦啦啦啦啦 block -------2");
        }];
        
    } onEvent:VVEventType_Test];
    [self.bus registAction:^VVDisposable * _Nullable(id<VVActionSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@3];
        [subscriber sendCompleted];
        return [VVDisposable disposableWithBlock:^{
            NSLog(@"啦啦啦啦啦啦啦啦 block ------3");
        }];
    } onEvent:VVEventType_Test];
    
    // target-action
    [self.bus registAction:@"test1:" target:self onEvent:VVEventType_Test];
    [self.bus registAction:@"test2:" target:self onEvent:VVEventType_Test];
}

- (void)test1:(id<VVActionSubscriber>)subscriber {
    
    [subscriber sendNext:@4];
    [subscriber sendCompleted];
    NSLog(@"啦啦啦啦啦啦啦啦 target-action ------4");
    
}

- (void)test2:(id<VVActionSubscriber>)subscriber {
    [subscriber sendNext:@5];
    [subscriber sendCompleted];
    NSLog(@"啦啦啦啦啦啦啦啦 target-action ------5");
}


- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
