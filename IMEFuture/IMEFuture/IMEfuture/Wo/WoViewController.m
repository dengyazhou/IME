//
//  WoViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/6/25.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "WoViewController.h"
#import "VoHeader.h"


#import "CompanyViewController.h"


#import "Cell1.h"
#import "Cell2.h"


#import "WoDeTongZhiViewController.h"
#import "GuanYuWoMenViewController.h"



#import "SheZhiViewController.h"

#import "WebDatailURL.h"

#import "YaoQingZhuCeVC.h"

#import "NSArray+Transition.h"
#import "WoChaKanDaTuViewController.h"
#import "NSString+Utils.h"

#import <AVFoundation/AVFoundation.h>

#import "UploadImageBean.h"

#define KWidthPX [UIScreen mainScreen].bounds.size.width/750.0
#define KHeightPX [UIScreen mainScreen].bounds.size.height/1334.0

@interface WoViewController () <UITableViewDelegate,UITableViewDataSource,CompanyViewControllerDelegate,SheZhiViewControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    LoginModel *_loginModel;
    UITableView *_tabelViewENTERPRISE;
    UITableView *_tabelViewNORMAL;
    NSInteger _jPushCount;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
    
    SheZhiViewController *_sheZhiViewController;
    SheZhiViewController *_sheZhiViewController1;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (nonatomic,strong) UIImagePickerController *imagePicker;

@end

@implementation WoViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    

    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    NSString *stringPsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"psw"];
    if (stringPsw) {//取到密码
        _loginModel = [DatabaseTool getLoginModel];
        if ([_loginModel.userType isEqualToString:@"NORMAL"]) {
            _tabelViewNORMAL.hidden = NO;
            _tabelViewENTERPRISE.hidden = YES;
            [_tabelViewNORMAL reloadData];
        } else {
            _tabelViewENTERPRISE.hidden = NO;
            _tabelViewNORMAL.hidden = YES;
            [_tabelViewENTERPRISE reloadData];
        }
        
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        PageQueryBean *pageQueryBean = [[PageQueryBean alloc] init];
        
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
        pageQueryBean.requestUserId = userId;
        postEntityBean.entity = pageQueryBean.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_notify_getUserPmCount parameters:dic success:^(id responseObjectModel) {
            ReturnEntityBean *returnEntityBean = responseObjectModel;
            PageQueryBean *pageQueryBean = [PageQueryBean mj_objectWithKeyValues:returnEntityBean.entity];
            if ([returnEntityBean.status isEqualToString:@"SUCCESS"]) {
                _jPushCount = [pageQueryBean.unreadNum integerValue];
                
                if ([pageQueryBean.unreadNum integerValue] == 0) {
                    UIView *viewBage = [self.tabBarController.tabBar viewWithTag:1992];
                    viewBage.hidden = YES;
                } else {
                    UIView *viewBage = [self.tabBarController.tabBar viewWithTag:1992];
                    viewBage.hidden = NO;
                }
                [_tabelViewENTERPRISE reloadData];
            }
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;//两个宏在一起的屏幕尺寸相减有问题，好想是同时执行[UIScreen mainScreen].bounds.size有bug
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [self initTableViewENTERPRISE];
    [self initTabelViewNORMAL];
    
    _tabelViewENTERPRISE.hidden = YES;
    _tabelViewNORMAL.hidden  = YES;
}

- (void)initTableViewENTERPRISE {
    _tabelViewENTERPRISE = [[UITableView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar-_height_TabBar) style:UITableViewStyleGrouped];//
    _tabelViewENTERPRISE.delegate = self;
    _tabelViewENTERPRISE.dataSource = self;
    _tabelViewENTERPRISE.tag = 100;
    [_tabelViewENTERPRISE registerNib:[UINib nibWithNibName:@"Cell1" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [_tabelViewENTERPRISE registerNib:[UINib nibWithNibName:@"Cell2" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:_tabelViewENTERPRISE];
    _tabelViewENTERPRISE.backgroundColor = [UIColor clearColor];
    _tabelViewENTERPRISE.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)initTabelViewNORMAL {
    _tabelViewNORMAL = [[UITableView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar-_height_TabBar) style:UITableViewStyleGrouped];
    _tabelViewNORMAL.delegate = self;
    _tabelViewNORMAL.dataSource = self;
    _tabelViewNORMAL.tag = 101;
    [_tabelViewNORMAL registerNib:[UINib nibWithNibName:@"Cell1" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [_tabelViewNORMAL registerNib:[UINib nibWithNibName:@"Cell2" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:_tabelViewNORMAL];
    _tabelViewNORMAL.backgroundColor = [UIColor clearColor];
    _tabelViewNORMAL.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 100) {
        return 4;
    } else {
        return 4;
    }
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.01f;
    }
    return 15.f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    } else {
        return 45;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 100) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 3;
        } else if (section == 2){
            return 1;
        } else {
            return 1;
        }
    } else {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return 3;
        } else if (section == 2){
            return 1;
        } else {
            return 1;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 100) {
        if (indexPath.section == 0) {
            Cell1 *cell11 = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
            for (NSDictionary *dic in array) {
                IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
                if ([loginModel.ucenterId isEqualToString:identityBean.ucenterId]) {
                    cell11.label1.text = identityBean.showName;
                }
            }
            cell11.label2.text = _loginModel.enterpriseName;
            [cell11.headImg sd_setImageWithURL:[NSURL URLWithString:loginModel.headImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
            
            cell11.headImg.layer.cornerRadius = 30;
            cell11.headImg.layer.masksToBounds = YES;
            return cell11;
        } else {
            Cell2 *cell22 = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            cell22.label2.hidden = YES;
            cell22.viewLineTop.hidden = NO;
//            cell22.viewLineBottom.hidden = NO;
            if (indexPath.row == 0) {
                cell22.viewLineTop.hidden = NO;
            } else {
                cell22.viewLineTop.hidden = YES;
            }
            if (indexPath.section == 1) {
                if (indexPath.row == 0) {
                    if (_jPushCount) {
                        if (_jPushCount == 0) {
                            
                        } else {
                            cell22.label2.hidden = NO;
                        }
                    }
                    //cell22.label2.text = [NSString stringWithFormat:@"%ld",_jPushCount];
                    cell22.label2.layer.masksToBounds = YES;
                }
                
                if (indexPath.row == 1) {
                    
                }
                
                NSArray *arrayImage = @[@"me_icon_notice",@"me_icon_set_up",@"me_icon_recommend"];
                NSArray *arraytitle = @[@"系统通知",@"用户设置",@"推荐注册"];
                cell22.imageView1.image = [UIImage imageNamed:arrayImage[indexPath.row]];
                cell22.label1.text = arraytitle[indexPath.row];
            }
            if (indexPath.section == 2) {
                cell22.imageView1.image = [UIImage imageNamed:@"me_icon_about"];
                cell22.label1.text = @"关于我们";
            }
            if (indexPath.section == 3) {
                cell22.imageView1.image = [UIImage imageNamed:@"隐私协议"];
                cell22.label1.text = @"隐私协议";
            }
            return cell22;
        }
    } else {
        if (indexPath.section == 0) {
            Cell1 *cell11 = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
            
            LoginModel *loginModel = [DatabaseTool getLoginModel];
            NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
            for (NSDictionary *dic in array) {
                IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
                if ([loginModel.ucenterId isEqualToString:identityBean.ucenterId]) {
                    cell11.label1.text = identityBean.showName;
                }
            }
            cell11.label2.text = _loginModel.enterpriseName;
            [cell11.headImg sd_setImageWithURL:[NSURL URLWithString:loginModel.headImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
            
            cell11.headImg.layer.cornerRadius = 30;
            cell11.headImg.layer.masksToBounds = YES;
            return cell11;
        } else {
            Cell2 *cell22 = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
            cell22.label2.hidden = YES;
            cell22.viewLineTop.hidden = NO;
//            cell22.viewLineBottom.hidden = NO;
            if (indexPath.row == 0) {
                cell22.viewLineTop.hidden = NO;
            } else {
                cell22.viewLineTop.hidden = YES;
            }
            
            if (indexPath.section == 1) {
                NSArray *arrayImage = @[@"me_icon_notice",@"me_icon_set_up",@"me_icon_recommend"];
                NSArray *arraytitle = @[@"系统通知",@"用户设置",@"推荐注册"];
                cell22.imageView1.image = [UIImage imageNamed:arrayImage[indexPath.row]];
                cell22.label1.text = arraytitle[indexPath.row];
            }
            if (indexPath.section == 2) {
                cell22.imageView1.image = [UIImage imageNamed:@"me_icon_about"];
                cell22.label1.text = @"关于我们";
            }
            if (indexPath.section == 3) {
                cell22.imageView1.image = [UIImage imageNamed:@"隐私协议"];
                cell22.label1.text = @"隐私协议";
            }
            return cell22;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag == 100) {
        if (indexPath.section == 0) {
            [self exchangeHeaderImage];
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                WoDeTongZhiViewController *wdtzVC = [[WoDeTongZhiViewController alloc] init];
                [self.navigationController pushViewController:wdtzVC animated:YES];
            }
            if (indexPath.row == 1) {
                SheZhiViewController *sheZhiViewController = [[SheZhiViewController alloc] init];
                sheZhiViewController.delegate = self;
                [self.navigationController pushViewController:sheZhiViewController animated:YES];
//                _sheZhiViewController = sheZhiViewController;
            }
            if (indexPath.row == 2) {
                YaoQingZhuCeVC *yaoQingZhuCeVC = [[YaoQingZhuCeVC alloc] init];
                [self.navigationController pushViewController:yaoQingZhuCeVC animated:YES];
            }
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                GuanYuWoMenViewController *gywMVC = [[GuanYuWoMenViewController alloc] init];
                [self.navigationController pushViewController:gywMVC animated:YES];
            }
        }
        if (indexPath.section == 3) {
            WebDatailURL *webVC = [[WebDatailURL alloc] init];
            webVC.detailUrl = IME_privacy;
            webVC.titleTitle = @"隐私协议";
            webVC.isShare = false;
            [self.navigationController pushViewController:webVC animated:YES];
        }
    } else {
        if (indexPath.section == 0) {
            [self exchangeHeaderImage];
        }
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                WoDeTongZhiViewController *wdtzVC = [[WoDeTongZhiViewController alloc] init];
                [self.navigationController pushViewController:wdtzVC animated:YES];
            }
            if (indexPath.row == 1) {
                SheZhiViewController *sheZhiViewController = [[SheZhiViewController alloc] init];
                sheZhiViewController.delegate = self;
                [self.navigationController pushViewController:sheZhiViewController animated:YES];
//                _sheZhiViewController1 = sheZhiViewController;
            }
            if (indexPath.row == 2) {
                YaoQingZhuCeVC *yaoQingZhuCeVC = [[YaoQingZhuCeVC alloc] init];
                [self.navigationController pushViewController:yaoQingZhuCeVC animated:YES];
            }
        }
        if (indexPath.section == 2) {
            GuanYuWoMenViewController *gywMVC = [[GuanYuWoMenViewController alloc] init];
            [self.navigationController pushViewController:gywMVC animated:YES];
        }
        if (indexPath.section == 3) {
            WebDatailURL *webVC = [[WebDatailURL alloc] init];
            webVC.detailUrl = IME_privacy;
            webVC.titleTitle = @"隐私协议";
            webVC.isShare = false;
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
    
}

- (void)exchangeHeaderImage {

    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相机权限
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。
            authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.imagePicker = [[UIImagePickerController alloc] init];
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                self.imagePicker.delegate = self;
                self.imagePicker.allowsEditing = YES;
                [self presentViewController:self.imagePicker animated:YES completion:nil];


                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"请在iPhone的“设置－隐私”选项中，允许智造家访问你的摄像机和麦克风" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.imagePicker dismissViewControllerAnimated:YES completion:nil];
                }];
                [alertController addAction:action];
                [self.imagePicker presentViewController:alertController animated:YES completion:nil];
            }
        }else{
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.imagePicker = [[UIImagePickerController alloc] init];
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                self.imagePicker.delegate = self;
                self.imagePicker.allowsEditing = YES;
                [self presentViewController:self.imagePicker animated:YES completion:nil];

            }
            else
            {
                NSLog(@"手机不支持相机");
            }
        }
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"从手机相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            self.imagePicker = [[UIImagePickerController alloc] init];
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            self.imagePicker.delegate = self;
            self.imagePicker.allowsEditing = YES;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"查看大图" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WoChaKanDaTuViewController *woChaKanDaTuViewController = [[WoChaKanDaTuViewController alloc] init];
        [self presentViewController:woChaKanDaTuViewController animated:YES completion:nil];
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [action0 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action2 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action3 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    [alertController addAction:action0];
    [alertController addAction:action1];
    [alertController addAction:action2];
    [alertController addAction:action3];
    
    //UIAlertController的UIAlertControllerStyleActionSheet模式必须 适配iPad
    if ([alertController respondsToSelector:@selector(popoverPresentationController)]) {
        alertController.popoverPresentationController.sourceView = self.view;//必须加
        alertController.popoverPresentationController.sourceRect = CGRectMake(0, kMainH, kMainW, kMainH);//可选
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *image = info[UIImagePickerControllerEditedImage];
 
    CGSize size = CGSizeMake(640, 640);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *data = UIImageJPEGRepresentation(newImage, 1);
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    
    UserBean *userBean = [[UserBean alloc] init];
    userBean.userId = loginModel.userId;
    
    postEntityBean.entity = userBean.mj_keyValues;
    
    NSDictionary *dic1 = postEntityBean.mj_keyValues;
    
    NSDictionary *dic = @{@"data":[NSString convertToJsonData:dic1]};
    
    UploadImageBean *uploadImageBean = [[UploadImageBean alloc] init];
    uploadImageBean.data = data;
    uploadImageBean.name = @"file";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [formatter stringFromDate:[NSDate date]];
    uploadImageBean.fileName = [NSString stringWithFormat:@"%@.png",strDate];
    uploadImageBean.mimeType = @"image/png";
    
    [HttpMamager postRequestImageWithURLString:DYZ_user_appUserHeadUpload parameters:dic UploadImageBean:@[uploadImageBean] success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [DatabaseTool updateLoginModelWithHeadImg:returnMsgBean.returnMsg];
            [_tabelViewNORMAL reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            [_tabelViewENTERPRISE reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
        }
    } progress:^(NSProgress *progress) {
           
    } fail:^(NSError *error) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
    } isKindOfModelClass:NSClassFromString(@"ReturnMsgBean")];
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark CompanyViewControllerDelegate
- (void)getLoginModel:(LoginModel *)model {
    
    _loginModel = model;
    [_tabelViewENTERPRISE reloadData];
}

- (void)loginSuccess {
    self.tabBarController.selectedIndex = 2;
}

- (void)hiddenWoQiYe:(BOOL)a hiddenWoGeRen:(BOOL)b {
    _tabelViewENTERPRISE.hidden = a;
    _tabelViewNORMAL.hidden = b;
}

- (void)notLoginExchangeViewController {
    self.tabBarController.selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"tabBarControllerSelectedIndex"];
}

#pragma mark SheZhiViewControllerDelegate
- (void)loginOutSheZhiViewController {
    
    NSLog(@"%@----------",[NSThread currentThread]);
    self.tabBarController.selectedIndex = 0;//2018年4月20号，突然有bug了
}


- (void)dealloc {
    
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
