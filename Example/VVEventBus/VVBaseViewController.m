//
//  VVBaseViewController.m
//  VVEventBus_Example
//
//  Created by zxfei on 2020/7/9.
//  Copyright © 2020 zxfei. All rights reserved.
//

#import "VVBaseViewController.h"

@interface VVBaseViewController ()

@end

@implementation VVBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (VVBus *)bus {
    if (!_bus) {
        _bus = [[VVBus alloc] init];
    }
    return _bus;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
