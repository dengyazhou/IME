//
//  FaBaoPingLunViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/8/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "FaBaoPingLunCaiViewController.h"
#import "VoHeader.h"
#import "IMETabBarViewController.h"


@interface FaBaoPingLunCaiViewController () <UITextViewDelegate> {
    UILabel *_labelTextView;
    NSInteger _suStart1;
    NSInteger _suStart2;
    NSInteger _suStart3;
    UIView *_viewTag;//为了让键盘下去 添加的view
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation FaBaoPingLunCaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    _suStart1 = 0;
    _suStart2 = 0;
    _suStart3 = 0;
    [self line:self.view withY:_height_NavBar];
    self.textView.delegate = self;
    
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    EnterpriseInfo *enterpriseInfo = [[EnterpriseInfo alloc] init];
    enterpriseInfo.enterpriseId = self.tradeOrder.supplierEnterpriseId;
    postEntityBean.entity = enterpriseInfo.mj_keyValues;
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_enterprise_epInfo parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        EnterpriseInfo *enterpriseInfo = [EnterpriseInfo mj_objectWithKeyValues:returnEntityBean.entity];
        [self.thumbnailUrl sd_setImageWithURL:[NSURL URLWithString:enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    
    
    
    
    self.enterpriseName.text = self.tradeOrder.supplierEnterpriseName;
    
    
    _labelTextView = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, kMainW-20, 17)];
    _labelTextView.font = [UIFont systemFontOfSize:17];
    _labelTextView.textColor = colorRGB(177, 177, 177);
    _labelTextView.text = @"请输入评价内容";
    [self.textView addSubview:_labelTextView];
    
    _viewTag = [[UIView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, 320 - _height_NavBar)];
    _viewTag.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewTag];
    _viewTag.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelector:)];
    [_viewTag addGestureRecognizer:tap];
}

- (void)tapSelector:(UITapGestureRecognizer *)tap {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
    _viewTag.hidden = YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _viewTag.hidden = NO;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        _labelTextView.hidden = YES;
    } else {
        _labelTextView.hidden = NO;
    }
    self.labelZiShu.text = [NSString stringWithFormat:@"%ld",500-textView.text.length];
}

- (IBAction)buttonTiJiao:(UIButton *)sender {
    if (_suStart1 != 0 && _suStart2 != 0 && _suStart3 != 0) {
        
        NSLog(@"%@",self.navigationController.viewControllers);

        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        Comment *comment = [[Comment alloc] init];
        comment.orderId = self.tradeOrder.orderId;
        comment.commentType = @"SUPPLIER";
        comment.targetEnterpriseId = self.tradeOrder.supplierEnterpriseId;
        comment.suStart1 = [NSNumber numberWithDouble:_suStart1];
        comment.suStart2 = [NSNumber numberWithDouble:_suStart2];
        comment.suStart3 = [NSNumber numberWithDouble:_suStart3];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        comment.sourceMemberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
        comment.content = self.textView.text;
        postEntityBean.entity = comment.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        //    NSLog(@"%@",dic);
        [HttpMamager postRequestWithURLString:DYZ_comment_addPurchaseComment parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"评价成功"];
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"评价失败"];
            }

            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isMemberOfClass:[IMETabBarViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"notificationRefreshECOrder" object:nil userInfo:nil];
                    break;
                }
            }
        } fail:^(NSError *error) {

        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    } else {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"评价未完成"];
    }
}

- (IBAction)button00:(UIButton *)sender {
     NSLog(@"00");
    [self.button00 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button01 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button02 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button03 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button04 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    _suStart1 = 1;
}
- (IBAction)button01:(UIButton *)sender {
     NSLog(@"01");
    [self.button00 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button01 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button02 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button03 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button04 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    _suStart1 = 2;
}
- (IBAction)button02:(UIButton *)sender {
     NSLog(@"02");
    [self.button00 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button01 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button02 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button03 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button04 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    _suStart1 = 3;
}
- (IBAction)button03:(UIButton *)sender {
     NSLog(@"03");
    [self.button00 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button01 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button02 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button03 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button04 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    _suStart1 = 4;
}
- (IBAction)button04:(UIButton *)sender {
     NSLog(@"04");
    [self.button00 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button01 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button02 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button03 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button04 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    _suStart1 = 5;
}


- (IBAction)button10:(UIButton *)sender {
     NSLog(@"10");
    [self.button10 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button11 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button12 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button13 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button14 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    _suStart2 = 1;
}
- (IBAction)button11:(UIButton *)sender {
     NSLog(@"11");
    [self.button10 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button11 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button12 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button13 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button14 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    _suStart2 = 2;
}
- (IBAction)button12:(UIButton *)sender {
     NSLog(@"12");
    [self.button10 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button11 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button12 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button13 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button14 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    _suStart2 = 3;
}
- (IBAction)button13:(UIButton *)sender {
     NSLog(@"13");
    [self.button10 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button11 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button12 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button13 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button14 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    _suStart2 = 4;
}
- (IBAction)button14:(UIButton *)sender {
     NSLog(@"14");
    [self.button10 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button11 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button12 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button13 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button14 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    _suStart2 = 5;
}

- (IBAction)button20:(UIButton *)sender {
    NSLog(@"20");
    [self.button20 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button21 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button22 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button23 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button24 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    _suStart3 = 1;
}
- (IBAction)button21:(UIButton *)sender {
    NSLog(@"21");
    [self.button20 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button21 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button22 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button23 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button24 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    _suStart3 = 2;
}
- (IBAction)button22:(UIButton *)sender {
    NSLog(@"22");
    [self.button20 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button21 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button22 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button23 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    [self.button24 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    _suStart3 = 3;
}
- (IBAction)button23:(UIButton *)sender {
    NSLog(@"23");
    [self.button20 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button21 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button22 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button23 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button24 setImage:[UIImage imageNamed:@"label_star_2t"] forState:UIControlStateNormal];
    _suStart3 = 4;
}
- (IBAction)button24:(UIButton *)sender {
    NSLog(@"24");
    [self.button20 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button21 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button22 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button23 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    [self.button24 setImage:[UIImage imageNamed:@"label_star"] forState:UIControlStateNormal];
    _suStart3 = 4;
}


- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)line:(UIView *)view withY:(CGFloat)y {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, y, kMainW, 0.5)];
    label.backgroundColor = colorLine;
    [view addSubview:label];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
