//
//  InformationSearchViewController.m
//  IMEFuture
//
//  Created by SyxdzybsDYZiMac on 16/6/29.
//  Copyright © 2016年 Netease. All rights reserved.
//

#import "InformationSearchViewController.h"

#import "Header.h"
#import "UIImageView+WebCache.h"
#import "HttpMamager.h"
#import "UrlContant.h"
#import "UIView+AddViewNoNetAndNoContent.h"

#import "IndustryInformationCell.h"
#import "OnlineExhibitionCell.h"
#import "ConventionCenterSearchCell.h"

#import "ModelGetInformationList.h"

#import "WebDatailURL.h"
#import "MyAlertCenter.h"


@interface InformationSearchViewController () <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    UITextField *_textFieldSearch;
    
    NSMutableArray *_arrayNewsList;
    NSMutableArray *_arrayOnlineList;
    NSMutableArray *_arrayOfflineList;
    
    NSInteger _aLeft;
    NSInteger _aMiddle;
    NSInteger _aRight;
    
    NSMutableArray *_arrayFooterTitle;
    
    UIView *_viewLoading;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;
@end

@implementation InformationSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    _viewLoading = [UIView loadingWithFrame:CGRectMake(0, 0, kMainW, kMainH) color:[UIColor clearColor] imageView:CGRectMake((kMainW - 34)/2, (kMainH - 34)/2, 34, 34)];
    [self.view addSubview:_viewLoading];
    _viewLoading.hidden = YES;
    
    _arrayFooterTitle = [[NSMutableArray alloc] initWithObjects:@"更多",@"更多",@"更多", nil];
    
    [self initViewSearch];
    [self initTableView];
    
    [_textFieldSearch becomeFirstResponder];
    
    _aLeft = 2;
    _aMiddle = 2;
    _aRight = 2;
    
    

}

- (void)initViewSearch {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ime_icon_search_2t"] highlightedImage:[UIImage imageNamed:@"ime_icon_search"]];
    imageView.frame = CGRectMake(8, 5, 22, 22);
    [self.viewSearch addSubview:imageView];
    
    _textFieldSearch= [[UITextField alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+8, 8, [UIScreen mainScreen].bounds.size.height - 74 - 17 , 17)];
    _textFieldSearch.textColor = [UIColor colorWithRed:177/255.0 green:177/255.0 blue:177/255.0 alpha:1];
    [self.viewSearch addSubview:_textFieldSearch];
    _textFieldSearch.returnKeyType = UIReturnKeySearch;
    
    
    _textFieldSearch.delegate = self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    _viewLoading.hidden = NO;
    
    [HttpMamager postRequestWithURLString:DYZ_information_searchInformation parameters:@{@"searchInfo":textField.text,@"page":@1,@"pageSize":pageSizeDYZ} success:^(id responseObjectModel) {
        _viewLoading.hidden = YES;
        ModelGetInformationList *model = responseObjectModel;
        _arrayNewsList = model.newsList;
        _arrayOnlineList = model.onlineList;
        _arrayOfflineList = model.offlineList;
        if (_arrayNewsList.count == 0 && _arrayOnlineList.count == 0 && _arrayOfflineList.count == 0) {

            [[MyAlertCenter defaultCenter] postAlertWithMessage:@"没找到相关结果"];
        } else {
            
        }
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ModelGetInformationList")];
    [textField resignFirstResponder];
    return YES;
}

- (void)initTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"IndustryInformationCell" bundle:nil] forCellReuseIdentifier:@"section0"];
    [self.tableView registerNib:[UINib nibWithNibName:@"OnlineExhibitionCell" bundle:nil] forCellReuseIdentifier:@"section1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ConventionCenterSearchCell" bundle:nil] forCellReuseIdentifier:@"section2"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _arrayNewsList.count;
    } else if (section == 1){
        return _arrayOnlineList.count;
    } else {
        return _arrayOfflineList.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 84;
    } else if (indexPath.section == 1){
        return 84;
    } else {
        return 84;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_arrayNewsList.count != 0 && section == 0) {
        return 30;
    }
    if (_arrayOnlineList.count != 0 && section == 1) {
        return 30;
    }
    if (_arrayOfflineList.count != 0 && section == 2) {
        return 30;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainW, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    [self lineHeader:view];
    
    NSArray *array = @[@"相关的行业资讯",@"相关的在线展览",@"相关的会展中心"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 150, 14)];
    label.text = [NSString stringWithFormat:@"%@ %@",_textFieldSearch.text,array[section]];
    label.font = [UIFont systemFontOfSize:14.0];
    label.textColor = colorRGB(177, 177, 177);
    [view addSubview:label];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text];
    [attributedString addAttribute:NSForegroundColorAttributeName value:colorRGB(89, 179, 50) range:NSMakeRange(0, 3)];
    label.attributedText = attributedString;
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_arrayNewsList.count != 0 && section == 0) {
        return 40;
    }
    if (_arrayOnlineList.count != 0 && section == 1) {
        return 40;
    }
    if (_arrayOfflineList.count != 0 && section == 2) {
        return 40;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor= [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, kMainW, 40);
    [button setTitleColor:colorRGB(32, 32, 32) forState:UIControlStateNormal];
    [button setTitle:_arrayFooterTitle[section] forState:UIControlStateNormal];
    button.tag = section;
    [button addTarget:self action:@selector(searchMore:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    return view;
}

- (void)searchMore:(UIButton *)sender {
    _viewLoading.hidden = NO;
    if (sender.tag == 0) {
        [self searchMoreRefresh0:(UIButton *)sender];
    }
    if (sender.tag == 1) {
        [self searchMoreRefresh1:(UIButton *)sender];
    }
    if (sender.tag == 2) {
        [self searchMoreRefresh2:(UIButton *)sender];
    }
}

- (void)searchMoreRefresh0:(UIButton *)sender {
    [HttpMamager postRequestWithURLString:DYZ_information_getInformationList parameters:@{@"searchInfo":_textFieldSearch.text,@"page":[NSNumber numberWithInteger:_aLeft],@"infoType":@"N",@"pageSize":pageSizeDYZ} success:^(id responseObjectModel) {
        ModelGetInformationList *model = responseObjectModel;
        for (int i=0; i < model.newsList.count; i++) {
            [_arrayNewsList addObject:model.newsList[i]];
        }
        if (model.newsList.count == 0) {
            [_arrayFooterTitle replaceObjectAtIndex:sender.tag withObject:@"加载完毕"];
        }
        [self.tableView reloadData];
        _viewLoading.hidden = YES;
        _aLeft++;
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ModelGetInformationList")];
}

- (void)searchMoreRefresh1:(UIButton *)sender {
    [HttpMamager postRequestWithURLString:DYZ_information_getInformationList parameters:@{@"searchInfo":_textFieldSearch.text,@"page":[NSNumber numberWithInteger:_aMiddle],@"infoType":@"O",@"pageSize":pageSizeDYZ} success:^(id responseObjectModel) {
        ModelGetInformationList *model = responseObjectModel;
        for (int i=0; i < model.onlineList.count; i++) {
            [_arrayOnlineList addObject:model.onlineList[i]];
        }
        if (model.onlineList.count == 0) {
            [_arrayFooterTitle replaceObjectAtIndex:sender.tag withObject:@"加载完毕"];
        }
        [self.tableView reloadData];
        _viewLoading.hidden = YES;
        _aMiddle++;
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ModelGetInformationList")];
}

- (void)searchMoreRefresh2:(UIButton *)sender {
    
    [HttpMamager postRequestWithURLString:DYZ_information_getInformationList parameters:@{@"searchInfo":_textFieldSearch.text,@"page":[NSNumber numberWithInteger:_aRight],@"infoType":@"I",@"pageSize":pageSizeDYZ} success:^(id responseObjectModel) {
        ModelGetInformationList *model = responseObjectModel;
        for (int i=0; i < model.offlineList.count; i++) {
            [_arrayOfflineList addObject:model.offlineList[i]];
        }
        if (model.onlineList.count == 0) {
            [_arrayFooterTitle replaceObjectAtIndex:sender.tag withObject:@"加载完毕"];
        }
        [self.tableView reloadData];
        _viewLoading.hidden = YES;
        [self.tableView reloadData];
        _aRight++;
    } fail:^(NSError *error) {
        
    } isKindOfModel:NSClassFromString(@"ModelGetInformationList")];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        IndustryInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"section0" forIndexPath:indexPath];
        [self lineCell:cell];
        
        ModelGetInformationListList *model = _arrayNewsList[indexPath.row];
        [cell.urlPath sd_setImageWithURL:[NSURL URLWithString:model.urlPath]];
        cell.title.text = model.title;
        cell.pubTm.text = [[model.pubTm componentsSeparatedByString:@" "] firstObject];
        
        NSMutableArray *tagResArray = model.tagRes;
        if (tagResArray.count == 0) {
            cell.tagRes0.text = nil;
            cell.tagRes1.text = nil;
            cell.tagRes2.text = nil;
        }
        if (tagResArray.count == 1) {
            ModelGetInformationListListTagRes *modelTagRes0 = tagResArray[0];
            cell.tagRes0.text = modelTagRes0.name;
            cell.tagRes1.text = nil;
            cell.tagRes2.text = nil;
        }
        if (tagResArray.count == 2) {
            ModelGetInformationListListTagRes *modelTagRes0 = tagResArray[0];
            ModelGetInformationListListTagRes *modelTagRes1 = tagResArray[1];
            cell.tagRes0.text = modelTagRes0.name;
            cell.tagRes1.text = modelTagRes1.name;
            cell.tagRes2.text = nil;
        }
        if (tagResArray.count == 3) {
            ModelGetInformationListListTagRes *modelTagRes0 = tagResArray[0];
            ModelGetInformationListListTagRes *modelTagRes1 = tagResArray[1];
            ModelGetInformationListListTagRes *modelTagRes2 = tagResArray[2];
            cell.tagRes0.text = modelTagRes0.name;
            cell.tagRes1.text = modelTagRes1.name;
            cell.tagRes2.text = modelTagRes2.name;
        }
        
        return cell;
    } else if (indexPath.section == 1) {
        OnlineExhibitionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"section1" forIndexPath:indexPath];
        [self lineCell:cell];
        
        ModelGetInformationListList *model = _arrayOnlineList[indexPath.row];
        [cell.urlPath sd_setImageWithURL:[NSURL URLWithString:model.urlPath]];
        cell.title.text = model.title;
        cell.info.text = model.info;
        
        return cell;
    } else {
        ConventionCenterSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"section2" forIndexPath:indexPath];
        [self lineCell:cell];
        
        ModelGetInformationListList *model = _arrayOfflineList[indexPath.row];
        [cell.urlPath sd_setImageWithURL:[NSURL URLWithString:model.urlPath]];
        cell.title.text = model.title;
        NSArray *begTmArr = [[[model.begTm componentsSeparatedByString:@" "] firstObject] componentsSeparatedByString:@"-"];
        NSArray *endTmArr = [[[model.endTm componentsSeparatedByString:@" "] firstObject] componentsSeparatedByString:@"-"];
        cell.begTm.text = [NSString stringWithFormat:@"%@.%@.%@-%@.%@",begTmArr[0],begTmArr[1],begTmArr[2],endTmArr[1],endTmArr[2]];
        cell.address.text = model.address;
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WebDatailURL *webVC = [[WebDatailURL alloc] init];
        ModelGetInformationListList *model = _arrayNewsList[indexPath.row];
        webVC.detailUrl = model.detailUrl;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    if (indexPath.section == 1) {
        WebDatailURL *webVC = [[WebDatailURL alloc] init];
        ModelGetInformationListList *model = _arrayOnlineList[indexPath.row];
        webVC.detailUrl = model.detailUrl;
        [self.navigationController pushViewController:webVC animated:YES];
    }
    if (indexPath.section == 2) {
        WebDatailURL *webVC = [[WebDatailURL alloc] init];
        ModelGetInformationListList *model = _arrayOfflineList[indexPath.row];
        webVC.detailUrl = model.detailUrl;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

- (void)lineCell:(UITableViewCell *)cell {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 83.5, kMainW, 0.5)];
    label.backgroundColor = colorLine;
    [cell.contentView addSubview:label];
}

- (void)lineHeader:(UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kMainW, 0.5)];
    label.backgroundColor = colorLine;
    [view addSubview:label];
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
