//
//  ScanGongXuViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ScanGongXuViewController.h"
#import "VoHeader.h"

#import "SaoYiSaoVC.h"
#import "ScanZuoYeDanYuanViewController.h"
#import "ProductionControlProcessReportVC.h"

@interface ScanGongXuViewController () <UITextFieldDelegate> {
    CGFloat _height_NavBar;
    CGFloat _height_BottomBar;
    
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *label;//摄像头对准图纸二维码，点击扫描


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar;

@end

@implementation ScanGongXuViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_BottomBar = Height_BottomBar;
    self.heightNavBar.constant = _height_NavBar;
    self.heightBottomBar.constant = _height_BottomBar;

    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self setAttributedString:@"摄像头对准图纸二维码/工序流转卡，\n点击扫描"];//设置中间字颜色
    
    self.textField.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self request:textField.text];
    
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField resignFirstResponder];
}


#pragma mark 扫描
- (IBAction)buttonScan:(id)sender {
    SaoYiSaoVC *saoYiSaoVC = [[SaoYiSaoVC alloc] init];
    saoYiSaoVC.scanTitle = @"扫描图纸二维码";
    [saoYiSaoVC setResultBlock:^(NSString *result) {
        [self request:result];
    }];
    [self presentViewController:saoYiSaoVC animated:YES completion:nil];
    
}

- (void)request:(NSString *)result {
    ProductionControlProcessReportVC *vc = [[ProductionControlProcessReportVC alloc] init];
    vc.productionControlNum = result;
    [self.navigationController pushViewController:vc animated:true];
    
}

- (void)setAttributedString:(NSString *)text {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:text];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:colorRGB(0, 122, 254) range:NSMakeRange(5, text.length - 9)];
    self.label.attributedText = attributeStr;
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
