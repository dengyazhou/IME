//
//  QRImage.h
//  二维码
//
//  Created by 邓亚洲 on 2016/11/9.
//  Copyright © 2016年 邓亚洲. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

@interface QRImage : NSObject

+ (UIImage *)imageWithQRString:(NSString *)string;

+ (NSString *)stringFromCiImage:(CIImage *)ciimage;

@end
