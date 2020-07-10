//
//  VVBaseView.h
//  VVEventBus_Example
//
//  Created by zxf-sagittarius on 2020/7/9.
//  Copyright © 2020 zxf-sagittarius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VVBus.h"

NS_ASSUME_NONNULL_BEGIN

@interface VVBaseView : UIView

@property (nonatomic, weak) VVBus *bus;

@end

NS_ASSUME_NONNULL_END
