//
//  YanHuoViewController09.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "YanHuoViewController09.h"
#import "VoHeader.h"
#import "YanHuoCell0900.h"
#import "YanHuoCell090100.h"
#import "YanHuoCell090101.h"
#import "YanHuoCell090102.h"

#import "FaHuoCell0901.h"
#import "YanHuoCell0903.h"

#import "UIViewXuanZeShiJian.h"

#import <AVFoundation/AVFoundation.h>
#import "NSString+Utils.h"
#import "NSArray+Transition.h"
#import "CiPingChuLiFangShiViewController09.h"
#import "PartDetailsView.h"
#import "CheckDefectivePhoneViewController.h"

#import "UploadImageBean.h"

#import "GlobalSettingManager.h"

@interface YanHuoViewController09 () <UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    UIView *_viewLoading;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottom;

@property (assign, nonatomic) NSInteger index;

@property (nonatomic,strong) UIImagePickerController *imagePicker;

@end

@implementation YanHuoViewController09

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *pickerFormatter1 = [[NSDateFormatter alloc] init];// 创建一个日期格式器
    [pickerFormatter1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.inspectOrderVo.inspectTime = [pickerFormatter1 stringFromDate:date];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoCell0900" bundle:nil] forCellReuseIdentifier:@"yanHuoCell0900"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoCell090100" bundle:nil] forCellReuseIdentifier:@"yanHuoCell090100"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoCell090101" bundle:nil] forCellReuseIdentifier:@"yanHuoCell090101"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoCell090102" bundle:nil] forCellReuseIdentifier:@"yanHuoCell090102"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell0901" bundle:nil] forCellReuseIdentifier:@"faHuoCell0901"];
    [self.tableView registerNib:[UINib nibWithNibName:@"YanHuoCell0903" bundle:nil] forCellReuseIdentifier:@"yanHuoCell0903"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = true;
    
}


- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        self.tableViewBottom.constant = 0;
    } else {
        self.tableViewBottom.constant = rect.size.height-60-Height_BottomBar;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 3) {
        return self.inspectOrderVo.inspectOrderItems.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        YanHuoCell0900 *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoCell0900" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.labelInspectTiem.text = self.inspectOrderVo.inspectTime;
        __weak YanHuoCell0900 *weakCell = cell;
        [cell setButtonInspectTime:^{
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"UIViewXuanZeShiJian" owner:self options:nil];
            UIViewXuanZeShiJian *viewXZSJ = [nib objectAtIndex:0];
            viewXZSJ.frame = CGRectMake(0, 0, kMainW, kMainH);
            [self.view addSubview:viewXZSJ];
            viewXZSJ.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
            [viewXZSJ initDataPickerButtonClick:^(NSString *string) {
                self.inspectOrderVo.inspectTime = string;
                weakCell.labelInspectTiem.text = string;
            } formatter:@"yyyy-MM-dd HH:mm:ss"];
        }];
        return cell;
    } else if (indexPath.section == 1) {
        if ([self.inspectOrderVo.deliveryMethods isEqualToString:@"SUPPLIER"]) {
            YanHuoCell090100 *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoCell090100" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.inspectOrderVo;
            return cell;
        } else if ([self.inspectOrderVo.deliveryMethods isEqualToString:@"LOGISTICS"]) {
            YanHuoCell090101 *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoCell090101" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.inspectOrderVo;
            return cell;
        } else if ([self.inspectOrderVo.deliveryMethods isEqualToString:@"SELF"]) {
            YanHuoCell090102 *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoCell090102" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.inspectOrderVo;
            return cell;
        }
    } else if (indexPath.section == 2) {
        FaHuoCell0901 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell0901" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 3) {
        YanHuoCell0903 *cell = [tableView dequeueReusableCellWithIdentifier:@"yanHuoCell0903" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        InspectOrderItemVo *model = self.inspectOrderVo.inspectOrderItems[indexPath.row];
        cell.model = model;
        DeliverOrderItemBean *model1;
        for (DeliverOrderItemBean *model11 in self.inspectOrderVo.deliverOrder.items) {
            if ([model.deliverOrderItemId isEqualToString:model11.deliverOrderItemId]) {
                model1 = model11;
            }
        }
        cell.labelPartName.text = [NSString stringWithFormat:@"%@、零件号/规格：%@",model1.itemNo!=nil?model1.itemNo:@"",model1.partNumber!=nil?model1.partNumber:@""];
        [cell setButtonSelectImageCallBack:^{
            self.index = indexPath.row;
            [self upLoadImage];
        }];
        [cell setButtonDelectImageCallBack:^{
            model.filePath = @"";
            model.fileRealName = @"";
            model.bucketName = @"";
            model.fileName = @"";
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        [cell setButtonCheckImageCallBack:^{
            CheckDefectivePhoneViewController *vc = [[CheckDefectivePhoneViewController alloc] init];
            vc.filePath = model.filePath;
            vc.fileRealName = model.fileRealName;
            vc.bucketName = model.bucketName;
            vc.fileName = model.fileRealName;
            
            [self.navigationController pushViewController:vc animated:true];
        }];
        [cell setButtonMianJianCallBack:^(UIButton * _Nonnull sender) {
            NSString *str = model.isMianjian.integerValue==0?@"确认免检这批零件吗？":@"是否取消零件免检";
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:str message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                model.isMianjian = model.isMianjian.integerValue==0?[NSNumber numberWithInteger:1]:[NSNumber numberWithInteger:0];
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
            [alert addAction:action0];
            [alert addAction:action1];
            [self presentViewController:alert animated:true completion:nil];
        }];
        
        [cell setButtonPartDetailCallBack:^{
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PartDetailsView" owner:self options:nil];
            PartDetailsView *partDetailsView = [nib objectAtIndex:0];
            partDetailsView.frame = CGRectMake(0, 0, kMainW, kMainH);
            [self.view addSubview:partDetailsView];
            [partDetailsView initDataIsDeliverOrderItemBean:model1];
        }];
        
        [cell setButtonSelectDefectiveMethodCallBack:^{
            CiPingChuLiFangShiViewController09 *cpclfsVC = [[CiPingChuLiFangShiViewController09 alloc] init];
            cpclfsVC.inspectOrderItemVo = model;
            [cpclfsVC setBlock:^(InspectOrderItemVo *item) {

                [self.tableView reloadData];
            }];
            [self.navigationController pushViewController:cpclfsVC animated:YES];
        }];
        
        
        return cell;
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (IBAction)buttonTemporaryStorage:(id)sender {
    [self requestTemporaryStorageAndSubmit:DYZ_inspect_addTemp];
}

- (IBAction)buttonSubmit:(id)sender {
    if (![[GlobalSettingManager shareGlobalSettingManager].competenceTypeArray containsObject:[NSNumber numberWithInt:43]]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"您没有操作权限，请联系管理员在员工权限设置中开通相关权限"];
        return;
    }
    
    [self requestTemporaryStorageAndSubmit:DYZ_inspect_add];
}


- (void)requestTemporaryStorageAndSubmit:(NSString *)url {
    _viewLoading.hidden = false;
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    InspectOrderVo *inspectOrderVo = [InspectOrderVo new];
    inspectOrderVo.receiveCode = self.inspectOrderVo.receiveCode;
    inspectOrderVo.receiveTime = self.inspectOrderVo.receiveTime;
    inspectOrderVo.supplierEnterpriseName = self.inspectOrderVo.supplierEnterpriseName;
    inspectOrderVo.inspectTime = self.inspectOrderVo.inspectTime;
    inspectOrderVo.deliverCode = self.inspectOrderVo.deliverCode;
    inspectOrderVo.deliverNumber = self.inspectOrderVo.deliverNumber;
    inspectOrderVo.deliveryTime = self.inspectOrderVo.deliveryTime;
    inspectOrderVo.deliveryMethods = self.inspectOrderVo.deliveryMethods;
    inspectOrderVo.deliveryMethodsDesc = self.inspectOrderVo.deliveryMethodsDesc;
    inspectOrderVo.isOpenErp = self.inspectOrderVo.isOpenErp;
    inspectOrderVo.deliverOrderId = self.inspectOrderVo.deliverOrderId;
    inspectOrderVo.receiveOrderId = self.inspectOrderVo.receiveOrderId;
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (InspectOrderItemVo *inspectOrderItemVo in self.inspectOrderVo.inspectOrderItems) {
        InspectOrderItemVo *item = [InspectOrderItemVo new];
//        item.receiveOrderItemId = inspectOrderItemVo.receiveOrderItemId;
//        item.receiveNum = inspectOrderItemVo.receiveNum;
//        item.deliverOrderItemId =  inspectOrderItemVo.deliverOrderItemId;
//        item.qualityQuantity = inspectOrderItemVo.qualityQuantity;
//        item.defectiveQuantity = inspectOrderItemVo.defectiveQuantity;
//        item.isMianjian = inspectOrderItemVo.isMianjian;
//        item.isReceiveMianjian = inspectOrderItemVo.isReceiveMianjian;
//        item.canInspectNum = inspectOrderItemVo.canInspectNum;
        
        if (inspectOrderItemVo.isMianjian.integerValue == 1) {
            inspectOrderItemVo.qualityInspectType = @"E";
        } else {
            inspectOrderItemVo.qualityInspectType = @"F";
        }
        
        inspectOrderItemVo.spotCheckNum = [NSNumber numberWithDouble:0];
        
        double realInspectQuantity = inspectOrderItemVo.qualityQuantity.doubleValue + inspectOrderItemVo.defectiveQuantity.doubleValue;
        inspectOrderItemVo.realInspectQuantity = [NSNumber numberWithDouble:realInspectQuantity];
        
        inspectOrderItemVo.realQualityQuantity = inspectOrderItemVo.qualityQuantity;
        
        item = inspectOrderItemVo;
        [dataArray addObject:item];
    }
    inspectOrderVo.inspectOrderItems = dataArray;
    postEntityBean.entity = inspectOrderVo.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:url parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            if ([url isEqualToString:DYZ_inspect_addTemp]) {//暂存
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"暂存成功"];
//                [self initRequest];
                [self.navigationController popViewControllerAnimated:true];
                _viewLoading.hidden = YES;
            } else {//质检
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"验货成功"];
                [self.navigationController popViewControllerAnimated:true];
                _viewLoading.hidden = YES;
            }
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:model.returnMsg];
            [self.navigationController popViewControllerAnimated:true];
        }

    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

- (void)initRequest{
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    DeliverOrderReqBean *deliverOrderReqBean = [DeliverOrderReqBean new];
    deliverOrderReqBean.deliverCode = self.inspectOrderVo.deliverCode;
    postEntityBean.entity = deliverOrderReqBean.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_inspect_appGetInspectOrder parameters:dic success:^(id responseObjectModel) {
        ReturnEntityBean *model = responseObjectModel;
        if ([model.status isEqualToString:@"SUCCESS"]) {
            InspectOrderVo *inspectOrderVo = [InspectOrderVo mj_objectWithKeyValues:model.entity];
            
            NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:0];
            NSMutableArray *inspectOrderItems = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSInteger i=0; i<inspectOrderVo.inspectOrderItems.count; i++) {
                InspectOrderItemVo *model0 = inspectOrderVo.inspectOrderItems[i];
                DeliverOrderItemBean *model1 = inspectOrderVo.deliverOrder.items[i];
                if (model0.isReceiveMianjian.integerValue == 1 || model1.receiveQuantity.doubleValue == 0) {
                    
                    NSLog(@"---------===receiveQuantity=0====---------");
                } else {
                    [inspectOrderItems addObject:model0];
                    [items addObject:model1];
                }
                
            }
            inspectOrderVo.inspectOrderItems = inspectOrderItems;
            inspectOrderVo.deliverOrder.items = items;
            
            self.inspectOrderVo = inspectOrderVo;
            [self.tableView reloadData];
            _viewLoading.hidden = YES;
        } else {
            
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
}


- (void)upLoadImage {
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
                self.imagePicker.allowsEditing = NO;
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
                self.imagePicker.allowsEditing = NO;
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
            self.imagePicker.allowsEditing = NO;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [action0 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action1 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    [action3 setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    
    [alertController addAction:action0];
    [alertController addAction:action1];
    [alertController addAction:action3];
    
    if ([alertController respondsToSelector:@selector(popoverPresentationController)]) {
        alertController.popoverPresentationController.sourceView = self.view;//必须加
        alertController.popoverPresentationController.sourceRect = CGRectMake(0, kMainH, kMainW, kMainH);//可选
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    _viewLoading.hidden = NO;
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    CGSize size = CGSizeMake(640, 640);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *data = UIImageJPEGRepresentation(newImage, 1);
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    
    postEntityBean.memberId = [GlobalSettingManager shareGlobalSettingManager].memberId;
    
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
    
    [HttpMamager postRequestImageWithURLString:DYZ_efeibiao_uploadfile_uploadInspectFile parameters:dic UploadImageBean:@[uploadImageBean] success:^(id responseObjectModel) {
        _viewLoading.hidden = YES;
        
        ReturnEntityBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            OssUploadBean *ossUploadBean = [OssUploadBean mj_objectWithKeyValues:returnMsgBean.entity];
            
            
            InspectOrderItemVo * inspectOrderItemVo = self.inspectOrderVo.inspectOrderItems[self.index];
            inspectOrderItemVo.filePath = ossUploadBean.filePath;
            inspectOrderItemVo.fileRealName = ossUploadBean.realName;
            inspectOrderItemVo.bucketName = ossUploadBean.bucketName;
            inspectOrderItemVo.fileName = ossUploadBean.fileName;
            
            InspectOrderItemVo *vn = self.inspectOrderVo.inspectOrderItems[self.index];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.index inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
        }
    } progress:^(NSProgress *progress) {
           
    } fail:^(NSError *error) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
    } isKindOfModelClass:NSClassFromString(@"ReturnEntityBean")];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:true];
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
