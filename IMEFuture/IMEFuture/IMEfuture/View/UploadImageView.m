//
//  UploadImageView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/3/10.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "UploadImageView.h"
#import "Header.h"

@interface UploadImageView ()

@property (weak, nonatomic) IBOutlet UIView *viewBG;


@end

@implementation UploadImageView

+ (instancetype)uploadImage{
    return [[[NSBundle mainBundle] loadNibNamed:@"UploadImageView" owner:self options:nil] firstObject];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//        self.frame = CGRectMake(0, 0, kMainW, kMainH);
        //这里设置self.frame 没什么用。需要在外界设置 _uploadImageView.frame = self.view.frame；这样放在self.view上就没问题。
        //如果没有_uploadImageView.frame = self.view.frame；放在[UIApplication sharedApplication].keyWindow 上没有问题。
        
        
        //下面的代码没用，要写在awakeFromNib中
//        self.viewBG.layer.cornerRadius = 8;
//        self.viewBG.layer.masksToBounds = YES;
         
    }
    return  self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewBG.layer.cornerRadius = 8;
    self.viewBG.layer.masksToBounds = YES;

   
    
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicAnimation.duration = 4;
    basicAnimation.removedOnCompletion = NO;
    [basicAnimation setRepeatCount:NSIntegerMax];
    basicAnimation.fromValue = [NSNumber numberWithInt:0];
    basicAnimation.toValue = [NSNumber numberWithInt:M_PI*8];
    [self.imageView.layer addAnimation:basicAnimation forKey:@"rotation"];
}

- (void)prepare {
    self.imageView.hidden = false;
    self.progressView.hidden = false;
    self.label.hidden = false;
    self.progressView.progress = 0;
    self.label.text = @"图片上传中...";
}

- (void)loadFinish {
    self.progressView.hidden = true;
    self.label.text = @"数据处理中...";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
