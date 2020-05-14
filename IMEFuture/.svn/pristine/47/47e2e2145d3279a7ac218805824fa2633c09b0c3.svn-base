//
//  InformationShowViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/6/29.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "InformationShowViewController.h"

#import "Header.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "HttpMamager.h"
#import "UrlContant.h"

#import "InformationSearchViewController.h"


#import "IndustryInformationCell.h"
#import "OnlineExhibitionCell.h"
#import "ConventionCenterCell.h"

#import "ModelGetInformationList.h"



#import "WebDatailURL.h"

#import "AFNetworkReachabilityManager.h"

/*
 10 self.buttonLeft
 11 self.buttonMiddle
 12 self.buttonRight
 
 20 self.scrollViewBG
 21 _tableViewLeft
 22 _tableViewMiddle
 23 _tableViewRight
 */

@interface InformationShowViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate> {
    UITableView *_tableViewLeft;
    UITableView *_tableViewMiddle;
    UITableView *_tableViewRight;
    NSMutableArray *_arrayNewsList;
    NSMutableArray *_arrayOnlineList;
    NSMutableArray *_arrayOfflineList;
    NSInteger _aLeft;
    NSInteger _aMiddle;
    NSInteger _aRight;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation InformationShowViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    
    [self initButtonSearch];
    
    [self initScrollViewBG];
    
    [self initTableViewLeft];
    
    [self initTableViewMiddle];
    
    [self initTableViewRight];
    
    /**
     AFNetworkReachabilityStatusUnknown          = -1,  // 未知
     AFNetworkReachabilityStatusNotReachable     = 0,   // 无连接
     AFNetworkReachabilityStatusReachableViaWWAN = 1,   // 3G 花钱
     AFNetworkReachabilityStatusReachableViaWiFi = 2,   // WiFi
     */
    self.viewBGNoNet.hidden = YES;
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 0) {
        self.viewBGNoNet.hidden = NO;
        self.scrollViewBG.hidden = YES;
    }
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == 1 || [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus ==2) {
        self.viewBGNoNet.hidden = YES;
        self.scrollViewBG.hidden = NO;
    }
    
    [self initRefreshLeft];
    [self initRefreshMiddle];
    [self initRefreshRight];
    if (!self.scrollViewBG.isHidden) {
        [_tableViewLeft.mj_header beginRefreshing];
    }
}

- (void)initButtonSearch {

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ime_icon_search_2t"] highlightedImage:[UIImage imageNamed:@"ime_icon_search"]];
    imageView.frame = CGRectMake(8, 5, 22, 22);
    [self.buttonSearch addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+8, 8, [UIScreen mainScreen].bounds.size.height - 74 - 17 , 17)];
    label.text = @"搜索行业资讯、会展信息";
    label.textColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1];
    [self.buttonSearch addSubview:label];
}

- (void)initScrollViewBG {
    self.labelLine = [[UILabel alloc] initWithFrame:CGRectMake(0, _height_NavBar+39, kMainW/3.0, 2)];
    self.labelLine.backgroundColor = [UIColor colorWithRed:89/255.0 green:179/255.0 blue:50/255.0 alpha:1];
    [self.view addSubview:self.labelLine];
    
    UILabel *lableLineL = [[UILabel alloc] initWithFrame:CGRectMake(kMainW/3.0-0.25, _height_NavBar, 0.5, 40)];
    lableLineL.backgroundColor = colorLine;
    [self.view addSubview:lableLineL];
    UILabel *lableLineR = [[UILabel alloc] initWithFrame:CGRectMake(kMainW/3.0*2-0.25, _height_NavBar, 0.5, 40)];
    lableLineR.backgroundColor = colorLine;
    [self.view addSubview:lableLineR];
    
    
    self.scrollViewBG.delegate = self;
    self.scrollViewBG.tag = 20;
    self.scrollViewBG.contentSize = CGSizeMake(kMainW * 3, 0);
    self.scrollViewBG.pagingEnabled = YES;
    self.scrollViewBG.showsHorizontalScrollIndicator = NO;
}

- (void)initTableViewLeft {
    _tableViewLeft = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainH - 106) style:UITableViewStylePlain];
    _tableViewLeft.delegate = self;
    _tableViewLeft.dataSource = self;
    _tableViewLeft.tag = 21;
    [_tableViewLeft registerNib:[UINib nibWithNibName:@"IndustryInformationCell" bundle:nil] forCellReuseIdentifier:@"cellLeft"];
    [self.scrollViewBG addSubview:_tableViewLeft];
    _tableViewLeft.backgroundColor = [UIColor clearColor];
    _tableViewLeft.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)initTableViewMiddle {
    _tableViewMiddle = [[UITableView alloc] initWithFrame:CGRectMake(kMainW, 0, kMainW, kMainH - 106) style:UITableViewStylePlain];
    _tableViewMiddle.delegate = self;
    _tableViewMiddle.dataSource = self;
    _tableViewMiddle.tag = 22;
    [_tableViewMiddle registerNib:[UINib nibWithNibName:@"OnlineExhibitionCell" bundle:nil] forCellReuseIdentifier:@"cellMiddle"];
    [self.scrollViewBG addSubview:_tableViewMiddle];
    _tableViewMiddle.backgroundColor = [UIColor clearColor];
    _tableViewMiddle.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)initTableViewRight {
    _tableViewRight = [[UITableView alloc] initWithFrame:CGRectMake(kMainW * 2, 0, kMainW, kMainH - 106) style:UITableViewStylePlain];
    _tableViewRight.delegate = self;
    _tableViewRight.dataSource = self;
    _tableViewRight.tag = 23;
    [_tableViewRight registerNib:[UINib nibWithNibName:@"ConventionCenterCell" bundle:nil] forCellReuseIdentifier:@"cellRight"];
    [_tableViewRight registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.scrollViewBG addSubview:_tableViewRight];
    _tableViewRight.backgroundColor = [UIColor clearColor];
    _tableViewRight.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)initRefreshLeft {
    _tableViewLeft.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [HttpMamager postRequestWithURLString:DYZ_information_getInformationList parameters:@{@"searchInfo":@"",@"page":@1,@"infoType":@"N",@"pageSize":pageSizeDYZ} success:^(id responseObjectModel) {
            ModelGetInformationList *model = responseObjectModel;
            _arrayNewsList = model.newsList;
            [_tableViewLeft reloadData];
            [_tableViewLeft.mj_header endRefreshing];
            [_tableViewLeft.mj_footer endRefreshing];
            _aLeft = 2;
        } fail:^(NSError *error) {
        } isKindOfModel:NSClassFromString(@"ModelGetInformationList")];
    }];
    _tableViewLeft.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [HttpMamager postRequestWithURLString:DYZ_information_getInformationList parameters:@{@"searchInfo":@"",@"page":[NSNumber numberWithInteger:_aLeft],@"infoType":@"N",@"pageSize":pageSizeDYZ} success:^(id responseObjectModel) {
            ModelGetInformationList *model = responseObjectModel;
            for (int i = 0; i < model.newsList.count; i++) {
                [_arrayNewsList addObject:model.newsList[i]];
            }
            [_tableViewLeft reloadData];
            
            if (model.newsList.count != 0) {
                [_tableViewLeft.mj_footer endRefreshing];
            } else {
                [_tableViewLeft.mj_footer endRefreshingWithNoMoreData];
            }
            _aLeft++;
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ModelGetInformationList")];
    }];
}

- (void)initRefreshMiddle {
    _tableViewMiddle.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [HttpMamager postRequestWithURLString:DYZ_information_getInformationList parameters:@{@"searchInfo":@"",@"page":@1,@"infoType":@"O",@"pageSize":pageSizeDYZ} success:^(id responseObjectModel) {
            ModelGetInformationList *model = responseObjectModel;
            _arrayOnlineList = model.onlineList;
            [_tableViewMiddle reloadData];
            [_tableViewMiddle.mj_header endRefreshing];
            [_tableViewMiddle.mj_footer endRefreshing];
            _aMiddle = 2;
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ModelGetInformationList")];
    }];
    
    _tableViewMiddle.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [HttpMamager postRequestWithURLString:DYZ_information_getInformationList parameters:@{@"searchInfo":@"",@"page":[NSNumber numberWithInteger:_aMiddle],@"infoType":@"O",@"pageSize":pageSizeDYZ} success:^(id responseObjectModel) {
            ModelGetInformationList *model = responseObjectModel;
            for (int i = 0; i < model.onlineList.count; i++) {
                [_arrayOnlineList addObject:model.onlineList[i]];
            }
            [_tableViewMiddle reloadData];
            if (model.onlineList.count != 0) {
                [_tableViewMiddle.mj_footer endRefreshing];
            } else {
                [_tableViewMiddle.mj_footer endRefreshingWithNoMoreData];
            }
            _aMiddle++;
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ModelGetInformationList")];
    }];
}

- (void)initRefreshRight {
    _tableViewRight.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [HttpMamager postRequestWithURLString:DYZ_information_getInformationList parameters:@{@"searchInfo":@"",@"page":@1,@"infoType":@"I",@"pageSize":pageSizeDYZ} success:^(id responseObjectModel) {
            ModelGetInformationList *model = responseObjectModel;
            _arrayOfflineList = model.offlineList;
            [_tableViewRight reloadData];
            [_tableViewRight.mj_header endRefreshing];
            [_tableViewRight.mj_footer endRefreshing];
            _aRight = 2;
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ModelGetInformationList")];
    }];
    
    _tableViewRight.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [HttpMamager postRequestWithURLString:DYZ_information_getInformationList parameters:@{@"searchInfo":@"",@"page":[NSNumber numberWithInteger:_aRight],@"infoType":@"I",@"pageSize":pageSizeDYZ} success:^(id responseObjectModel) {
            ModelGetInformationList *model = responseObjectModel;
            for (int i = 0; i < model.offlineList.count; i++) {
                [_arrayOfflineList addObject:model.offlineList[i]];
            }
            [_tableViewRight reloadData];
            if (model.offlineList.count != 0) {
                [_tableViewRight.mj_footer endRefreshing];
            } else {
                [_tableViewRight.mj_footer endRefreshingWithNoMoreData];
            }
            _aRight++;
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ModelGetInformationList")];
    }];
}
- (IBAction)buttonClickSearch:(UIButton *)sender {
    [self.navigationController pushViewController:[InformationSearchViewController new] animated:YES];
}
- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 21) {
        return _arrayNewsList.count;
    } else if (tableView.tag == 22) {
        return _arrayOnlineList.count;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 21) {
        IndustryInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellLeft" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            UIView *viewH= [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 0.5)];
            viewH.backgroundColor = colorLine;
            [cell.contentView addSubview:viewH];
        }
        UIView *viewF = [[UIView alloc] initWithFrame:CGRectMake(0, 83.5, kMainW, 0.5)];
        viewF.backgroundColor = colorLine;
        [cell.contentView addSubview:viewF];
        
        ModelGetInformationListList *model = _arrayNewsList[indexPath.row];
        [cell.urlPath sd_setImageWithURL:[NSURL URLWithString:model.urlPath]];
        cell.title.text = model.title;
        cell.pubTm.text = [[model.pubTm componentsSeparatedByString:@" "] firstObject];
        
        NSMutableArray *tagResArray = model.tagRes;
        
        if (tagResArray.count == 0) {
            cell.tagRes0.text = nil;
            cell.tagRes1.text = nil;
            cell.tagRes2.text = nil;
        }
        if (tagResArray.count == 1) {
            ModelGetInformationListListTagRes *modelTagRes0 = tagResArray[0];
            cell.tagRes0.text = modelTagRes0.name;
            cell.tagRes1.text = nil;
            cell.tagRes2.text = nil;
        }
        if (tagResArray.count == 2) {
            ModelGetInformationListListTagRes *modelTagRes0 = tagResArray[0];
            ModelGetInformationListListTagRes *modelTagRes1 = tagResArray[1];
            cell.tagRes0.text = modelTagRes0.name;
            cell.tagRes1.text = modelTagRes1.name;
            cell.tagRes2.text = nil;
        }
        if (tagResArray.count == 3) {
            ModelGetInformationListListTagRes *modelTagRes0 = tagResArray[0];
            ModelGetInformationListListTagRes *modelTagRes1 = tagResArray[1];
            ModelGetInformationListListTagRes *modelTagRes2 = tagResArray[2];
            cell.tagRes0.text = modelTagRes0.name;
            cell.tagRes1.text = modelTagRes1.name;
            cell.tagRes2.text = modelTagRes2.name;
        }
        return cell;

    } else if (tableView.tag == 22) {
        OnlineExhibitionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellMiddle" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            UIView *viewH= [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 0.5)];
            viewH.backgroundColor = colorLine;
            [cell.contentView addSubview:viewH];
        }
        UIView *viewF = [[UIView alloc] initWithFrame:CGRectMake(0, 83.5, kMainW, 0.5)];
        viewF.backgroundColor = colorLine;
        [cell.contentView addSubview:viewF];
        
        ModelGetInformationListList *model = _arrayOnlineList[indexPath.row];
        [cell.urlPath sd_setImageWithURL:[NSURL URLWithString:model.urlPath]];
        cell.title.text = model.title;
        cell.info.text = model.info;
        return cell;
    } else {
        
        if (indexPath.row == 0) {
            ConventionCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellRight" forIndexPath:indexPath];
            
            [self line:cell.contentView withY:0];
            [self line:cell.contentView withY:168.5];
            
            ModelGetInformationListList *model = _arrayOfflineList[indexPath.section];
            [cell.urlPath sd_setImageWithURL:[NSURL URLWithString:model.urlPath]];
            cell.title.text = model.title;
            NSArray *begTmArr = [[[model.begTm componentsSeparatedByString:@" "] firstObject] componentsSeparatedByString:@"-"];
            NSArray *endTmArr = [[[model.endTm componentsSeparatedByString:@" "] firstObject] componentsSeparatedByString:@"-"];
            cell.begTm.text = [NSString stringWithFormat:@"%@.%@.%@-%@.%@",begTmArr[0],begTmArr[1],begTmArr[2],endTmArr[1],endTmArr[2]];
            cell.address.text = model.address;
            return cell;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 21) {
        return 84;
    } else if (tableView.tag == 22){
        return 84;
    } else {
        if (indexPath.row == 0) {
            return 169;
        } else {
            if (_arrayOfflineList.count == (indexPath.section+1)) {
                return 0;
            } else {
                return 10;
            }
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 21) {
        return 1;
    } else if (tableView.tag == 22) {
        return 1;
    } else {
        return _arrayOfflineList.count;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 21) {
        WebDatailURL *webVC = [[WebDatailURL alloc] init];
        ModelGetInformationListList *model = _arrayNewsList[indexPath.row];
        webVC.detailUrl = model.detailUrl;
        webVC.titleTitle = model.title;
        webVC.content = model.info;
        webVC.imagePath = model.urlPath;
        webVC.isShare = true;
        
        [self.navigationController pushViewController:webVC animated:YES];
    }
    if (tableView.tag == 22) {
        WebDatailURL *webVC = [[WebDatailURL alloc] init];
        ModelGetInformationListList *model = _arrayOnlineList[indexPath.row];
        webVC.detailUrl = model.detailUrl;
        webVC.titleTitle = model.title;
        webVC.content = model.info;
        webVC.imagePath = model.urlPath;
        webVC.isShare = true;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    if (tableView.tag == 23) {
        if (indexPath.row == 0) {
            WebDatailURL *webVC = [[WebDatailURL alloc] init];
            ModelGetInformationListList *model = _arrayOfflineList[indexPath.section];
            webVC.detailUrl = model.detailUrl;
            webVC.titleTitle = model.title;
            webVC.content = model.info;
            webVC.imagePath = model.urlPath;
            webVC.isShare = true;
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)buttonClickScroll:(UIButton *)sender {
    self.scrollViewBG.contentOffset = CGPointMake((sender.tag-10)*kMainW, 0);
    [sender setTitleColor:[UIColor colorWithRed:89/255.0 green:179/255.0 blue:50/255.0 alpha:1] forState:UIControlStateNormal];
    self.labelLine.frame = CGRectMake(kMainW/3*(sender.tag-10), _height_NavBar+39, kMainW/3, 2);
    switch (sender.tag) {
        case 10:{
            [_tableViewLeft.mj_header beginRefreshing];
            [self.buttonMiddle setTitleColor:[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
            [self.buttonRight setTitleColor:[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
            break;
        }
        case 11:{
            [_tableViewMiddle.mj_header beginRefreshing];
            [self.buttonLeft setTitleColor:[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
            [self.buttonRight setTitleColor:[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
            break;
        }
        case 12:{
            [_tableViewRight.mj_header beginRefreshing];
            [self.buttonLeft setTitleColor:[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
            [self.buttonMiddle setTitleColor:[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    switch (scrollView.tag) {
        case 20:{
            CGFloat x = scrollView.contentOffset.x;
//            NSLog(@"%f",x);
//            if (x < kMainScreenW) {
//                NSLog(@"0");
//            }
//            if (x >= kMainScreenW && x < kMainScreenW*2) {
//                NSLog(@"1");
//            }
//            if (x >= kMainScreenW*2) {
//                NSLog(@"2");
//            }
            if (x == 0) {
                self.labelLine.frame = CGRectMake(0, _height_NavBar+39, kMainW/3, 2);
                [self.buttonLeft setTitleColor:[UIColor colorWithRed:89/255.0 green:179/255.0 blue:50/255.0 alpha:1] forState:UIControlStateNormal];
                [self.buttonMiddle setTitleColor:[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
                [self.buttonRight setTitleColor:[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
            }
            if (x == kMainW) {
                self.labelLine.frame = CGRectMake(kMainW/3, _height_NavBar+39, kMainW/3, 2);
                [self.buttonLeft setTitleColor:[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
                [self.buttonMiddle setTitleColor:[UIColor colorWithRed:89/255.0 green:179/255.0 blue:50/255.0 alpha:1] forState:UIControlStateNormal];
                [self.buttonRight setTitleColor:[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
            }
            if (x == kMainW*2) {
                self.labelLine.frame = CGRectMake(kMainW/3*2, _height_NavBar+39, kMainW/3,2);
                [self.buttonLeft setTitleColor:[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
                [self.buttonMiddle setTitleColor:[UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1] forState:UIControlStateNormal];
                [self.buttonRight setTitleColor:[UIColor colorWithRed:89/255.0 green:179/255.0 blue:50/255.0 alpha:1] forState:UIControlStateNormal];
            }
            break;
        }
            
        case 21:{
            
            break;
        }
        case 22:{
            
            break;
        }
        case 23:{
            
            break;
        }
        default:
            break;
    }
    
}

- (void)line:(UIView *)view withY:(CGFloat)y {
    UIView *viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, y, kMainW, 0.5)];
    viewLine.backgroundColor = colorLine;
    [view addSubview:viewLine];
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
