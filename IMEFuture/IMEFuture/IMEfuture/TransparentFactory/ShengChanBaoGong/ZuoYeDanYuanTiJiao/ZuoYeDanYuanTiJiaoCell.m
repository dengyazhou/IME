//
//  ZuoYeDanYuanTiJiaoCell.m
//  IMEFuture
//
//  Created by 邓亚洲 on 2018/6/27.
//  Copyright © 2018年 Netease. All rights reserved.
//

#import "ZuoYeDanYuanTiJiaoCell.h"
#import "ZuoYeDanYuanTiJiaoCollectionViewCell.h"
#import "ZuoYeDanYuanTiJiaoCollectionViewCell1.h"
#import "Header.h"

@interface ZuoYeDanYuanTiJiaoCollectionViewCell () <UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZuoYeDanYuanTiJiaoCell

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
    
    
    
    self.ViewBGTaBleViewMuJu.layer.borderColor = colorRGB(221, 221, 221).CGColor;
    self.ViewBGTaBleViewMuJu.layer.borderWidth = 1;
    self.ViewBGTaBleViewMuJu.hidden = YES;
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 33;
}

- (IBAction)buttonXuanZeMuJuClick:(id)sender {
    if (self.materialArray.count == 0) {
        return;
    }
    self.ViewBGTaBleViewMuJu.hidden = NO;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.materialArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.materialArray[indexPath.row].sequenceNum;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@",indexPath);

    self.ViewBGTaBleViewMuJu.hidden = YES;
    if (self.blockTableSelect) {
        self.blockTableSelect(indexPath.row);
    }
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
        cell.imageViewYZ.image = [UIImage imageWithData:self.arrayDateImage[indexPath.row].data];
        [cell.button addTarget:self action:@selector(buttonClickChaKanDaTuD:) forControlEvents:UIControlEventTouchUpInside];
        cell.button.tag = indexPath.row;
        return cell;
    } else if (indexPath.row == self.arrayDateImage.count) {
        ZuoYeDanYuanTiJiaoCollectionViewCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zuoYeDanYuanTiJiaoCollectionViewCell1" forIndexPath:indexPath];
        [cell.button addTarget:self action:@selector(buttonAddImage:) forControlEvents:UIControlEventTouchUpInside];
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
