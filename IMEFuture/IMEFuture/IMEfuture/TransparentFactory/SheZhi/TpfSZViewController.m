//
//  TpfSZViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/7/1.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "TpfSZViewController.h"
#import "Header.h"

#import "TpfSZViewCCell1.h"

#import "BangDingYuanGongViewController.h"
#import "BangDingZuoYeDanYuanViewController.h"

@interface TpfSZViewController () <UITableViewDelegate,UITableViewDataSource>{
    CGFloat _height_NavBar;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation TpfSZViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TpfSZViewCCell1" bundle:nil] forCellReuseIdentifier:@"tpfSZViewCCell1"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TpfSZViewCCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"tpfSZViewCCell1" forIndexPath:indexPath];
    cell.viewLineTop.hidden = YES;
    cell.viewLineTop15.hidden = YES;
    cell.viewLineBottom.hidden = YES;
    if (indexPath.row == 0) {
        cell.viewLineTop.hidden = NO;
        cell.label0.text = @"绑定员工";
    } else if (indexPath.row == 1) {
        cell.viewLineTop15.hidden = NO;
        cell.viewLineBottom.hidden = NO;
        cell.label0.text = @"绑定作业单元";
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        BangDingYuanGongViewController *bangDingYuanGongViewController = [[BangDingYuanGongViewController alloc] init];
        [self.navigationController pushViewController:bangDingYuanGongViewController animated:YES];
    } else if (indexPath.row == 1) {
        BangDingZuoYeDanYuanViewController *bangDingZuoYeDanYuanViewController = [[BangDingZuoYeDanYuanViewController alloc] init];
        [self.navigationController pushViewController:bangDingZuoYeDanYuanViewController animated:YES];
    }
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
