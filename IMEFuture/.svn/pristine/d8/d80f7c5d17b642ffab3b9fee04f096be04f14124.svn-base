//
//  PartDetailsViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/12/12.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "PartDetailsViewController.h"
#import "VoHeader.h"


#import "PartDetailsCell0.h"
#import "LingJianXiangQingViewController2.h"
#import "NSArray+Transition.h"

@interface PartDetailsViewController () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    NSArray *_arrayButton;
    UITableView *_tableView0;
    UICollectionView *_collertionView;
    
    NSArray *_arrayDatalist00;
    NSArray *_arrayDatalist01;
    NSMutableArray <__kindof InquiryOrderItemFile *>*_arrayInquiryOrderItemFile;
    
    NSMutableArray <__kindof AccDrawingInter *> *_arrayAccDrawingInter;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UIButton *button0;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation PartDetailsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_button0 setTitleColor:colorCai forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [self initUI];
    
    [self initDatalist01];
    
    [self initArrayInquiryOrderItemFile];
    
    
}

- (void)initUI {
    _arrayButton = @[_button0];
    for (int i = 0; i < _arrayButton.count; i++) {
        UIButton *button = _arrayButton[i];
        button.tag = 100+i;
    }

    _arrayDatalist00 = @[@"  零件号/规格：",@"  零件名：",@"  物料号：",@"  品牌：",@"  材质：",@"  数量：",@"  交货日期：",@"  物料描述："];
    
    self.scrollView.tag = 500;
    self.scrollView.contentSize = CGSizeMake(kMainW*_arrayButton.count, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = NO;
    self.scrollView.backgroundColor = colorRGB(241, 241, 241);
    
    _tableView0 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainH-_height_NavBar-40-10) style:UITableViewStylePlain];
    _tableView0.delegate = self;
    _tableView0.dataSource = self;
    _tableView0.tag = 200;
    _tableView0.backgroundColor = [UIColor clearColor];
    [_tableView0 registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView0 registerNib:[UINib nibWithNibName:@"PartDetailsCell0" bundle:nil] forCellReuseIdentifier:@"partDetailsCell0"];
    _tableView0.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView0.tableFooterView = [UIView new];
    [self.scrollView addSubview:_tableView0];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;//最小X间距
    flowLayout.minimumLineSpacing = 0;//最小Y间距
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collertionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kMainW, kMainW/2) collectionViewLayout:flowLayout];
    _collertionView.delegate = self;
    _collertionView.dataSource = self;
    _collertionView.tag = 201;
    _collertionView.backgroundColor = [UIColor whiteColor];
    [_collertionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
//    [self.scrollView addSubview:_collertionView];
    
}

- (void)initDatalist01 {
    //材质
    NSString *string1 = self.inquiryOrderItem.materialName2.length>0?self.inquiryOrderItem.materialName2:@"--";
    NSArray *arrayTags = [self.inquiryOrderItem.tags componentsSeparatedByString:@"."];
    NSMutableArray *arrayTags1 = [[NSMutableArray alloc] initWithCapacity:0];
    for (NSString *string in arrayTags) {
        if (![string isEqualToString:@""]) {
            [arrayTags1 addObject:string];
        }
    }
    //零件工艺
    NSString *stringTag;
    for (int i = 0; i < arrayTags1.count; i++) {
        if (i == 0) {
            stringTag = arrayTags1[i];
        } else {
            stringTag = [NSString stringWithFormat:@"%@、%@",stringTag,arrayTags1[i]];
        }
    }
    NSString *string2 = [NSString stringWithFormat:@"%@",stringTag.length != 0?stringTag:@"详见图纸"];
    //尺寸
    NSString *string3;
    if ([NSString SizeUnit:self.inquiryOrderItem.sizeUnit]) {
        string3 = [NSString stringWithFormat:@"长 %.2f * 宽 %.2f * 高 %.2f %@",[self.inquiryOrderItem.length doubleValue],[self.inquiryOrderItem.width doubleValue],[self.inquiryOrderItem.height doubleValue],[NSString SizeUnit:self.inquiryOrderItem.sizeUnit]];
    } else {
        string3 = @"--";
    }
    //单零件净重
    NSString *string4 = self.inquiryOrderItem.suttle?[NSString stringWithFormat:@"%.2fkg",[self.inquiryOrderItem.suttle doubleValue]]:@"--";
    //采购数量
    NSString *string5;
    string5 = [NSString stringWithFormat:@"%@%@",self.inquiryOrderItem.num1,[NSString QuantityUnit:self.inquiryOrderItem.quantityUnit].length>0?[NSString QuantityUnit:self.inquiryOrderItem.quantityUnit]:@""];
    
    NSString *string6 = self.inquiryOrderItem.purchaseNum?[NSString stringWithFormat:@"%@%@",self.inquiryOrderItem.purchaseNum,[NSString QuantityUnit:self.inquiryOrderItem.quantityUnit].length>0?[NSString QuantityUnit:self.inquiryOrderItem.quantityUnit]:@""]:@"--";
    //零件描述
    NSString *string7 = self.inquiryOrderItem.detail.length>0?self.inquiryOrderItem.detail:@"--";

    //目标价 （授盘价）
    NSString *string8 = [self.inquiryOrderItem.price1 stringValue].length != 0?[self.inquiryOrderItem.price1 stringValue]:@"--";
    //物料号
    NSString *string9 = self.inquiryOrderItem.materialNumber.length != 0?self.inquiryOrderItem.materialNumber:@"--";
    //规格
    NSString *string10 = self.inquiryOrderItem.specifications.length != 0?self.inquiryOrderItem.specifications:@"--";
    //品牌
    NSString *string11 = self.inquiryOrderItem.brand.length != 0?self.inquiryOrderItem.brand:@"--";
    //图号
    NSString *stirng12 = self.inquiryOrderItem.figureNo.length != 0 ?self.inquiryOrderItem.figureNo:@"--";
    //所属项目
    NSString *stirng13 = self.inquiryOrderItem.ownProjectName.length != 0?self.inquiryOrderItem.ownProjectName:@"--";
    //零件号
    NSString *string14 = self.inquiryOrderItem.partNumber.length != 0?self.inquiryOrderItem.partNumber:@"--";
    //要求到货时间
    NSString *batchDeliverItem = self.inquiryOrderItem.deliveryTime.length != 0?self.inquiryOrderItem.deliveryTime:@"--";
    
    //材质牌号
    NSString *materialNo = self.inquiryOrderItem.materialNo.length>0?self.inquiryOrderItem.materialNo:@"--";
    
    //零件名
    NSString *partName = self.inquiryOrderItem.partName.length>0?self.inquiryOrderItem.partName:@"--";
    
    //物料描述
    NSString *materialDescription = self.inquiryOrderItem.materialDescription.length>0?self.inquiryOrderItem.materialDescription:@"--";
    _arrayDatalist01 = @[[NSString stringWithFormat:@"%@/%@",string14,string10],partName,string9,string11,string1,string5,batchDeliverItem,materialDescription];
}

- (void)initArrayInquiryOrderItemFile {
    if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
        _arrayInquiryOrderItemFile = [[NSMutableArray alloc] initWithCapacity:0];
        for (InquiryOrderItemFile *inquiryOrderItemFile in self.inquiryOrderItem.inquiryOrderItemFiles) {
            if (![inquiryOrderItemFile.sec_thumbnailUrl containsString:@".pdf"]) {
                [_arrayInquiryOrderItemFile addObject:inquiryOrderItemFile];
            }
        }
    }
    if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 1) {
        
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        
        PurchaseProjectInfo *purchaseProjectInfo = [[PurchaseProjectInfo alloc] init];
        
    
        purchaseProjectInfo.sec_enterpriseId = self.enterpriseId;
        purchaseProjectInfo.partNumber = self.inquiryOrderItem.partNumber;
        purchaseProjectInfo.picVersion = self.inquiryOrderItem.picVersion;
        
        postEntityBean.entity = purchaseProjectInfo.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_purchaseProject_queryDrawingLibrariesInfo parameters:dic success:^(id responseObjectModel) {
            
            ReturnEntityBean *model = responseObjectModel;
            
            if ([model.status isEqualToString:@"SUCCESS"]) {
                
                PurchaseProjectInfo *purchaseProjectInfo = [PurchaseProjectInfo mj_objectWithKeyValues:model.entity];
                
                AccVersionInter *accVersionInter = purchaseProjectInfo.sec_foundVersion;
                
                _arrayAccDrawingInter = [[NSMutableArray alloc] initWithCapacity:0];
                
                for (AccDrawingInter *acc in accVersionInter.drawings) {
                    if (![acc.previewUrl containsString:@".pdf"]) {
                        [_arrayAccDrawingInter addObject:acc];
                    }
                }
                
                [_collertionView reloadData];
                [_tableView0 reloadData];
                
            }
            
        } fail:^(NSError *error) {
            
        } isKindOfModel:NSClassFromString(@"ReturnEntityBean")];
    }
 
}

- (IBAction)buttonClick:(UIButton *)sender {
    self.indexNum = sender.tag - 100;
    for (int i = 0; i < _arrayButton.count; i++) {
        UIButton *but = _arrayButton[i];
        if ((sender.tag-100) == i) {
            [but setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
        } else {
            [but setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
        }
    }
    [self.scrollView setContentOffset:CGPointMake((sender.tag-100)*kMainW, 0)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == 201) {
                [view removeFromSuperview];
            }
        }
        
        if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
            if (_arrayInquiryOrderItemFile.count > 0) {
                [cell.contentView addSubview:_collertionView];
            }
        }
        if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 1) {
            if (_arrayAccDrawingInter.count > 0) {
                [cell.contentView addSubview:_collertionView];
            }
        }
        
        return cell;
    } else if (indexPath.section == 1) {
        PartDetailsCell0 *cell = [tableView dequeueReusableCellWithIdentifier:@"partDetailsCell0" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.viewLineTop.hidden = YES;
        if (indexPath.row == 0) {
            cell.viewLineTop.hidden = NO;
        }
        if (indexPath.row != _arrayDatalist00.count-1) {
            cell.viewLineBottomConstraint.constant = 8;
        } else {
            cell.viewLineBottomConstraint.constant = 0;
        }
        
        cell.label0.text = _arrayDatalist00[indexPath.row];
        cell.label1.text = _arrayDatalist01[indexPath.row];
        return cell;
    } else {
        return nil;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return _arrayDatalist00.count;
    } else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
    
        if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
            if (_arrayInquiryOrderItemFile.count > 0) {
                return kMainW/2.0;
            }
        }
        if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 1) {
            if (_arrayAccDrawingInter.count > 0) {
                return kMainW/2.0;
            }
        }
        return 0;
    } else if (indexPath.section == 1) {
        CGSize size = [_arrayDatalist01[indexPath.row] boundingRectWithSize:CGSizeMake(kMainW-110-10, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        if ((size.height + 10) >= 45) {
            return size.height + 10;
        } else {
            return 45;
        }
    } else {
        return 0;
    }
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    for (UIView *view in cell.contentView.subviews) {
        if (view.tag == 1) {
            [view removeFromSuperview];
        }
    }
    
    UIImageView *imageViewD = [[UIImageView alloc] initWithFrame:CGRectMake(7.5, 7.5, (kMainW-30)/2/7*8, (kMainW-30)/2)];
    
    if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
        if ([_arrayInquiryOrderItemFile[indexPath.row].sec_thumbnailUrl containsString:@".dwg"] ) {
            imageViewD.image = [UIImage imageNamed:@"picture_dwg"];
        } else if ([_arrayInquiryOrderItemFile[indexPath.row].sec_thumbnailUrl containsString:@".png"] || [_arrayInquiryOrderItemFile[indexPath.row].sec_thumbnailUrl containsString:@".jpg"] || [_arrayInquiryOrderItemFile[indexPath.row].sec_thumbnailUrl containsString:@".gif"] || [_arrayInquiryOrderItemFile[indexPath.row].sec_thumbnailUrl containsString:@".jpeg"]) {
            NSLog(@">>>%@",_arrayInquiryOrderItemFile[indexPath.row].sec_thumbnailUrl);
            
            [imageViewD sd_setImageWithURL:[NSURL URLWithString:_arrayInquiryOrderItemFile[indexPath.row].sec_thumbnailUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
        } else {
            imageViewD.image = [UIImage imageNamed:@"img_picture_conversion"];
        }
    }
    
    if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 1) {
        if ([_arrayAccDrawingInter[indexPath.row].previewUrl containsString:@".dwg"] ) {
            imageViewD.image = [UIImage imageNamed:@"picture_dwg"];
        } else if ([_arrayAccDrawingInter[indexPath.row].previewUrl containsString:@".png"] || [_arrayAccDrawingInter[indexPath.row].previewUrl containsString:@".jpg"] || [_arrayAccDrawingInter[indexPath.row].previewUrl containsString:@".gif"] || [_arrayAccDrawingInter[indexPath.row].previewUrl containsString:@".jpeg"]) {
            [imageViewD sd_setImageWithURL:[NSURL URLWithString:_arrayAccDrawingInter[indexPath.row].previewUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
        } else {
            imageViewD.image = [UIImage imageNamed:@"img_picture_conversion"];
        }
    }
    
    
    
    [cell.contentView addSubview:imageViewD];
    imageViewD.tag = 1;
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
        return _arrayInquiryOrderItemFile.count;
    }
    if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 1) {
        return _arrayAccDrawingInter.count;
    }
    return 0;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *array;
    if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
        array = _arrayInquiryOrderItemFile;
    }
    if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 1) {
        array = _arrayAccDrawingInter;
    }
    
    NSLog(@">>>%ld<",_arrayAccDrawingInter.count);
    return CGSizeMake(kMainW/2/7*8, kMainW/2);
//    if (array.count%2 == 0) {
//        return CGSizeMake(kMainW/2, kMainW/2);
//    } else {
//        if (indexPath.row == array.count - 1) {
//            return CGSizeMake(kMainW, kMainW/2);
//        } else {
//            return CGSizeMake(kMainW/2, kMainW/2);
//        }
//    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 0) {
        LingJianXiangQingViewController2 *lingJianXiangQingViewController2 = [[LingJianXiangQingViewController2 alloc] init];
        lingJianXiangQingViewController2.isMatchDrawingCloud = [NSNumber numberWithInteger:0];
        lingJianXiangQingViewController2.inquiryOrderItemFile = _arrayInquiryOrderItemFile[indexPath.row];
        [self.navigationController pushViewController:lingJianXiangQingViewController2 animated:YES];
    }
    if ([self.inquiryOrderItem.isMatchDrawingCloud integerValue] == 1) {
        LingJianXiangQingViewController2 *lingJianXiangQingViewController2 = [[LingJianXiangQingViewController2 alloc] init];
        lingJianXiangQingViewController2.isMatchDrawingCloud = [NSNumber numberWithInteger:1];
        lingJianXiangQingViewController2.accDrawingInter = _arrayAccDrawingInter[indexPath.row];
        [self.navigationController pushViewController:lingJianXiangQingViewController2 animated:YES];
    }
    
}

- (IBAction)back:(UIButton *)sender {
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
