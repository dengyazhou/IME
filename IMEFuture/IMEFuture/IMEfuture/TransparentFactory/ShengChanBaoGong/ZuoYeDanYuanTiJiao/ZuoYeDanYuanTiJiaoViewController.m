//
//  ZuoYeDanYuanTiJiaoViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/20.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ZuoYeDanYuanTiJiaoViewController.h"
#import "VoHeader.h"


#import "TpfMaiViewController.h"
#import "ZuoYeDanYuanTiJiaoCell.h"
#import "ZuoYeDanYuanTiJiaoCell1.h"

#import "SelectScrapReasonVC.h"
#import "NSString+Utils.h"

#import <AVFoundation/AVFoundation.h>
#import "TpfCheckBigPictureAndDeletePictureVC.h"
#import "ScanYuanGongMaViewController.h"
#import "ScanTuZhiViewController.h"
#import "ZuoYeDanYuanLieBiaoViewController.h"
#import "UploadImageBean.h"

#import "ScanEmployeeVC.h"
#import "SaoYiSaoVC.h"

#import "IMEFuture-swift.h"
#import "UploadImageView.h"
#import "MaterialDYZ.h"
#import "GlobalSettingManager.h"

@interface ZuoYeDanYuanTiJiaoViewController () <UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate> {
    CGFloat _height_NavBar;
    CGFloat _height_BottomBar;
    
    BOOL _bool001;
    
    UIView *_viewLoading;
    
    UploadImageView *_uploadImageView;
    
    double _completedQuantity;//合格数
    double _scrappedQuantity;//报废数
    double _repairQuantity;//报废数
    
//    NSInteger _reworkStatus;//是否返修 默认值设为2
    NSMutableArray *_arrayCauseCode1;//报废原因
    NSMutableArray *_arrayCauseCode2;//不良原因
    
    NSMutableArray <UploadImageBean * >*_arrayDateImageView0;//confirmPicture
    NSMutableArray <UploadImageBean * >*_arrayDateImageView1;//defectPictureFiles 报废图片
    NSMutableArray <UploadImageBean * >*_arrayDateImageView2;//repairPictureFiles 不良图片
    
    NSInteger _submitType;//提交方式（0正常提交1审核提交）
    NSString *_auditor;//审核员（用户编号）
    NSString *_password;//密码
    
    UICollectionView *_collectionView;
    
    ReportWorkProductionOrderConfirmVo *_reportWorkProductionOrderConfirmVoTemp;//临时存值用的
}
@property (nonatomic,strong) NSNumber *  roughWeight;

@property (nonatomic,strong) NSNumber *  netweight;

@property (nonatomic, strong) MaterialDYZ *  materialModel;
@property (nonatomic, strong) NSMutableArray <MaterialDYZ *> *materialArray;


@property (nonatomic,strong) UIImagePickerController *imagePicker;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBottomBar;


@end

@implementation ZuoYeDanYuanTiJiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_BottomBar = Height_BottomBar;
    self.heightNavBar.constant = _height_NavBar;
    self.heightBottomBar.constant = _height_BottomBar;
//    _reworkStatus = 0;
    
    _reportWorkProductionOrderConfirmVoTemp = [[ReportWorkProductionOrderConfirmVo alloc] init];
    
    _arrayCauseCode1 = [NSMutableArray arrayWithCapacity:0];
    _arrayCauseCode2 = [NSMutableArray arrayWithCapacity:0];
    _arrayDateImageView0 = [NSMutableArray arrayWithCapacity:0];
    _arrayDateImageView1 = [NSMutableArray arrayWithCapacity:0];
    _arrayDateImageView2 = [NSMutableArray arrayWithCapacity:0];
    _bool001 = NO;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW - 34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    _uploadImageView = [UploadImageView uploadImage];
    _uploadImageView.frame = self.view.frame;
    [self.view addSubview:_uploadImageView];
    _uploadImageView.hidden = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ZuoYeDanYuanTiJiaoCell" bundle:nil] forCellReuseIdentifier:@"zuoYeDanYuanTiJiaoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZuoYeDanYuanTiJiaoCell1" bundle:nil] forCellReuseIdentifier:@"zuoYeDanYuanTiJiaoCell1"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 285;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self requestGetMouldByProductionControlNum];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ZuoYeDanYuanTiJiaoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zuoYeDanYuanTiJiaoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (_bool001 == YES) {
            if (_completedQuantity != 0) {
                cell.textField0.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:_completedQuantity]];
            } else {
                cell.textField0.text = @"0";
            }
        } else {
            cell.textField0.text = nil;
        }
        
        [cell.textField0 addTarget:self action:@selector(textField0Click:) forControlEvents:UIControlEventEditingChanged];
        cell.textField0.inputAccessoryView = [self addToolbar];
        cell.textField0.delegate = self;
        
        //不良
        if (_repairQuantity != 0) {
            cell.textField1.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:_repairQuantity]];
        } else {
            cell.textField1.text = nil;
        }
        [cell.textField1 addTarget:self action:@selector(textField1Click:) forControlEvents:UIControlEventEditingChanged];
        cell.textField1.inputAccessoryView = [self addToolbar];
        cell.textField1.delegate = self;
        
        //报废
        if (_scrappedQuantity != 0) {
            cell.textField2.text = [NSString stringWithFormat:@"%@",[NSNumber numberWithDouble:_scrappedQuantity]];
        } else {
            cell.textField2.text = nil;
        }
        [cell.textField2 addTarget:self action:@selector(textField2Click:) forControlEvents:UIControlEventEditingChanged];
        cell.textField2.inputAccessoryView = [self addToolbar];
        cell.textField2.delegate = self;
        
        //不良
        cell.view21.hidden = YES;
        if (_repairQuantity > 0) {
            cell.view21.hidden = NO;
        }
        
        //报废
        cell.view22.hidden = YES;
        if (_scrappedQuantity > 0) {
            cell.view22.hidden = NO;
        }
        
        //不良
        cell.buttonQueXianYuanYing21.hidden = YES;
        cell.buttonQueXianYuanYingQingXuanZe21.hidden = YES;
        NSMutableArray <__kindof CauseDetailVo *>*arrayTemp1 = [[NSMutableArray alloc] initWithCapacity:0];
        for (CauseDetailVo *causeDetailVo in _reportWorkProductionOrderConfirmVoTemp.repairCauseDetailVos) {
            if (causeDetailVo.quantity.doubleValue > 0) {
                [arrayTemp1 addObject:causeDetailVo];
            }
        }
        if (arrayTemp1.count > 0) {
            cell.buttonQueXianYuanYing21.hidden = NO;
            [cell.buttonQueXianYuanYing21 setTitle:[NSString stringWithFormat:@"已选择%ld种不良原因",arrayTemp1.count] forState:UIControlStateNormal];
        } else {
            cell.buttonQueXianYuanYingQingXuanZe21.hidden = NO;
        }
        [cell.buttonQueXianYuanYing21 addTarget:self action:@selector(buttonQueXianYuanYingQingXuanZe21:) forControlEvents:UIControlEventTouchUpInside];
        [cell.buttonQueXianYuanYingQingXuanZe21 addTarget:self action:@selector(buttonQueXianYuanYingQingXuanZe21:) forControlEvents:UIControlEventTouchUpInside];
        
        //报废
        cell.buttonQueXianYuanYing22.hidden = YES;
        cell.buttonQueXianYuanYingQingXuanZe22.hidden = YES;
        NSMutableArray <__kindof CauseDetailVo *>*arrayTemp2 = [[NSMutableArray alloc] initWithCapacity:0];
        for (CauseDetailVo *causeDetailVo in _reportWorkProductionOrderConfirmVoTemp.scrappedCauseDetailVos) {
            if (causeDetailVo.quantity.doubleValue > 0) {
                [arrayTemp2 addObject:causeDetailVo];
            }
        }
        if (arrayTemp2.count > 0) {
            cell.buttonQueXianYuanYing22.hidden = NO;
            [cell.buttonQueXianYuanYing22 setTitle:[NSString stringWithFormat:@"已选择%ld种报废原因",arrayTemp2.count] forState:UIControlStateNormal];
        } else {
            cell.buttonQueXianYuanYingQingXuanZe22.hidden = NO;
        }
        [cell.buttonQueXianYuanYing22 addTarget:self action:@selector(buttonQueXianYuanYingQingXuanZe22:) forControlEvents:UIControlEventTouchUpInside];
        [cell.buttonQueXianYuanYingQingXuanZe22 addTarget:self action:@selector(buttonQueXianYuanYingQingXuanZe22:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //毛重
        [cell.textFieldMaoZhong addTarget:self action:@selector(textFieldMaoZhongClick:) forControlEvents:UIControlEventEditingChanged];
        cell.textFieldMaoZhong.inputAccessoryView = [self addToolbar];
        cell.textFieldMaoZhong.delegate = self;
        if (self.roughWeight) {
            cell.textFieldMaoZhong.text = self.roughWeight.stringValue;
        }
        //净重
        [cell.textFieldJingZhong addTarget:self action:@selector(textFieldJingZhongClick:) forControlEvents:UIControlEventEditingChanged];
        cell.textFieldJingZhong.inputAccessoryView = [self addToolbar];
        cell.textFieldJingZhong.delegate = self;
        if (self.netweight) {
            cell.textFieldJingZhong.text = self.netweight.stringValue;
        }
        //模具
        cell.materialArray = self.materialArray;
        [cell.tableView reloadData];
        cell.labelMoJu.text = self.materialModel.sequenceNum;
        [cell tableViewDidSelectBlock:^(NSInteger rowYZ) {
            self.materialModel = self.materialArray[rowYZ];
            cell.labelMoJu.text = self.materialModel.sequenceNum;
        }];
        
        //点击扫码
        [cell.buttonDianJiSaoMa addTarget:self action:@selector(buttonDianJiSaoMaClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.arrayDateImage = _arrayDateImageView0;
        _collectionView = cell.collectionView;
        [cell.collectionView reloadData];
        
        [cell buttonClickChaKanDaTuBlock:^(NSInteger rowYZ) {
            [self buttonClickChaKanDaTu:rowYZ];
        }];
        [cell buttonAddImageBlock:^{
            [self addImage];
        }];
        
        return cell;
    } else if (indexPath.row == 1) {
        ZuoYeDanYuanTiJiaoCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"zuoYeDanYuanTiJiaoCell1" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.label0.text = [NSString stringWithFormat:@"生产订单：%@",self.productionOrderNum];
        cell.label1.text = [NSString stringWithFormat:@"生产单元：%@",self.workUnitText];
        cell.label2.text = [NSString stringWithFormat:@"报工人名：%@",self.personnelName];;
        cell.label3.text = [NSString stringWithFormat:@"下道工序：%@",self.operationTextNext.length > 0?self.operationTextNext:@"无"];
        cell.label4.text = [NSString stringWithFormat:@"消耗时间：%02ld时%02ld分%02ld秒",[self.workTime integerValue]/1000/3600,([self.workTime integerValue]/1000%3600)/60,[self.workTime integerValue]/1000%60];//计消耗时间：
        
        int planTime = (int)[self.planTime doubleValue];
        int planTime1 = ([self.planTime doubleValue] - planTime)*60;
        if ([GlobalSettingManager shareGlobalSettingManager].showPlanHour) {
            cell.label5.text = [NSString stringWithFormat:@"计划工时：%d小时%d分",planTime,planTime1];
        } else {
            cell.label5.text = @"计划工时：--";
        }
        
        cell.label6.text = [NSString stringWithFormat:@"客户交期：%@",self.requirementDate];
        cell.label7.text = [NSString stringWithFormat:@"未完成数量：%@",self.unfinishedQuantity];
        
        return cell;
    } else {
        return nil;
    }
}

- (void)textField0Click:(UITextField *)sender {
    _completedQuantity = [sender.text doubleValue];
    if (sender.text.length > 0) {
        _bool001 = YES;
    } else {
        _bool001 = NO;
    }
    
}

//不良数量
- (void)textField1Click:(UITextField *)sender {
    _repairQuantity = [sender.text doubleValue];
    NSLog(@"%f",_repairQuantity);
}

//报废数量
- (void)textField2Click:(UITextField *)sender {
    _scrappedQuantity = [sender.text doubleValue];
    NSLog(@"%f",_scrappedQuantity);
}

//毛重
- (void)textFieldMaoZhongClick:(UITextField *)sender {
    self.roughWeight = [NSNumber numberWithDouble:sender.text.doubleValue];
}

//净重
- (void)textFieldJingZhongClick:(UITextField *)sender {
   self.netweight = [NSNumber numberWithDouble:sender.text.doubleValue];
}

#pragma mark 模具扫描
- (void)buttonDianJiSaoMaClick:(UIButton *)sender {
    SaoYiSaoVC *saoYiSaoVC = [[SaoYiSaoVC alloc] init];
    saoYiSaoVC.scanTitle = @"扫描模具二维码";
    [saoYiSaoVC setResultBlock:^(NSString *result) {
        
        [self requestCheckMoldMaterial:result];
    }];
    [self presentViewController:saoYiSaoVC animated:YES completion:nil];
}

- (void)requestCheckMoldMaterial:(NSString *)str {
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = [[NSError alloc] init];
    NSDictionary *dic123 = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
        NSString *siteCode = tpfUser.siteCode;
        
        MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
        
        MaterialVo *material = [[MaterialVo alloc] init];
        material.siteCode = siteCode;
        material.materialCode = dic123[@"modelCode"];;
        material.productionControlNum = self.productionControlNum;
        
        mesPostEntityBean.entity = material.mj_keyValues;
        NSDictionary *dic = mesPostEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_mes_material_checkMoldMaterial parameters:dic success:^(id responseObjectModel) {
            ReturnMsgBean *returnMsgBean = responseObjectModel;
            if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
                
                MaterialDYZ *material = [[MaterialDYZ alloc] init];
                material.materialCode = dic123[@"modelCode"];
                material.materialText = dic123[@"modelName"];
                material.sequenceNum = dic123[@"sequenceNum"];
                self.materialModel = material;

                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
            }
            
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    });
}

#pragma mark 获取模具接口
- (void)requestGetMouldByProductionControlNum {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        LoginModel *loginModel = [DatabaseTool getLoginModel];
        UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
        NSString *siteCode = tpfUser.siteCode;
        
        MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
        ProductionControlVo *productionControlVo = [[ProductionControlVo alloc] init];
        productionControlVo.siteCode = siteCode;
        productionControlVo.productionControlNum = self.productionControlNum;
        mesPostEntityBean.entity = productionControlVo.mj_keyValues;
        NSDictionary *dic = mesPostEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_mes_material_getMouldByProductionControlNum parameters:dic success:^(id responseObjectModel) {
            ReturnListBean *returnListBean = responseObjectModel;
            if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
                self.materialArray = [MaterialDYZ mj_objectArrayWithKeyValuesArray:returnListBean.list];
                if (self.materialArray.count > 0) {
                    self.materialModel = self.materialArray[0];
                } else {
                    MaterialDYZ *material = [[MaterialDYZ alloc] init];
                    material.materialText = @"暂无模具";
                    material.sequenceNum = @"暂无模具";
                    self.materialModel = material;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            } else {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:returnListBean.returnMsg];
            }
            
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnListBean")];
    });
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.length == 1 && string.length == 0) {
        return YES;
    } else if (textField.text.length >= 8) {
        textField.text = [textField.text substringToIndex:8];
        return NO;
    }
    return YES;
}


//不良原因
- (void)buttonQueXianYuanYingQingXuanZe21:(UIButton *)sender {
    
    SelectScrapReasonVC *vc = [[SelectScrapReasonVC alloc] init];
    vc.TypeUploadImageName = @"repairPictureFiles";//不良图片
    
    vc.productionControlNum = self.productionControlNum;
    vc.processOperationId = self.processOperationId;
    
    if (_reportWorkProductionOrderConfirmVoTemp.repairCauseDetailVos.count > 0) {
        //存在
        vc.causeDetailVos = [_reportWorkProductionOrderConfirmVoTemp.repairCauseDetailVos mutableCopy];
    } else {
        //不存在
    }
    vc.blockArrayCauseDetailVo = ^(NSMutableArray<CauseDetailVo *> *causeDetailVos) {
        _reportWorkProductionOrderConfirmVoTemp.repairCauseDetailVos = causeDetailVos;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    };
    vc.quantity = _repairQuantity;
    [self.navigationController pushViewController:vc animated:YES];
}

//报废原因
- (void)buttonQueXianYuanYingQingXuanZe22:(UIButton *)sender {

    SelectScrapReasonVC *vc = [[SelectScrapReasonVC alloc] init];
    vc.TypeUploadImageName = @"defectPictureFiles";//报废图片
    
    vc.productionControlNum = self.productionControlNum;
    vc.processOperationId = self.processOperationId;
    if (_reportWorkProductionOrderConfirmVoTemp.scrappedCauseDetailVos.count > 0) {
        //存在
        vc.causeDetailVos = [_reportWorkProductionOrderConfirmVoTemp.scrappedCauseDetailVos mutableCopy];
    } else {
        //不存在
    }
    vc.blockArrayCauseDetailVo = ^(NSMutableArray<CauseDetailVo *> *causeDetailVos) {
        _reportWorkProductionOrderConfirmVoTemp.scrappedCauseDetailVos = causeDetailVos;
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    };
    vc.quantity = _scrappedQuantity;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addImage {
    if (_arrayDateImageView0.count >= 10) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"最多添加10张图片"];
        return;
    }
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

    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    CGSize size = CGSizeMake(640, 640);
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *data = UIImageJPEGRepresentation(newImage, 1);
    
    UploadImageBean *uploadImageBean = [[UploadImageBean alloc] init];
    uploadImageBean.data = data;
    uploadImageBean.name = @"confirmPictureFiles";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [formatter stringFromDate:[NSDate date]];
    uploadImageBean.fileName = [NSString stringWithFormat:@"%@.png",strDate];
    uploadImageBean.mimeType = @"image/png";
    
    [_arrayDateImageView0 addObject:uploadImageBean];
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    
    [_collectionView reloadData];

    //延迟调用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self->_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_arrayDateImageView0.count inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    });
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buttonClickChaKanDaTu:(NSInteger)index {
    TpfCheckBigPictureAndDeletePictureVC *vc = [[TpfCheckBigPictureAndDeletePictureVC alloc] init];
    vc.arrayUploadImageBean = _arrayDateImageView0;
    vc.index = index;
    vc.buttonBackBlock = ^{
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    };
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark 审核
- (IBAction)buttonCheck:(id)sender {
    if (_bool001 == NO) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入合格数量"];
        return;
    } else if (_completedQuantity > self.unfinishedQuantity.doubleValue) {
//        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"合格数量不能大于未完成数量"];
//        return;
    }
    
    _submitType = 1;
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    NSString *personnerlCode = [DatabaseTool t_TpfPWTableGetPersonnelCodeWithSiteCode:siteCode];
    if (![personnerlCode isEqualToString:@"(null)"]) {//绑定了人员
        _auditor = personnerlCode;
        [self showAlertViewPasswordAuthentification];
    } else {
        ScanEmployeeVC *vc = [[ScanEmployeeVC alloc] init];
        [vc passwordAuthentificationCallBack:^(NSString *str, NSInteger needPassword) {
            if (needPassword == 1) {//需要密码
                self->_auditor = str;
                [self performSelector:@selector(afterdyz) withObject:nil afterDelay:1];//延迟调用一下，不然UIAlertController出不来
            } else {//不需要密码
                self->_auditor = str;
                [self requestDoConfirmProduction];
            }
        }];
        [self.navigationController pushViewController:vc animated:true];
    }
}

- (void)afterdyz {
    [self showAlertViewPasswordAuthentification];
}

- (void)showAlertViewPasswordAuthentification {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"交接班确认" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSString *str = alertVC.textFields[0].text;
        if (str == nil || str.length == 0) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入密码"];
            return;
        }
        _password = str;
        [self requestDoConfirmProduction];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"审核人输入密码";
        textField.secureTextEntry = true;
    }];
    [self presentViewController:alertVC animated:true completion:nil];
}

#pragma mark 提交
- (IBAction)buttonTiJiao:(id)sender {
    if (_bool001 == NO) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入合格数量"];
        return;
    }
    
    if (self.completionMode.integerValue == 1) {
        if (_completedQuantity > self.unfinishedQuantity.doubleValue) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"合格数量不能大于未完成数量"];
            return;
        }
    } else {
        
    }

    
    _submitType = 0;
    [self requestDoConfirmProduction];
}

- (void)requestDoConfirmProduction{
    
    if (_repairQuantity > 0) {//不良
        if (_reportWorkProductionOrderConfirmVoTemp.repairCauseDetailVos) {
            double total = 0;
            for (NSInteger i=0; i<_reportWorkProductionOrderConfirmVoTemp.repairCauseDetailVos.count; i++) {
                CauseDetailVo *temp = _reportWorkProductionOrderConfirmVoTemp.repairCauseDetailVos[i];
                total = total+temp.quantity.doubleValue;
            }
            if (total > _repairQuantity) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"不得大于缺陷总数"];
                return;
            }
        }
    }
    if (_scrappedQuantity > 0) {//报废
        if (_reportWorkProductionOrderConfirmVoTemp.scrappedCauseDetailVos) {
            double total = 0;
            for (NSInteger i=0; i<_reportWorkProductionOrderConfirmVoTemp.scrappedCauseDetailVos.count; i++) {
                CauseDetailVo *temp = _reportWorkProductionOrderConfirmVoTemp.scrappedCauseDetailVos[i];
                total = total+temp.quantity.doubleValue;
            }
            if (total > _scrappedQuantity) {
                [[MyAlertCenter defaultCenter] postAlertWithMessage:@"不得大于缺陷总数"];
                return;
            }
        }
    }
    
    
//    _viewLoading.hidden = NO;
    _uploadImageView.hidden = NO;
    [_uploadImageView prepare];
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    
    MesPostEntityBean *mesPostEntityBean = [[MesPostEntityBean alloc] init];
    ReportWorkProductionOrderConfirmVo *productionOrderConfirmVo = [[ReportWorkProductionOrderConfirmVo alloc] init];
    productionOrderConfirmVo.siteCode = siteCode;
    productionOrderConfirmVo.operationCode = self.operationCode;
    productionOrderConfirmVo.productionControlNum = self.productionControlNum;
    productionOrderConfirmVo.workUnitCode = self.workUnitCode;
    productionOrderConfirmVo.confirmUser = self.confirmUser;
    productionOrderConfirmVo.completedQuantity = [NSNumber numberWithDouble:_completedQuantity];//合格数
    productionOrderConfirmVo.repairQuantity = [NSNumber numberWithDouble:_repairQuantity];//返修数量
    productionOrderConfirmVo.scrappedQuantity = [NSNumber numberWithDouble:_scrappedQuantity];//报废数量
    productionOrderConfirmVo.scrappedCauseList = _arrayCauseCode1;
    productionOrderConfirmVo.repairCauseList = _arrayCauseCode2;
    productionOrderConfirmVo.status = self.status;
    productionOrderConfirmVo.confirmFlag = [NSNumber numberWithInteger:[self.confirmFlag integerValue]];
    productionOrderConfirmVo.actualEndDateTime = self.actualendDateTime;
    productionOrderConfirmVo.logId = self.logId;
    productionOrderConfirmVo.processOperationId = [NSNumber numberWithLong:[self.processOperationId longLongValue]];
    productionOrderConfirmVo.workTime = [self.workTime stringValue];
    productionOrderConfirmVo.auditor = _auditor;
    productionOrderConfirmVo.password = _password;
    productionOrderConfirmVo.submitType = [NSNumber numberWithInteger:_submitType];
    productionOrderConfirmVo.loginType = [[NSUserDefaults standardUserDefaults]objectForKey:@"loginType"];
    productionOrderConfirmVo.roughWeight = self.roughWeight;
    productionOrderConfirmVo.netweight = self.netweight;
    productionOrderConfirmVo.moldmaterial = self.materialModel.materialCode;
    productionOrderConfirmVo.sequenceNum = self.materialModel.sequenceNum;
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    for (UploadImageBean *bean in _arrayDateImageView0) {
        [array addObject:bean];
    }
    
    if (_repairQuantity > 0) {//不良
        if (_reportWorkProductionOrderConfirmVoTemp.repairCauseDetailVos) {
            NSMutableArray <__kindof CauseDetailVo *>*arrayTemp = [[NSMutableArray alloc] initWithCapacity:0];
            for (CauseDetailVo *causeDetailVo in _reportWorkProductionOrderConfirmVoTemp.repairCauseDetailVos) {
                if (causeDetailVo.quantity.doubleValue > 0) {
                    for (UploadImageBean *uploadImageBean in causeDetailVo.uploadImageBeanList) {
                        [array addObject:uploadImageBean];
                    }
                    [arrayTemp addObject:causeDetailVo];
                }
            }
            productionOrderConfirmVo.repairCauseDetailVos = arrayTemp;
        }
        if (_reportWorkProductionOrderConfirmVoTemp.repairCauseDetailVos) {
            for (CauseDetailVo *causeDetailVo in _reportWorkProductionOrderConfirmVoTemp.repairCauseDetailVos) {
                causeDetailVo.uploadImageBeanList = [[NSMutableArray alloc] initWithCapacity:0];
            }
        }
    }
    if (_scrappedQuantity > 0) {//报废
        if (_reportWorkProductionOrderConfirmVoTemp.scrappedCauseDetailVos) {
            NSMutableArray <__kindof CauseDetailVo *>*arrayTemp = [[NSMutableArray alloc] initWithCapacity:0];
            
            for (CauseDetailVo *causeDetailVo in _reportWorkProductionOrderConfirmVoTemp.scrappedCauseDetailVos) {
                if (causeDetailVo.quantity.doubleValue > 0) {
                    for (UploadImageBean *uploadImageBean in causeDetailVo.uploadImageBeanList) {
                        [array addObject:uploadImageBean];
                    }
                    [arrayTemp addObject:causeDetailVo];
                }
               
            }
            productionOrderConfirmVo.scrappedCauseDetailVos = arrayTemp;
        }
        if (_reportWorkProductionOrderConfirmVoTemp.scrappedCauseDetailVos) {
            for (CauseDetailVo *causeDetailVo in _reportWorkProductionOrderConfirmVoTemp.scrappedCauseDetailVos) {
                causeDetailVo.uploadImageBeanList = [[NSMutableArray alloc] initWithCapacity:0];
            }
        }
    }
    
    mesPostEntityBean.entity = productionOrderConfirmVo.mj_keyValues;
    NSDictionary *dic1 = mesPostEntityBean.mj_keyValues;
    NSLog(@"%@",dic1);
    
    NSDictionary *dic = @{@"data":[NSString convertToJsonDataTouMingGongChang:dic1]};
    
    NSLog(@"%@",dic);
    
    
    [HttpMamager postRequestImageWithURLString:DYZ_productionOrderConfirm_doConfirmProduction parameters:dic UploadImageBean:array success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;

        self->_uploadImageView.hidden = YES;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"提交成功"];

            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isMemberOfClass:[ScanTuZhiViewController class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                    return;
                }
            }
            //再制工单
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[ZaiZhiGongDanVC class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                    return;
                }
            }
            for (UIViewController *temp in self.navigationController.viewControllers) {
                if ([temp isKindOfClass:[ScanYuanGongMaVC class]]) {
                    [self.navigationController popToViewController:temp animated:YES];
                    return;
                }
            }

        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:returnMsgBean.returnMsg];
        }
    } progress:^(NSProgress *progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_uploadImageView.progressView setProgress:progress.fractionCompleted];
            if (progress.fractionCompleted == 1) {
                [self->_uploadImageView loadFinish];
            }
        });
    } fail:^(NSError *error) {
        self->_uploadImageView.hidden = YES;
    } isKindOfModelClass:NSClassFromString(@"ReturnMsgBean")];
}

#pragma mark 回到首页
- (IBAction)buttonGoHome:(id)sender {
    for (UIViewController *temp in self.navigationController.viewControllers) {
        if ([temp isKindOfClass:[TpfMaiViewController class]]) {
            [self.navigationController popToViewController:temp animated:YES];
            break;
        }
    }
}

- (IBAction)back:(id)sender {
    
    
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    UserInfoVo *tpfUser = [UserInfoVo mj_objectWithKeyValues:loginModel.tpfUser];
    NSString *siteCode = tpfUser.siteCode;
    NSString *personnelCode = [DatabaseTool t_TpfPWTableGetPersonnelCodeWithSiteCode:siteCode];
    NSString *workUnitCode = [DatabaseTool t_TpfPWTableGetWorkUnitCodeWithSiteCode:siteCode];
    
    if ((![personnelCode isEqualToString:@"(null)"]) && (![workUnitCode isEqualToString:@"(null)"])) {
        //有 personnelCode，有 workUnitCode
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isMemberOfClass:[ScanTuZhiViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
                return;
            }
        }
    } else if ((![personnelCode isEqualToString:@"(null)"]) && ([workUnitCode isEqualToString:@"(null)"])) {
        //有 personnelCode，无 workUnitCode
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isMemberOfClass:[ZuoYeDanYuanLieBiaoViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
                return;
            }
        }
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isMemberOfClass:[ScanTuZhiViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
                return;
            }
        }
    } else if (([personnelCode isEqualToString:@"(null)"]) && (![workUnitCode isEqualToString:@"(null)"])) {
        //无 personnelCode，有 workUnitCode
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[ScanYuanGongMaViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
                return;
            }
        }
    } else if (([personnelCode isEqualToString:@"(null)"]) && ([workUnitCode isEqualToString:@"(null)"])) {
        //无 personnelCode，无 workUnitCode
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[ScanYuanGongMaViewController class]]) {
                [self.navigationController popToViewController:temp animated:YES];
                return;
            }
        }
    }
    
    //再制工单
    if (self.status.intValue == 4) {
        
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[ZaiZhiGongDanVC class]]) {
                
                [self.navigationController popToViewController:temp animated:YES];
                return;
            }
        }
        for (UIViewController *temp in self.navigationController.viewControllers) {
            if ([temp isKindOfClass:[ScanYuanGongMaVC class]]) {
                
                [self.navigationController popToViewController:temp animated:YES];
                return;
            }
        }
        
    } else {
        
        [self.navigationController popViewControllerAnimated:true];
    }
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
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
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
