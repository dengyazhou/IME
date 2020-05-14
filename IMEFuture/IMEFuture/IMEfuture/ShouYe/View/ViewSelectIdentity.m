//
//  ViewSelectIdentity.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/4/23.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ViewSelectIdentity.h"

#import "Header.h"

@interface ViewSelectIdentity () {
    
}

@property (weak, nonatomic) IBOutlet UIView *viewBG;

@end

@implementation ViewSelectIdentity

+ (instancetype)selectIdentity {
    return [[NSBundle mainBundle] loadNibNamed:@"ViewSelectIdentity" owner:nil options:nil].firstObject;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.frame = CGRectMake(0, 0, kMainW, kMainH);
        
        //下面的代码没用，要写在awakeFromNib中
//        self.viewBG.layer.cornerRadius = 8;
//        self.viewBG.layer.masksToBounds = YES;
//        self.viewBG.backgroundColor = [UIColor redColor];
        
    
    }
    return  self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.viewBG.layer.cornerRadius = 8;
    self.viewBG.layer.masksToBounds = YES;

}

- (IBAction)buttonQuXiao:(id)sender {
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
