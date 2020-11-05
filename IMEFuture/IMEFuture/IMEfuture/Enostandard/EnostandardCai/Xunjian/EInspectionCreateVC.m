//
//  EInspectionCreateVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/18.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import "EInspectionCreateVC.h"
#import "VoHeader.h"
#import <AVFoundation/AVFoundation.h>
#import "TpfCheckBigPictureAndDeletePictureVC.h"

#import "EInspectionCreateCell.h"
#import "InspectionBean.h"

@interface EInspectionCreateVC () <UITableViewDelegate,UITableViewDataSource> {
    UIView *_viewLoading;
    
    NSMutableArray * _arrayDateImageView0;
    UICollectionView *_collectionView;
}


@property (nonatomic, strong) InspectionBean *inspectionBean;

@property (nonatomic,strong) UIImagePickerController *imagePicker;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerBg;

@property (weak, nonatomic) IBOutlet UITableView *tableViewTgSupplier;
@property (weak, nonatomic) IBOutlet UIView *tableViewTgSupplierBg;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@property (nonatomic, strong) NSMutableArray *arrayTgSupplier;
@property (nonatomic, assign) NSUInteger index;

@end

@implementation EInspectionCreateVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightNavBar.constant = Height_NavBar;
    
    self.index = NSUIntegerMax;
    
    _arrayDateImageView0 = [NSMutableArray arrayWithCapacity:0];
    self.inspectionBean = [[InspectionBean alloc] init];
    self.inspectionBean.inspectionType = @"1";
    self.inspectionBean.inspectionCommentKey1 = @"质量";
    self.inspectionBean.inspectionCommentKey2 = @"成本";
    self.inspectionBean.inspectionCommentKey3 = @"交付";
    self.inspectionBean.inspectionCommentKey4 = @"响应";
    self.inspectionBean.inspectionCommentKey5 = @"其他";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *dateStr = [formatter  stringFromDate:[NSDate date]];
    self.inspectionBean.inspectionDate = dateStr;
    
    
    
    self.datePickerBg.hidden = YES;
    
    self.tableViewTgSupplierBg.hidden = YES;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"EInspectionCreateCell" bundle:nil] forCellReuseIdentifier:@"eInspectionCreateCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tableViewTgSupplier registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableViewTgSupplier.delegate = self;
    self.tableViewTgSupplier.dataSource = self;
    self.tableViewTgSupplier.rowHeight = 44;
    self.tableViewTgSupplier.tableFooterView = [UIView new];
    
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, Height_NavBar, kMainW, kMainH-Height_NavBar) color:[UIColor clearColor] imageView:CGRectMake((kMainW-34)/2, 180, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return 1;
    } else if (tableView == self.tableViewTgSupplier) {
        if (self.arrayTgSupplier.count == 0) {
            return 1;
        }
        return self.arrayTgSupplier.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        EInspectionCreateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eInspectionCreateCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.arrayTgSupplier = self.arrayTgSupplier;
        [cell.tableView reloadData];
        cell.textField0.text = self.inspectionBean.name;
        
        [cell.textField0 addTarget:self action:@selector(textField0Click:) forControlEvents:UIControlEventEditingChanged];
        cell.textField0.inputAccessoryView = [self addToolbar];
        
        [cell.button1 addTarget:self action:@selector(buttonClickSelectDataTime:) forControlEvents:UIControlEventTouchUpInside];
        cell.textField1.text = [[self.inspectionBean.inspectionDate componentsSeparatedByString:@" "] firstObject];
        cell.textField1.inputAccessoryView = [self addToolbar];
        
        cell.textField2.text = self.inspectionBean.inspectionCommentValue1;
        [cell.textField2 addTarget:self action:@selector(textField2Click:) forControlEvents:UIControlEventEditingChanged];
        cell.textField3.text = self.inspectionBean.inspectionCommentValue2;
        [cell.textField3 addTarget:self action:@selector(textField3Click:) forControlEvents:UIControlEventEditingChanged];
        cell.textField4.text = self.inspectionBean.inspectionCommentValue3;
        [cell.textField4 addTarget:self action:@selector(textField4Click:) forControlEvents:UIControlEventEditingChanged];
        cell.textField5.text = self.inspectionBean.inspectionCommentValue4;
        [cell.textField5 addTarget:self action:@selector(textField5Click:) forControlEvents:UIControlEventEditingChanged];
        cell.textField6.text = self.inspectionBean.inspectionCommentValue5;
        [cell.textField6 addTarget:self action:@selector(textField6Click:) forControlEvents:UIControlEventEditingChanged];
        cell.textField2.inputAccessoryView = [self addToolbar];
        cell.textField3.inputAccessoryView = [self addToolbar];
        cell.textField4.inputAccessoryView = [self addToolbar];
        cell.textField5.inputAccessoryView = [self addToolbar];
        cell.textField6.inputAccessoryView = [self addToolbar];
        
        
        cell.arrayDateImage = _arrayDateImageView0;
        [cell.collectionView reloadData];
        
        [cell buttonClickChaKanDaTuBlock:^(NSInteger rowYZ) {
            [self buttonClickChaKanDaTu:rowYZ];
        }];
        [cell buttonAddImageBlock:^{
            [self addImage];
        }];
        return cell;
    } else if (tableView == self.tableViewTgSupplier) {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (self.arrayTgSupplier.count == 0) {
            cell.textLabel.text = @"无数据";
        } else {
            NSDictionary *dic = self.arrayTgSupplier[indexPath.row];
            cell.textLabel.text = dic[@"name"];
        }
        return cell;
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        
    } else if (tableView == self.tableViewTgSupplier) {
        if (self.arrayTgSupplier.count == 0) {
           
        } else {
            self.tableViewTgSupplierBg.hidden = YES;
            
            NSDictionary *dic = self.arrayTgSupplier[indexPath.row];
            self.inspectionBean.name = dic[@"name"];
            self.inspectionBean.supplierManufacturerId = dic[@"id"];
            [self.tableView reloadData];
        }
    }
}

#pragma mark 供应商
- (void)textField0Click:(UITextField *)sender {
    if (sender.text.length >= 2) {
        self.tableViewTgSupplierBg.hidden = false;
        self.inspectionBean.name = sender.text;
        [self initRequest:sender.text];
    }
    if (sender.text.length == 0) {
        self.tableViewTgSupplierBg.hidden = true;
        self.inspectionBean.name = @"";
        self.inspectionBean.supplierManufacturerId = @"";
    }
}

#pragma mark 巡检日期
- (void)buttonClickSelectDataTime:(UIButton *)sender {
    self.datePickerBg.hidden = NO;
}

#pragma mark 质量
- (void)textField2Click:(UITextField *)sender {
    self.inspectionBean.inspectionCommentValue1 = sender.text;
}

#pragma mark 成本
- (void)textField3Click:(UITextField *)sender {
    self.inspectionBean.inspectionCommentValue2 = sender.text;
}

#pragma mark 支付
- (void)textField4Click:(UITextField *)sender {
    self.inspectionBean.inspectionCommentValue3 = sender.text;
}

#pragma mark 响应
- (void)textField5Click:(UITextField *)sender {
    self.inspectionBean.inspectionCommentValue4 = sender.text;
}

#pragma mark 其他
- (void)textField6Click:(UITextField *)sender {
    self.inspectionBean.inspectionCommentValue5 = sender.text;
}


- (void)addImage {
    if (_arrayDateImageView0.count >= 5) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"最多添加5张图片"];
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
    uploadImageBean.name = @"file";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [formatter stringFromDate:[NSDate date]];
    uploadImageBean.fileName = [NSString stringWithFormat:@"%@.png",strDate];
    uploadImageBean.mimeType = @"image/png";
    
    NSDictionary *dic1 = @{@"fbToken":[GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken,
                    @"fileModuleType":@"S_RE"};//INSPECTION
    NSDictionary *dic = @{@"data":[NSString convertToJsonData:dic1]};
    
    [HttpMamager postRequestImageWithURLString:DYZ_api_upload_uploadFileMethod parameters:dic UploadImageBean:@[uploadImageBean] success:^(id responseObjectModel) {
        _viewLoading.hidden = YES;
        
        ReturnEntityBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            
            OssUploadResBean *ossUploadBean = [OssUploadResBean mj_objectWithKeyValues:returnMsgBean.entity];
            ossUploadBean.imageData = data;
            [self->_arrayDateImageView0 addObject:ossUploadBean];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
        }
        
    } progress:^(NSProgress *progress) {
           
    } fail:^(NSError *error) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
    } isKindOfModelClass:NSClassFromString(@"ReturnEntityBean")];
    [self dismissViewControllerAnimated:YES completion:nil];


    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buttonClickChaKanDaTu:(NSInteger)index {
//    TpfCheckBigPictureAndDeletePictureVC *vc = [[TpfCheckBigPictureAndDeletePictureVC alloc] init];
//    vc.arrayUploadImageBean = _arrayDateImageView0;
//    vc.index = index;
//    vc.buttonBackBlock = ^{
//        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
//    };
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark date Picker 取消
- (IBAction)buttonDatePickerQuXiao:(id)sender {
    self.datePickerBg.hidden = YES;
}
#pragma mark date Picker 确定
- (IBAction)buttonDatePickerQueDing:(id)sender {
   NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
   //设置时间格式
   formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *dateStr = [formatter  stringFromDate:self.datePicker.date];
    self.inspectionBean.inspectionDate = dateStr;

    self.datePickerBg.hidden = YES;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark 取消
- (IBAction)buttonQuXiao:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 确定
- (IBAction)buttonQueDing:(id)sender {
    if (self.inspectionBean.supplierManufacturerId.length == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择供应商"];
        return;
    }
    
    _viewLoading.hidden = false;
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    
    for (NSInteger i = 0; i<_arrayDateImageView0.count; i++) {
        OssUploadResBean *model =  _arrayDateImageView0[i];
        [self.inspectionBean setValue:model.mainFileName forKey:[NSString stringWithFormat:@"fileName%ld",i+1]];
        [self.inspectionBean setValue:model.mainFileRealName forKey:[NSString stringWithFormat:@"fileRealName%ld",i+1]];
        [self.inspectionBean setValue:model.mainFolderPath forKey:[NSString stringWithFormat:@"filePath%ld",i+1]];
    }
    
    postEntityBean.entity = self.inspectionBean.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_api_purchaseInspection_addSupplierInspection parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"创建成功"];
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        _viewLoading.hidden = true;
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"接口错误"];
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}



- (void)initRequest:(NSString *)name{
    _viewLoading.hidden = false;
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    postEntityBean.fbToken = [GlobalSettingManager shareGlobalSettingManager].eFeiBiaoToken;
    postEntityBean.entity = @{@"name":name};
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_api_project_tgSupplierList parameters:dic success:^(id responseObjectModel) {
        _viewLoading.hidden = true;
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            self.arrayTgSupplier = [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dicTemp in returnListBean.list) {
//                data: null
//                id: "8a9876f56893a0dd01690e76e9b70b6a"
//                name: "上海智造家"
//                type: null
                
//                @{@"data": ,
//                    @"id": ,
//                  @"name": ,
//                  @"type": ,
//                }
                [self.arrayTgSupplier addObject:dicTemp];
            }
            
            [self.tableViewTgSupplier reloadData];
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
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
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
