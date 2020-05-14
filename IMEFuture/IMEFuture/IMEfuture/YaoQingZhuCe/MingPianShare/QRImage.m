//
//  QRImage.m
//  二维码
//
//  Created by 邓亚洲 on 2016/11/9.
//  Copyright © 2016年 邓亚洲. All rights reserved.
//

#import "QRImage.h"

@implementation QRImage

+ (UIImage *)imageWithQRString:(NSString *)string {
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    UIImage * image = [self createNonInterpolatedUIImageFormCIImage:qrFilter.outputImage withSize:300];
    return image;
}

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:image fromRect:extent];
    
    // Now we'll rescale using CoreGraphics
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    // We don't want to interpolate (since we've got a pixelcorrent image)
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    // Get the image out
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // Tidy up
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return scaledImage;
}

+ (NSString *)stringFromCiImage:(CIImage *)ciimage {
    NSString *content = nil;
    if (!ciimage) {
        return content;
    }
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:[CIContext contextWithOptions:nil] options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:ciimage];
    if (features.count) {
        for (CIFeature *feature in features) {
            if ([feature isKindOfClass:[CIQRCodeFeature class]]) {
                content = ((CIQRCodeFeature *)feature).messageString;
                break;
            }
        }
    } else {
        NSLog(@"未正常解析二维码图片，请确保iPhone5/5c以上的设备");
    }
    return content;
}

@end
