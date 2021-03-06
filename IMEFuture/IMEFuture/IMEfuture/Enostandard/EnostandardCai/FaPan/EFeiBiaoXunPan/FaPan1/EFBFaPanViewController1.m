//
//  EFBFaPanViewController1.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/2/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "EFBFaPanViewController1.h"
#import "Masonry.h"
#import "EFBFaPanLingJianCell.h"

#import "EFBFaPanViewController2.h"

#import "XinZengLingJianDuoCiVC.h"

@interface EFBFaPanViewController1 () <UITableViewDelegate,UITableViewDataSource> {
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *viewNoContent;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation EFBFaPanViewController1

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.viewNoContent.hidden = YES;
    if (self.inquiryOrder.inquiryOrderItems.count > 0) {
        self.viewNoContent.hidden = YES;
    } else {
        self.viewNoContent.hidden = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EFBFaPanLingJianCell" bundle:nil] forCellReuseIdentifier:@"eFBFaPanLingJianCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 30;
    } else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 30)];
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] init];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(view.mas_centerY);
        }];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = colorRGB(153, 153, 153);
        label.text = [NSString stringWithFormat:@"步骤二：询盘内容(共%ld个零件)",self.inquiryOrder.inquiryOrderItems.count];
        return view;
    } else {
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.inquiryOrder.inquiryOrderItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EFBFaPanLingJianCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eFBFaPanLingJianCell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    InquiryOrderItem *inquiryOrderItem = self.inquiryOrder.inquiryOrderItems[indexPath.section];
    
    cell.label0.text = inquiryOrderItem.partName;
    cell.label1.text = [NSString stringWithFormat:@"零件数量：%@%@",[NSString removeSuffixIsZone:[inquiryOrderItem.num1 doubleValue]],[NSString QuantityUnit:inquiryOrderItem.quantityUnit]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {//修改零件
    XinZengLingJianDuoCiVC *xinZengLingJianDuoCiVC = [[XinZengLingJianDuoCiVC alloc] init];
    xinZengLingJianDuoCiVC.isZeng = NO;
    xinZengLingJianDuoCiVC.inquiryType = self.inquiryOrder.inquiryType;
    xinZengLingJianDuoCiVC.isPre = self.inquiryOrder.isPre;
    xinZengLingJianDuoCiVC.partType = self.inquiryOrder.partType;
    xinZengLingJianDuoCiVC.processType = self.inquiryOrder.processType;
    xinZengLingJianDuoCiVC.supplierTaxRate = self.inquiryOrder.supplierTaxRate;
    xinZengLingJianDuoCiVC.inquiryOrderItem = self.inquiryOrder.inquiryOrderItems[indexPath.section];//有问题 点击返回时，值修改了，深浅拷贝问题
    
    xinZengLingJianDuoCiVC.buttonBackBlock = ^(InquiryOrderItem *inquiryOrderItem) {//保存
        [self.inquiryOrder.inquiryOrderItems replaceObjectAtIndex:indexPath.section withObject:inquiryOrderItem];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
    };
    
    xinZengLingJianDuoCiVC.buttonShanChuBlock = ^(InquiryOrderItem *inquiryOrderItem) {//删除
        [self.inquiryOrder.inquiryOrderItems removeObjectAtIndex:indexPath.section];
        
        self.viewNoContent.hidden = YES;
        if (self.inquiryOrder.inquiryOrderItems.count > 0) {
            self.viewNoContent.hidden = YES;
        } else {
            self.viewNoContent.hidden = NO;
        }
        
        [self.tableView reloadData];
    };
    [self.navigationController pushViewController:xinZengLingJianDuoCiVC animated:YES];
}

#pragma mark 添加零件
- (IBAction)buttonAdd:(UIButton *)sender {
    XinZengLingJianDuoCiVC *xinZengLingJianDuoCiVC = [[XinZengLingJianDuoCiVC alloc] init];
    xinZengLingJianDuoCiVC.isZeng = YES;
    xinZengLingJianDuoCiVC.inquiryType = self.inquiryOrder.inquiryType;
    xinZengLingJianDuoCiVC.isPre = self.inquiryOrder.isPre;
    xinZengLingJianDuoCiVC.partType = self.inquiryOrder.partType;
    xinZengLingJianDuoCiVC.processType = self.inquiryOrder.processType;
    xinZengLingJianDuoCiVC.supplierTaxRate = self.inquiryOrder.supplierTaxRate;
    xinZengLingJianDuoCiVC.buttonBackBlock = ^(InquiryOrderItem *inquiryOrderItem) {//保存
        //        NSLog(@"%ld",inquiryOrderItem.inquiryOrderItemFiles.count);
        [self.inquiryOrder.inquiryOrderItems insertObject:inquiryOrderItem atIndex:0];
        
        self.viewNoContent.hidden = YES;
        if (self.inquiryOrder.inquiryOrderItems.count > 0) {
            self.viewNoContent.hidden = YES;
        } else {
            self.viewNoContent.hidden = NO;
        }
        
        [self.tableView reloadData];
    };
    xinZengLingJianDuoCiVC.buttonBaoCunBingJiXuTianJiaBlock = ^(InquiryOrderItem *inquiryOrderItem) {//保存并继续添加
        [self buttonAdd:nil];
    };
    [self.navigationController pushViewController:xinZengLingJianDuoCiVC animated:YES];
}

#pragma mark 下一步
- (IBAction)buttonXiaYiBu:(UIButton *)sender {
    if (!(self.inquiryOrder.inquiryOrderItems.count > 0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请添加零件"];
        return;
    }
    
    EFBFaPanViewController2 *eFBFaPanViewController2 = [[EFBFaPanViewController2 alloc] init];
    
    NSDictionary *dic = [self.inquiryOrder mj_keyValues];
    NSLog(@"%@",dic);
    
    eFBFaPanViewController2.inquiryOrder = self.inquiryOrder;
    eFBFaPanViewController2.buttonBackBlock = ^(InquiryOrder *inquiryOrder) {
        self.inquiryOrder = inquiryOrder;
    };
    [self.navigationController pushViewController:eFBFaPanViewController2 animated:YES];
}

- (IBAction)back:(id)sender {
    self.buttonBackBlock(self.inquiryOrder);
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
