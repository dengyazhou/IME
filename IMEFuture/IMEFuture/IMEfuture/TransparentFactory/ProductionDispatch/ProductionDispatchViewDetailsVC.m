//
//  ProductionDispatchViewDetailsVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2020/9/3.
//  Copyright © 2020 dengyazhou. All rights reserved.
//

#import "ProductionDispatchViewDetailsVC.h"
#import "VoHeader.h"
#import <ReactiveObjC.h>

@interface ProductionDispatchViewDetailsVC () {
    UIView *_viewLoading;
}


@property (weak, nonatomic) IBOutlet UIButton *buttonLeftBack;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (weak, nonatomic) IBOutlet UILabel *label01;
@property (weak, nonatomic) IBOutlet UILabel *label02;
@property (weak, nonatomic) IBOutlet UILabel *label03;
@property (weak, nonatomic) IBOutlet UILabel *label04;
@property (weak, nonatomic) IBOutlet UILabel *label05;
@property (weak, nonatomic) IBOutlet UILabel *label06;
@property (weak, nonatomic) IBOutlet UILabel *label07;
@property (weak, nonatomic) IBOutlet UILabel *label08;
@property (weak, nonatomic) IBOutlet UILabel *label99;



@end

@implementation ProductionDispatchViewDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    //rac
    @weakify(self);
    [[self.buttonLeftBack rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:true];
    }];
    
    [self reloadData];
}

- (void)reloadData {
    ProductionControlVo *model = self.productionControlVo;
    self.label01.text = model.productionOrderNum;
    self.label02.text = model.projectNum;
    self.label03.text = model.projectName;
    self.label04.text = model.materialCode;
    self.label05.text = model.materialText;
    self.label06.text = model.materialspec;
    self.label07.text = model.orderQuantity.stringValue;
    self.label08.text = model.plannedQuantity.stringValue;
    self.label99.text = [[FunctionDYZ dyz] strDateFormat:model.requirementDate withEnterDateFormat:@"yyyy-MM-dd HH:mm:ss" withGoDateFormat:@"yyyy-MM-dd"];
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
