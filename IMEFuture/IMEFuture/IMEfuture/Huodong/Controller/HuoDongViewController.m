//
//  HuoDongViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/6/25.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "HuoDongViewController.h"
#import "Header.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "HttpMamager.h"
#import "UrlContant.h"
#import "UIView+AddViewNoNetAndNoContent.h"

#import "HuoDongTableViewCell.h"
#import "ModelInformationActivity.h"
#import "WebDatailURL.h"


@interface HuoDongViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSMutableArray *_activityListArray;
    NSInteger _aPage;
    UIView *_viewNoContent;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;


@end

@implementation HuoDongViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"tabBarControllerSelectedIndex"];
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"needLogin"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    _viewNoContent = [UIView addView:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar-_height_TabBar) imageNamed:@"ime_picture_inquiry_empty" title:@"暂无活动"];
    [self.view addSubview:_viewNoContent];
    _viewNoContent.hidden = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"HuoDongTableViewCell" bundle:nil] forCellReuseIdentifier:@"HouDongCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [HttpMamager postRequestWithURLString:DYZ_information_informationActivity parameters:@{@"page":@1,@"pageSize":pageSizeDYZ} success:^(id responseObjectModel) {
            _activityListArray = [[NSMutableArray alloc] initWithCapacity:0];
            ModelInformationActivity *model = responseObjectModel;
            for (ModelInformationActivityActivityList *modelInformationActivityActivityList in model.activityList) {
                [_activityListArray addObject:modelInformationActivityActivityList];

            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            if (model.activityList.count != 0) {
                [self.tableView.mj_footer endRefreshing];
                _viewNoContent.hidden = YES;
                self.tableView.mj_footer.hidden = NO;
            } else {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                _viewNoContent.hidden = NO;
                self.tableView.mj_footer.hidden = YES;
            }
            _aPage = 2;
        } fail:^(NSError *error) {

        } isKindOfModel:NSClassFromString(@"ModelInformationActivity")];
    
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [HttpMamager postRequestWithURLString:DYZ_information_informationActivity parameters:@{@"page":[NSNumber numberWithInteger:_aPage],@"pageSize":pageSizeDYZ} success:^(id responseObjectModel) {
            ModelInformationActivity *model = responseObjectModel;
            for (int i=0; i < model.activityList.count; i++) {
                [_activityListArray addObject:model.activityList[i]];
            }
            [self.tableView reloadData];
            if (model.activityList.count != 0) {
                [self.tableView.mj_footer endRefreshing];
                self.tableView.mj_footer.hidden = NO;
            } else {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                self.tableView.mj_footer.hidden = YES;
            }
            _aPage++;
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ModelInformationActivity")];
    }];
    
    
    [self.tableView.mj_header beginRefreshing];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 213;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _activityListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HuoDongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HouDongCell" forIndexPath:indexPath];
    ModelInformationActivityActivityList *model = _activityListArray[indexPath.row];
    [cell.urlPath sd_setImageWithURL:[NSURL URLWithString:model.urlPath]];
    cell.title.text = model.title;
    cell.info.text = model.info;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WebDatailURL *webVC = [[WebDatailURL alloc] init];
    ModelInformationActivityActivityList *model = _activityListArray[indexPath.row];
    
    webVC.detailUrl = model.detailUrl;
    webVC.titleTitle = model.title;
    webVC.content = model.info;
    webVC.imagePath = model.urlPath;
    webVC.isShare = true;
    [self.navigationController pushViewController:webVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
