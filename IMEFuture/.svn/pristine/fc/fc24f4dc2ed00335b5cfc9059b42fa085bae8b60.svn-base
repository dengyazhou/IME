//
//  EInquiryActionViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 16/12/13.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "EInquiryActionViewController.h"
#import "VoHeader.h"
#import "InquiryHistoryBean.h"

#import "EInquiryActionCell.h"


@interface EInquiryActionViewController () <UITableViewDelegate,UITableViewDataSource> {
    
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}
@property (weak, nonatomic) IBOutlet UILabel *labelTitle1;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation EInquiryActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
//    datalist = @[@"智造家通过网站",@"智造家通过网站智造家通过网站智造家通过网站智造家通过网站智造家通过网站智造家通过网站智造家通过网站智造家通过网站",@"智造家通过网站智造家通过网站智造家通过网站",@"智造家通过网站智造家通过网站智造家通过网站智造家通过网站",@"智造家通过网站智造家通过网站智造家通过网站智造家通过网站智造家通过网站",@"智造家通过网站",@"智造家通过网站智造家通过网站",@"智造家通过网站智造家通过网站智造家通过网站智造家通过网站",@"智造家通过网站",@"智造家通过网站智造家通过网站",@"智造家通过网站智造家通过网站智造家通过网站智造家通过网站智造家通过网站智造家通过网站"];
    
    self.labelTitle1.text = [NSString stringWithFormat:@"询盘动态（%ld）",self.inquiryHistoryBeanList.count];
    [self initUI];
}

- (void)initUI {
    [self.tableView registerNib:[UINib nibWithNibName:@"EInquiryActionCell" bundle:nil] forCellReuseIdentifier:@"eInquiryActionCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EInquiryActionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eInquiryActionCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.view1.backgroundColor = colorRGB(241, 241, 241);
    cell.label1.textColor = colorRGB(0, 0, 0);
    cell.label2.textColor = colorRGB(177, 177, 177);
    cell.viewLine0.hidden = NO;
    
    
    InquiryHistoryBean *model = self.inquiryHistoryBeanList[indexPath.row];
    if (indexPath.row == 0) {
        cell.viewLine0.hidden = YES;
//        if ([self.inquiryManufacturerId isEqualToString:quotationOrder.manufacturerId] || !quotationOrder.manufacturerId) {
//            cell.view1.backgroundColor = colorRGB(255 , 132, 0);
//            cell.label1.textColor = colorRGB(255, 132, 0);
//            cell.label2.textColor = colorRGB(255, 132, 0);
//        } else {
//            cell.view1.backgroundColor = colorRGB(0 , 168, 255);
//            cell.label1.textColor = colorRGB(0 , 168, 255);
//            cell.label2.textColor = colorRGB(0 , 168, 255);
//        }
        cell.view1.backgroundColor = colorRGB(255 , 132, 0);
        cell.label1.textColor = colorRGB(255, 132, 0);
        cell.label2.textColor = colorRGB(255, 132, 0);
    }

    cell.label0.text = model.purEnterprise.length!=0?model.purEnterprise:@"--";
    cell.label1.text = model.msg.length!=0?model.msg:@"--";
    cell.label2.text = model.createTime.length!=0?model.createTime:@"--";
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.inquiryHistoryBeanList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    InquiryHistoryBean *model = self.inquiryHistoryBeanList[indexPath.row];
    NSString *string = model.status.length!=0?model.status:@"--";
    CGSize size = [string boundingRectWithSize:CGSizeMake(kMainW-10-40, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    return 9+24+5+size.height+5+17+10;
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
