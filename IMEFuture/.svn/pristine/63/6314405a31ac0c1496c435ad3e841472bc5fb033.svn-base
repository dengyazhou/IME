//
//  IMETabBarViewController.m
//  LiveApp
//
//  Created by 邓亚洲 on 2016/11/7.
//  Copyright © 2016年 邓亚洲. All rights reserved.
//

#import "IMETabBarViewController.h"

#import "Header.h"

#import "IMETabBar.h"
#import "CaiGouShangFaPanVC.h"

@interface IMETabBarViewController () <IMETabBarDelegate>

@property (nonatomic,strong) IMETabBar *imeTabbar;

@end

@implementation IMETabBarViewController

- (IMETabBar *)imeTabbar {
    if (!_imeTabbar) {
        _imeTabbar = [[IMETabBar alloc] initWithFrame:CGRectMake(0, 0, kMainW, 49)];
        _imeTabbar.delegate = self;
    }
    return _imeTabbar;
}

- (void)tabbar:(IMETabBar *)tabbar clickButton:(IMEItemType)idx {
    if (idx != IMEItemTypeLaunch) {
        self.selectedIndex = idx - IMEItemTypeLive;
        return;
    }
    
    NSLog(@"%s",__FUNCTION__);
    
    CaiGouShangFaPanVC *caiGouShangFaPanVC = [[CaiGouShangFaPanVC alloc] init];
    [self.navigationController pushViewController:caiGouShangFaPanVC animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //加载控制器
    [self configViewControllers];
    
    //加载tabbar
    [self.tabBar addSubview:self.imeTabbar];
    
    //解决tabbar的阴影线
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
    
    
}

- (void)configViewControllers {
    NSMutableArray *array = [NSMutableArray arrayWithArray:@[@"ECInquiryViewController",@"ECOrderViewController",@"ECSupplierViewController",@"ECProjectViewController"]];
    for (NSInteger i = 0; i < array.count; i ++) {
        NSString *vcName = array[i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        [array replaceObjectAtIndex:i withObject:vc];
    }
    self.viewControllers = array;
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
