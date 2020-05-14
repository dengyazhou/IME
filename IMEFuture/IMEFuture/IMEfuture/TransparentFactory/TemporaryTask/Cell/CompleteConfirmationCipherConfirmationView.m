//
//  CompleteConfirmationCipherConfirmationView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/19.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "CompleteConfirmationCipherConfirmationView.h"
#import "Header.h"
#import "MyAlertCenter.h"


@interface CompleteConfirmationCipherConfirmationView () <UIGestureRecognizerDelegate>


@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (weak, nonatomic) IBOutlet UILabel *mustWriteLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewBgCenterY;

@property (weak, nonatomic) IBOutlet UIView *dateView;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (nonatomic,strong) NSDate *date;

@end

@implementation CompleteConfirmationCipherConfirmationView

+ (instancetype)loadXibView {
    return [[[NSBundle mainBundle] loadNibNamed:@"CompleteConfirmationCipherConfirmationView" owner:self options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.frame = CGRectMake(0, 0, kMainW, kMainH);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.viewBg.layer.cornerRadius = 10;
    self.viewBg.clipsToBounds = YES;
    
    
    
    self.wrongPasswordView.hidden = true;
    
    self.SelectionTimeButton.layer.cornerRadius = 5;
    self.SelectionTimeButton.layer.borderWidth = 0.5;
    self.SelectionTimeButton.layer.borderColor = colorRGB(221, 221, 221).CGColor;
    
    
    self.dateView.hidden = YES;
    
    [self.textField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];
    self.textField.secureTextEntry = YES;
    
    UITapGestureRecognizer *singleFinger = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
    singleFinger.numberOfTouchesRequired = 1; //手指数
    singleFinger.numberOfTapsRequired = 1; //tap次数
    singleFinger.delegate = self;
    [self addGestureRecognizer:singleFinger];
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSLog(@">>%f<<",rect.origin.y);
    if (rect.origin.y == kMainH) {
        self.viewBgCenterY.constant += 50;
    } else {
        self.viewBgCenterY.constant -= 50;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if ([touch.view isDescendantOfView:self.viewBg]) {
        return NO;
    }
    return YES;
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)tap{
    if (self.viewBgCenterY.constant == self.center.y) {
        [self removeFromSuperview];
    } else {
        [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
    }
    
}

- (void)initWithDataWithAffirmWithName:(NSString *)name ButtonClick:(void (^)(void))affrimBlock {
    self.affrimBlock = affrimBlock;
    
    if (self.needPassword.integerValue == 1) { // 需要密码
        self.passwordView.hidden = false;
    } else if (self.needPassword.integerValue == 0) { // 不需要密码
        self.passwordView.hidden = true;
    }
    self.labelrenwu.text = self.name;
    self.textFieldshijigongshi.text = self.workTime.stringValue;
    self.textFieldshijigongshi.enabled = false;
    self.textFieldjihuagongshi.text = self.planWorkTime.stringValue;
    
    self.mustWriteLabel.text = [NSString stringWithFormat:@"%@ 请输入密码(必填)：",name];
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc] initWithString:self.mustWriteLabel.text];
    
    [abs addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(self.mustWriteLabel.text.length-4, 2)];
    self.mustWriteLabel.attributedText = abs;
}

- (void)textFieldTextChange:(UITextField *)sender {
    self.wrongPasswordView.hidden = true;
}

- (IBAction)affirmBuutonClick:(id)sender {
    self.dateView.hidden = YES;
    if (self.needPassword.integerValue == 1) { // 需要密码
        if (self.textField.text.length > 0) {
            
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入密码"];
            return;
        }
    } else if (self.needPassword.integerValue == 0) { // 不需要密码
        
    }
    
    
    if (self.affrimBlock) {
        self.affrimBlock();
    }
}

- (IBAction)cancelBuutonClick:(id)sender {
    [self removeFromSuperview];
}














- (IBAction)selectTimeButtonClicj:(id)sender {
    [self.textField resignFirstResponder];
    if (self.date) {
        [self.datePicker setDate:self.date];
    }
    self.dateView.hidden = NO;
    
    self.viewBgCenterY.constant -= 50;
    
}
- (IBAction)selectTimeAffirmButton:(id)sender {
    self.dateView.hidden = YES;
    
    self.date = self.datePicker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:self.date];
    [self.SelectionTimeButton setTitle:dateString forState:UIControlStateNormal];
    self.viewBgCenterY.constant +=50;
}

- (IBAction)selectTimecancelButton:(id)sender {
    self.dateView.hidden = YES;
    self.viewBgCenterY.constant +=50;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
