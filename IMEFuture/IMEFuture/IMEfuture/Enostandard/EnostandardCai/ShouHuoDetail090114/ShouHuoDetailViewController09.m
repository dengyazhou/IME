//
//  ShouHuoDetailViewController09.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/1/15.
//  Copyright © 2019年 Netease. All rights reserved.
//

#import "ShouHuoDetailViewController09.h"
#import "Header.h"
#import "ShouHuoDetailCell0900.h"
#import "ShouHuoDetailCell090000.h"
#import "ShouHuoDetailCell090001.h"
#import "ShouHuoDetailCell090002.h"
#import "ShouHuooDetailCell0901.h"
#import "FaHuoCell0901.h"
#import "ShouHuooDetailCell0903.h"
#import "PartDetailsView.h"

@interface ShouHuoDetailViewController09 () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (assign,nonatomic) NSInteger index;

@end

@implementation ShouHuoDetailViewController09

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoDetailCell0900" bundle:nil] forCellReuseIdentifier:@"shouHuoDetailCell0900"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoDetailCell090000" bundle:nil] forCellReuseIdentifier:@"shouHuoDetailCell090000"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoDetailCell090001" bundle:nil] forCellReuseIdentifier:@"shouHuoDetailCell090001"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuoDetailCell090002" bundle:nil] forCellReuseIdentifier:@"shouHuoDetailCell090002"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuooDetailCell0901" bundle:nil] forCellReuseIdentifier:@"shouHuooDetailCell0901"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FaHuoCell0901" bundle:nil] forCellReuseIdentifier:@"faHuoCell0901"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShouHuooDetailCell0903" bundle:nil] forCellReuseIdentifier:@"shouHuooDetailCell0903"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return self.receiveBean.receiveOrderItems.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (self.index == 0) {
            ShouHuoDetailCell0900 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoDetailCell0900" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.receiveBean;
            return cell;
        } else if (self.index == 1) {
            if ([self.receiveBean.deliverOrder.deliveryMethods isEqualToString:@"SUPPLIER"]) {
                ShouHuoDetailCell090000 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoDetailCell090000" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.receiveBean;
                return cell;
            } else if ([self.receiveBean.deliverOrder.deliveryMethods isEqualToString:@"LOGISTICS"]) {
                ShouHuoDetailCell090001 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoDetailCell090001" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.receiveBean;
                return cell;
            } else if ([self.receiveBean.deliverOrder.deliveryMethods isEqualToString:@"SELF"]) {
                ShouHuoDetailCell090002 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuoDetailCell090002" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.model = self.receiveBean;
                return cell;
            }
        }
    } else if (indexPath.section == 1) {
        ShouHuooDetailCell0901 * cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuooDetailCell0901" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setButtonUpOrDownCallBack:^(UIButton * _Nonnull sender) {
            self.index = self.index==0?1:0;
            [sender setTitle:self.index==0?@"展开更多":@"收起" forState:UIControlStateNormal];
            [sender setImage:[UIImage imageNamed:self.index==0?@"Down":@"up1"] forState:UIControlStateNormal];
            [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }];
        return cell;
    } else if (indexPath.section == 2) {
        FaHuoCell0901 *cell = [tableView dequeueReusableCellWithIdentifier:@"faHuoCell0901" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.section == 3) {
        ShouHuooDetailCell0903 *cell = [tableView dequeueReusableCellWithIdentifier:@"shouHuooDetailCell0903" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.receiveBean.receiveOrderItems[indexPath.row];
        cell.model1 = self.receiveBean.deliverOrder.items[indexPath.row];
        [cell setButtonPartDetailCallBack:^{
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PartDetailsView" owner:self options:nil];
            PartDetailsView *partDetailsView = [nib objectAtIndex:0];
            partDetailsView.frame = CGRectMake(0, 0, kMainW, kMainH);
            [self.view addSubview:partDetailsView];
            [partDetailsView initDataIsDeliverOrderItemBean:self.receiveBean.deliverOrder.items[indexPath.row]];
        }];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
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
