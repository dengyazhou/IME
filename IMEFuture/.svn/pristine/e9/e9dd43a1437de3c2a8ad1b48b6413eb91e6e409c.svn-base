//
//  ShanChuTuPianVC.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/3/8.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "TpfShanChuTuPianVC.h"
#import "VoHeader.h"

#import "ShanChuTuPianCVCell.h"


@interface TpfShanChuTuPianVC () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    UICollectionView *_collectionView;
    
    CGFloat _height_NavBar;
    CGFloat _height_TabBar;
}

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightNavBar;

@end

@implementation TpfShanChuTuPianVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _height_NavBar = Height_NavBar;
    _height_TabBar = Height_TabBar;
    self.heightNavBar.constant = _height_NavBar;
    
    self.labelTitle.text = [NSString stringWithFormat:@"%ld/%ld",self.index+1,self.arrayDataImage.count];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _height_NavBar, kMainW, kMainH-_height_NavBar) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
//    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"ShanChuTuPianCVCell" bundle:nil] forCellWithReuseIdentifier:@"shanChuTuPianCVCell"];
    
    _collectionView.pagingEnabled = YES;
    [self.view addSubview:_collectionView];
    
    [_collectionView setContentOffset:CGPointMake(self.index*kMainW, 0) animated:NO];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kMainW, kMainH-_height_NavBar);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayDataImage.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ShanChuTuPianCVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shanChuTuPianCVCell" forIndexPath:indexPath];
    cell.imageView1.image = [UIImage imageWithData:self.arrayDataImage[indexPath.row]];
    cell.buttonCancel.tag = indexPath.row;
    [cell.buttonCancel addTarget:self action:@selector(buttonCancelClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)buttonCancelClick:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确认删除吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.arrayDataImage removeObjectAtIndex:sender.tag];
        [_collectionView reloadData];

        self.labelTitle.text = [NSString stringWithFormat:@"%ld/%ld",self.index+1,self.arrayDataImage.count];
        if (self.arrayDataImage.count == 0) {
            self.buttonBackBlock(self.arrayDataImage);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    [alertController addAction:action];
    [alertController addAction:action1];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    int x = scrollView.contentOffset.x;
    NSInteger index;
    if (x < kMainW/2) {
        index = 0;
    } else if (x < kMainW/2*3) {
        index = 1;
    } else if (x < kMainW/2*5) {
        index = 2;
    } else if (x < kMainW/2*7) {
        index = 3;
    } else if (x < kMainW/2*9) {
        index = 4;
    } else if (x < kMainW/2*11) {
        index = 5;
    } else if (x < kMainW/2*13) {
        index = 6;
    } else if (x < kMainW/2*15) {
        index = 7;
    } else if (x < kMainW/2*17) {
        index = 8;
    } else if (x < kMainW/2*19) {
        index = 9;
    } else if (x < kMainW/2*21) {
        index = 10;
    } else if (x < kMainW/2*23) {
        index = 11;
    } else if (x < kMainW/2*25) {
        index = 12;
    } else if (x < kMainW/2*27) {
        index = 13;
    } else if (x < kMainW/2*29) {
        index = 14;
    } else if (x < kMainW/2*31) {
        index = 15;
    } else if (x < kMainW/2*33) {
        index = 16;
    } else if (x < kMainW/2*35) {
        index = 17;
    } else if (x < kMainW/2*37) {
        index = 18;
    } else if (x < kMainW/2*39) {
        index = 19;
    }
    
    self.index = index;
    self.labelTitle.text = [NSString stringWithFormat:@"%ld/%ld",self.index+1,self.arrayDataImage.count];
}

- (IBAction)back:(id)sender {
    self.buttonBackBlock(self.arrayDataImage);
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
