//
//  VVTestView1.m
//  VVEventBus_Example
//
//  Created by zxfei on 2020/7/9.
//  Copyright © 2020 zxfei. All rights reserved.
//

#import "VVTestView.h"
#import "VVTestEventDefine.h"
@interface VVTestView ()

@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;

@end

@implementation VVTestView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"test" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        self.btn1 = button;
    
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"test" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button sizeToFit];
    self.btn1 = button;

}

- (void)test {
    
    VVEvent *event = [[VVEvent alloc] initWithEvent:VVEventType_Test identifier:@"identifier" poster:self];
    [self.bus hitEvent:event next:^(id  _Nullable value) {
        NSLog(@"收到回调value %@",value);
    }];
}

- (void)test2 {
    
    VVEvent *event = [[VVEvent alloc] initWithEvent:@"test2" identifier:nil poster:self];
    [self.bus hitEvent:event next:^(id  _Nullable value) {
        NSLog(@"value %@",value);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.btn1.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height/2);
    
}

- (void)dealloc {
    NSLog(@"%s",__func__);
}

@end
