//
//  ZuoYeDanYuanLieBiaoViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/7.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ZuoYeDanYuanLieBiaoViewController.h"
#import "VoHeader.h"

#import "ZuoYeDanYuanLBCell.h"

@interface ZuoYeDanYuanLieBiaoViewController () <UITableViewDelegate,UITableViewDataSource>{
    CGFloat _height_NavBar;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation ZuoYeDanYuanLieBiaoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZuoYeDanYuanLBCell" bundle:nil] forCellReuseIdentifier:@"zuoYeDanYuanLBCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.resultBlock([NSString stringWithFormat:@"%ld",indexPath.row]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZuoYeDanYuanLBCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zuoYeDanYuanLBCell" forIndexPath:indexPath];
    ReportWorkWorkUnitScanVo *workUnitScanVo = self.dataArray[indexPath.row];
    cell.label0.text = workUnitScanVo.processCode;
    cell.label1.text = workUnitScanVo.operationCode;
    cell.label2.text = workUnitScanVo.operationText;
    return cell;
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
