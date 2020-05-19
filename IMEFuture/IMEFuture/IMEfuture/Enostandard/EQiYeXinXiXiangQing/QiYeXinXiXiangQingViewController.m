//
//  QiYeXinXiXiangQingViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/7/6.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "QiYeXinXiXiangQingViewController.h"
#import "VoHeader.h"

#import "Masonry.h"

#import "EQYXXXQCommentCell.h"
#import "EQYCommentViewController.h"


#import "UIButtonIM.h"

@interface QiYeXinXiXiangQingViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSArray *_arr2;
    BOOL _hasRelation;//NO 已关注 //YES 未关注
    NSMutableArray *_arrayComment;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation QiYeXinXiXiangQingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    [self initUI];
    [self initRequestEpRelationHasRelation];
    [self initRequestCommentList];
}

- (void)initUI {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, 0.5)];
    label.backgroundColor = colorLine;
    [self.view addSubview:label];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"EQYXXXQCommentCell" bundle:nil] forCellReuseIdentifier:@"eQYXXXQCommentCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([self.isPrivate integerValue] == 1) {
        self.buttonGuanZhu.hidden = YES;
    } else {
        self.buttonGuanZhu.hidden = NO;
    }
    
    
    //取消关注功能
    self.buttonGuanZhu.hidden = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 8;
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        return 1;
    }
    if (section == 4) {
        return 1;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 68;
    }
    if (indexPath.section == 1) {
        return 30;
    }
    if (indexPath.section == 2) {
        return 49;
    }
    if (indexPath.section == 3) {
        return 49;
    }
    if (indexPath.section == 4) {
        return 165;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 4) {
        return 0.5;
    } else if (section == 2) {
        return 0;
    } else {
        return 11;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = colorRGB(241, 241, 241);
    
    UILabel *labelLineHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainW, 0.5)];
    labelLineHeader.backgroundColor = colorRGB(221, 221, 221);
    [view addSubview:labelLineHeader];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 || indexPath.section == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == 10 || view.tag == 11 || view.tag == 12 || view.tag == 13 || view.tag == 14 || view.tag == 15) {
                [view removeFromSuperview];
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            UILabel *labelLineHeader = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainW, 0.5)];
            labelLineHeader.backgroundColor = colorRGB(221, 221, 221);
            labelLineHeader.tag = 10;
            [cell.contentView addSubview:labelLineHeader];
        }
        
        
        if (indexPath.section == 0) {
            UIImageView *imageViewH = [[UIImageView alloc] init];
            [imageViewH sd_setImageWithURL:[NSURL URLWithString:self.enterpriseInfo.logoImg] placeholderImage:[UIImage imageNamed:@"ime_test_company"]];
            imageViewH.tag = 11;
            [cell.contentView addSubview:imageViewH];
            [imageViewH mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(10);
                make.top.equalTo(cell.contentView.mas_top).with.offset(10);
                make.width.mas_equalTo(48);
                make.height.mas_equalTo(48);
            }];
            
            
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = self.enterpriseInfo.enterpriseName;
            label1.textColor = colorRGB(32, 32, 32);
            label1.tag = 12;
            [cell.contentView addSubview:label1];
            
            if ([self.enterpriseInfo.hasTrFactory integerValue] == 0) {
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imageViewH.mas_right).with.offset(10);
                    make.top.equalTo(imageViewH.mas_top).with.offset(5);
                }];
            }
            
            if ([self.enterpriseInfo.hasTrFactory integerValue] == 1) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_factory"]];
                [cell.contentView addSubview:imageView];
                imageView.tag = 13;
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imageViewH.mas_right).with.offset(10);
                    make.top.equalTo(imageViewH.mas_top).with.offset(5);
                    make.width.mas_equalTo(17);
                    make.height.mas_equalTo(17);
                }];
                
                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(imageViewH.mas_right).with.offset(37);
                    make.top.equalTo(imageViewH.mas_top).with.offset(5);
                }];
            }
            
            if ([self.isPrivate integerValue] == 1) {
                if (self.enterpriseInfo.enterpriseName.length > 5) {
                    NSString *stringEnterpriseNameL = [self.enterpriseInfo.enterpriseName substringWithRange:NSMakeRange(0, 2)];
                    NSString *stringEnterpriseNameR = [self.enterpriseInfo.enterpriseName substringWithRange:NSMakeRange(self.enterpriseInfo.enterpriseName.length-2, 2)];
                    label1.text = [NSString stringWithFormat:@"%@****%@",stringEnterpriseNameL,stringEnterpriseNameR];
                } else {
                    NSString *stringEnterpriseName = [self.enterpriseInfo.enterpriseName substringWithRange:NSMakeRange(0, 2)];
                    label1.text = [NSString stringWithFormat:@"%@****",stringEnterpriseName];
                }
            } else {
                label1.text = self.enterpriseInfo.enterpriseName;
            }
            if ([self.isAlwaysShow isEqualToString:@"yes"]) {
                label1.text = self.enterpriseInfo.enterpriseName;
            }
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.text = [NSString stringWithFormat:@"%@ %@",self.enterpriseInfo.province?self.enterpriseInfo.province:@"",self.enterpriseInfo.city?self.enterpriseInfo.city:@""];
            label2.textColor = colorRGB(117, 117, 117);
            label2.font = [UIFont systemFontOfSize:12];
            label2.tag = 14;
            [cell.contentView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(imageViewH.mas_right).with.offset(10);
                make.top.equalTo(label1.mas_bottom).with.offset(3);
            }];
        
            
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(cell.mas_right).with.offset(-63-5);
            }];

            
//            if ([self.quotationOrderStatus isEqualToString:@"SR"]||[self.quotationOrderStatus isEqualToString:@"WR"]||[self.isATG isEqualToString:@"ATG"]) {
//                button.hidden = NO;
//                label1.text = self.enterpriseInfo.enterpriseName;
//                
//                [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.right.equalTo(cell.mas_right).with.offset(-115);
//                }];
//            }
            
        }
        if (indexPath.section == 1) {
            NSArray *arr1 = @[@"公司性质",@"雇员数量",@"工厂面积",@"年采购额",@"成立年份",@"行业类型",@"进出口权",@"企业认证"];
            
            NSString *string1 = self.enterpriseInfo.enterpriseNature?self.enterpriseInfo.enterpriseNature:@"--";
            NSString *string2 = self.enterpriseInfo.employeeNum?[NSString stringWithFormat:@"%@人",self.enterpriseInfo.employeeNum]:@"--";
            NSString *string3 = self.enterpriseInfo.factorySize?[NSString stringWithFormat:@"%@(平方米)",self.enterpriseInfo.factorySize]:@"--";
            NSString *string4 = self.enterpriseInfo.annualProcurement?[NSString stringWithFormat:@"%@(万元)",self.enterpriseInfo.annualProcurement]:@"--";
            NSString *string5 = [self.enterpriseInfo.foundTimeY integerValue] != 0?[NSString stringWithFormat:@"%ld",[self.enterpriseInfo.foundTimeY integerValue]]:@"--";
            NSString *string6 = self.enterpriseInfo.industryType?self.enterpriseInfo.industryType:@"--";
            NSString *string7 = self.enterpriseInfo.hasIEPower?[self hasIEPower:[self.enterpriseInfo.hasIEPower integerValue]]:@"--";
            NSString *string8 = self.enterpriseInfo.renzheng?self.enterpriseInfo.renzheng:@"--";
            _arr2 = @[string1,string2,string3,string4,string5,string6,string7,string8];
            
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = arr1[indexPath.row];
            label1.textColor = colorRGB(117, 117, 117);
            label1.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(10);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            }];
            
            UILabel *label2 = [[UILabel alloc] init];
            label2.text = _arr2[indexPath.row];
            label2.textColor = colorRGB(32, 32, 32);
            label2.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:label2];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(100);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            }];
            
        }
        
        //    NSLog(@"%@",self.enterpriseInfo.buStartLevel);//采购商平均星数
        //    NSLog(@"%@",self.enterpriseInfo.suStartLevel);//供应商评分平均星数
        
        if (indexPath.section == 2) {
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = @"采购商综合评分";
            label1.textColor = colorRGB(117, 117, 117);
            label1.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(10);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            }];
            
            
            
            if (self.enterpriseInfo.buStartLevel) {
                if (indexPath.row == 0) {
                    for (int i = 0; i < 5; i++) {
                        UIImageView *imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_star_2t"]];
                        imageView5.frame = CGRectMake(150 + 20*i, 17, 15, 15);
                        [cell.contentView addSubview:imageView5];
                    }
                }
                NSInteger integerNum = [[[self.enterpriseInfo.buStartLevel stringValue] substringWithRange:NSMakeRange(0, 1)] integerValue];
                
                if (indexPath.row == 0) {
                    for (int i = 0; i < integerNum; i++) {
                        UIImageView *imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_star"]];
                        imageView5.frame = CGRectMake(150 + 20*i, 17, 15, 15);
                        [cell.contentView addSubview:imageView5];
                    }
                }
                UILabel *labelStart = [[UILabel alloc] initWithFrame:CGRectMake(160 + 20*5, 17, 38, 15)];
                labelStart.text = [NSString stringWithFormat:@"%.1f分",[self.enterpriseInfo.buStartLevel doubleValue]];
                labelStart.textColor = colorRGB(117, 117, 117);
                labelStart.font = [UIFont systemFontOfSize:14];
                [cell.contentView addSubview:labelStart];
            } else {
                UILabel *labelStart = [[UILabel alloc] initWithFrame:CGRectMake(160 + 20*4, 17, 58, 15)];
                labelStart.text = @"暂无评价";
                labelStart.textColor = colorRGB(117, 117, 117);
                labelStart.font = [UIFont systemFontOfSize:14];
                [cell.contentView addSubview:labelStart];
            }
        }
        
        if (indexPath.section == 3) {
            UILabel *label1 = [[UILabel alloc] init];
            label1.text = @"供应商综合评分";
            label1.textColor = colorRGB(117, 117, 117);
            label1.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:label1];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.contentView.mas_left).with.offset(10);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
            }];
            
            
            if (self.enterpriseInfo.suStartLevel) {
                if (indexPath.row == 0) {
                    for (int i = 0; i < 5; i++) {
                        UIImageView *imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_star_2t"]];
                        imageView5.frame = CGRectMake(150 + 20*i, 17, 15, 15);
                        [cell.contentView addSubview:imageView5];
                    }
                }
                NSInteger integerNum = [[[self.enterpriseInfo.suStartLevel stringValue] substringWithRange:NSMakeRange(0, 1)] integerValue];
                if (indexPath.row == 0) {
                    for (int i = 0; i < integerNum; i++) {
                        UIImageView *imageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"label_star_3t-2"]];
                        imageView5.frame = CGRectMake(150 + 20*i, 17, 15, 15);
                        [cell.contentView addSubview:imageView5];
                    }
                }
                UILabel *labelStart = [[UILabel alloc] initWithFrame:CGRectMake(160 + 20*5, 17, 38, 15)];
                labelStart.text = [NSString stringWithFormat:@"%.1f分",[self.enterpriseInfo.suStartLevel doubleValue]];
                labelStart.textColor = colorRGB(117, 117, 117);
                labelStart.font = [UIFont systemFontOfSize:14];
                [cell.contentView addSubview:labelStart];
            } else {
                UILabel *labelStart = [[UILabel alloc] initWithFrame:CGRectMake(160 + 20*4, 17, 58, 15)];
                labelStart.text = @"暂无评价";
                labelStart.textColor = colorRGB(117, 117, 117);
                labelStart.font = [UIFont systemFontOfSize:14];
                [cell.contentView addSubview:labelStart];
            }
        }
        
        return cell;
    }
    
    if (indexPath.section == 4) {
        EQYXXXQCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eQYXXXQCommentCell" forIndexPath:indexPath];
        cell.viewNoContent.hidden = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.star0.image = [UIImage imageNamed:@"label_star_2t"];
        cell.star1.image = [UIImage imageNamed:@"label_star_2t"];
        cell.star2.image = [UIImage imageNamed:@"label_star_2t"];
        cell.star3.image = [UIImage imageNamed:@"label_star_2t"];
        cell.star4.image = [UIImage imageNamed:@"label_star_2t"];
        
        NSArray *arrayStar = @[cell.star0,cell.star1,cell.star2,cell.star3,cell.star4];
        
        
        Comment *comment;
        if (_arrayComment.count == 0) {
            cell.label0.text = @"收到的评价（0）";
            cell.viewNoContent.hidden = NO;
        } else {
            comment = _arrayComment[indexPath.row];
            cell.label0.text = [NSString stringWithFormat:@"收到的评价（%ld）",_arrayComment.count];
            cell.viewNoContent.hidden = YES;
        }
        
        
        
        if ([comment.commentType isEqualToString:@"PURCHASE"]) {
            int a = [comment.purchaseSyntheticScore doubleValue];
            for (int i = 0; i < a; i++) {
                UIImageView *imageV = arrayStar[i];
                imageV.image = [UIImage imageNamed:@"label_star"];
            }
            cell.label1.text = [NSString stringWithFormat:@"%@分",comment.purchaseSyntheticScore];
            cell.label2.text = [NSString stringWithFormat:@"来自采购商 %@",comment.sourceEnterpriseName];
            cell.label3.text = comment.content.length != 0?comment.content:@"暂无评价";
            cell.label4.text = [NSString stringWithFormat:@"%@ 订单信息 %@",comment.createTime,comment.orderTitle];
            
        }
        
        if ([comment.commentType isEqualToString:@"SUPPLIER"]) {
            int a = [comment.supplierSyntheticScore doubleValue];
            for (int i = 0; i < a; i++) {
                UIImageView *imageV = arrayStar[i];
                imageV.image = [UIImage imageNamed:@"label_star_3t-2"];
            }
            cell.label1.text = [NSString stringWithFormat:@"%@分",comment.supplierSyntheticScore];
            cell.label2.text = [NSString stringWithFormat:@"来自供应商 %@",comment.sourceEnterpriseName];
            cell.label3.text = comment.content.length != 0?comment.content:@"暂无评价";
            cell.label4.text = [NSString stringWithFormat:@"%@ 订单信息 %@",comment.createTime,comment.orderTitle];

        }
        
        
        
        [cell.button addTarget:self action:@selector(buttonChaKanQuanBu:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    return nil;
}

- (void)buttonChaKanQuanBu:(UIButton *)sender {
    EQYCommentViewController *eQYCommentViewController = [[EQYCommentViewController alloc] init];
    eQYCommentViewController.arrayComment = _arrayComment;
    [self.navigationController pushViewController:eQYCommentViewController animated:YES];
}



- (IBAction)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)buttonGuanZhu:(UIButton *)sender {
    //已关注
    //    _hasRelation = NO;
    //已关注 点击取消关注
    if (_hasRelation == NO) {
        [self initRequestEpRelationCancelRelation];
    }
    
    //未关注
    //    _hasRelation = YES;
    //未关注 点击关注
    if (_hasRelation == YES) {
        [self initRequestEpRelationAddRelation];
    }
}

#pragma mark 验证企业是否已关注
- (void)initRequestEpRelationHasRelation {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    EnterpriseRelation *enterpriseRelation = [[EnterpriseRelation alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    enterpriseRelation.initiatorId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    enterpriseRelation.passiveId = self.passiveId;
    enterpriseRelation.relationType = @"A";
    postEntityBean.entity = enterpriseRelation.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
    [HttpMamager postRequestWithURLString:DYZ_epRelation_hasRelation parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            if ([returnMsgBean.returnCode integerValue] == 0) {
                //已关注
                _hasRelation = NO;
                [self.buttonGuanZhu setImage:[UIImage imageNamed:@"ime_e_icon_concern_2t"] forState:UIControlStateNormal];
            }
            if ([returnMsgBean.returnCode integerValue] == 1) {
                //未关注
                _hasRelation = YES;
                [self.buttonGuanZhu setImage:[UIImage imageNamed:@"ime_e_icon_concern"] forState:UIControlStateNormal];
            }
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}
#pragma mark 取消关注/移除黑名单
- (void)initRequestEpRelationCancelRelation {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    EnterpriseRelation *enterpriseRelation = [[EnterpriseRelation alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    enterpriseRelation.initiatorId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    enterpriseRelation.passiveId = self.passiveId;
    enterpriseRelation.relationType = @"A";
    postEntityBean.entity = enterpriseRelation.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_epRelation_cancelRelation parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            _hasRelation = YES;
            [self.buttonGuanZhu setImage:[UIImage imageNamed:@"ime_e_icon_concern"] forState:UIControlStateNormal];
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"取消关注"];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
}

#pragma mark 添加企业关系（关注/黑名单/合作（交易））
- (void)initRequestEpRelationAddRelation {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    EnterpriseRelation *enterpriseRelation = [[EnterpriseRelation alloc] init];
    LoginModel *loginModel = [DatabaseTool getLoginModel];
    enterpriseRelation.initiatorId = [GlobalSettingManager shareGlobalSettingManager].manufacturerId;
    enterpriseRelation.passiveId = self.passiveId;
    enterpriseRelation.type = [NSNumber numberWithInteger:1];
    enterpriseRelation.relationType = @"A";
    postEntityBean.entity = enterpriseRelation.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    [HttpMamager postRequestWithURLString:DYZ_epRelation_addRelation parameters:dic success:^(id responseObjectModel) {
        ReturnMsgBean *returnMsgBean = responseObjectModel;
        if ([returnMsgBean.status isEqualToString:@"SUCCESS"]) {
            _hasRelation = NO;
            [self.buttonGuanZhu setImage:[UIImage imageNamed:@"ime_e_icon_concern_2t"] forState:UIControlStateNormal];
            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"关注成功"];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnMsgBean")];
    
}

- (void)initRequestCommentList {
    EfeibiaoPostEntityBean *postEntityBean = [[EfeibiaoPostEntityBean alloc] init];
    Comment *comment = [[Comment alloc] init];
    comment.targetEnterpriseId = self.enterpriseInfo.enterpriseId;
    postEntityBean.entity = comment.mj_keyValues;
    NSDictionary *dic = postEntityBean.mj_keyValues;
    
//    NSLog(@"%@",dic);
    
    [HttpMamager postRequestWithURLString:DYZ_comment_list parameters:dic success:^(id responseObjectModel) {
        ReturnListBean *returnListBean = responseObjectModel;
        if ([returnListBean.status isEqualToString:@"SUCCESS"]) {
            _arrayComment= [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dic in returnListBean.list) {
                Comment *comment = [Comment mj_objectWithKeyValues:dic];
                [_arrayComment addObject:comment];
            }
            [self.tableView reloadData];
        }
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ReturnListBean")];
}
- (NSString *)hasIEPower:(NSInteger)integer {
    if (integer == 0) {
        return @"无";
    }
    if (integer == 1) {
        return @"有";
    }
    return nil;
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
