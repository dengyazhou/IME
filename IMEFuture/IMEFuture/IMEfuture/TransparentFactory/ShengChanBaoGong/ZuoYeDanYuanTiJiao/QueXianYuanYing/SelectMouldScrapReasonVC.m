//
//  SelectMouldScrapReasonVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/8/20.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "SelectMouldScrapReasonVC.h"
#import "VoHeader.h"



#import "UIColor+DYZColorChange.h"

#import <AVFoundation/AVFoundation.h>
#import "TpfCheckBigPictureAndDeletePictureVC.h"

#import "SelectScrapReasonHeader.h"
#import "SelectScrapReasonCell.h"
#import "SelectScrapPictureVC.h"

@interface SelectMouldScrapReasonVC () <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    CGFloat _height_NavBar;
    CGFloat _height_BottomBar;
    
    NSMutableArray *_arrayDefectCauseVo;
    
    UIView *_viewLoading;
    
    UICollectionView *_collectionView;
    
}
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (nonatomic,strong) UIImagePickerController *imagePicker;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar;

@end

@implementation SelectMouldScrapReasonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_BottomBar = Height_BottomBar;
    self.heightNavBar.constant = _height_NavBar;
    self.heightBottomBar.constant = _height_BottomBar;

    
    if ([self.TypeUploadImageName isEqualToString:@"defectPictureFiles"] || [self.TypeUploadImageName isEqualToString:@"scrappedPictureFiles"]) {
        self.labelTitle.text = @"报废原因选择";
    } else if ([self.TypeUploadImageName isEqualToString:@"repairPictureFiles"]) {
        self.labelTitle.text = @"不良原因选择";
    }
    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) color:colorRGB(241, 241, 241) imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectScrapReasonCell" bundle:nil] forCellReuseIdentifier:@"selectScrapReasonCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectScrapReasonHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"selectScrapReasonHeader"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 0.1;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedSectionHeaderHeight = 0.1;
    self.tableView.sectionFooterHeight = 0.1;
    
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.tableFooterView = [UIView new];
    
    if (self.causeDetailVos) {//有值说明是从外面传进来的
        
    } else {
        [self initRequest];
    }

    
}

- (void)initRequest {
    _viewLoading.hidden = NO;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    PagerBean *pageBean = [[PagerBean alloc] init];
    pageBean.page = [NSNumber numberWithInt:1];
    pageBean.pageSize = [NSNumber numberWithInt:100];
    
    mesPostEntityBean.pager = pageBean;
    
    ReportWorkDefectCauseVo *defectCauseVo = [[ReportWorkDefectCauseVo alloc] init];
    defectCauseVo.siteCode = siteCode;
    mesPostEntityBean.entity = defectCauseVo.mj_keyValues;
    NSDictionary *dic = mesPostEntityBean.mj_keyValues;
    
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_modelSequence_getModelReturnCauseList parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        _viewLoading.hidden = YES;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            _arrayDefectCauseVo = [NSMutableArray arrayWithCapacity:0];
            self.causeDetailVos = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in returnListBean.list) {
                ModelReturnCauseVo *modelReturnCauseVo = [ModelReturnCauseVo mj_objectWithKeyValues:dic];
                CauseDetailVo *causeDetailVo = [[CauseDetailVo alloc] init];
                causeDetailVo.causeCode = modelReturnCauseVo.causeCode;
                causeDetailVo.causeText = modelReturnCauseVo.causeText;
                [self.causeDetailVos addObject:causeDetailVo];
            }
            if (self.causeDetailVos.count == 0) {
                if ([self.TypeUploadImageName isEqualToString:@"modelPictureFiles"]) {
                    [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请维护模具缺陷"];
                }
            }
            [self.tableView reloadData];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = YES;
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.causeDetailVos.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SelectScrapReasonHeader *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"selectScrapReasonHeader"];
    if ([self.TypeUploadImageName isEqualToString:@"modelPictureFiles"]) {
        view.label0.text = @"缺陷原因";
        view.label1.text = @"缺陷备注";
        view.label2.text = @"缺陷图片";
    }
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectScrapReasonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"selectScrapReasonCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    CauseDetailVo *causeDetailVo = self.causeDetailVos[indexPath.row];
    cell.label.text = causeDetailVo.causeText;
    
    cell.textField.text = causeDetailVo.causeMemo;
    cell.textField.tag = indexPath.row;
    cell.textField.inputAccessoryView = [self addToolbar];
    [cell.textField addTarget:self action:@selector(textFieldEditingChangDyz:) forControlEvents:UIControlEventEditingChanged];
    cell.textField.keyboardType = UIKeyboardTypeDefault;
    
    
    if (causeDetailVo.uploadImageBeanList.count > 0) {
        [cell.button setImage:[UIImage imageNamed:@"picture2"] forState:UIControlStateNormal];
    } else {
        [cell.button setImage:[UIImage imageNamed:@"picture1"] forState:UIControlStateNormal];
    }
    [cell.button addTarget:self action:@selector(buttonCameraClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.button.tag = indexPath.row;
    
    
    return cell;
}

- (void)buttonCameraClick:(UIButton *)sender {
    CauseDetailVo *causeDetailVo = self.causeDetailVos[sender.tag];
    
    SelectScrapPictureVC *vc = [[SelectScrapPictureVC alloc] init];
    if (causeDetailVo.uploadImageBeanList.count > 0) {
        //有值
        vc.arrayUploadImageBean = [causeDetailVo.uploadImageBeanList mutableCopy];
    } else {
        //没有值
        vc.arrayUploadImageBean = [[NSMutableArray alloc] initWithCapacity:0];
    }
    vc.blockArrayUploadImageBean = ^(NSMutableArray<UploadImageBean *> * _Nonnull arrayUploadImageBean) {
        causeDetailVo.uploadImageBeanList = arrayUploadImageBean;
        //不刷新表了，直接改变button图片
        if (causeDetailVo.uploadImageBeanList.count > 0) {
            [sender setImage:[UIImage imageNamed:@"picture2"] forState:UIControlStateNormal];
        } else {
            [sender setImage:[UIImage imageNamed:@"picture1"] forState:UIControlStateNormal];
        }
    };
    vc.TypeUploadImageName = [self.TypeUploadImageName stringByAppendingString:causeDetailVo.causeCode];
//    vc.productionControlNumAndprocessOperationId = self.productionControlNumAndprocessOperationId;
//    vc.confirmUser = self.confirmUser;
    [self.navigationController pushViewController:vc animated:true];
}

- (void)textFieldEditingChangDyz:(UITextField *)sender {
    CauseDetailVo *causeDetailVo = self.causeDetailVos[sender.tag];
    causeDetailVo.causeMemo = sender.text;
}


#pragma mark 确定
- (IBAction)buttonConfirm:(id)sender {
    if (self.blockArrayCauseDetailVo) {
        self.blockArrayCauseDetailVo(self.causeDetailVos);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
