//
//  CALayer+LayerBorderColor.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/7.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "CALayer+LayerBorderColor.h"
#import <UIKit/UIKit.h>

@implementation CALayer (LayerBorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)color {
    
    self.borderColor = color.CGColor;
}


@end
