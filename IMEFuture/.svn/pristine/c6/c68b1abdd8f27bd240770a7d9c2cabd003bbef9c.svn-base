//
//  PartDetailsViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/12/12.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "PartDetailsDingDanViewController.h"
#import "VoHeader.h"


#import "PartDetailsCell0.h"
#import "LingJianXiangQingDingDanViewController2.h"
#import "ShengChangJinDuTableViewCell.h"
#import "ShengChangJinDuTableViewCell2.h"
#import "NSArray+Transition.h"

@interface PartDetailsDingDanViewController () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    NSArray *_arrayButton;
    UITableView *_tableView0;
    UICollectionView *_collertionView;
    UITableView *_tableView2;
    
    NSArray *_arrayDatalist00;
    NSArray *_arrayDatalist01;
    NSMutableArray <__kindof TradeOrderItemFile *>*_arrayTradeOrderItemFile;
    
    NSMutableArray <__kindof AccDrawingInter *> *_arrayAccDrawingInter;
    
    NSMutableArray *_arrayYesOpen;
    ProductionOrderInfoForShow *_productionOrderInfoForShow;
    
    UILabel *_viewProductionOrder;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UIButton *button0;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation PartDetailsDingDanViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.isHaveDanTouMingGongChang isEqualToString:@"yes"]) {
        self.button1.hidden = NO;;
    } else {
        self.button1.hidden = YES;
    }
    if (self.indexNum||self.indexNum==0) {
        for (int i = 0; i < _arrayButton.count; i++) {
            UIButton *but = _arrayButton[i];
            if (self.indexNum == i) {
                [but setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
            } else {
                [but setTitleColor:colorRGB(117, 117, 117) forState:UIControlStateNormal];
            }
        }
        [self.scrollView setContentOffset:CGPointMake(self.indexNum*kMainW, 0)];
    } else {
        UIButton *button = [_arrayButton firstObject];
        [button setTitleColor:colorRGB(255, 132, 0) forState:UIControlStateNormal];
    }
    
    _viewProductionOrder.hidden = YES;
    if (_productionOrderInfoForShow.productionConfirmInfoForShowList.count == 0) {
        _viewProductionOrder.hidden = NO;
        _tableView2.scrollEnabled = NO;
    } else {
        _viewProductionOrder.hidden = YES;
        _tableView2.scrollEnabled = YES;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [self initUI];
    
    [self initDatalist01];
    
    [self initArrayTradeOrderItemFile];
}

- (void)initUI {
    _arrayButton = @[_button0,_button1];
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
    
    
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(kMainW*1, 0, kMainW, kMainH-_height_NavBar-40-10) style:UITableViewStylePlain];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView2.tag = 202;
    _tableView2.backgroundColor = [UIColor clearColor];
    [_tableView2 registerNib:[UINib nibWithNibName:@"ShengChangJinDuTableViewCell" bundle:nil] forCellReuseIdentifier:@"shengChangJinDuTableViewCell"];
    [_tableView2 registerNib:[UINib nibWithNibName:@"ShengChangJinDuTableViewCell2" bundle:nil] forCellReuseIdentifier:@"shengChangJinDuTableViewCell2"];
    [self initTableHeaderView];
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView2.tableFooterView = [UIView new];
    [self.scrollView addSubview:_tableView2];
    
    
    _viewProductionOrder = [[UILabel alloc] initWithFrame:CGRectMake(kMainW*1, 68, kMainW, 200)];
    _viewProductionOrder.backgroundColor = [UIColor whiteColor];
    _viewProductionOrder.text = @"暂无安排生产";
    _viewProductionOrder.textColor = colorRGB(117, 117, 117);
    _viewProductionOrder.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:_viewProductionOrder];

}

- (void)initDatalist01 {
    NSString *string0 = (self.tradeOrderItem.insideCode&&![self.tradeOrderItem.insideCode isEqualToString:@""])?self.tradeOrderItem.insideCode:@"--";;
    NSString *string1 = self.tradeOrderItem.materialName2.length>0?self.tradeOrderItem.materialName2:@"--";
    NSArray *arrayTags = [self.tradeOrderItem.tags componentsSeparatedByString:@"."];
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
    if ([NSString SizeUnit:self.tradeOrderItem.sizeUnit]) {
        string3 = [NSString stringWithFormat:@"长 %.2f * 宽 %.2f * 高 %.2f %@",[self.tradeOrderItem.length doubleValue],[self.tradeOrderItem.width doubleValue],[self.tradeOrderItem.height doubleValue],[NSString SizeUnit:self.tradeOrderItem.sizeUnit]];
    } else {
        string3 = @"--";
    }
    //单零件净重
    NSString *string4 = self.tradeOrderItem.suttle?[NSString stringWithFormat:@"%.2fkg",[self.tradeOrderItem.suttle doubleValue]]:@"--";
    //采购数量
    NSString *string5 = [NSString stringWithFormat:@"%ld%@",[self.tradeOrderItem.num integerValue],[NSString QuantityUnit:self.tradeOrderItem.quantityUnit].length>0?[NSString QuantityUnit:self.tradeOrderItem.quantityUnit]:@""];
    
    NSString *string6 = self.tradeOrderItem.purchaseNum?[NSString stringWithFormat:@"%@%@",self.tradeOrderItem.purchaseNum,[NSString QuantityUnit:self.tradeOrderItem.quantityUnit].length>0?[NSString QuantityUnit:self.tradeOrderItem.quantityUnit]:@""]:@"--";
    //零件描述
    NSString *string7 = (self.tradeOrderItem.detail&&![self.tradeOrderItem.detail isEqualToString:@""])?self.tradeOrderItem.detail:@"--";
    //物料号
    NSString *string9 = self.tradeOrderItem.materialNumber.length != 0?self.tradeOrderItem.materialNumber:@"--";
    //规格
    NSString *string10 = self.tradeOrderItem.specifications.length != 0?self.tradeOrderItem.specifications:@"--";
    //品牌
    NSString *string11 = self.tradeOrderItem.brand.length != 0?self.tradeOrderItem.brand:@"--";
    //图号
    NSString *stirng12 = self.tradeOrderItem.figureNo.length != 0?self.tradeOrderItem.figureNo:@"--";
    //所属项目
    NSString *stirng13 = self.tradeOrderItem.ownProjectName.length != 0?self.tradeOrderItem.ownProjectName:@"--";
    //零件号
    NSString *string14 = self.tradeOrderItem.partNumber.length != 0?self.tradeOrderItem.partNumber:@"--";
    //要求到货时间
    NSString *batchDeliverItem = self.tradeOrderItem.deliveryTime != 0?self.tradeOrderItem.deliveryTime:@"--";
    
    //零件名
    NSString *partName = self.tradeOrderItem.partName.length>0?self.tradeOrderItem.partName:@"--";
    
    //物料描述
    NSString *materialDescription = self.tradeOrderItem.materialDescription.length>0?self.tradeOrderItem.materialDescription:@"--";
    _arrayDatalist01 = @[[NSString stringWithFormat:@"%@/%@",string14,string10],partName,string9,string11,string1,string5,batchDeliverItem,materialDescription];
    
}

- (void)initArrayTradeOrderItemFile {
    if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 0) {
        _arrayTradeOrderItemFile = [[NSMutableArray alloc] initWithCapacity:0];
        for (TradeOrderItemFile *tradeOrderItemFile in self.tradeOrderItem.tradeOrderItemFiles) {
            NSLog(@"%@",tradeOrderItemFile.thumbnailUrl);
            if (![tradeOrderItemFile.thumbnailUrl containsString:@".pdf"]) {
                [_arrayTradeOrderItemFile addObject:tradeOrderItemFile];
            }
        }
    }
    if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 1) {
        EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
        
        PurchaseProjectInfo *purchaseProjectInfo = [[PurchaseProjectInfo alloc] init];
        
        
        purchaseProjectInfo.sec_enterpriseId = self.enterpriseId;
        
        purchaseProjectInfo.partNumber = self.tradeOrderItem.partNumber;
        purchaseProjectInfo.picVersion = self.tradeOrderItem.picVersion;
        
        postEntityBean.entity = purchaseProjectInfo.mj_keyValues;
        
        NSDictionary *dic = postEntityBean.mj_keyValues;
        
        [HttpMamager postRequestWithURLString:DYZ_purchaseProject_queryDrawingLibrariesInfo parameters:dic success:^(id responseObjectModel) {
            
            ReturnEntityBean *model = responseObjectModel;
            
            if ([model.status isEqualToString:@"SUCCESS"]) {
                
                PurchaseProjectInfo *purchaseProjectInfo = [PurchaseProjectInfo mj_objectWithKeyValues:model.entity];
                
                AccVersionInter *accVersionInter = purchaseProjectInfo.sec_foundVersion;
                
                _arrayAccDrawingInter = [[NSMutableArray alloc] initWithCapacity:0];
                
                for (AccDrawingInter *acc in accVersionInter.drawings) {
                    NSLog(@"%@",acc.previewUrl);
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

- (void)initTableHeaderView {
    for (NSDictionary *dic in self.factoryProductInfo.productionOrderInfoForShowList) {
        ProductionOrderInfoForShow *productionOrderInfoForShow = [ProductionOrderInfoForShow mj_objectWithKeyValues:dic];
        if ([productionOrderInfoForShow.productionlotNum isEqualToString:self.tradeOrderItem.tradeOrderItemId]) {
            _productionOrderInfoForShow = productionOrderInfoForShow;
            break;
        }
    }
    
    NSLog(@"count:%ld",_productionOrderInfoForShow.productionConfirmInfoForShowList.count);
    
    _arrayYesOpen = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < _productionOrderInfoForShow.productionConfirmInfoForShowList.count; i++) {
        [_arrayYesOpen addObject:@"yes"];
    }
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ELJXQTableViewHeaderView" owner:self options:nil];
    UIView *tmpCustomView = [nib objectAtIndex:0];
    tmpCustomView.frame = CGRectMake(0, 0, kMainW, 34);
    UILabel *label2 = [tmpCustomView viewWithTag:2];
    label2.text = [NSString stringWithFormat:@"%ld%@",[_productionOrderInfoForShow.productFinishPercent integerValue],@"%"];
    
    
    NSArray *nib1 = [[NSBundle mainBundle]loadNibNamed:@"ELJXQTableViewHeaderView1" owner:self options:nil];
    UIView *tmpCustomView1 = [nib1 objectAtIndex:0];
    tmpCustomView1.frame = CGRectMake(0, 34, kMainW, 34);
    tmpCustomView1.backgroundColor = colorRGB(234, 234, 234);
    
    UIView *tmpView = [[UIView alloc] init];
    tmpView.frame = CGRectMake(0, 0, kMainW, 68);
    [tmpView addSubview:tmpCustomView];
    [tmpView addSubview:tmpCustomView1];
    _tableView2.tableHeaderView = tmpView;
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
    if (tableView.tag == 200) {
        if (indexPath.section == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            for (UIView *view in cell.contentView.subviews) {
                if (view.tag == 201) {
                    [view removeFromSuperview];
                }
            }
            
            if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 0) {
                if (_arrayTradeOrderItemFile.count > 0) {
                    [cell.contentView addSubview:_collertionView];
                }
            }
            if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 1) {
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
    if (tableView.tag == 202) {
        if (indexPath.row == 0) {
            ShengChangJinDuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shengChangJinDuTableViewCell" forIndexPath:indexPath];
            return cell;
        } else {
            ShengChangJinDuTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"shengChangJinDuTableViewCell2" forIndexPath:indexPath];
            ProductionConfirmInfoForShow *productionConfirmInfoForShow = [ProductionConfirmInfoForShow mj_objectWithKeyValues:_productionOrderInfoForShow.productionConfirmInfoForShowList[indexPath.section]];
            
            TpfOperationForShow *tpfOperationForShow = [TpfOperationForShow mj_objectWithKeyValues:productionConfirmInfoForShow.tpfOperationForShowList[indexPath.row - 1]];
            cell.productionControlNum.text = tpfOperationForShow.operationText;
            cell.plannedQuantity.text = tpfOperationForShow.plannedQuantity;
            cell.completedQuantity.text = tpfOperationForShow.completedQuantity;
            return cell;
        }
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 200) {
        if (section == 0) {
            return 1;
        } else if (section == 1) {
            return _arrayDatalist00.count;
        } else {
            return 0;
        }
    }
    if (tableView.tag == 202) {
        NSString *string = _arrayYesOpen[section];
        if ([string isEqualToString:@"no"]) {
            return 0;
        } else {
            ProductionConfirmInfoForShow *productionConfirmInfoForShow = [ProductionConfirmInfoForShow mj_objectWithKeyValues:_productionOrderInfoForShow.productionConfirmInfoForShowList[section]];
            return 1+productionConfirmInfoForShow.tpfOperationForShowList.count;
        }
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.tag == 200) {
        return 2;
    }
    if (tableView.tag == 202) {
        return _productionOrderInfoForShow.productionConfirmInfoForShowList.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.tag == 200) {
    }
    if (tableView.tag == 202) {
        return 56;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ProductionConfirmInfoForShow *productionConfirmInfoForShow = [ProductionConfirmInfoForShow mj_objectWithKeyValues:_productionOrderInfoForShow.productionConfirmInfoForShowList[section]];
    
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ELJXQTableViewSectionView" owner:self options:nil];
    UIView *tmpCustomView = [nib objectAtIndex:0];
    tmpCustomView.frame = CGRectMake(0, 0, kMainW, 56);
    
    UILabel *label1 =[tmpCustomView viewWithTag:1];
    label1.text = productionConfirmInfoForShow.productionControlNum;
    UILabel *label2 =[tmpCustomView viewWithTag:2];
    label2.text = productionConfirmInfoForShow.plannedQuantity;
    UILabel *label3 =[tmpCustomView viewWithTag:3];
    label3.text = productionConfirmInfoForShow.completedQuantity;
    UILabel *label4 =[tmpCustomView viewWithTag:4];
    label4.text = [NSString stringWithFormat:@"%ld%@",[productionConfirmInfoForShow.processPercent integerValue],@"%"];
    
    UIButton *buttonBG = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBG.frame = CGRectMake(0, 0, kMainW, 56);
    buttonBG.tag = section;
    [buttonBG addTarget:self action:@selector(buttonClickOpenClose:) forControlEvents:UIControlEventTouchUpInside];
    [tmpCustomView addSubview:buttonBG];
    buttonBG.backgroundColor = [UIColor clearColor];
    
    return tmpCustomView;
}

- (void)buttonClickOpenClose:(UIButton *)sender {
    NSLog(@"%ld",sender.tag);
    NSString *string = _arrayYesOpen[sender.tag];
    if ([string isEqualToString:@"yes"]) {
        [_arrayYesOpen replaceObjectAtIndex:sender.tag withObject:@"no"];
    }
    if ([string isEqualToString:@"no"]) {
        [_arrayYesOpen replaceObjectAtIndex:sender.tag withObject:@"yes"];
    }
    [_tableView2 reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.tag == 200) {
        if (indexPath.section == 0) {
            if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 0) {
                if (_arrayTradeOrderItemFile.count > 0) {
                    return kMainW/2.0;
                }
            }
            if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 1) {
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
    if (tableView.tag == 202) {
        if (indexPath.row == 0) {
            return 33;
        } else {
            return 49;
        }
    }
    return 0;
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
    
    if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 0) {
        if ([_arrayTradeOrderItemFile[indexPath.row].thumbnailUrl containsString:@".dwg"] ) {
            imageViewD.image = [UIImage imageNamed:@"picture_dwg"];
        } else if ([_arrayTradeOrderItemFile[indexPath.row].thumbnailUrl containsString:@".png"] || [_arrayTradeOrderItemFile[indexPath.row].thumbnailUrl containsString:@".jpg"] || [_arrayTradeOrderItemFile[indexPath.row].thumbnailUrl containsString:@".gif"] || [_arrayTradeOrderItemFile[indexPath.row].thumbnailUrl containsString:@".jpeg"]) {
            [imageViewD sd_setImageWithURL:[NSURL URLWithString:_arrayTradeOrderItemFile[indexPath.row].thumbnailUrl] placeholderImage:[UIImage imageNamed:@"img_picture_conversion"]];
        } else {
            imageViewD.image = [UIImage imageNamed:@"img_picture_conversion"];
        }
    }
    if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 1) {
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
    if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 0) {
        return _arrayTradeOrderItemFile.count;
    }
    
    if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 1) {
        return _arrayAccDrawingInter.count;
    }
    return 0;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *array;
    if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 0) {
        array = _arrayTradeOrderItemFile;
    }
    
    if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 1) {
        array = _arrayAccDrawingInter;
    }
    
    
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
    if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 0) {
        LingJianXiangQingDingDanViewController2 *lingJianXiangQingDingDanViewController2 = [[LingJianXiangQingDingDanViewController2 alloc] init];
        lingJianXiangQingDingDanViewController2.isMatchDrawingCloud = [NSNumber numberWithInteger:0];
        lingJianXiangQingDingDanViewController2.tradeOrderItemFile = _arrayTradeOrderItemFile[indexPath.row];
        [self.navigationController pushViewController:lingJianXiangQingDingDanViewController2 animated:YES];
    }
    
    if ([self.tradeOrderItem.isMatchDrawingCloud integerValue] == 1) {
        LingJianXiangQingDingDanViewController2 *lingJianXiangQingDingDanViewController2 = [[LingJianXiangQingDingDanViewController2 alloc] init];
        lingJianXiangQingDingDanViewController2.isMatchDrawingCloud = [NSNumber numberWithInteger:1];
        lingJianXiangQingDingDanViewController2.accDrawingInter = _arrayAccDrawingInter[indexPath.row];
        [self.navigationController pushViewController:lingJianXiangQingDingDanViewController2 animated:YES];
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
