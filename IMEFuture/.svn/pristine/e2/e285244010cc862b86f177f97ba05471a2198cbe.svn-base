//
//  LianXiRenViewController.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2017/7/24.
//  Copyright © 2017年 Netease. All rights reserved.
//

#import "LianXiRenViewController.h"

#import "Header.h"
#import "MyAlertCenter.h"

#import "XHJAddressBook.h"
#import "PersonModel.h"
#import "PersonCell.h"
#import "BeiYaoQingRenXingXiViewController.h"
#import "LianXiRenSouSuoViewController.h"
#import <AddressBook/AddressBook.h>


#import "NSString+Utils.h"

#define  mainWidth [UIScreen mainScreen].bounds.size.width
#define  mainHeigth  [UIScreen mainScreen].bounds.size.height

@interface LianXiRenViewController () <UITableViewDataSource,UITableViewDelegate> {
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property(nonatomic,strong)NSMutableArray *listContent;
@property (strong, nonatomic) NSMutableArray *sectionTitles;

@property (strong, nonatomic) PersonModel *people;
@property (weak, nonatomic) IBOutlet UITableView *tableShow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableShowTop;//44和0
@property (nonatomic,strong) UIView *viewNoAddressBook;//邀请不在通讯录里的好友
@property (weak, nonatomic) IBOutlet UIView *viewSouSuo;//搜索view


@property (weak, nonatomic) IBOutlet UIView *viewSheZhi;//智造家没有权限访问你的通讯录
@property (weak, nonatomic) IBOutlet UIView *viewNoContent;//没有联系人

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;


@end

@implementation LianXiRenViewController {
    XHJAddressBook *_addBook;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;

    self.viewSheZhi.hidden = YES;
    self.viewNoContent.hidden = YES;
    self.viewSouSuo.hidden = YES;
    
    _sectionTitles=[NSMutableArray new];
    
    self.tableShow.delegate=self;
    self.tableShow.dataSource=self;
    self.tableShow.tableFooterView = [UIView new];
    self.tableShow.sectionIndexBackgroundColor=[UIColor clearColor];
    self.tableShow.sectionIndexColor = colorRGB(89, 178, 50);
    
    self.tableShow.tableHeaderView = self.viewNoAddressBook;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self initData];
        dispatch_sync(dispatch_get_main_queue(), ^
                      {
                          [self setTitleList];
                          [self.tableShow reloadData];
                          int staticid=ABAddressBookGetAuthorizationStatus();
//                          NSLog(@">>>>>>>>>%d",staticid);
                          if (staticid==3) {//打开了权限
                              if (_listContent.count>0) {
                                  self.tableShowTop.constant = 44;
                                  self.viewNoContent.hidden = YES;
                                  self.viewSouSuo.hidden = NO;
                              } else {
                                  self.tableShowTop.constant = 0;
                                  self.viewNoContent.hidden = NO;
                                  self.viewSouSuo.hidden = YES;
                              }
                          }
                          if (staticid==2) {//没有打开权限
                              if (_listContent.count>0) {
                                  self.tableShowTop.constant = 44;
                                  self.viewSheZhi.hidden = YES;
                                  self.viewSouSuo.hidden = NO;
                              } else {
                                  self.tableShowTop.constant = 0;
                                  self.viewSheZhi.hidden = NO;
                                  self.viewSouSuo.hidden = YES;
                              }
                          }
                      });
    });
}

- (UIView *)viewNoAddressBook {
    if (!_viewNoAddressBook) {
        _viewNoAddressBook = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 55)];
        _viewNoAddressBook.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 8.5, 0, 0)];
        imageView.image = [UIImage imageNamed:@"icon_邀请非通讯好友"];
        [imageView sizeToFit];
        [_viewNoAddressBook addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+14, 0, kMainW-(CGRectGetMaxX(imageView.frame)+14), 55)];
        label.text = @"邀请不在通讯录里的好友";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = colorRGB(51, 51, 51);
        [_viewNoAddressBook addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, kMainW, 55);
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(buttonClickLianxiRenNoAddressBook:) forControlEvents:UIControlEventTouchUpInside];
        [_viewNoAddressBook addSubview:button];
        
        UIView *viewLineTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 0.5)];
        viewLineTop.backgroundColor = colorRGB(228, 228, 228);
        [_viewNoAddressBook addSubview:viewLineTop];
        
        
        UIView *viewLineBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 54.5, kMainW, 0.5)];
        viewLineBottom.backgroundColor = colorRGB(228, 228, 228);
        [_viewNoAddressBook addSubview:viewLineBottom];
    }
    return _viewNoAddressBook;
}

- (IBAction)buttonSouSuo:(id)sender {
    LianXiRenSouSuoViewController *lianXiRenSouSuoViewController = [[LianXiRenSouSuoViewController alloc] init];
    [self.navigationController pushViewController:lianXiRenSouSuoViewController animated:YES];
}

- (IBAction)buttonSheZhi:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请在iPhone的“设置-隐私-通讯录”选项中，允许智造家访问你的通讯录。" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [alertController addAction:action];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)setTitleList {
    UILocalizedIndexedCollation *theCollation = [UILocalizedIndexedCollation currentCollation];
    [self.sectionTitles removeAllObjects];
    [self.sectionTitles addObjectsFromArray:[theCollation sectionTitles]];
    NSMutableArray * existTitles = [NSMutableArray array];
    for(int i=0;i<[_listContent count];i++)//过滤 就取存在的索引条标签
    {
        PersonModel *pm=_listContent[i][0];
        for(int j=0;j<_sectionTitles.count;j++)
        {
            if(pm.sectionNumber==j)
                [existTitles addObject:self.sectionTitles[j]];
        }
    }
    [self.sectionTitles removeAllObjects];
    self.sectionTitles =existTitles;
}


-(NSMutableArray*)listContent
{
    if(_listContent==nil)
    {
        _listContent=[NSMutableArray new];
    }
    return _listContent;
}
-(void)initData
{
    _addBook=[[XHJAddressBook alloc]init];
    self.listContent=[_addBook getAllPerson];
    if(_listContent==nil)
    {
        NSLog(@"数据为空或通讯录权限拒绝访问，请到系统开启");
        return;
    }
}

//几个  section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_listContent count];
    
}
//对应的section有多少row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[_listContent objectAtIndex:(section)] count];
    
}
//cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
//section的高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if(self.sectionTitles==nil||self.sectionTitles.count==0)
        return nil;
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"uitableviewbackground"]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = colorRGB(153, 153, 153);
    label.font = [UIFont systemFontOfSize:14];
    NSString *sectionStr=[self.sectionTitles objectAtIndex:(section)];
    [label setText:sectionStr];
    [contentView addSubview:label];
    return contentView;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdenfer=@"addressCell";
    PersonCell *personcell=(PersonCell*)[tableView dequeueReusableCellWithIdentifier:cellIdenfer];
    if(personcell==nil)
    {
        personcell=[[PersonCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenfer];
    }
    
    NSArray *sectionArr=[_listContent objectAtIndex:indexPath.section];
    _people = (PersonModel *)[sectionArr objectAtIndex:indexPath.row];
    [personcell setData:_people];
    
    return personcell;
    
}

- (void)buttonClickLianxiRenNoAddressBook:(UIButton *)sender {
    BeiYaoQingRenXingXiViewController *beiYaoQingRenXingXiViewController = [[BeiYaoQingRenXingXiViewController alloc] init];
    beiYaoQingRenXingXiViewController.isLianXiRen = @"NO";
    [self.navigationController pushViewController:beiYaoQingRenXingXiViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *sectionArr=[_listContent objectAtIndex:indexPath.section];
    self.people = (PersonModel *)[sectionArr objectAtIndex:indexPath.row];
    
    if (_people.tel.length == 0) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"当前不支持非空手机号，请见谅"];
        return;
    }
    if (![NSString checkTelNumber:_people.tel]) {
        [[MyAlertCenter defaultCenter] postAlertWithMessage:@"当前不支持非手机号"];
        return;
    }
    
    BeiYaoQingRenXingXiViewController *beiYaoQingRenXingXiViewController = [[BeiYaoQingRenXingXiViewController alloc] init];
    beiYaoQingRenXingXiViewController.isLianXiRen = @"YES";
    beiYaoQingRenXingXiViewController.strName = _people.phonename;
    beiYaoQingRenXingXiViewController.strPhoneNumber = _people.tel;
    
    [self.navigationController pushViewController:beiYaoQingRenXingXiViewController animated:YES];
}

//开启右侧索引条
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.sectionTitles;
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
