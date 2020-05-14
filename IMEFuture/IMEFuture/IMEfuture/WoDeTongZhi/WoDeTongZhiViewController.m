//
//  WoDeTongZhiViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/18.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "WoDeTongZhiViewController.h"
#import "VoHeader.h"

#import "WoDeTongZhiCell.h"

#import "BaoJiaZiXunViewController.h"

#import "EGOrderViewController.h"

#import "XunPanXiangQingViewController.h"
#import "DingDanXiangQingCaiViewController.h"
#import "DingDanXiangQingGongViewController.h"
#import "YanHuoLieBiaoVC.h"
#import "YanHuoXiangQingVC.h"
#import "BuFaHuoLieBiaoVC.h"

#import "EGYiJiaViewController.h"
#import "ECYiJiaViewController.h"
#import "EGChaKanBaoJiaYiJiaViewController.h"
#import "ECChaKanBaoJiaYiJiaViewController.h"
#import "XiTongTZSelectedResultsViewController.h"

#import "NSArray+Transition.h"

#import "WebDatailURL.h"
#import "JPUSHService.h"
#import "UIView+Toast.h"


#import <WebKit/WebKit.h>
#import "IMEProcessPool.h"
#import "ShouHuoViewController09.h"
#import "ShouHuoDetailViewController09.h"
#import "YanHuoViewController09.h"
#import "YanHuoDetailViewController.h"
#import "ShaiXuanBaoJiaViewController.h"
#import "FaHuoLieBiaoViewController09.h"
#import "ChaKanShouPanJiePanYiJiaViewController.h"

static NSInteger pageSize = 14;

@interface WoDeTongZhiViewController () <UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,WKNavigationDelegate> {
    NSMutableArray <__kindof PmPageBean *> *_arrayPmPageBean;
    
    NSInteger _aPage;
    
    UIView *_viewNoContent;
    NSMutableArray *_arrayButton;
    
    UIView *_viewLoading1;//透明
    PmPageBean *_pmPageBean;//记录点击的是哪一个PmPageBean，然后在webView的回调当中区分
    NSMutableDictionary *_mutableDic;//extra
    
    NSString *_first;
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (nonatomic,strong) NSMutableArray *arrayNSIndexPath;//记录上一次的选中结果

@property (weak, nonatomic) IBOutlet UIView *viewEditing;//全选、标记已读、删除
@property (weak, nonatomic) IBOutlet UIImageView *imageViewDuiGou;//imageView 对勾 是否全选 用tag区分（默认为0 全选为1）

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomConstraint;//0 最下面、50 在上面

@property (weak, nonatomic) IBOutlet UIView *viewBGShaiXuan;//按产品筛选 取消


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation WoDeTongZhiViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([self.isNotification isEqualToString:@"YES"]) {
        BaoJiaZiXunViewController *baoJiaZiXunViewController = [[BaoJiaZiXunViewController alloc] init];
        baoJiaZiXunViewController.inquiryOrderId = self.inquiryIdNotification;
        [self.navigationController pushViewController:baoJiaZiXunViewController animated:YES];
        self.isNotification = nil;
    }
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _first = @"first";
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.viewBGShaiXuan.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    _arrayButton = [NSMutableArray arrayWithCapacity:0];
    UIView *viewAnChanPin = [self.viewBGShaiXuan viewWithTag:100];
    for (NSInteger i = 1; i < 7; i++) {
        UIButton *btn = [viewAnChanPin viewWithTag:i];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = colorRGB(231, 228, 231).CGColor;
        btn.layer.cornerRadius = 15;
        [btn addTarget:self action:@selector(buttonSelectedResults:) forControlEvents:UIControlEventTouchUpInside];
        [_arrayButton addObject:btn];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"WoDeTongZhiCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    
    self.tableView.estimatedRowHeight = 44.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self initRequest];
    
    _viewNoContent = [UIView addView:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) imageNamed:@"img_no_result" title:@"暂无数据"];
    _viewNoContent.hidden = YES;
    [self.view addSubview:_viewNoContent];
    
    _viewLoading1 = [UIView loadingWithFrame:CGRectMake(0, 0, kMainW, kMainH)];
    _viewLoading1.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewLoading1];
    _viewLoading1.hidden = YES;
    
    UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
    singleFingerOne.numberOfTouchesRequired = 1;
    singleFingerOne.numberOfTapsRequired = 1;
    singleFingerOne.delegate = self;
    [self.viewBGShaiXuan addGestureRecognizer:singleFingerOne];
}

#pragma mark 编辑
- (IBAction)buttonEditing:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (!button.currentTitle) {
        [button setImage:nil forState:UIControlStateNormal];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        self.viewEditing.hidden = NO;
        self.tableViewBottomConstraint.constant = 50;
        self.tableView.editing = YES;
    } else if ([button.currentTitle isEqualToString:@"完成"]){
        [button setImage:[UIImage imageNamed:@"icon_edit1"] forState:UIControlStateNormal];
        [button setTitle:nil forState:UIControlStateNormal];
        self.viewEditing.hidden = YES;
        self.tableViewBottomConstraint.constant = 0;
        self.tableView.editing = NO;
    }
    [self.view bringSubviewToFront:self.viewEditing];
}

#pragma mark 筛选
- (IBAction)buttonScreen:(id)sender {
    self.viewBGShaiXuan.hidden = NO;
    [self.view bringSubviewToFront:self.viewBGShaiXuan];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayPmPageBean.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WoDeTongZhiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectedBackgroundView = [UIView new];
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    
    cell.viewTap.hidden = YES;
    
    PmPageBean *pmPageBean = _arrayPmPageBean[indexPath.row];
      
    cell.labelName.text = [NSString AppName:pmPageBean.appName];

    if ([pmPageBean.isRead boolValue]==0) {
        cell.viewTap.hidden = NO;
    } else if ([pmPageBean.isRead boolValue]==1){
        cell.viewTap.hidden = YES;
    }

    cell.labelTime.text = pmPageBean.createTime;
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[pmPageBean.content  dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:25.0f] } documentAttributes:nil error:nil];
    cell.label1.attributedText = attrStr;
//    NSString *strUrl = [pmPageBean.content stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
//    strUrl = [strUrl stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
//    strUrl = [strUrl stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
//    cell.label1.text = strUrl;
    cell.label1.font = [UIFont systemFontOfSize:14];
    cell.label1.textColor = colorRGB(102, 102, 102);
//    cell.label1.text = pmPageBean.content;
    
//    NSString * stringContent = pmPageBean.content;
//    NSString *string = @"";
//    for (int i = 0; i < stringContent.length; i++) {
//        NSString *str = [stringContent substringWithRange:NSMakeRange(i, 1)];
//        string = [NSString stringWithFormat:@"%@%@",string,str];
//    }
//    cell.label1.text = string;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!tableView.editing) {//tableView在编辑的不能点击
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        PmPageBean *pmPageBean = _arrayPmPageBean[indexPath.row];
        
        _pmPageBean = pmPageBean;
        
        if ([pmPageBean.needAppDisplay integerValue] == 1) {
            //需要App原生展示
            if ([pmPageBean.receiveUserId isEqualToString:loginModel.userId]) {
                //当前身份是可以展示
                NSLog(@"需要App原生展示 --- 当前身份是可以展示");
                [self withPmPageBean:_pmPageBean];
                [self readAppNotifacation:_pmPageBean];
            } else {
                //当前身份不能展示，需要切换身份
                NSLog(@"需要App原生展示 --- 当前身份不能展示，需要切换身份");
                [self changeIdentity:pmPageBean.receiveUserId];
            }
        } else if (pmPageBean.detailUrl.length>0) {
            //需要App用网页展示通知URL之向的网页
            if ([pmPageBean.receiveUserId isEqualToString:loginModel.userId]) {
                //当前身份是可以展示
                NSLog(@"需要App用网页展示通知URL之向的网页 --- 当前身份是可以展示");
                [self webViewWithTitle:@"通知详情" withURL:pmPageBean.detailUrl];
                [self readAppNotifacation:_pmPageBean];
            } else {
                //当前身份不能展示，需要切换身份
                NSLog(@"需要App用网页展示通知URL之向的网页 --- 当前身份不能展示，需要切换身份");
                [self changeIdentity:pmPageBean.receiveUserId];
            }
        } else {
            //不需要展示
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"该通知无详情页面"];
            [self readAppNotifacation:_pmPageBean];
        }
    } else {
        NSMutableIndexSet *arrayCount = [[NSMutableIndexSet alloc] init];
        [[self.tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"1%@-----%ld",obj,idx);
            [arrayCount addIndex:obj.row];
        }];
        
        NSLog(@"1count-->>%ld",arrayCount.count);
        if (arrayCount.count > 0) {
        
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableIndexSet *arrayCount = [[NSMutableIndexSet alloc] init];
    [[self.tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"2%@-----%ld",obj,idx);
        [arrayCount addIndex:obj.row];
    }];
    
    NSLog(@"2count-->>%ld",arrayCount.count);
    if (arrayCount.count > 0) {
        
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    if (tableView.editing) {
        return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:NO animated:YES];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确认删除该消息吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            PmPageBean *pmPageBean = _arrayPmPageBean[indexPath.row];
            EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
            
            NSString *userId = nil;
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
            for (NSDictionary *dic in array) {
                IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
                if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                    userId = identityBean.userId;
                    break;
                }
            }
            
            postEntityBean.entity = @{@"pmIds":pmPageBean.pmId,@"userId":userId};
            NSDictionary *dic = postEntityBean.mj_keyValues;
            [HttpMamager postRequestWithURLString:DYZ_notify_deleteUserPm parameters:dic success:^(id responseObjectModel) {
                
                ReturnMsgBean *returnMsgBean = responseObjectModel;
                if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"操作成功"];
                }
            } fail:^(NSError *error) {
                
            } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
            
            [_arrayPmPageBean removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark 全选
- (IBAction)buttonQuanXuan:(id)sender {
    self.imageViewDuiGou.tag = self.imageViewDuiGou.tag==0?1:0;
    if (self.imageViewDuiGou.tag == 0) {
        self.imageViewDuiGou.image = [UIImage imageNamed:@"icon_unchecked"];
        [[self.tableView indexPathsForVisibleRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.tableView deselectRowAtIndexPath:obj animated:NO];//只能取消当前页面的选中，所以下面来个reload
        }];
        [self.tableView reloadData];
    } else {
        self.imageViewDuiGou.image = [UIImage imageNamed:@"icon_selected"];
        [_arrayPmPageBean enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }];
    }
}

#pragma mark 标记已读
- (IBAction)buttonBiaoJiYiDu:(id)sender {
    __block NSString *pmId = nil;
    [[self.tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@----%ld",obj,idx);
        PmPageBean *pmPageBean = _arrayPmPageBean[obj.row];
        if (idx == 0) {
            pmId = pmPageBean.pmId;
        } else {
            pmId = [NSString stringWithFormat:@"%@|%@",pmId,pmPageBean.pmId];
        }
    }];

    NSLog(@"%@",pmId);
    if (pmId) {
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        NSString *userId = nil;
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
        for (NSDictionary *dic in array) {
            IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
            if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                userId = identityBean.userId;
                break;
            }
        }
        postEntityBean.entity = @{@"pmIds":pmId,@"userId":userId};
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_notify_readUserPm parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [[self.tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSLog(@"%@----%ld",obj,idx);
                    PmPageBean *pmPageBean = _arrayPmPageBean[obj.row];
                    pmPageBean.isRead = [NSNumber numberWithInteger:1];
                }];
                
                self.arrayNSIndexPath = [NSMutableArray arrayWithArray:[self.tableView indexPathsForSelectedRows]];
                [self.tableView reloadData];
//                [self.arrayNSIndexPath enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:obj.row inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
//                }];
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"操作成功"];
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    } else {
        return;
    }

}

#pragma mark 筛选
- (void)buttonSelectedResults:(UIButton *)sender {
    for (NSInteger i = 0; i < _arrayButton.count; i++) {
        UIButton *btn = _arrayButton[i];
        if (sender.tag == btn.tag) {
            btn.layer.borderColor = colorRGB(89, 178, 50).CGColor;
            [btn setTitleColor:colorRGB(89, 178, 50) forState:UIControlStateNormal];
        } else {
            btn.layer.borderColor = colorRGB(231, 228, 231).CGColor;
            [btn setTitleColor:colorRGB(102, 102, 102) forState:UIControlStateNormal];
        }
    }
    
    NSString *requestAppName = nil;
    if (sender.tag == 1) {
        requestAppName = @"USERCENTER";
    } else if (sender.tag == 2) {
        requestAppName = @"TMGC";
    } else if (sender.tag == 3) {
        requestAppName = @"FEIBIAO";
    } else if (sender.tag == 4) {
        requestAppName = @"DRAW";
    } else if (sender.tag == 5) {
        requestAppName = @"SBBJY";
    } else if (sender.tag == 6) {
        requestAppName = @"WEIKE";
    }
    XiTongTZSelectedResultsViewController *xiTongTZSelectedResultsViewController = [[XiTongTZSelectedResultsViewController alloc] init];
    xiTongTZSelectedResultsViewController.requestAppName = requestAppName;
    [self.navigationController pushViewController:xiTongTZSelectedResultsViewController animated:YES];
    
    self.viewBGShaiXuan.hidden = YES;
}

#pragma mark 删除
- (IBAction)buttonShanChu:(id)sender {
    
    NSMutableIndexSet *arrayCount = [[NSMutableIndexSet alloc] init];
    [[self.tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"%@-----%ld",obj,idx);
        [arrayCount addIndex:obj.row];
    }];
    
//    NSLog(@"count-->>%ld",arrayCount.count);
    if (arrayCount.count > 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"确认删除该消息吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            __block NSString *pmId = nil;
            NSMutableIndexSet *insets = [[NSMutableIndexSet alloc] init];
            [[self.tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [insets addIndex:obj.row];
                
                PmPageBean *pmPageBean = _arrayPmPageBean[obj.row];
                if (idx == 0) {
                    pmId = pmPageBean.pmId;
                } else {
                    pmId = [NSString stringWithFormat:@"%@|%@",pmId,pmPageBean.pmId];
                }
            }];
            if (pmId) {
                EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
                
                NSString *userId = nil;
                LoginModel *loginModel = [DatabaseTool getLoginModel];
                NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
                for (NSDictionary *dic in array) {
                    IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
                    if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                        userId = identityBean.userId;
                        break;
                    }
                }
                
                postEntityBean.entity = @{@"pmIds":pmId,@"userId":userId};
                
                NSDictionary *dic = postEntityBean.mj_keyValues;
                [HttpMamager postRequestWithURLString:DYZ_notify_deleteUserPm parameters:dic success:^(id responseObjectModel) {
                    
                    ReturnMsgBean *returnMsgBean = responseObjectModel;
                    
                    if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"操作成功"];
                        
                        [self.tableView.mj_footer beginRefreshing];
                        [self.tableView reloadData];
                    }
                } fail:^(NSError *error) {
                    
                } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
            } else {
                return;
            }
            
            [_arrayPmPageBean removeObjectsAtIndexes:insets];
            [self.tableView deleteRowsAtIndexPaths:[self.tableView indexPathsForSelectedRows] withRowAnimation:UITableViewRowAnimationFade];
            
            if (_arrayPmPageBean.count == 0) {
                [self.tableView.mj_footer resetNoMoreData];
                [self.tableView reloadData];
            }
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark 取消
- (IBAction)buttonQuXiao:(id)sender {
    self.viewBGShaiXuan.hidden = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UIView *viewAnChanPin = [self.viewBGShaiXuan viewWithTag:100];
    if ([touch.view isDescendantOfView:viewAnChanPin]) {
        return NO;
    }
    return YES;
}

- (void)handleSingleFingerEvent:(UITapGestureRecognizer *)tap {
    self.viewBGShaiXuan.hidden = YES;
}
#pragma mark 不同的平台，不同的通知类型处理
- (void)withPmPageBean:(PmPageBean *)pmPageBean {
    _mutableDic = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (ParamsBean *paramsBean in pmPageBean.extra) {
        [_mutableDic setObject:paramsBean.value forKey:paramsBean.name];
    }
    
    if ([pmPageBean.statisticStr isEqualToString:@"N217"]||[pmPageBean.statisticStr isEqualToString:@"N218"]||[pmPageBean.statisticStr isEqualToString:@"N219"]||[pmPageBean.statisticStr isEqualToString:@"N220"]||[pmPageBean.statisticStr isEqualToString:@"N221"]||[pmPageBean.statisticStr isEqualToString:@"N222"]||[pmPageBean.statisticStr isEqualToString:@"N223"]||[pmPageBean.statisticStr isEqualToString:@"N224"]||[pmPageBean.statisticStr isEqualToString:@"N226"]) {
        //供应商 询盘详情
        XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
        xunPanXiangQingViewController.inquiryOrderId = _mutableDic[@"a"];
        xunPanXiangQingViewController.isDefaultPurchase = DefaultSupplier;
        [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
    }
    
    //供应商 接单详情
    if ([pmPageBean.statisticStr isEqualToString:@"N225"]) {
        _viewLoading1.hidden = NO;
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
        TradeOrder *tradeOrder = [[TradeOrder alloc] init];
        tradeOrder.orderId = _mutableDic[@"e"];
        postEntityBean.entity = tradeOrder.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        //    NSLog(@"%@",dic)
        [HttpMamager postRequestWithURLString:DYZ_tradeOrder_supplier_supplierOrderDetail parameters:dic success:^(id responseObjectModel) {
            ReturnEntityBean *returnEntityBean = responseObjectModel;
            _viewLoading1.hidden = YES;
            if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
                TradeOrder *tradeOrder = [TradeOrder mj_objectWithKeyValues:returnEntityBean.entity];
                ChaKanShouPanJiePanYiJiaViewController *vc = [[ChaKanShouPanJiePanYiJiaViewController alloc] init];
                vc.orderId = tradeOrder.orderId;
                vc.inquiryOrderId = tradeOrder.inquiryOrderId;
                [self.navigationController pushViewController:vc animated:YES];
            }
        } fail:^(NSError *error) {
            _viewLoading1.hidden = YES;
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    }
    
    //供应商 发货页面
    if ([pmPageBean.statisticStr isEqualToString:@"N227"]) {
        _viewLoading1.hidden = NO;
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
        TradeOrder *tradeOrder = [[TradeOrder alloc] init];
        tradeOrder.orderId = _mutableDic[@"e"];
        postEntityBean.entity = tradeOrder.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        //    NSLog(@"%@",dic)
        [HttpMamager postRequestWithURLString:DYZ_tradeOrder_supplier_supplierOrderDetail parameters:dic success:^(id responseObjectModel) {
            ReturnEntityBean *returnEntityBean = responseObjectModel;
            _viewLoading1.hidden = YES;
            if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
                TradeOrder *tradeOrder = [TradeOrder mj_objectWithKeyValues:returnEntityBean.entity];
                FaHuoLieBiaoViewController09 *vc = [[FaHuoLieBiaoViewController09 alloc] init];
                vc.insideOrderCode = tradeOrder.insideOrderCode;
                vc.isOpenErp = tradeOrder.isOpenErp;
                [self.navigationController pushViewController:vc animated:true];
            }
        } fail:^(NSError *error) {
            _viewLoading1.hidden = YES;
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    }
    
    //供应商 发货详情。没有发货详情界面，产品说不做。
    if ([pmPageBean.statisticStr isEqualToString:@"N229"]||[pmPageBean.statisticStr isEqualToString:@"N230"]||[pmPageBean.statisticStr isEqualToString:@"N231"]) {
        
    }
    

    //采购商 该询盘筛选报价页面
    if ([pmPageBean.statisticStr isEqualToString:@"N8"]) {
        _viewLoading1.hidden = false;
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
        
        InquiryOrder *inquiryOrder = [[InquiryOrder alloc] init];
        inquiryOrder.inquiryOrderId = _mutableDic[@"b"];
        postEntityBean.entity = inquiryOrder.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_inquiry_purchase_detail parameters:dic success:^(id responseObjectModel) {
            ReturnEntityBean *model = responseObjectModel;
            _viewLoading1.hidden = YES;
            if ([model.status isEqualToString:@"SUCCESS"]) {

                ShaiXuanBaoJiaViewController *shaiXuanBaoJiaViewController = [[ShaiXuanBaoJiaViewController alloc] init];
                shaiXuanBaoJiaViewController.inquiryOrder = [InquiryOrder mj_objectWithKeyValues:model.entity];
                [self.navigationController pushViewController:shaiXuanBaoJiaViewController animated:YES];
        
            }
            
        } fail:^(NSError *error) {
            _viewLoading1.hidden = YES;
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];

    }
    
    //采购商 询盘详情
    if ([pmPageBean.statisticStr isEqualToString:@"N9"]) {
        XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
        xunPanXiangQingViewController.inquiryOrderId = _mutableDic[@"b"];
        xunPanXiangQingViewController.isDefaultPurchase = DefaultPurchase;
        [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
    }
    
    //采购商 订单详情页面
    if ([pmPageBean.statisticStr isEqualToString:@"N10"]||[pmPageBean.statisticStr isEqualToString:@"N11"]||[pmPageBean.statisticStr isEqualToString:@"N12"]||[pmPageBean.statisticStr isEqualToString:@"N13"]) {
        DingDanXiangQingCaiViewController *dingDanXiangQingCaiViewController = [[DingDanXiangQingCaiViewController alloc] init];
        dingDanXiangQingCaiViewController.orderId = _mutableDic[@"a"];
        dingDanXiangQingCaiViewController.stringResource = @"ECaiGouShangViewControllerL";
        [self.navigationController pushViewController:dingDanXiangQingCaiViewController animated:YES];
    }
    
    //采购商 收货页面
    if ([pmPageBean.statisticStr isEqualToString:@"N14"]) {
//        _mutableDic[@"b"];
        _viewLoading1.hidden = false;
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
        DeliverOrderReqBean *deliverOrderReqBean = [DeliverOrderReqBean new];
        deliverOrderReqBean.deliverCode = _mutableDic[@"b"];
        postEntityBean.entity = deliverOrderReqBean.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        [HttpMamager postRequestWithURLString:DYZ_inspect_appGetInspectOrder parameters:dic success:^(id responseObjectModel) {
            _viewLoading1.hidden = YES;
            ReturnEntityBean *model = responseObjectModel;
            if ([model.status isEqualToString:@"SUCCESS"]) {
                InspectOrderVo *inspectOrderVo = [InspectOrderVo mj_objectWithKeyValues:model.entity];
                if (inspectOrderVo.receiveOrder == nil) {//收货
                    ShouHuoViewController09 *vc = [ShouHuoViewController09 new];
                    vc.deliverOrderDetailBean = inspectOrderVo.deliverOrder;
                    [self.navigationController pushViewController:vc animated:true];
                } else {//收货详情
                    ShouHuoDetailViewController09 *vc = [[ShouHuoDetailViewController09 alloc] init];
                    inspectOrderVo.receiveOrder.deliverOrder = inspectOrderVo.deliverOrder;
                    vc.receiveBean = inspectOrderVo.receiveOrder;
                    [self.navigationController pushViewController:vc animated:true];
                }
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:model.returnMsg];
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    }
    
    //采购商 质检页面
    if ([pmPageBean.statisticStr isEqualToString:@"N16"]) {
        _viewLoading1.hidden = false;
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        postEntityBean.fbToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"efeibiaoToken"];
        DeliverOrderReqBean *deliverOrderReqBean = [DeliverOrderReqBean new];
        deliverOrderReqBean.deliverCode = _mutableDic[@"a"];
        postEntityBean.entity = deliverOrderReqBean.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        [HttpMamager postRequestWithURLString:DYZ_inspect_appGetInspectOrder parameters:dic success:^(id responseObjectModel) {
            ReturnEntityBean *model = responseObjectModel;
                        if ([model.status isEqualToString:@"SUCCESS"]) {
                            
                            InspectOrderVo *inspectOrderVo = [InspectOrderVo mj_objectWithKeyValues:model.entity];
                            
                            if (inspectOrderVo.inspectOrderId == nil) {
                                if (inspectOrderVo.receiveOrder == nil) {
                                    NSLog(@"没有质检单");
                                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"没有质检单"];
                                } else {
                                    InspectOrderVo *model = [InspectOrderVo new];
                                    model.supplierEnterpriseName = inspectOrderVo.supplierEnterpriseName;
                                    model.receiveCode = inspectOrderVo.deliverOrder.receiveCode;
                                    model.receiveTime = inspectOrderVo.receiveOrder.receiveTime;
                                    model.deliverCode = inspectOrderVo.deliverOrder.deliverCode;
                                    model.deliveryTime = inspectOrderVo.deliverOrder.deliveryTime;
                                    model.deliverNumber = inspectOrderVo.deliverOrder.deliverNumber;
                                    model.deliveryMethods = inspectOrderVo.deliverOrder.deliveryMethods;
                                    model.deliveryContact = inspectOrderVo.deliverOrder.deliveryContact;
                                    model.deliveryPhone = inspectOrderVo.deliverOrder.deliveryPhone;
                                    model.license = inspectOrderVo.deliverOrder.license;
                                    model.logisticsCompanyKey = inspectOrderVo.deliverOrder.logisticsCompanyKey;
                                    model.logisticsNo = inspectOrderVo.deliverOrder.logisticsNo;
                                    model.selfAddress = inspectOrderVo.deliverOrder.selfAddress;
                                    model.remark = inspectOrderVo.deliverOrder.remark;
                                    model.deliveryMethodsDesc = inspectOrderVo.deliverOrder.deliveryMethodsDesc;
                                    
                                    model.deliverOrderId = inspectOrderVo.deliverOrder.deliverOrderId;
                                    model.receiveOrderId = inspectOrderVo.receiveOrder.receiveOrderId;
                                    model.isOpenErp = inspectOrderVo.receiveOrder.isOpenErp;
                                    
            
                                    NSMutableArray *inspectOrderItems = [[NSMutableArray alloc] init];
                                    
                                    for (NSInteger i=0; i<inspectOrderVo.receiveOrder.receiveOrderItems.count; i++) {
                                        ReceiveItemBean *receiveItem = inspectOrderVo.receiveOrder.receiveOrderItems[i];
                                        InspectOrderItemVo *item = [InspectOrderItemVo new];
                                        item.receiveOrderItemId = receiveItem.receiveOrderItemId;
                                        item.receiveNum = receiveItem.receiveNum.stringValue;
                                        item.deliverOrderItemId =  receiveItem.deliverOrderItemId;
                                        item.qualityQuantity = receiveItem.receiveNum;
                                        item.defectiveQuantity = [NSNumber numberWithInteger:0];
                                        item.isMianjian = [NSNumber numberWithInteger:0];
                                        item.isReceiveMianjian = receiveItem.isMianjian;
                                        item.canInspectNum = receiveItem.receiveNum;
                                        
                                        if (receiveItem.isMianjian.integerValue == 1) {
                                            
                                        } else {
                                            [inspectOrderItems addObject:item];
                                        }
                                    }
                                    

                                    model.inspectOrderItems = inspectOrderItems;
                                    
                                    model.deliverOrder = inspectOrderVo.deliverOrder;
                                    
                                    YanHuoViewController09 *vc = [[YanHuoViewController09 alloc] init];
                                    vc.inspectOrderVo = model;
                                    
                                    [self.navigationController pushViewController:vc animated:true];
                                }
                            } else {
                                if ([inspectOrderVo.receiveOrderStatus isEqualToString:@"INSPECTING"]) {//质检中
                                    YanHuoViewController09 *vc = [[YanHuoViewController09 alloc] init];
                                    NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:0];
                                    NSMutableArray *inspectOrderItems = [[NSMutableArray alloc] initWithCapacity:0];
                                    for (NSInteger i=0; i<inspectOrderVo.inspectOrderItems.count; i++) {
                                        InspectOrderItemVo *model0 = inspectOrderVo.inspectOrderItems[i];
                                        DeliverOrderItemBean *model1 = inspectOrderVo.deliverOrder.items[i];
                                        if (model0.isReceiveMianjian.integerValue == 1) {
                                            
                                        } else {
                                            [inspectOrderItems addObject:model0];
                                            [items addObject:model1];
                                        }
                                    }
                                    inspectOrderVo.inspectOrderItems = inspectOrderItems;
                                    inspectOrderVo.deliverOrder.items = items;
                                    vc.inspectOrderVo = inspectOrderVo;
                                    [self.navigationController pushViewController:vc animated:true];
                                } else if ([inspectOrderVo.receiveOrderStatus isEqualToString:@"INSPECTED"]) {//已质检
                                    YanHuoDetailViewController *vc = [[YanHuoDetailViewController alloc] init];
                                    
                                    inspectOrderVo.deliveryContact = inspectOrderVo.deliverOrder.deliveryContact;
                                    inspectOrderVo.deliveryPhone = inspectOrderVo.deliverOrder.deliveryPhone;
                                    
                                    vc.inspectOrderVo = inspectOrderVo;
                                    [self.navigationController pushViewController:vc animated:true];
                                }
                            }
                            _viewLoading1.hidden = YES;
                        } else {
                            [[MyAlertCenter defaultCenter] postAlertWithMessage:model.returnMsg];
                        }
        } fail:^(NSError *error) {
                            
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
                
    }
    
    
    
    

    
    
    
    
//    if ([pmPageBean.statisticStr isEqualToString:@"ND6"]||[pmPageBean.statisticStr isEqualToString:@"ND9"]||[pmPageBean.statisticStr isEqualToString:@"ND11"]||[pmPageBean.statisticStr isEqualToString:@"ND12"]||[pmPageBean.statisticStr isEqualToString:@"ND13"]||[pmPageBean.statisticStr isEqualToString:@"ND16"]||[pmPageBean.statisticStr isEqualToString:@"ND17"]||[pmPageBean.statisticStr isEqualToString:@"ND21"]||[pmPageBean.statisticStr isEqualToString:@"ND28"]) {
//        // 订单详情
//        if ([pmPageBean.statisticStr isEqualToString:@"ND6"]||[pmPageBean.statisticStr isEqualToString:@"ND16"]||[pmPageBean.statisticStr isEqualToString:@"ND17"]) {
//            //非标采购商 订单详情
//            DingDanXiangQingCaiViewController *dingDanXiangQingCaiViewController = [[DingDanXiangQingCaiViewController alloc] init];
//            dingDanXiangQingCaiViewController.orderId = _mutableDic[@"tradeId"];
//            dingDanXiangQingCaiViewController.stringResource = @"ECaiGouShangViewControllerL";
//            [self.navigationController pushViewController:dingDanXiangQingCaiViewController animated:YES];
//        } else {
//            //非标供应商 订单详情
//            DingDanXiangQingGongViewController *dingDanXiangQingGongViewController = [[DingDanXiangQingGongViewController alloc] init];
//            dingDanXiangQingGongViewController.orderId = _mutableDic[@"tradeId"];
//            [self.navigationController pushViewController:dingDanXiangQingGongViewController animated:YES];
//        }
//    }
//    
//    if ([pmPageBean.statisticStr isEqualToString:@"ND23"]||[pmPageBean.statisticStr isEqualToString:@"ND24"]) {
//        BaoJiaZiXunViewController *baoJiaZiXunViewController = [[BaoJiaZiXunViewController alloc] init];
//        baoJiaZiXunViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
//        [self.navigationController pushViewController:baoJiaZiXunViewController animated:YES];
//    }
//    
//    if ([pmPageBean.statisticStr isEqualToString:@"ND30"]){
//        ECYiJiaViewController *eCYiJiaViewController = [[ECYiJiaViewController alloc] init];
//        eCYiJiaViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
//        [self.navigationController pushViewController:eCYiJiaViewController animated:YES];
//    }
//    if ([pmPageBean.statisticStr isEqualToString:@"ND31"]){
//        ECChaKanBaoJiaYiJiaViewController *eCChaKanBaoJiaYiJiaViewController = [[ECChaKanBaoJiaYiJiaViewController alloc] init];
//        eCChaKanBaoJiaYiJiaViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
//        [self.navigationController pushViewController:eCChaKanBaoJiaYiJiaViewController animated:YES];
//    }
//    if ([pmPageBean.statisticStr isEqualToString:@"ND32"]){
//        EGYiJiaViewController *eGYiJiaViewController = [[EGYiJiaViewController alloc] init];
//        eGYiJiaViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
//        [self.navigationController pushViewController:eGYiJiaViewController animated:YES];
//    }
//    if ([pmPageBean.statisticStr isEqualToString:@"ND33"]){
//        EGChaKanBaoJiaYiJiaViewController *eGChaKanBaoJiaYiJiaViewController = [[EGChaKanBaoJiaYiJiaViewController alloc] init];
//        eGChaKanBaoJiaYiJiaViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
//        [self.navigationController pushViewController:eGChaKanBaoJiaYiJiaViewController animated:YES];
//    }
//    
////    if ([pmPageBean.statisticStr isEqualToString:@"ND101"]){//验货列表
////        YanHuoLieBiaoVC *yanHuoLieBiaoVC = [[YanHuoLieBiaoVC alloc] init];
////        yanHuoLieBiaoVC.tradeOrderId = _mutableDic[@"tradeId"];
////        [self.navigationController pushViewController:yanHuoLieBiaoVC animated:YES];
////    }
//    
//    if ([pmPageBean.statisticStr isEqualToString:@"ND102"]){//验货详情
//        YanHuoXiangQingVC *yanHuoXiangQingVC = [[YanHuoXiangQingVC alloc] init];
//        yanHuoXiangQingVC.orderOperateId = _mutableDic[@"operateId"];
//        [self.navigationController pushViewController:yanHuoXiangQingVC animated:YES];
//    }
//    if ([pmPageBean.statisticStr isEqualToString:@"ND103"]){//验货详情
//        YanHuoXiangQingVC *yanHuoXiangQingVC = [[YanHuoXiangQingVC alloc] init];
//        yanHuoXiangQingVC.orderOperateId = _mutableDic[@"operateId"];
//        [self.navigationController pushViewController:yanHuoXiangQingVC animated:YES];
//    }
//    if ([pmPageBean.statisticStr isEqualToString:@"ND104"]){//验货详情
//        YanHuoXiangQingVC *yanHuoXiangQingVC = [[YanHuoXiangQingVC alloc] init];
//        yanHuoXiangQingVC.orderOperateId = _mutableDic[@"operateId"];
//        [self.navigationController pushViewController:yanHuoXiangQingVC animated:YES];
//    }
//    if ([pmPageBean.statisticStr isEqualToString:@"ND105"]){//补发货列表
//        BuFaHuoLieBiaoVC *buFaHuoLieBiaoVC = [[BuFaHuoLieBiaoVC alloc] init];
//        buFaHuoLieBiaoVC.tradeOrderId = _mutableDic[@"tradeId"];
//        [self.navigationController pushViewController:buFaHuoLieBiaoVC animated:YES];
//    }
//    
//    if ([pmPageBean.statisticStr isEqualToString:@"ND120"]) {//授盘审核成功
//        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"授盘审核成功"];
//    }
//    if ([pmPageBean.statisticStr isEqualToString:@"ND121"]) {//授盘审核失败
//        //非标采购商 询盘详情
//        XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
//        xunPanXiangQingViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
//        [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
//    }
//    if ([pmPageBean.statisticStr isEqualToString:@"ND122"]) {//被预授盘的供应商修改报价
//        //非标采购商 询盘详情
//        XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
//        xunPanXiangQingViewController.inquiryOrderId = _mutableDic[@"inquiryId"];
//        [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
//    }
    
}

- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initRequest{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];

        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:pageSize];
        pagerBean.page = [NSNumber numberWithInteger:[@1 integerValue]];
        postEntityBean.pager = pagerBean;
        
        OrderByBean *orderByBean = [[OrderByBean alloc] init];
        orderByBean.orderName = @"c.createTime";
        orderByBean.orderSort = @"desc";
        
        NSMutableArray <OrderByBean *> *arrayOrderByBean = [[NSMutableArray alloc] initWithCapacity:0];
        [arrayOrderByBean addObject:orderByBean];
        postEntityBean.order = arrayOrderByBean;
        
        PageQueryBean *pageQueryBean = [[PageQueryBean alloc] init];
        
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
        for (NSDictionary *dic in array) {
            IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
            if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                pageQueryBean.requestUserId = identityBean.userId;
                break;
            }
        }
        
        pageQueryBean.requestStatus = [NSNumber numberWithInteger:1];

        postEntityBean.entity = pageQueryBean.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_notify_getUserPm parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *returnListBean = responseObjectModel;
            
            if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                _arrayPmPageBean = [[NSMutableArray alloc] initWithCapacity:0];
                for (NSDictionary *dic in returnListBean.list) {
                    PmPageBean *pmPageBean = [PmPageBean mj_objectWithKeyValues:dic];
                    [_arrayPmPageBean addObject:pmPageBean];
                }
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                if (returnListBean.list.count != 0) {
                    if (returnListBean.list.count < pageSize) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    } else {
                        [self.tableView.mj_footer endRefreshing];
                    }
                    _viewNoContent.hidden = YES;
                    
                } else {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    _viewNoContent.hidden = NO;
                }
                _aPage = 2;
            } else {
                
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
        
        //上拉刷新把状态只为最开始状态
        self.imageViewDuiGou.tag = 0;
        self.imageViewDuiGou.image = [UIImage imageNamed:@"icon_unchecked"];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        
        PagerBean *pagerBean = [[PagerBean alloc] init];
        pagerBean.pageSize = [NSNumber numberWithInteger:pageSize];
        pagerBean.page = [NSNumber numberWithInteger:_aPage];
        postEntityBean.pager = pagerBean;
        
        OrderByBean *orderByBean = [[OrderByBean alloc] init];
        orderByBean.orderName = @"c.createTime";
        orderByBean.orderSort = @"desc";
        
        NSMutableArray <OrderByBean *> *arrayOrderByBean = [[NSMutableArray alloc] initWithCapacity:0];
        [arrayOrderByBean addObject:orderByBean];
        postEntityBean.order = arrayOrderByBean;
        
        PageQueryBean *pageQueryBean = [[PageQueryBean alloc] init];
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
        for (NSDictionary *dic in array) {
            IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
            if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                pageQueryBean.requestUserId = identityBean.userId;
                break;
            }
        }
        pageQueryBean.requestStatus = [NSNumber numberWithInteger:1];
        postEntityBean.entity = pageQueryBean.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;

        [HttpMamager postRequestWithURLString:DYZ_notify_getUserPm parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *returnListBean = responseObjectModel;
            if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                for (NSDictionary *dic in returnListBean.list) {
                    PmPageBean *pmPageBean = [PmPageBean mj_objectWithKeyValues:dic];
                    [_arrayPmPageBean addObject:pmPageBean];
                }
                
                self.arrayNSIndexPath = [NSMutableArray arrayWithArray:[self.tableView indexPathsForSelectedRows]];
                [self.tableView reloadData];
                if (self.imageViewDuiGou.tag == 0) {
                    [self.arrayNSIndexPath enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:obj.row inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
                    }];
                } else {//全选
                    [_arrayPmPageBean enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
                    }];
                }
                
                if (returnListBean.list.count != 0) {
                    [self.tableView.mj_footer endRefreshing];
                } else {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
                
                if (_arrayPmPageBean.count != 0) {
                    _viewNoContent.hidden = YES;
                } else {
                    _viewNoContent.hidden = NO;
                }
                _aPage++;
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    }];
}

#pragma mark App用网页展示通知
- (void)webViewWithTitle:(NSString *)title withURL:(NSString *)url{
    WebDatailURL *webDatailURL = [[WebDatailURL alloc] init];
    webDatailURL.titleTitle = title;
    webDatailURL.detailUrl = url;
    [self.navigationController pushViewController:webDatailURL animated:YES];
}
#pragma mark 切换身份
- (void)changeIdentity:(NSString *)receiveUserId {
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
    for (NSDictionary *dic in array) {
        IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
        if ([identityBean.userId isEqualToString:receiveUserId]) {
            [self changeWithIdentityBean:identityBean];
            break;
        }
    }
}

- (void)changeWithIdentityBean:(IdentityBean *)identityBean {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否切换身份到:" message:identityBean.showName preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionleft = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *actionRight = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _viewLoading1.hidden = NO;
        
        NSString *string = [NSString stringWithFormat:@"%@?ucenterId=%@",DYZ_user_changeIdentity,identityBean.ucenterId];
        
        WKWebViewConfiguration *webViewConfiguration = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *contentController = [[WKUserContentController alloc] init];
        webViewConfiguration.userContentController = contentController;
        webViewConfiguration.processPool = [IMEProcessPool shareInstance];
        WKWebView *wkWebView =[[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:webViewConfiguration];
        wkWebView.navigationDelegate = self;
        [wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
        [self.view addSubview:wkWebView];
        
        [self readAppNotifacation:_pmPageBean];
    }];
    [alertController addAction:actionleft];
    [alertController addAction:actionRight];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if (![webView.URL.absoluteString containsString:@"goMain"]) {
        if ([_first isEqualToString:@"first"]) {
            _first = @"first1";
            NSString *string1 = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
            NSString *string2 = [[NSUserDefaults standardUserDefaults]objectForKey:@"epname"];
            NSString *string3 = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
            NSString *string4 = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginType"];
            NSDictionary *dicParameters = @{@"username":string1,
                                            @"epname":string2,
                                            @"password":string3,
                                            @"loginType":string4,
                                            @"isRefreshToken":@"false"};
            [HttpMamager postRequestLoginWithURLString:DYZ_user_login parameters:dicParameters success:^(id responseObjectModel) {
                //                _viewLoading1.hidden = YES;
                [self httpRequestCallback:(id)responseObjectModel url:DYZ_user_login];
            } fail:^(NSError *error) {
                _viewLoading1.hidden = YES;
            }];
        }
    }
}

- (void)httpRequestCallback:(id)responseObjectModel url:(NSString *)url {
    if ([url isEqualToString:DYZ_user_login]) {
        NSDictionary *dic = responseObjectModel;
        
        LoginModel *obj = [[LoginModel alloc] init];
        obj.enterpriseName = dic[@"enterpriseName"];
        obj.errorMes = dic[@"errorMes"];
        obj.headImg = [NSString stringWithFormat:@"%@",dic[@"headImg"]];
        obj.manufacturerId = dic[@"manufacturerId"];
        obj.memberId = dic[@"memberId"];
        obj.neteaseToken = dic[@"neteaseToken"];
        obj.notifyUrls = dic[@"notifyUrls"];
        obj.resultCode = [dic[@"resultCode"] integerValue];
        obj.ucenterId = dic[@"ucenterId"];
        obj.userType = dic[@"userType"];
        obj.accountName = dic[@"accountName"];
        obj.enterpriseId = dic[@"enterpriseId"];
        obj.regStatus = dic[@"regStatus"];
        obj.userId = dic[@"userId"];
        
        if ([dic[@"userType"] isEqualToString:@"ENTERPRISE"]) {
            @try {
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic[@"member"] options:NSJSONWritingPrettyPrinted error:nil];
                obj.member = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            } @catch (NSException *exception) {
                obj.member = nil;
            }
        }
        
        @try {
            NSData *jsonDataIdentityBeans = [NSJSONSerialization dataWithJSONObject:dic[@"identityBeans"] options:NSJSONWritingPrettyPrinted error:nil];
            obj.identityBeans = [[NSString alloc] initWithData:jsonDataIdentityBeans encoding:NSUTF8StringEncoding];
        } @catch (NSException *exception) {
            obj.identityBeans = nil;
        }
        
        @try {
            NSData *jsonDataucenterUser = [NSJSONSerialization dataWithJSONObject:dic[@"ucenterUser"] options:NSJSONWritingPrettyPrinted error:nil];
            obj.ucenterUser = [[NSString alloc] initWithData:jsonDataucenterUser encoding:NSUTF8StringEncoding];
        } @catch (NSException *exception) {
            obj.ucenterUser = nil;
        }
        
        if (obj.resultCode == 0) {
            
            if ([obj.regStatus isEqualToString:@"REGISTER"]) {//已注册帐号
                _viewLoading1.hidden = YES;
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"注册信息不完善，请到官网登录完善信息" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [ac addAction:action];
                [self presentViewController:ac animated:YES completion:nil];
            }
            if ([obj.regStatus isEqualToString:@"COMPLETEDATA"]) {//已提交资料,待审核
                _viewLoading1.hidden = YES;
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"账户审核中，请等待" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [ac addAction:action];
                [self presentViewController:ac animated:YES completion:nil];
            }
            if ([obj.regStatus isEqualToString:@"REFUSE"]) {//已拒绝
                _viewLoading1.hidden = YES;
                UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"账户审核失败，请到官网查看失败原因" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [ac addAction:action];
                [self presentViewController:ac animated:YES completion:nil];
            }
            if ([obj.regStatus isEqualToString:@"CONFIRM"]) {
                //已审核
                
                [DatabaseTool updateLoginReturnWithLogin:obj];
                
                NSArray *array = [NSArray stringToJSON:obj.identityBeans];
                for (NSDictionary *dic in array) {
                    IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
                    if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                        [JPUSHService setAlias:identityBean.userId callbackSelector:nil object:self];
                        break;
                    }
                }
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
                _viewLoading1.hidden = YES;
                
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"切换成功"];
                
                /*  enterpriseNameDic  为税率17% 3%  */
                NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"enterpriseNameDic"];//用来存储登录过的用户 公司名 为税率17% 3%
                NSMutableDictionary *dicM = [NSMutableDictionary dictionaryWithDictionary:dic];
                BOOL haveEnterpriseName = NO;
                for (NSString *str in dicM.allKeys) {
                    if ([obj.enterpriseName isEqualToString:str]) {
                        haveEnterpriseName = YES;
                        break;
                    }
                }
                if (!haveEnterpriseName) {
                    [dicM setObject:@"" forKey:obj.enterpriseName];
                    [[NSUserDefaults standardUserDefaults] setObject:dicM forKey:@"enterpriseNameDic"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                /*  enterpriseNameDic  为税率17% 3%  */
                
                if ([obj.userType isEqualToString:@"ENTERPRISE"]) {
                    
                } else {
                    
                }
                if ([_pmPageBean.needAppDisplay integerValue] == 1) {
                    //需要App原生展示
                    [self withPmPageBean:_pmPageBean];
                    
                } else if (_pmPageBean.detailUrl.length>0) {
                    //需要App用网页展示通知URL之向的网页
                    [self webViewWithTitle:@"通知详情" withURL:_pmPageBean.detailUrl];
                }
                
            }
        } else if ([dic[@"resultCode"] integerValue] == -2) {
            _viewLoading1.hidden = YES;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"密码错误"];
        } else if ([dic[@"resultCode"] integerValue] == -1) {
            _viewLoading1.hidden = YES;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"系统异常"];
        } else {
            _viewLoading1.hidden = YES;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"登录失败"];
        }
    }
}

#pragma mark 点击每一个Cell标记已读
- (void)readAppNotifacation:(PmPageBean *)pmPageBean {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    NSString *userId = nil;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
    for (NSDictionary *dic in array) {
        IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
        if ([identityBean.userType isEqualToString:@"NORMAL"]) {
            userId = identityBean.userId;
            break;
        }
    }
    postEntityBean.entity = @{@"pmIds":pmPageBean.pmId,@"userId":userId};
    
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_notify_readUserPm parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[self.tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"%@----%ld",obj,idx);
                PmPageBean *pmPageBean = _arrayPmPageBean[obj.row];
                pmPageBean.isRead = [NSNumber numberWithInteger:1];
            }];
            
            self.arrayNSIndexPath = [NSMutableArray arrayWithArray:[self.tableView indexPathsForSelectedRows]];
            [self.tableView reloadData];
            [self.arrayNSIndexPath enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:obj.row inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
            }];
            
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
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

//- (void)withNotificationItem:(NotificationItem *)notificationItem {
//    
//    if ([notificationItem.type isEqualToString:@"ND1"]||[notificationItem.type isEqualToString:@"ND2"]||[notificationItem.type isEqualToString:@"ND3"]||[notificationItem.type isEqualToString:@"ND5"]||[notificationItem.type isEqualToString:@"ND7"]||[notificationItem.type isEqualToString:@"ND8"]||[notificationItem.type isEqualToString:@"ND10"]||[notificationItem.type isEqualToString:@"ND25"]||[notificationItem.type isEqualToString:@"ND26"]||[notificationItem.type isEqualToString:@"ND27"]) {
//        //询盘详情
//        if ([notificationItem.type isEqualToString:@"ND3"]||[notificationItem.type isEqualToString:@"ND5"]||[notificationItem.type isEqualToString:@"ND7"]) {
//            //非标采购商 询盘详情
//            XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
//            for (ParamsBean *paramsBean in notificationItem.notification.appContent.paramsBeans) {
//                if ([paramsBean.name isEqualToString:@"inquiryId"]) {
//                    xunPanXiangQingViewController.inquiryOrderId = paramsBean.value;
//                    break;
//                }
//            }
//            [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
//            
//        } else {
//            //非标供应商 询盘详情
//            XunPanXiangQingViewController *xunPanXiangQingViewController = [[XunPanXiangQingViewController alloc] init];
//            for (ParamsBean *paramsBean in notificationItem.notification.appContent.paramsBeans) {
//                if ([paramsBean.name isEqualToString:@"inquiryId"]) {
//                    xunPanXiangQingViewController.inquiryOrderId = paramsBean.value;
//                    break;
//                }
//            }
//            [self.navigationController pushViewController:xunPanXiangQingViewController animated:YES];
//            
//        }
//    }
//    if ([notificationItem.type isEqualToString:@"ND6"]||[notificationItem.type isEqualToString:@"ND9"]||[notificationItem.type isEqualToString:@"ND11"]||[notificationItem.type isEqualToString:@"ND12"]||[notificationItem.type isEqualToString:@"ND13"]||[notificationItem.type isEqualToString:@"ND16"]||[notificationItem.type isEqualToString:@"ND17"]||[notificationItem.type isEqualToString:@"ND21"]||[notificationItem.type isEqualToString:@"ND28"]) {
//        // 订单详情
//        if ([notificationItem.type isEqualToString:@"ND6"]||[notificationItem.type isEqualToString:@"ND16"]||[notificationItem.type isEqualToString:@"ND17"]) {
//            //非标采购商 订单详情
//            DingDanXiangQingCaiViewController *dingDanXiangQingCaiViewController = [[DingDanXiangQingCaiViewController alloc] init];
//            for (ParamsBean *paramsBean in notificationItem.notification.appContent.paramsBeans) {
//                if ([paramsBean.name isEqualToString:@"tradeId"]) {
//                    dingDanXiangQingCaiViewController.orderId = paramsBean.value;
//                    break;
//                }
//            }
//            dingDanXiangQingCaiViewController.stringResource = @"ECaiGouShangViewControllerL";
//            [self.navigationController pushViewController:dingDanXiangQingCaiViewController animated:YES];
//        } else {
//            //非标供应商 订单详情
//            DingDanXiangQingGongViewController *dingDanXiangQingGongViewController = [[DingDanXiangQingGongViewController alloc] init];
//            for (ParamsBean *paramsBean in notificationItem.notification.appContent.paramsBeans) {
//                if ([paramsBean.name isEqualToString:@"tradeId"]) {
//                    dingDanXiangQingGongViewController.orderId = paramsBean.value;
//                    break;
//                }
//            }
//            dingDanXiangQingGongViewController.stringResource = @"EGongYingShangViewControllerL";
//            [self.navigationController pushViewController:dingDanXiangQingGongViewController animated:YES];
//        }
//    }
//    
//    if ([notificationItem.type isEqualToString:@"ND23"]||[notificationItem.type isEqualToString:@"ND24"]) {
//        BaoJiaZiXunViewController *baoJiaZiXunViewController = [[BaoJiaZiXunViewController alloc] init];
//        for (ParamsBean *paramsBean in notificationItem.notification.appContent.paramsBeans) {
//            if ([paramsBean.name isEqualToString:@"inquiryId"]) {
//                baoJiaZiXunViewController.inquiryOrderId = paramsBean.value;
//                break;
//            }
//        }
//        [self.navigationController pushViewController:baoJiaZiXunViewController animated:YES];
//    }
//    
//    if ([notificationItem.type isEqualToString:@"ND30"]){
//        ECYiJiaViewController *eCYiJiaViewController = [[ECYiJiaViewController alloc] init];
//        for (ParamsBean *paramsBean in notificationItem.notification.appContent.paramsBeans) {
//            if ([paramsBean.name isEqualToString:@"inquiryId"]) {
//                eCYiJiaViewController.inquiryOrderId = paramsBean.value;
//                break;
//            }
//        }
//        [self.navigationController pushViewController:eCYiJiaViewController animated:YES];
//    }
//    if ([notificationItem.type isEqualToString:@"ND31"]){
//        ECChaKanBaoJiaYiJiaViewController *eCChaKanBaoJiaYiJiaViewController = [[ECChaKanBaoJiaYiJiaViewController alloc] init];
//        for (ParamsBean *paramsBean in notificationItem.notification.appContent.paramsBeans) {
//            if ([paramsBean.name isEqualToString:@"inquiryId"]) {
//                eCChaKanBaoJiaYiJiaViewController.inquiryOrderId = paramsBean.value;
//                break;
//            }
//        }
//        [self.navigationController pushViewController:eCChaKanBaoJiaYiJiaViewController animated:YES];
//    }
//    if ([notificationItem.type isEqualToString:@"ND32"]){
//        EGYiJiaViewController *eGYiJiaViewController = [[EGYiJiaViewController alloc] init];
//        for (ParamsBean *paramsBean in notificationItem.notification.appContent.paramsBeans) {
//            if ([paramsBean.name isEqualToString:@"inquiryId"]) {
//                eGYiJiaViewController.inquiryOrderId = paramsBean.value;
//                break;
//            }
//        }
//        [self.navigationController pushViewController:eGYiJiaViewController animated:YES];
//    }
//    if ([notificationItem.type isEqualToString:@"ND33"]){
//        EGChaKanBaoJiaYiJiaViewController *eGChaKanBaoJiaYiJiaViewController = [[EGChaKanBaoJiaYiJiaViewController alloc] init];
//        for (ParamsBean *paramsBean in notificationItem.notification.appContent.paramsBeans) {
//            if ([paramsBean.name isEqualToString:@"inquiryId"]) {
//                eGChaKanBaoJiaYiJiaViewController.inquiryOrderId = paramsBean.value;
//                break;
//            }
//        }
//        [self.navigationController pushViewController:eGChaKanBaoJiaYiJiaViewController animated:YES];
//    }
//}

@end
