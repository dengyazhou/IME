//
//  UploadImageView.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/3/10.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UploadImageView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *label;


+ (instancetype)uploadImage;

- (void)prepare;

- (void)loadFinish;

@end

NS_ASSUME_NONNULL_END
