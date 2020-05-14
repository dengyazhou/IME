//
//  YaoQingZhuCeVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/7/24.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "YaoQingZhuCeVC.h"
#import "VoHeader.h"

#import "YaoQingZhuCeCell.h"
#import "LianXiRenViewController.h"
#import "MingPianShareViewController.h"

#import <ShareSDK/ShareSDK.h>
// 弹出分享菜单需要导入的头文件
#import <ShareSDKUI/ShareSDK+SSUI.h>
// 自定义分享菜单栏需要导入的头文件
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//自定义分享编辑界面所需要导入的头文件
#import <ShareSDKUI/SSUIEditorViewStyle.h>

#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>

#import <AddressBook/AddressBook.h>


@interface YaoQingZhuCeVC () <UITableViewDelegate,UITableViewDataSource> {
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSDictionary *dicEntity;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation YaoQingZhuCeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self initRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [self.view addSubview:self.tableView];
    
    //发起通讯录访问
    CFErrorRef error = NULL;
    ABAddressBookRef addressBooks = ABAddressBookCreateWithOptions(NULL, &error);
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);//发出访问通讯录的请求
    ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error) {
        
        dispatch_semaphore_signal(sema);
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YaoQingZhuCeCell *yaoQingZhuCeCell = [tableView dequeueReusableCellWithIdentifier:@"yaoQingZhuCeCell" forIndexPath:indexPath];
    NSArray *arrayHeaderImage = @[@"icon_通讯录邀请",@"icon_第三方邀请",@"icon_business_card_sharing"];
    NSArray *arraylabelTitle = @[@"通过通讯录邀请",@"通过第三方邀请(微信、QQ等)",@"名片分享"];
    yaoQingZhuCeCell.viewLineBottom.hidden = YES;
    
    if (indexPath.row == 2) {
        yaoQingZhuCeCell.viewLineBottom.hidden = YES;
    } else {
        yaoQingZhuCeCell.viewLineBottom.hidden = NO;
    }
    
    yaoQingZhuCeCell.imageHeader0.image = [UIImage imageNamed:arrayHeaderImage[indexPath.row]];
    yaoQingZhuCeCell.labelTitle0.text = arraylabelTitle[indexPath.row];
    
    return yaoQingZhuCeCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        LianXiRenViewController *lianXiRenViewController = [[LianXiRenViewController alloc] init];
        [self.navigationController pushViewController:lianXiRenViewController animated:YES];
    }
    
    if (indexPath.row == 1) {
        [self shareSDK];
    }
    
    if (indexPath.row == 2) {
        MingPianShareViewController *mingPianShareViewController = [[MingPianShareViewController alloc] init];
        mingPianShareViewController.dicEntity = self.dicEntity;
        [self.navigationController pushViewController:mingPianShareViewController animated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) style:UITableViewStylePlain];
        [_tableView registerNib:[UINib nibWithNibName:@"YaoQingZhuCeCell" bundle:nil] forCellReuseIdentifier:@"yaoQingZhuCeCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellEditingStyleNone;
        _tableView.scrollEnabled = NO;
    }
    return _tableView;
}

- (void)shareSDK {
    //1、创建分享参数
//            NSArray* imageArray = @[[UIImage imageNamed:@"icon_144"]];
    NSArray* imageArray = @[@"https://img02.imefuture.com/logo2.png"];
    
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKEnableUseClientShare];
//        self.dicEntity[@"content"]
//        self.dicEntity[@"link"]
        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@\r\n%@",self.dicEntity[@"content"],self.dicEntity[@"link"]]
                                         images:imageArray
                                            url:self.dicEntity[@"link"]
                                          title:@"智造家-服务制造未来"
                                           type:SSDKContentTypeAuto];
        
        [SSUIShareActionSheetStyle setItemNameFont:[UIFont systemFontOfSize:11.75]];
        [SSUIEditorViewStyle setiPhoneNavigationBarBackgroundColor:[UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1]];
        
        [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSystem];

        //SSDKPlatformSubTypeWechatSession
        SSUIShareActionSheetCustomItem *item00 = [SSUIShareActionSheetCustomItem itemWithIcon:[UIImage imageNamed:@"icon_微信"] label:@"微信好友" onClick:^{
            [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                
            }];
        }];
        //SSDKPlatformSubTypeQQFriend
        SSUIShareActionSheetCustomItem *item01 = [SSUIShareActionSheetCustomItem itemWithIcon:[UIImage imageNamed:@"icon_QQ"] label:@"QQ好友" onClick:^{
            [ShareSDK share:SSDKPlatformSubTypeQQFriend parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                
            }];
        }];
        //SSDKPlatformTypeSinaWeibo
        SSUIShareActionSheetCustomItem *item02 = [SSUIShareActionSheetCustomItem itemWithIcon:[UIImage imageNamed:@"icon_新浪"] label:@"新浪微博" onClick:^{
            [ShareSDK share:SSDKPlatformTypeSinaWeibo parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
                switch (state) {
                    case SSDKResponseStateSuccess:
                    {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                            message:nil
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"确定"
                                                                  otherButtonTitles:nil];
                        [alertView show];
                        break;
                    }
                    case SSDKResponseStateFail:
                    {
                        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weibo:"]]) {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                            message:nil
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil, nil];
                            [alert show];
                        } else {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                            message:[NSString stringWithFormat:@"%@",@"您还未安装新浪客户端"]
                                                                           delegate:nil
                                                                  cancelButtonTitle:@"OK"
                                                                  otherButtonTitles:nil, nil];
                            [alert show];
                        }
                        break;
                    }
                    default:
                        break;
                }
            }];
        }];
    
        SSUIShareActionSheetCustomItem *item0 = [SSUIShareActionSheetCustomItem itemWithIcon:[UIImage imageNamed:@"icon_复制链接"] label:@"复制链接" onClick:^{
            [UIPasteboard generalPasteboard].string = [NSString stringWithFormat:@"%@ %@",self.dicEntity[@"content"],self.dicEntity[@"link"]];
            [self performSelector:@selector(handleThread) withObject:nil afterDelay:0.2];
        }];
        
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:@[item00,item01,item02,item0]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                   }];
    }
}

- (void)handleThread {
    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"链接复制成功"];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initRequest {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    InviteInfo *inviteInfo = [[InviteInfo alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    inviteInfo.userId = loginModel.userId;
    postEntityBean.entity = inviteInfo.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_user_getUserInviteInfo parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            self.dicEntity = returnMsgBean.entity;
        } else {
            
        }
    } fail:^(NSError *error) {
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
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
