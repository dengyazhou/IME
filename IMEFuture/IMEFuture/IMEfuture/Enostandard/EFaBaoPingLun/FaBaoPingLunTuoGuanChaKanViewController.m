//
//  FaBaoPingLunTuoGuanChaKanViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/12/20.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "FaBaoPingLunTuoGuanChaKanViewController.h"
#import "VoHeader.h"

#import "FaBaoPingLunTuoGuanViewController.h"


@interface FaBaoPingLunTuoGuanChaKanViewController () {
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation FaBaoPingLunTuoGuanChaKanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
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
    self.label2.text = [NSString stringWithFormat:@"订单信息：%@ %@",self.tradeOrder.orderCode,self.tradeOrder.title];

    self.label3.text = [NSString stringWithFormat:@"打分：%@分",[self.tradeOrder.averageScore stringValue]];
    
    self.label4.text = [NSString stringWithFormat:@"备注：%@",self.tradeOrder.content.length>0?self.tradeOrder.content:@"--"];
    
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSString *string = [NSString stringWithFormat:@"备注：%@",self.tradeOrder.content.length>0?self.tradeOrder.content:@"--"];
    CGSize size1 = [string boundingRectWithSize:CGSizeMake(kMainW-20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    self.viewBGHight.frame = CGRectMake(0, _height_NavBar+68+10, kMainW, 40+8+size1.height+9);
    
}


- (IBAction)editing:(id)sender {
    FaBaoPingLunTuoGuanViewController *faBaoPingLunTuoGuanViewController = [[FaBaoPingLunTuoGuanViewController alloc] init];
    faBaoPingLunTuoGuanViewController.tradeOrder = self.tradeOrder;
    [self.navigationController pushViewController:faBaoPingLunTuoGuanViewController animated:YES];
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
