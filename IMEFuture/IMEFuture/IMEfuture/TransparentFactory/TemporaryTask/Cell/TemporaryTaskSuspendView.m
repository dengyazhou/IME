//
//  TemporaryTaskSuspendView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/19.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "TemporaryTaskSuspendView.h"
#import "Header.h"
#import "MyAlertCenter.h"

@interface TemporaryTaskSuspendView ()<UIGestureRecognizerDelegate>


@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (weak, nonatomic) IBOutlet UILabel *mustWriteLabel;

@property (weak, nonatomic) IBOutlet UITextView *textViewSuspendExplain;

@end

@implementation TemporaryTaskSuspendView

+ (instancetype)loadXibView {
    return [[[NSBundle mainBundle] loadNibNamed:@"TemporaryTaskSuspendView" owner:self options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0, kMainW, kMainH);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.viewBg.layer.cornerRadius = 10;
    self.viewBg.clipsToBounds = YES;

    self.mustWriteLabel.text = @"暂停原因(必填)：";
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc] initWithString:self.mustWriteLabel.text];
    [abs addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(self.mustWriteLabel.text.length-4, 2)];
    self.mustWriteLabel.attributedText = abs;
    
    
    // placeholder
    UILabel *label = [UILabel new];
    label.font = self.textViewSuspendExplain.font;
    label.text = @"请输入暂停原因";
    label.numberOfLines = 0;
    label.textColor = [UIColor lightGrayColor];
    [label sizeToFit];
    [self.textViewSuspendExplain addSubview:label];
    
    // kvc
    [self.textViewSuspendExplain setValue:label forKey:@"_placeholderLabel"];
    
    UITapGestureRecognizer *singleFinger = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
    singleFinger.numberOfTouchesRequired = 1; //手指数
    singleFinger.numberOfTapsRequired = 1; //tap次数
    singleFinger.delegate = self;
    [self addGestureRecognizer:singleFinger];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.viewBg]) {
        return NO;
    }
    return YES;
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)tap{
    [self removeFromSuperview];
}

- (void)initWithDataWithAffirmButtonClick:(void (^)(NSString * _Nonnull))affrimBlock {
    self.affrimBlock = affrimBlock;
}

- (IBAction)affirmBuutonClick:(id)sender {
    if (self.textViewSuspendExplain.text.length > 0) {
        
    } else {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入暂停原因"];
        return;
    }
    if (self.affrimBlock) {
        self.affrimBlock(self.textViewSuspendExplain.text);
    }
    [self removeFromSuperview];
}

- (IBAction)cancelBuutonClick:(id)sender {
    [self removeFromSuperview];
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
