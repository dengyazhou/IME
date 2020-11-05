//
//  EInspectionCreateCell.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/27.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "EInspectionCreateCell.h"
#import "ZuoYeDanYuanTiJiaoCollectionViewCell.h"
#import "ZuoYeDanYuanTiJiaoCollectionViewCell1.h"
#import "Header.h"


@interface ZuoYeDanYuanTiJiaoCollectionViewCell () <UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@end

@implementation EInspectionCreateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.estimatedItemSize = CGSizeMake(0.1, 0.1);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0.1;
    self.collectionView.collectionViewLayout = layout;
   
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZuoYeDanYuanTiJiaoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"zuoYeDanYuanTiJiaoCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ZuoYeDanYuanTiJiaoCollectionViewCell1" bundle:nil] forCellWithReuseIdentifier:@"zuoYeDanYuanTiJiaoCollectionViewCell1"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}









- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.arrayDateImage.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.arrayDateImage.count) {
        ZuoYeDanYuanTiJiaoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zuoYeDanYuanTiJiaoCollectionViewCell" forIndexPath:indexPath];
        cell.imageViewYZ.image = [UIImage imageWithData:self.arrayDateImage[indexPath.row].imageData];
        [cell.button addTarget:self action:@selector(buttonClickChaKanDaTuD:) forControlEvents:UIControlEventTouchUpInside];
        cell.button.tag = indexPath.row;
        return cell;
    } else if (indexPath.row == self.arrayDateImage.count) {
        ZuoYeDanYuanTiJiaoCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zuoYeDanYuanTiJiaoCollectionViewCell1" forIndexPath:indexPath];
        [cell.button addTarget:self action:@selector(buttonAddImage:) forControlEvents:UIControlEventTouchUpInside];
        cell.label0.text = @"最多上传5张";
        return cell;
    } else {
        return nil;
    }
}

- (void)buttonAddImage:(UIButton *)button {
    self.blockAddImage();
}

- (void)buttonClickChaKanDaTuD:(UIButton *)button {
    self.blockDaTu(button.tag);
}

- (void)buttonAddImageBlock:(void (^)(void))block {
    self.blockAddImage = block;
}

- (void)buttonClickChaKanDaTuBlock:(void (^)(NSInteger))block {
    self.blockDaTu = block;
}

- (void)tableViewDidSelectBlock:(void (^)(NSInteger))block {
    self.blockTableSelect = block;
}


@end
