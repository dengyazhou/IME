//
//  EQYCommentViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/12/14.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "EQYCommentViewController.h"
#import "VoHeader.h"
#import "EQYCommentCell.h"

@interface EQYCommentViewController () <UITableViewDelegate,UITableViewDataSource> {
    NSArray *datalist;
    NSArray *dataListScore;
}

@property (weak, nonatomic) IBOutlet UILabel *labelTitle1;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EQYCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    datalist = @[@"智造家通过网站",@"智造家通过网站智造家通过网站",@"智造家通过网站智造家通过网站智造家通过网站",@"智造家通过网站智造家通过网站智造家通过网站智造家通过网站",@"智造家通过网站智造家通过网站智造家通过网站智造家通过网站智造家通过网站",@"智造家通过网站",@"智造家通过网站智造家通过网站",@"智造家通过网站智造家通过网站智造家通过网站智造家通过网站",@"智造家通过网站"];
//    dataListScore = @[@"1",@"5",@"2",@"0",@"5",@"4",@"2",@"3",@"1"];
    
    self.labelTitle1.text = [NSString stringWithFormat:@"评价（%ld）",self.arrayComment.count];;
    [self initUI];
}

- (void)initUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"EQYCommentCell" bundle:nil] forCellReuseIdentifier:@"eQYCommentCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayComment.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EQYCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eQYCommentCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.star0.image = [UIImage imageNamed:@"label_star_2t"];
    cell.star1.image = [UIImage imageNamed:@"label_star_2t"];
    cell.star2.image = [UIImage imageNamed:@"label_star_2t"];
    cell.star3.image = [UIImage imageNamed:@"label_star_2t"];
    cell.star4.image = [UIImage imageNamed:@"label_star_2t"];
    
    NSArray *arrayStar = @[cell.star0,cell.star1,cell.star2,cell.star3,cell.star4];
    
    Comment *comment = self.arrayComment[indexPath.row];
    
    if ([comment.commentType isEqualToString:@"PURCHASE"]) {
        int a = [comment.purchaseSyntheticScore doubleValue];
        for (int i = 0; i < a; i++) {
            UIImageView *imageV = arrayStar[i];
            imageV.image = [UIImage imageNamed:@"label_star"];
        }
        cell.label0.text = [NSString stringWithFormat:@"%@分",comment.purchaseSyntheticScore];
        cell.label1.text = [NSString stringWithFormat:@"来自采购商 %@",comment.sourceEnterpriseName];
        cell.label2.text = comment.content.length != 0?comment.content:@"暂无评价";
        cell.label3.text = [NSString stringWithFormat:@"%@ 订单信息 %@",comment.createTime,comment.orderTitle];
        
    }
    
    if ([comment.commentType isEqualToString:@"SUPPLIER"]) {
        int a = [comment.supplierSyntheticScore doubleValue];
        for (int i = 0; i < a; i++) {
            UIImageView *imageV = arrayStar[i];
            imageV.image = [UIImage imageNamed:@"label_star_3t-2"];
        }
        cell.label0.text = [NSString stringWithFormat:@"%@分",comment.supplierSyntheticScore];
        cell.label1.text = [NSString stringWithFormat:@"来自供应商 %@",comment.sourceEnterpriseName];
        cell.label2.text = comment.content.length != 0?comment.content:@"暂无评价";
        cell.label3.text = [NSString stringWithFormat:@"%@ 订单信息 %@",comment.createTime,comment.orderTitle];
        
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Comment *comment = self.arrayComment[indexPath.row];
    CGSize size = [comment.content boundingRectWithSize:CGSizeMake(kMainW-20, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    return 10+16+8+size.height+8+17+10;
//    return 90;
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
