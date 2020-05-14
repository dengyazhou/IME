//
//  XunPanXiangQingViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/4.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "ShaiXuanBaoJiaViewController.h"
#import "VoHeader.h"


#import "Masonry.h"

#import "ShaiXuanBaoJiaCell0.h"

#import "BaoJiaZiXunViewController.h"


#import "ShouPanViewController.h"
#import "ShaiXianBaoJiaCell0.h"
#import "ShaiXianBaoJiaCell.h"
#import "NSArray+Transition.h"
#import "GlobalSettingManager.h"

@interface ShaiXuanBaoJiaViewController () <UITableViewDelegate,UITableViewDataSource> {
    UIView *_viewLoading;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (assign,nonatomic) NSInteger index;

@property (nonatomic,strong) InquiryOrder *inquiryOrderHttp;

@end

@implementation ShaiXuanBaoJiaViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _viewLoading.hidden = NO;
    
    //筛选报价
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
    InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
    inquiryOrder.inquiryOrderId = self.inquiryOrder.inquiryOrderId;//必填
    postEntityBean.entity = inquiryOrder.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_inquiry_purchase_select parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            InquiryOrder *inquiryOrder = [InquiryOrder mj_objectWithKeyValues:returnEntityBean.entity];
            
            self.inquiryOrderHttp = inquiryOrder;
            [self.tableView reloadData];
            _viewLoading.hidden = YES;
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [self initUI];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    [self.view addSubview:_viewLoading];


}

- (void)initUI {
    UILabel *labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, 0.5)];
    labelLine.backgroundColor = colorRGB(221, 221, 221);
    [self.view addSubview:labelLine];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"ShaiXuanBaoJiaCell0" bundle:nil] forCellReuseIdentifier:@"cell0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShaiXianBaoJiaCell0" bundle:nil] forCellReuseIdentifier:@"shaiXianBaoJiaCell0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShaiXianBaoJiaCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.inquiryOrderHttp.quotationOrderList.count+1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 101+6;
        }
        return 0;
    } else {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    } else if (section == 1) {
        return 30;
    } else {
        return 0.1;//Grouped 设置为0.1才有效果
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    } else {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 30)];
        view.backgroundColor = colorBG;
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.font = [UIFont systemFontOfSize:12];
        label1.textColor = colorText153;
        label1.text = @"报价(";
        [view addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top);
            make.bottom.equalTo(view.mas_bottom);
            make.left.equalTo(view.mas_left).with.offset(10);
        }];
        UILabel *label2 = [[UILabel alloc] init];
        label2.font = [UIFont systemFontOfSize:12];
        label2.textColor = colorCai;
        label2.text = [NSString stringWithFormat:@"%ld",self.inquiryOrderHttp.quotationOrderList.count];
        [view addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label1.mas_top);
            make.bottom.equalTo(label1.mas_bottom);
            make.left.equalTo(label1.mas_right);
        }];
        UILabel *label3 = [[UILabel alloc] init];
        label3.font = [UIFont systemFontOfSize:12];
        label3.textColor = colorText153;
        label3.text = @"家供应商已报价)";
        [view addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label1.mas_top);
            make.bottom.equalTo(label1.mas_bottom);
            make.left.equalTo(label2.mas_right);
        }];
        return view;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ShaiXuanBaoJiaCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell0" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.inquiryOrder = self.inquiryOrder;
        
        cell.clipsToBounds = YES;
        return cell;
    } else {
        if (indexPath.row == 0) {
            ShaiXianBaoJiaCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"shaiXianBaoJiaCell0" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.view0.backgroundColor = [colorCai colorWithAlphaComponent:0.05];
            cell.view1.backgroundColor = [colorCai colorWithAlphaComponent:0.05];
            cell.label0.text = @"公司";
            cell.label1.text = @"供应商报价(元)";
            return cell;
        } else {
            ShaiXianBaoJiaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            cell.label_factory.hidden = YES;
            cell.labelConstraint.constant = 0;
            QuotationOrder *quotationOrder = self.inquiryOrderHttp.quotationOrderList[indexPath.row-1];
            if ([quotationOrder.isRead integerValue] == 0) {
                cell.viewXiaoHongDian.hidden = NO;
            } else {
                cell.viewXiaoHongDian.hidden = YES;
            }
            cell.label0.text = [NSString stringWithFormat:@"%@",quotationOrder.member.enterpriseInfo.enterpriseName];
            
            if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:117]]) {
                cell.label1.text = @"****";
            } else {
                cell.label1.text = [NSString stringWithFormat:@"%.2f",[quotationOrder.totalPrice1 doubleValue]];
            }
            
            if ([quotationOrder.member.enterpriseInfo.hasTrFactory integerValue] == 0) {
                cell.label_factory.hidden = YES;
                cell.labelConstraint.constant = 0;
            }
            if ([quotationOrder.member.enterpriseInfo.hasTrFactory integerValue] == 1) {
                cell.label_factory.hidden = NO;
                cell.labelConstraint.constant = 32;
            }
            return cell;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row > 0) {
        QuotationOrder *quotationOrder = self.inquiryOrderHttp.quotationOrderList[indexPath.row-1];
        
        if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:22]]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
            return;
        }
        
        ShouPanViewController *vc = [[ShouPanViewController alloc] init];
        vc.inquiryOrderId = quotationOrder.inquiryOrderId;
        vc.quotationOrderId = quotationOrder.quotationOrderId;
        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:action0];
    [alertC addAction:action1];
    [self presentViewController:alertC animated:YES completion:nil];
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
