//
//  ShenQingYSHView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/6/10.
//  Copyright © 2019 Netease. All rights reserved.
//

#import "ShenQingYSHView.h"

#import "Header.h"

@interface ShenQingYSHView () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (weak, nonatomic) IBOutlet UIButton *buttonYes;
@property (weak, nonatomic) IBOutlet UIButton *buttonNo;

@property (weak, nonatomic) IBOutlet UIView *viewReason;
@property (weak, nonatomic) IBOutlet UILabel *labelReason;
@property (weak, nonatomic) IBOutlet UITextField *textFieldReason;

@property (weak, nonatomic) IBOutlet UIButton *buttonUpload;
@property (weak, nonatomic) IBOutlet UIButton *buttonPreview;
@property (weak, nonatomic) IBOutlet UIButton *buttonDelete;

@property (weak, nonatomic) IBOutlet UIButton *buttonConfirm;

@property (nonatomic,assign) NSInteger isTongGuo;

@end

@implementation ShenQingYSHView


+ (instancetype)loadView {
     return [[[NSBundle mainBundle] loadNibNamed:@"ShenQingYSHView" owner:self options:nil] firstObject];
}

- (void)initData:(TradeOrder *)tradeOrder {
    self.textFieldReason.text = tradeOrder.purchaseAccpetMsg;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.viewBg.layer.cornerRadius = 5;
    self.viewBg.clipsToBounds = YES;
    
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc] initWithString:self.labelReason.text];
    [abs addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, 2)];
    self.labelReason.attributedText = abs;
    
    [self.buttonYes setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax选中"] forState:UIControlStateNormal];
    [self.buttonNo setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax未选中"] forState:UIControlStateNormal];
    
    self.viewReason.hidden = true;
    
    self.buttonPreview.hidden = true;
    
    self.buttonPreview.hidden = true;
    
    UITapGestureRecognizer *singleFinger = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
    singleFinger.numberOfTouchesRequired = 1;
    singleFinger.numberOfTapsRequired = 1;
    singleFinger.delegate = self;
    [self addGestureRecognizer:singleFinger];
    
    self.isTongGuo = 1;
}

- (IBAction)buttonClickTongGuo:(UIButton *)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax选中"] forState:UIControlStateNormal];
    [self.buttonNo setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax未选中"] forState:UIControlStateNormal];
    self.isTongGuo = 1;
    self.viewReason.hidden = true;
    
}

- (IBAction)buttonClickBuTongGuo:(UIButton *)sender {
    [sender setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax选中"] forState:UIControlStateNormal];
    [self.buttonYes setBackgroundImage:[UIImage imageNamed:@"ime_icon_tax未选中"] forState:UIControlStateNormal];
    self.isTongGuo = 0;
    self.viewReason.hidden = false;
}

- (IBAction)buttonClickUpload:(UIButton *)sender {
    
}

- (IBAction)buttonClickPreview:(UIButton *)sender {
    
}

- (IBAction)buttonClickDelete:(UIButton *)sender {
    
}

- (IBAction)buttonClickConfirm:(UIButton *)sender {
    if (self.buttonBlockYanShou) {
        //self.isTongGuo == 1 //通过
        //self.isTongGuo == 0 //不通过
        self.buttonBlockYanShou(self.isTongGuo, self.textFieldReason.text);
    }
    self.hidden = true;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.viewBg.center = self.center;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.viewBg]) {
        return NO;
    }
    return YES;
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)tap {
    
    if (self.viewBg.center.y == self.center.y) {//原因框在上面，点击空白就让键盘下去；原因框在中间，点击空白就隐藏
        self.hidden = YES;
    } else {
        [self.textFieldReason resignFirstResponder];
    }
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {//在底部
        self.viewBg.center = self.center;
    } else {//在上面
        self.viewBg.center = CGPointMake(self.center.x, self.center.y-rect.size.height/2);
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
