//
//  CompleteConfirmationVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/18.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "CompleteConfirmationVC.h"

#import "CompleteConfirmationCCell.h"

#import "TemporaryTaskDetailedListVC.h"
#import "TpfMaiViewController.h"

#import "CompleteConfirmationCipherConfirmationView.h"
#import "CompleteConfirmationConfirmationSuccessView.h"

@interface CompleteConfirmationVC () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    UIView *_viewLoading;
    CompleteConfirmationCipherConfirmationView *_completeConfirmationCipherConfirmationView;
}


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (nonatomic,strong) NSMutableArray *arrayList;
@property (nonatomic,strong) NSMutableArray *arrayListOriginal;

@end

@implementation CompleteConfirmationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeCompleteConfirmationVC:) name:UIKeyboardWillChangeFrameNotification object:nil];

    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillShowNotificationCompleteConfirmationVC:) name:UIKeyboardWillShowNotification object:nil];
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillHideNotificationCompleteConfirmationVC:) name:UIKeyboardWillHideNotification object:nil];
    

    [self.collectionView registerNib:[UINib nibWithNibName:@"CompleteConfirmationCCell" bundle:nil] forCellWithReuseIdentifier:@"completeConfirmationCCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW-34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self initRequestGetTemporaryTaskConfirmUserList];
    
    self.textFiled.inputAccessoryView = [self addToolbar];
    [self.textFiled addTarget:self action:@selector(textFieldEditingChangedDYZ:) forControlEvents:UIControlEventEditingChanged];
    
}

//- (void)WillShowNotificationCompleteConfirmationVC:(NSNotification *)noti {
//    _completeConfirmationCipherConfirmationView.center = CGPointMake(self.view.center.x,  self.view.center.y-80);
//}
//
//- (void)WillHideNotificationCompleteConfirmationVC:(NSNotification *)noti {
//    _completeConfirmationCipherConfirmationView.center = self.view.center;
//}


- (void)keyboardWillChangeCompleteConfirmationVC:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        _completeConfirmationCipherConfirmationView.center = self.view.center;
    } else {
        _completeConfirmationCipherConfirmationView.center = CGPointMake(self.view.center.x,  self.view.center.y-80);
    }
}

- (void)textFieldEditingChangedDYZ:(UITextField *)textField {
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (UserInfoVo *vo in self.arrayListOriginal) {
        if ([vo.userText containsString:textField.text]) {
            [array addObject:vo];
        }
    }
    self.arrayList = nil;
    if (textField.text.length == 0) {
        self.arrayList = self.arrayListOriginal;
    } else {
        self.arrayList = array;
    }
    [self.collectionView reloadData];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((kMainW-14*2-9*2)/3.0, 30);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(11, 14, 10, 14);
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 0;
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;//Item之间的最小间隔
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CompleteConfirmationCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"completeConfirmationCCell" forIndexPath:indexPath];
    UserInfoVo *userInfoVo = self.arrayList[indexPath.row];
    cell.labelName.text = userInfoVo.userText;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoVo *userInfoVoTemp = self.arrayList[indexPath.row];
    
    CompleteConfirmationCipherConfirmationView *viewConfirmation = [CompleteConfirmationCipherConfirmationView loadXibView];
    viewConfirmation.needPassword = [NSNumber numberWithInteger:1];
    viewConfirmation.name = self.name;
    viewConfirmation.workTime = self.workTime;
    viewConfirmation.planWorkTime = self.planWorkTime;

    [viewConfirmation initWithDataWithAffirmWithName:userInfoVoTemp.userText ButtonClick:^ {
        
        if (viewConfirmation.textFieldjihuagongshi.text.integerValue == 0) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"计划工时要大于0"];
            return;
        }
        
        _viewLoading.hidden = false;
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
        
        MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
        TemporaryTaskVo *temporaryTaskVo = [[TemporaryTaskVo alloc] init];
        temporaryTaskVo.idDYZ = self.temporaryTaskVo.idDYZ;
        temporaryTaskVo.siteCode = userInfo.siteCode;
        temporaryTaskVo.confirmUser = userInfoVoTemp.userCode;
        temporaryTaskVo.modifyUser = userInfo.userCode;
        temporaryTaskVo.loginType = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginType"];
        temporaryTaskVo.userName = userInfoVoTemp.userCode;
        temporaryTaskVo.password = viewConfirmation.textField.text;
        temporaryTaskVo.planWorkTime = [NSNumber numberWithInteger:viewConfirmation.textFieldjihuagongshi.text.integerValue];
        postEntityBean.entity = temporaryTaskVo.mj_keyValues;
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_mes_temporaryTask_temporaryTaskCommitByPassword parameters:dic success:^(id responseObjectModel) {
            _viewLoading.hidden = true;
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                [viewConfirmation removeFromSuperview];
                
                CompleteConfirmationConfirmationSuccessView *successView = [CompleteConfirmationConfirmationSuccessView loadXibView];
                [self.view addSubview:successView];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [successView removeFromSuperview];
                    
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        if ([vc isMemberOfClass:[TemporaryTaskDetailedListVC class]]) {
                            [self.navigationController popToViewController:vc animated:true];
                            return;
                        }
                    }
                    
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        if ([vc isMemberOfClass:[TpfMaiViewController class]]) {
                            [self.navigationController popToViewController:vc animated:true];
                            return;
                        }
                    }
                    
                });
            } else {
                viewConfirmation.wrongPasswordView.hidden = false;
                
            }
        } fail:^(NSError *error) {
            _viewLoading.hidden = true;
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
        
    }];
    [self.view addSubview:viewConfirmation];
    _completeConfirmationCipherConfirmationView = viewConfirmation;
    
}


- (void)initRequestGetTemporaryTaskConfirmUserList {
    _viewLoading.hidden = false;
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *userInfo = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];

    MesPostEntityBean *postEntityBean = [[MesPostEntityBean alloc] init];
    UserInfoVo *info = [[UserInfoVo alloc] init];
    info.siteCode = userInfo.siteCode;
    info.userCode = userInfo.userCode;
//    info.userText = @"";
    postEntityBean.entity = info.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_mes_temporaryTask_getTemporaryTaskConfirmUserList parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.arrayList = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dicTemp in returnListBean.list) {
                UserInfoVo *vo = [UserInfoVo mj_objectWithKeyValues:dicTemp];
                [self.arrayList addObject:vo];
            }
            self.arrayListOriginal = self.arrayList;
            [self.collectionView reloadData];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = true;
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];

    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIToolbar *)addToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 38)];
    toolbar.tintColor = colorRGB(0, 168, 255);
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space,bar];
    return toolbar;
}

- (void)textFieldDone {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
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
