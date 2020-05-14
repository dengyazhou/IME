//
//  CompleteConfirmationConfirmationSuccessView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/19.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "CompleteConfirmationConfirmationSuccessView.h"
#import "Header.h"

@interface CompleteConfirmationConfirmationSuccessView ()


@property (weak, nonatomic) IBOutlet UIView *viewBg;
@property (weak, nonatomic) IBOutlet UILabel *mustWriteLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *wrongPasswordView;
@end

@implementation CompleteConfirmationConfirmationSuccessView

+ (instancetype)loadXibView {
    return [[[NSBundle mainBundle] loadNibNamed:@"CompleteConfirmationConfirmationSuccessView" owner:self options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0, kMainW, kMainH);
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.viewBg.layer.cornerRadius = 10;
    self.viewBg.clipsToBounds = YES;
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
