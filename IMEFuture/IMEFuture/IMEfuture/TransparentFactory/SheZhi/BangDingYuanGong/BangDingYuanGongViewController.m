//
//  ScanYuanGongMaViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/6.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "BangDingYuanGongViewController.h"
#import "VoHeader.h"

#import "SaoYiSaoVC.h"
#import "TpfMaiViewController.h"
#import "BangDingYuanGongCell.h"


@interface BangDingYuanGongViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    CGFloat _height_NavBar;
    CGFloat _height_BottomBar;
    
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;//摄像头对准图纸二维码，点击扫描

@property (weak, nonatomic) IBOutlet UIView *view00;
@property (weak, nonatomic) IBOutlet UIView *view01;//没数据
@property (weak, nonatomic) IBOutlet UIView *view02;//有数据

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *labelPersonCount;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (nonatomic, strong) NSMutableArray *arrayPersonnelVo;

@end

@implementation BangDingYuanGongViewController

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
//    self.heightBottomBar.constant = _height_BottomBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BangDingYuanGongCell" bundle:nil] forCellReuseIdentifier:@"bangDingYuanGongCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 60;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self setAttributedString:@"摄像头对准员工二维码，\n点击扫描"];//设置中间字颜色
    
    self.textField.delegate = self;
    
    self.view01.hidden = YES;
    self.view02.hidden = YES;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"Array_PersonnelVo_%@.data",siteCode]];
    NSMutableArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];//这个取出来的array是存在的，所以array==nil获!array，不能判断array，需要用array.count==0判断，或者array == [NSNull null]，判断
    
    if (!array || array.count == 0) {
        self.arrayPersonnelVo = [[NSMutableArray alloc] initWithCapacity:0];
        self.view01.hidden = NO;
        self.view02.hidden = YES;
    } else {
        self.arrayPersonnelVo = array;
        self.view01.hidden = YES;
        self.view02.hidden = NO;
        self.labelPersonCount.text = [NSString stringWithFormat:@"已扫描%lu个员工，绑定多人时为多人报工",(unsigned long)array.count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayPersonnelVo.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BangDingYuanGongCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bangDingYuanGongCell" forIndexPath:indexPath];
    PersonnelVo *vo = self.arrayPersonnelVo[indexPath.row];
    cell.name.text = vo.personnelName;
    
    cell.buttonDelete.tag = indexPath.row;
    [cell.buttonDelete addTarget:self action:@selector(buttonDeletePersonVoArray:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)buttonDeletePersonVoArray:(UIButton *)button {
    [self.arrayPersonnelVo removeObjectAtIndex:button.tag];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:button.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView reloadData];//写这句代码的意义是，由于button.tag不会变所以会崩溃，这句代码就是为了刷新tag值
    
    if (self.arrayPersonnelVo.count > 0) {
        self.view01.hidden = YES;
        self.view02.hidden = NO;
        self.labelPersonCount.text = [NSString stringWithFormat:@"已扫描%lu个员工，绑定多人时为多人报工",(unsigned long)self.arrayPersonnelVo.count];
    } else {
        self.view01.hidden = NO;
        self.view02.hidden = YES;
    }
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"Array_PersonnelVo_%@.data",siteCode]];
    [NSKeyedArchiver archiveRootObject:self.arrayPersonnelVo toFile:path];
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
    NSLog(@"%s",__FUNCTION__);
    SaoYiSaoVC *saoYiSaoVC = [[SaoYiSaoVC alloc] init];
    saoYiSaoVC.scanTitle = @"扫描员工二维码";
    [saoYiSaoVC setResultBlock:^(NSString *result) {
        NSData *jsonData = [result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
         [self request:dic[@"personnelCode"]];
    }];
    [self presentViewController:saoYiSaoVC animated:YES completion:nil];
}

#pragma mark 扫描完成
- (IBAction)buttonScanComplete:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)request:(NSString *)result {
    _viewLoading.hidden = NO;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    MesPostEntityBean * mesPostEntityBean = [[MesPostEntityBean alloc] init];
    PersonnelVo * personnelVo = [[PersonnelVo alloc] init];
    personnelVo.siteCode = siteCode;
    personnelVo.personnelCode = result;
    mesPostEntityBean.entity = personnelVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_scan_personnelScan parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnEntityBean = responseObjectModel;
        
        _viewLoading.hidden = YES;
        if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
            PersonnelVo *personnelVo = [PersonnelVo mj_objectWithKeyValues:returnEntityBean.entity];
            
            BOOL flag = true;
            for (int i=0; i<self.arrayPersonnelVo.count; i++) {
                PersonnelVo *temp = self.arrayPersonnelVo[i];
                if ([temp.personnelCode isEqualToString:personnelVo.personnelCode]) {
                    flag = false;
                    return;
                }
            }
            if (flag) {
                [self.arrayPersonnelVo addObject:personnelVo];
            }
            if (self.arrayPersonnelVo.count > 0) {
                self.view01.hidden = YES;
                self.view02.hidden = NO;
            } else {
                self.view01.hidden = NO;
                self.view02.hidden = YES;
            }
            [self.tableView reloadData];
            self.labelPersonCount.text = [NSString stringWithFormat:@"已扫描%lu个员工，绑定多人时为多人报工",(unsigned long)self.arrayPersonnelVo.count];
            
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
            NSString *siteCode = tpfUser.siteCode;
            
            NSString * path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"Array_PersonnelVo_%@.data",siteCode]];
            [NSKeyedArchiver archiveRootObject:self.arrayPersonnelVo toFile:path];
            
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnEntityBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;
       
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
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
