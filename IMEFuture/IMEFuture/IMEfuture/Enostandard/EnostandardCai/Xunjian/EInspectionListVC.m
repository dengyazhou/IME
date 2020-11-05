//
//  EInspectionListVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/18.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "EInspectionListVC.h"
#import "VoHeader.h"


#import "EInspectionCell.h"
#import "EInspectionCreateVC.h"
#import "EInspectionDetailVC.h"

#import "InspectionBean.h"

@interface EInspectionListVC () <UITableViewDelegate,UITableViewDataSource> {
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (nonatomic, strong) NSMutableArray *inspectionArray;

@property (nonatomic, assign) NSUInteger index;

@end

@implementation EInspectionListVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    self.index = NSUIntegerMax;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"EInspectionCell" bundle:nil] forCellReuseIdentifier:@"eInspectionCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW-34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.inspectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EInspectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eInspectionCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.viewBg.layer.shadowOffset = CGSizeMake(0, 0);//默认为(0, -3)
    cell.viewBg.layer.shadowRadius = 4;
    cell.viewBg.layer.shadowOpacity = 1;//默认为0，所以根本看不见
        
//    if (indexPath.row == 1) {
//        cell.viewBg.layer.shadowColor = [UIColor colorWithRed:65/255.0 green:178/255.0 blue:253/255.0 alpha:0.64].CGColor;
//        cell.imageView1.image = [UIImage imageNamed:@"eInspectionNext_blue"];
//    } else {
//        cell.viewBg.layer.shadowColor = [UIColor clearColor].CGColor;
//        cell.imageView1.image = [UIImage imageNamed:@"eInspectionNext_gray"];
//    }
    
    cell.viewBg.layer.shadowColor = [UIColor clearColor].CGColor;
    cell.imageView1.image = [UIImage imageNamed:@"eInspectionNext_gray"];
    
    InspectionBean *inspectionBean = self.inspectionArray[indexPath.row];
    cell.label0.text = inspectionBean.inspectionCode;
    cell.label1.text = inspectionBean.memberName;
    cell.label2.text = inspectionBean.supplierEnterpriseName;
    cell.label3.text = [[inspectionBean.inspectionDate componentsSeparatedByString:@" "] firstObject];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EInspectionDetailVC *vc = [[EInspectionDetailVC alloc] init];
    vc.inspectionBean = self.inspectionArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:true];
}

- (IBAction)buttonNewCreate:(id)sender {
    EInspectionCreateVC *vc = [[EInspectionCreateVC alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)initRequest{
    _viewLoading.hidden = false;
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    postEntityBean.entity = @{@"inspectionType":@"1"};
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_api_purchaseInspection_inspectionList parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.inspectionArray = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dicTemp in returnListBean.list) {
                InspectionBean *inspection = [InspectionBean mj_objectWithKeyValues:dicTemp];
                [self.inspectionArray addObject:inspection];
            }
            
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = true;
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}

- (IBAction)back:(id)sender {
[self.navigationController popViewControllerAnimated:YES];
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
