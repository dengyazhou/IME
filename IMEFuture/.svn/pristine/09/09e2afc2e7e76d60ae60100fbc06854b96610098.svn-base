//
//  ECProjectDetailViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/5/8.
//  Copyright © 2019 Netease. All rights reserved.
//

#import "ECProjectDetailViewController.h"

@interface ECProjectDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *projectName;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *label7;
@property (weak, nonatomic) IBOutlet UILabel *label8;
@property (weak, nonatomic) IBOutlet UILabel *label9;

@end

@implementation ECProjectDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.projectName.text = [NSString stringWithFormat:@"项目名称：%@",self.purchaseProject.projectName!=nil?self.purchaseProject.projectName:@""];
    self.label1.text = [NSString stringWithFormat:@"零件项数：%@",self.purchaseProject.itemsNum!=nil?self.purchaseProject.itemsNum:@""];
    self.label2.text = [NSString stringWithFormat:@"收货项数：%@",self.purchaseProject.receiveItemsNum!=nil?self.purchaseProject.receiveItemsNum:@""];
    self.label3.text = [NSString stringWithFormat:@"入库项数：%@",self.purchaseProject.receiveItemsNum!=nil?self.purchaseProject.receiveItemsNum:@""];
    self.label4.text = [NSString stringWithFormat:@"项目创建日期：%@",self.purchaseProject.createTime!=nil?self.purchaseProject.createTime:@""];
    self.label5.text = [NSString stringWithFormat:@"项目结束日期：%@",self.purchaseProject.endTm!=nil?self.purchaseProject.endTm:@""];
    self.label6.text = [NSString stringWithFormat:@"项目创建人：%@",self.purchaseProject.memberName!=nil?self.purchaseProject.memberName:@""];
    self.label7.text = [NSString stringWithFormat:@"负责人：%@",self.purchaseProject.followName!=nil?self.purchaseProject.followName:@""];
    self.label8.text = [NSString stringWithFormat:@"剩余天数：%@",self.purchaseProject.liftDays!=nil?self.purchaseProject.liftDays:@""];
    self.label9.text = [NSString stringWithFormat:@"备注：%@",self.purchaseProject.remark!=nil?self.purchaseProject.remark:@""];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
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
