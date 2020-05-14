//
//  ErWeiMaShareViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 17/7/25.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "MingPianShareViewController.h"
#import "VoHeader.h"

#import <ShareSDK/ShareSDK.h>
// 弹出分享菜单需要导入的头文件
#import <ShareSDKUI/ShareSDK+SSUI.h>
// 自定义分享菜单栏需要导入的头文件
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//自定义分享编辑界面所需要导入的头文件
#import <ShareSDKUI/SSUIEditorViewStyle.h>

#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>

#import "QRImage.h"

#import "NSArray+Transition.h"

#import "NSString+Utils.h"

#import "UploadImageBean.h"

@interface MingPianShareViewController () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewImageBGBG;//要生成的图片view

@property (weak, nonatomic) IBOutlet UIView *viewImageBG;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *labelName;

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *buttonHeader;
@property (weak, nonatomic) IBOutlet UIButton *buttonMingPian;

@property (nonatomic,strong) UIImagePickerController *imagePicker;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backTopConstant;//10 Or 34


@end

@implementation MingPianShareViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.backTopConstant.constant = Height_StatusBar-10;
    
    self.viewImageBG.layer.cornerRadius = 10;
    
    self.viewImageBG.layer.shadowColor = [UIColor blackColor].CGColor;
    self.viewImageBG.layer.shadowOpacity = 0.1;
    self.viewImageBG.layer.shadowRadius = 10;
    self.viewImageBG.layer.shadowOffset = CGSizeMake(4, 4);
    
    self.headerImage.layer.cornerRadius = 50;
    self.headerImage.layer.masksToBounds = YES;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    
    NSArray *array = [NSArray stringToJSON:loginModel.identityBeans];
    
    for (NSDictionary *dic in array) {
        IdentityBean *identityBean = [IdentityBean mj_objectWithKeyValues:dic];
        if ([loginModel.ucenterId isEqualToString:identityBean.ucenterId]) {
            if ([identityBean.userType isEqualToString:@"NORMAL"]) {
                [self.headerImage sd_setImageWithURL:[NSURL URLWithString:loginModel.headImg] placeholderImage:[UIImage imageNamed:@"icon_not_loaded"]];
            } else {
                [self.headerImage sd_setImageWithURL:[NSURL URLWithString:loginModel.headImg] placeholderImage:[UIImage imageNamed:@"icon_not_loaded"]];
            }
        }
        if ([identityBean.userType isEqualToString:@"NORMAL"]) {
            self.labelName.text = identityBean.realName;
        }
    }
    
    self.labelTitle.text = @"智造家是专业的智能制造产业链服务平台，提供优质高效的信息化、管理提升、平台采购及供应链管理、人才、金融和创新服务。";
    
    UIImage *image = [QRImage imageWithQRString:self.dicEntity[@"link"]];
    self.imageView.image = image;
    
    [self.buttonHeader addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonHeader.tag = 1;
    [self.buttonMingPian addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.buttonMingPian.tag = 2;
}

- (UIImage *)makeImageWithView:(UIView *)view withSize:(CGSize)size
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 [UIScreen mainScreen].scale。
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}

- (void)buttonClick:(UIButton *)sender {
    if (sender.tag == 1) {
        [self exchangHeader];
    }
    if (sender.tag == 2) {
        [self shareSDK];
    }
}

- (void)exchangHeader {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imagePicker = [[UIImagePickerController alloc] init];
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.imagePicker.delegate = self;
            self.imagePicker.allowsEditing = YES;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
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
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [action0 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action2 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    [alertController addAction:action0];
    [alertController addAction:action1];
    [alertController addAction:action2];
    
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
            [self.headerImage sd_setImageWithURL:[NSURL URLWithString:returnMsgBean.returnMsg]];
        }
    } progress:^(NSProgress *progress) {
           
    } fail:^(NSError *error) {
        
    } isKindOfModelClass:NSClassFromString(@"ReturnMsgBean")];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)shareSDK {
    UIImage *image = [self makeImageWithView:self.viewImageBGBG withSize:self.viewImageBGBG.bounds.size];
    
    //1、创建分享参数
//    NSArray* imageArray = @[[UIImage imageNamed:@"icon_透明工厂"]];
    //    NSArray* imageArray = @[self.imagePath];
    NSArray *imageArray = @[image];
    
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKEnableUseClientShare];
        [shareParams SSDKSetupShareParamsByText:nil
                                         images:imageArray
                                            url:nil
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
        
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:@[item00,item01,item02]
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                   }];
    }
}

- (IBAction)dismiss:(id)sender {
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
