//
//  GuanYuWoMenViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/18.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "GuanYuWoMenViewController.h"

#import "Header.h"

@interface GuanYuWoMenViewController () {
    NSArray *_array;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation GuanYuWoMenViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    self.labelVersions.text = [NSString stringWithFormat:@"V%@",version];
    _array = @[@"        智造家是智能制造产业链的服务平台，智造家在非标制造管理信息化、非标项目管理及技术人才服务、非标备件库存管理信息化三个方面提供一系列可快速推广和低成本使用的SaaS解决方案及管理服务，实现加工制造过程信息化、采购供应链高效率、交付透明化、图纸跨平台协作、项目规范管理化、技术人才服务和备件服务快捷精准化的目标。智造家已推出的产品包括非标管家、图纸云、透明工厂、搜自动化部件设备备件云、非标加工交易平台等。",@"        智造家期待通过不断迭代专业化产品和管理服务实现智造家“集聚智造资源，服务制造未来”的美好愿景。"];
    self.label1.text = _array[0];
    self.label2.text = _array[1];
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGSize size1 = [_array[0] boundingRectWithSize:CGSizeMake(kMainW-20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    CGSize size2 = [_array[1] boundingRectWithSize:CGSizeMake(kMainW-20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    if ([_array[1] isEqualToString:@""]) {
        size2 = CGSizeMake(0, 0);
    }
    self.viewLabel.frame = CGRectMake(0, CGRectGetMaxY(self.labelVersions.frame)+15, kMainW, size1.height+size2.height+32);
}

- (IBAction)back:(UIButton *)sender {
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
