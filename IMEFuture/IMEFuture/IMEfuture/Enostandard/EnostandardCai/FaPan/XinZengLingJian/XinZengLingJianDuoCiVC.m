//
//  XinZengLingJianVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/2/26.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "XinZengLingJianDuoCiVC.h"
#import "VoHeader.h"

#import "XinZengLingJianHeader1.h"


#import "XinZengLingJianCVCell.h"
#import "XinZengLingJianFooter.h"


#import "JHCollectionViewFlowLayout.h"

#import "NSString+Utils.h"
#import <AVFoundation/AVFoundation.h>
#import "VoHeader.h"
#import "NSArray+Transition.h"

#import "UIViewXuanZeDanWei.h"
#import "XuanZeYaoQiuDaoHuoRiQiVC.h"

#import "ToolTransition.h"
#import "ShanChuTuPianVC.h"

#import "UploadImageBean.h"


@interface XinZengLingJianDuoCiVC () <UICollectionViewDelegate,UICollectionViewDataSource,JHCollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate>{
    UICollectionView *_collectionView;
    
    UIView *_viewLoading;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (nonatomic,strong) UIImagePickerController *imagePicker;

@property (weak, nonatomic) IBOutlet UILabel *titleName;

@property (weak, nonatomic) IBOutlet UIView *viewZeng;
@property (weak, nonatomic) IBOutlet UIView *viewXiu;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation XinZengLingJianDuoCiVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.viewZeng.hidden = YES;
    self.viewXiu.hidden = YES;
    if (self.isZeng == YES) {
        self.viewZeng.hidden = NO;
        self.titleName.text = @"新增零件";
    } else {
        self.viewXiu.hidden = NO;
        self.titleName.text = @"编辑零件信息";
    }
    [_collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    if (self.inquiryOrderItem) {
        
    } else {
        self.inquiryOrderItem = [[InquiryOrderItem alloc] init];
        self.inquiryOrderItem.quantityUnit = @"件";
        self.inquiryOrderItem.inquiryOrderItemFiles = [NSMutableArray arrayWithCapacity:0];
        
        if ([self.inquiryType isEqualToString:@"FTG"]) {
            self.inquiryOrderItem.isVisiblePrice = [NSNumber numberWithInteger:1];
        }
        self.inquiryOrderItem.partType = self.partType;
        self.inquiryOrderItem.processType = self.processType;
        self.inquiryOrderItem.supplierTaxRate = self.supplierTaxRate;
        
    }
    
    JHCollectionViewFlowLayout *jhFlowLayout = [[JHCollectionViewFlowLayout alloc] init];
//    flowLayout.minimumInteritemSpacing = 0;
//    flowLayout.minimumLineSpacing = 0;

    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _height_NavBar+10, kMainW, kMainH-(_height_NavBar+10+60)) collectionViewLayout:jhFlowLayout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsVerticalScrollIndicator = YES;
    
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
//    [_collectionView registerNib:[UINib nibWithNibName:@"XinZengLingJianDuoCiHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"xinZengLingJianDuoCiHeader"];
    [_collectionView registerNib:[UINib nibWithNibName:@"XinZengLingJianHeader1" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"xinZengLingJianHeader1"];
    [_collectionView registerNib:[UINib nibWithNibName:@"XinZengLingJianCVCell" bundle:nil] forCellWithReuseIdentifier:@"xinZengLingJianCVCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"XinZengLingJianFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"xinZengLingJianFooter"];
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar)];
    _viewLoading.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
}

- (void)keyboardWillChange:(NSNotification *)noti {
    CGRect rect = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (rect.origin.y == kMainH) {
        _collectionView.frame = CGRectMake(0, _height_NavBar+10, kMainW, kMainH-(_height_NavBar+10+60));
    } else {
        _collectionView.frame = CGRectMake(0, _height_NavBar+10, kMainW, kMainH-(_height_NavBar+10+rect.size.height));
    }
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ([self.isPre integerValue] == 0) {
        return CGSizeMake(kMainW, 44*7+76+44*2+30);//宽好像没用
    } else {
        return CGSizeMake(kMainW, 44*8+76+44*2+30);//宽好像没用
    }
//    if ([self.inquiryType isEqualToString:@"FTG"]) {
//        if ([self.isPre integerValue] == 0) {
//            return CGSizeMake(kMainW, 44*7+76+44*2+30);//宽好像没用
//        } else {
//            return CGSizeMake(kMainW, 44*8+76+44*2+30);//宽好像没用
//        }
//    } else {
//        if ([self.isPre integerValue] == 0) {
//            return CGSizeMake(kMainW, 44*8+76+44*2+30);//宽好像没用
//        } else {
//            return CGSizeMake(kMainW, 44*9+76+44*2+30);//宽好像没用
//        }
//    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kMainW, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kMainW-20)/4.0-0.41, (kMainW-20)/4.0-0.41);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 0, 10);//分别为上、左、下、右
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.inquiryOrderItem.inquiryOrderItemFiles.count+1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        XinZengLingJianHeader1 *xinZengLingJianDuoCiHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"xinZengLingJianHeader1" forIndexPath:indexPath];
        
        xinZengLingJianDuoCiHeader.view5.hidden = YES;
        if ([self.isPre integerValue] == 0) {
            xinZengLingJianDuoCiHeader.view1.hidden = YES;
        } else {
            xinZengLingJianDuoCiHeader.view1.hidden = NO;
        }
//        if ([self.inquiryType isEqualToString:@"FTG"]) {
//            xinZengLingJianDuoCiHeader.view5.hidden = YES;
//            if ([self.isPre integerValue] == 0) {
//                xinZengLingJianDuoCiHeader.view1.hidden = YES;
//            } else {
//                xinZengLingJianDuoCiHeader.view1.hidden = NO;
//            }
//        } else {
//            xinZengLingJianDuoCiHeader.view5.hidden = NO;
//            if ([self.isPre integerValue] == 0) {
//                xinZengLingJianDuoCiHeader.view1.hidden = YES;
//            } else {
//                xinZengLingJianDuoCiHeader.view1.hidden = NO;
//            }
//        }
        
        
        [xinZengLingJianDuoCiHeader.textField0 addTarget:self action:@selector(textField0LingJianMingCheng:) forControlEvents:UIControlEventEditingChanged];
        xinZengLingJianDuoCiHeader.textField0.text = self.inquiryOrderItem.partName;
        xinZengLingJianDuoCiHeader.textField0.inputAccessoryView = [self addToolbar];//零件名称
        
        xinZengLingJianDuoCiHeader.textField01.tintColor = [UIColor clearColor];//要求到货日期
        xinZengLingJianDuoCiHeader.textField01.inputView = [UIView new];
        UIImageView *imageView01 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
        xinZengLingJianDuoCiHeader.textField01.rightView = imageView01;
        xinZengLingJianDuoCiHeader.textField01.rightViewMode = UITextFieldViewModeAlways;
        if (self.inquiryOrderItem.batchDeliverNum != nil) {
            xinZengLingJianDuoCiHeader.textField01.text = [NSString stringWithFormat:@"分%ld次到货",(long)[self.inquiryOrderItem.batchDeliverNum integerValue]];
        } else {
            xinZengLingJianDuoCiHeader.textField1.text = nil;
        }
        
        [xinZengLingJianDuoCiHeader.buttonTextField01 addTarget:self action:@selector(textField01YaoQiuDaoHuoRiQi:) forControlEvents:UIControlEventTouchUpInside];
        

        [xinZengLingJianDuoCiHeader.textField1 addTarget:self action:@selector(textField1LingJianShuLiang:) forControlEvents:UIControlEventEditingChanged];
        xinZengLingJianDuoCiHeader.textField1.text = [self.inquiryOrderItem.num1 stringValue];
        xinZengLingJianDuoCiHeader.textField1.inputAccessoryView = [self addToolbar];//零件数量
        xinZengLingJianDuoCiHeader.textField1.delegate = self;
        xinZengLingJianDuoCiHeader.textField1.tag = 10;
        
        xinZengLingJianDuoCiHeader.textField2.tintColor = [UIColor clearColor];//单位
        xinZengLingJianDuoCiHeader.textField2.inputView = [UIView new];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next"]];
        xinZengLingJianDuoCiHeader.textField2.rightView = imageView;
        xinZengLingJianDuoCiHeader.textField2.rightViewMode = UITextFieldViewModeAlways;
        xinZengLingJianDuoCiHeader.textField2.text = [NSString QuantityUnit:self.inquiryOrderItem.quantityUnit];
        [xinZengLingJianDuoCiHeader.buttonTextField2 addTarget:self action:@selector(buttonTextField2DanWei:) forControlEvents:UIControlEventTouchUpInside];
        
        [xinZengLingJianDuoCiHeader.textField3 addTarget:self action:@selector(textField3MuBiaoJia:) forControlEvents:UIControlEventEditingChanged];
        if (self.inquiryOrderItem.price1) {
            xinZengLingJianDuoCiHeader.textField3.text = [self.inquiryOrderItem.price1 stringValue];
        } else {
            xinZengLingJianDuoCiHeader.textField3.text = nil;
        }
        xinZengLingJianDuoCiHeader.textField3.inputAccessoryView = [self addToolbar];//未税核算价
        if ([self.inquiryType isEqualToString:@"FTG"]) {
            xinZengLingJianDuoCiHeader.textField3.placeholder = @"请输入，必填项";
        } else {
            xinZengLingJianDuoCiHeader.textField3.placeholder = @"请输入";
        }
        
        if ([self.inquiryOrderItem.isVisiblePrice integerValue] == 0) {
            xinZengLingJianDuoCiHeader.switch3.on = NO;
        } else if ([self.inquiryOrderItem.isVisiblePrice integerValue] == 1) {//目标价供应商可见
            xinZengLingJianDuoCiHeader.switch3.on = YES;
        }
        if ([self.inquiryType isEqualToString:@"FTG"]) {
            xinZengLingJianDuoCiHeader.switch3.enabled = NO;
        } else {
            xinZengLingJianDuoCiHeader.switch3.enabled = YES;
        }
        [xinZengLingJianDuoCiHeader.switch3 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        
        [xinZengLingJianDuoCiHeader.textField51 addTarget:self action:@selector(textField51lingjianhao:) forControlEvents:UIControlEventEditingChanged];
        xinZengLingJianDuoCiHeader.textField51.text = self.inquiryOrderItem.partNumber;//零件号/规格
        xinZengLingJianDuoCiHeader.textField51.inputAccessoryView = [self addToolbar];
        
        [xinZengLingJianDuoCiHeader.textField52 addTarget:self action:@selector(textField52lingjianbanben:) forControlEvents:UIControlEventEditingChanged];
        xinZengLingJianDuoCiHeader.textField52.text = self.inquiryOrderItem.ownProjectName;//所属项目
        xinZengLingJianDuoCiHeader.textField52.inputAccessoryView = [self addToolbar];
        
        [xinZengLingJianDuoCiHeader.textField7 addTarget:self action:@selector(textField7WuLiaoHao:) forControlEvents:UIControlEventEditingChanged];
        xinZengLingJianDuoCiHeader.textField7.text = self.inquiryOrderItem.materialNumber;//物料号
        xinZengLingJianDuoCiHeader.textField7.delegate = self;
        xinZengLingJianDuoCiHeader.textField7.tag = 11;
        xinZengLingJianDuoCiHeader.textField7.inputAccessoryView = [self addToolbar];
        
        for (UIView *view in xinZengLingJianDuoCiHeader.textView8.subviews) {
            if (view.tag == 20180206) {
                [view removeFromSuperview];
            }
        }
        
        // placeholder
        UILabel *label = [UILabel new];
        label.font = xinZengLingJianDuoCiHeader.textView8.font;
        label.text = @"请填写零件描述";
        label.numberOfLines = 0;
        label.textColor = [UIColor lightGrayColor];
        [label sizeToFit];
        label.tag = 20180206;
        [xinZengLingJianDuoCiHeader.textView8 addSubview:label];
        // kvc
        [xinZengLingJianDuoCiHeader.textView8 setValue:label forKey:@"_placeholderLabel"];
        
        xinZengLingJianDuoCiHeader.textView8.delegate = self;
        xinZengLingJianDuoCiHeader.textView8.text = self.inquiryOrderItem.detail;
        xinZengLingJianDuoCiHeader.textView8.inputAccessoryView = [self addToolbar];
        
    
        [xinZengLingJianDuoCiHeader.textField9 addTarget:self action:@selector(textField9GuiGe:) forControlEvents:UIControlEventEditingChanged];
        xinZengLingJianDuoCiHeader.textField9.text = self.inquiryOrderItem.specifications;
        xinZengLingJianDuoCiHeader.textField9.inputAccessoryView = [self addToolbar];
        
        [xinZengLingJianDuoCiHeader.textField10 addTarget:self action:@selector(textField10PingPai:) forControlEvents:UIControlEventEditingChanged];
        xinZengLingJianDuoCiHeader.textField10.text = self.inquiryOrderItem.brand;
        xinZengLingJianDuoCiHeader.textField10.inputAccessoryView = [self addToolbar];

        
        return xinZengLingJianDuoCiHeader;
    } else if ([kind isEqualToString:@"UICollectionElementKindSectionFooter"]) {
        XinZengLingJianFooter *xinZengLingJianFooter = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"xinZengLingJianFooter" forIndexPath:indexPath];
        return xinZengLingJianFooter;
    } else {
        return nil;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XinZengLingJianCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"xinZengLingJianCVCell" forIndexPath:indexPath];

    if (indexPath.row == self.inquiryOrderItem.inquiryOrderItemFiles.count) {
        cell.imageView1.image = [UIImage imageNamed:@"add"];
    } else {
        InquiryOrderItemFile *inquiryOrderItemFile = self.inquiryOrderItem.inquiryOrderItemFiles[indexPath.row];
        [cell.imageView1 sd_setImageWithURL:[NSURL URLWithString:inquiryOrderItemFile.sec_thumbnailUrl] placeholderImage:nil];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"最多上传一张图片"];
        return;
    }
    //新增图纸
    if (indexPath.row == self.inquiryOrderItem.inquiryOrderItemFiles.count) {
        [self addImage];
    } else {
        ShanChuTuPianVC *shanChuTuPianVC = [[ShanChuTuPianVC alloc] init];
        shanChuTuPianVC.inquiryOrderItem = self.inquiryOrderItem;
        shanChuTuPianVC.index = indexPath.row;
        shanChuTuPianVC.buttonBackBlock = ^(InquiryOrderItem *inquiryOrderItem) {
            self.inquiryOrderItem = inquiryOrderItem;
        };
        [self.navigationController pushViewController:shanChuTuPianVC animated:YES];
    }
}

#pragma mark - JHCollectionViewDelegateFlowLayout
- (UIColor *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout backgroundColorForSection:(NSInteger)section
{
    return [@[
              [UIColor whiteColor]
              ] objectAtIndex:section];
}

#pragma mark 零件名称
- (void)textField0LingJianMingCheng:(UITextField *)sender {
    self.inquiryOrderItem.partName = sender.text;
}

#pragma mark 要求到货日期
- (void)textField01YaoQiuDaoHuoRiQi:(UIButton *)sender {

    NSLog(@"%s",__FUNCTION__);
    
    XuanZeYaoQiuDaoHuoRiQiVC *xuanZeYaoQiuDaoHuoRiQiVC = [[XuanZeYaoQiuDaoHuoRiQiVC alloc] init];
    if (self.inquiryOrderItem.sec_batchDeliverItem.count > 0) {
        xuanZeYaoQiuDaoHuoRiQiVC.arrayBatchDeliverItem = self.inquiryOrderItem.sec_batchDeliverItem;
    }
//    if (self.inquiryOrderItem.batchDeliverItem != nil) {
//        NSMutableArray *array = (NSMutableArray *)[ToolTransition arrayFromString:self.inquiryOrderItem.batchDeliverItem];
//        xuanZeYaoQiuDaoHuoRiQiVC.arrayBatchDeliverItem = array;
//    }
    xuanZeYaoQiuDaoHuoRiQiVC.buttonBackBlock = ^(NSMutableArray *arrayBatchDeliverItem) {
        
        double num = 0;
        NSString *deliveryTime;
        for (BatchDeliverItem *deliverItem in arrayBatchDeliverItem) {
            num = num + [deliverItem.num doubleValue];
            deliveryTime = deliverItem.deliverTm;
        }
        
        self.inquiryOrderItem.batchDeliverNum = [NSNumber numberWithInteger:arrayBatchDeliverItem.count];
        
//        NSString *batchDeliverItem = [ToolTransition stringFromArray:arrayBatchDeliverItem];
//
//        self.inquiryOrderItem.batchDeliverItem = batchDeliverItem;
        
        self.inquiryOrderItem.sec_batchDeliverItem = arrayBatchDeliverItem;
        
        self.inquiryOrderItem.num1 = [NSNumber numberWithDouble:num];
        self.inquiryOrderItem.deliveryTime = deliveryTime;
        
        NSLog(@">%@>>>>%@",self.inquiryOrderItem.batchDeliverNum,self.inquiryOrderItem.batchDeliverItem);
        
        [_collectionView reloadData];
    };
    [self.navigationController pushViewController:xuanZeYaoQiuDaoHuoRiQiVC animated:YES];
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

#pragma mark 零件数量
- (void)textField1LingJianShuLiang:(UITextField *)sender {
    
    self.inquiryOrderItem.num1 = [NSNumber numberWithDouble:[sender.text doubleValue]];
}

#pragma mark 单位
- (void)buttonTextField2DanWei:(UIButton *)sender {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UIViewXuanZeDanWei" owner:self options:nil];
    UIViewXuanZeDanWei *viewXZHYFS = [nib objectAtIndex:0];
    viewXZHYFS.frame = CGRectMake(0, 0, kMainW, kMainH);
    [self.view addSubview:viewXZHYFS];
    viewXZHYFS.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [viewXZHYFS initPickerViewButtonClick:^(NSString *string) {
        NSLog(@"%@",string);
        self.inquiryOrderItem.quantityUnit = string;
        [_collectionView reloadData];
    } buttonQuXiao:^{
        [sender resignFirstResponder];
    }];
    
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];//让键盘下去
}

#pragma mark 目标价(单价)
- (void)textField3MuBiaoJia:(UITextField *)sender {
    self.inquiryOrderItem.price1 = [NSNumber numberWithDouble:[sender.text doubleValue]];
}

#pragma mark 目标价供应商可见
- (void)switchAction:(UISwitch *)sender {
    BOOL isButtonOn = [sender isOn];
    if (isButtonOn) {
        self.inquiryOrderItem.isVisiblePrice = [NSNumber numberWithInteger:1];
    } else {
        self.inquiryOrderItem.isVisiblePrice = [NSNumber numberWithInteger:0];
    }
}

#pragma mark 零件号
- (void)textField51lingjianhao:(UITextField *)sender {
    self.inquiryOrderItem.partNumber = sender.text;
}

#pragma mark 所属项目
- (void)textField52lingjianbanben:(UITextField *)sender {
    self.inquiryOrderItem.ownProjectName = sender.text;
}
#pragma mark 物料号
- (void)textField7WuLiaoHao:(UITextField *)sender {
    
    self.inquiryOrderItem.materialNumber = sender.text;
}
#pragma mark UITextFieldDelegate
//键盘只能输入@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag == 10) {//零件数量
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@".1234567890"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    } else if (textField.tag == 11) {//物料号
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
    } else {
        return NO;
    }
    
}

#pragma mark 规格
- (void)textField9GuiGe:(UITextField *)sender {
    self.inquiryOrderItem.specifications = sender.text;
}

#pragma mark 品牌
- (void)textField10PingPai:(UITextField *)sender {
    self.inquiryOrderItem.brand = sender.text;
}

#pragma mark 零件描述
- (void)textViewDidChange:(UITextView *)textView {
    self.inquiryOrderItem.detail = textView.text;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [_collectionView setContentOffset:CGPointMake(0, 30)];
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [_collectionView setContentOffset:CGPointMake(0, 0)];
}

- (void)addImage {
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
    
    [HttpMamager postRequestImageWithURLString:DYZ_efeibiao_uploadfile_upload parameters:dic UploadImageBean:@[uploadImageBean] success:^(id responseObjectModel) {
        _viewLoading.hidden = YES;
        
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            
            NSArray *array = [NSArray stringToJSON:returnMsgBean.returnMsg];
            NSDictionary *dic = array[0];
            UploadFile *uploadFile = [UploadFile mj_objectWithKeyValues:dic];
            
            InquiryOrderItemFile *inquiryOrderItemFile = [[InquiryOrderItemFile alloc] init];

            inquiryOrderItemFile.sec_thumbnailUrl = uploadFile.thumbnailUrl;
            
            inquiryOrderItemFile.file = uploadFile;
            
            [self.inquiryOrderItem.inquiryOrderItemFiles addObject:inquiryOrderItemFile];
            
            [_collectionView reloadData];
        } else {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
        }
        
    } progress:^(NSProgress *progress) {
           
    } fail:^(NSError *error) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"上传失败"];
    } isKindOfModelClass:NSClassFromString(@"ReturnMsgBean")];
    [self dismissViewControllerAnimated:YES completion:nil];
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

#pragma mark 保存
- (IBAction)buttonBaoCun:(UIButton *)sender {
    if (!(self.inquiryOrderItem.partName.length > 0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入零件名称"];
        return;
    }
    if ([self.isPre integerValue] == 1) {
        if (!(self.inquiryOrderItem.sec_batchDeliverItem.count > 0)) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择要求到货日期"];
            return;
        }
    }
    if (!([self.inquiryOrderItem.num1 doubleValue] > 0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入零件数量"];
        return;
    }
    if (!(self.inquiryOrderItem.quantityUnit.length > 0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择单位"];
        return;
    }
    if ([self.inquiryType isEqualToString:@"FTG"]) {
        if (!([self.inquiryOrderItem.price1 doubleValue] > 0)) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入目标价"];
            return;
        }
    }
    if (!(self.inquiryOrderItem.partNumber.length > 0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入零件号规格"];
        return;
    }
    if (!(self.inquiryOrderItem.materialNumber.length > 0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入物料号"];
        return;
    }
    self.buttonBackBlock(self.inquiryOrderItem);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark 保存并继续添加
- (IBAction)buttonBaoCunAndTianJia:(UIButton *)sender {
    NSLog(@"%s",__FUNCTION__);
    //-------保存------
    if (!(self.inquiryOrderItem.partName.length > 0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入零件名称"];
        return;
    }
    if (!([self.inquiryOrderItem.num1 doubleValue] > 0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入零件数量"];
        return;
    }
    if (!(self.inquiryOrderItem.quantityUnit.length > 0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请选择单位"];
        return;
    }
    if ([self.inquiryType isEqualToString:@"FTG"]) {
        if (!([self.inquiryOrderItem.price1 doubleValue] > 0)) {
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入目标价"];
            return;
        }
    }
    if (!(self.inquiryOrderItem.partNumber.length > 0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入零件号规格"];
        return;
    }
    if (!(self.inquiryOrderItem.materialNumber.length > 0)) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"请输入物料号"];
        return;
    }
    self.buttonBackBlock(self.inquiryOrderItem);
    [self.navigationController popViewControllerAnimated:YES];
    //-------保存------
    
    self.buttonBaoCunBingJiXuTianJiaBlock(self.inquiryOrderItem);
    
    
}

#pragma mark 删除
- (IBAction)buttonShangChu:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"是否删除当前零件？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.buttonShanChuBlock(self.inquiryOrderItem);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alertController addAction:action];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (IBAction)back:(id)sender {
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
