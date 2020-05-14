//
//  ShQYSHCHKRView.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/6/10.
//  Copyright © 2019 Netease. All rights reserved.
//

#import "ShQYSHCHKRView.h"

#import "Header.h"

@interface ShQYSHCHKRView () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewBg;
;

@property (weak, nonatomic) IBOutlet UILabel *labelReason;


@property (weak, nonatomic) IBOutlet UIButton *buttonPreview;

@property (weak, nonatomic) IBOutlet UIButton *buttonRevise;



@end

@implementation ShQYSHCHKRView


+ (instancetype)loadView {
     return [[[NSBundle mainBundle] loadNibNamed:@"ShQYSHCHKRView" owner:self options:nil] firstObject];
}

- (void)initData:(TradeOrder *)tradeOrder {
    self.labelReason.text = [NSString stringWithFormat:@"原因：%@",tradeOrder.purchaseAccpetMsg];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.viewBg.layer.cornerRadius = 5;
    self.viewBg.clipsToBounds = YES;


    UITapGestureRecognizer *singleFinger = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
    singleFinger.numberOfTouchesRequired = 1;
    singleFinger.numberOfTapsRequired = 1;
    singleFinger.delegate = self;
    [self addGestureRecognizer:singleFinger];
    

}

- (IBAction)buttonClickPreview:(UIButton *)sender {
    
}

//修改
- (IBAction)buttonClickRevise:(UIButton *)sender {
    self.hidden = true;
    if (self.buttonBlockRevise) {
        self.buttonBlockRevise();
    }
}

- (IBAction)buttonClickClose:(UIButton *)sender {
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
    self.hidden = YES;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
