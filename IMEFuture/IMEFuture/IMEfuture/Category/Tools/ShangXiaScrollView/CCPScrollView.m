//
//  CCPScrollView.m
//  Created by C CP on 16/9/27.
//  Copyright © 2016年 C CP. All rights reserved.
//

#import "CCPScrollView.h"
#import "PmPageBean.h"

@interface CCPScrollView ()<UIScrollViewDelegate>
/**
 *  滚动视图
 */
@property (nonatomic,strong) UIScrollView *ccpScrollView;
/**
 *  label的宽度
 */
@property (nonatomic,assign) CGFloat labelW;
/**
 *  label的高度
 */
@property (nonatomic,assign) CGFloat labelH;
/**
 *  定时器
 */
@property (nonatomic,strong) NSTimer *timer;
/**
 *  记录滚动的页码
 */
@property (nonatomic,assign) int page;

@end

@implementation CCPScrollView

- (UIScrollView *)ccpScrollView {
    
    if (_ccpScrollView == nil) {
        
        _ccpScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _ccpScrollView.showsHorizontalScrollIndicator = NO;
        _ccpScrollView.showsVerticalScrollIndicator = NO;
        _ccpScrollView.scrollEnabled = NO;
        _ccpScrollView.pagingEnabled = YES;
        [self addSubview:_ccpScrollView];
        
        [_ccpScrollView setContentOffset:CGPointMake(0 , self.labelH) animated:YES];
    }
    
    return _ccpScrollView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.labelW = frame.size.width;
        
        self.labelH = frame.size.height;
        
        self.ccpScrollView.delegate = self;
        
        [self addTimer];
        
    }
    
    return self;
}

//重写set方法 创建对应的label
- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
    
    if (dataArray == nil) {
        [self removeTimer];
        return;
    }
    
    if (dataArray.count == 0) {
        [self removeTimer];
        return;
    }
    
    if (dataArray.count == 1) {
        [self removeTimer];
    }
    
    id lastObj = [dataArray lastObject];
    
    NSMutableArray *objArray = [[NSMutableArray alloc] init];
    
    [objArray addObject:lastObj];
    [objArray addObjectsFromArray:dataArray];
    
    self.titleNewArray = objArray;
    
    //CGFloat contentW = 0;
    CGFloat contentH = self.labelH *objArray.count;
    
    self.ccpScrollView.contentSize = CGSizeMake(0, contentH);
    
    CGFloat labelW = self.ccpScrollView.frame.size.width;
    self.labelW = labelW;
    CGFloat labelH = self.ccpScrollView.frame.size.height;
    self.labelH = labelH;
    CGFloat labelX = 0;
    
//    //防止重复赋值数据叠加
//    for (id label in self.ccpScrollView.subviews) {
//        
//        [label removeFromSuperview];
//        
//    }
    
    [self.ccpScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
    }];
    
    for (int i = 0; i < objArray.count; i++) {
        
        UILabel *titleLabel = [[UILabel alloc] init];
        
        titleLabel.userInteractionEnabled = YES;
        
        titleLabel.tag = 100 + i;
        
        titleLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        titleLabel.font = [UIFont systemFontOfSize:12];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTheLabel:)];
        
        [titleLabel addGestureRecognizer:tap];
        
        titleLabel.textAlignment = NSTextAlignmentLeft;
        
        CGFloat labelY = i * labelH;
        
        titleLabel.frame = CGRectMake(15+24+8, labelY, labelW-(15+24+8+15), labelH);
        
        PmPageBean *pmPageBean = objArray[i];
//        titleLabel.text = pmPageBean.content;
        
        NSString *strUrl = [pmPageBean.content stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
        strUrl = [strUrl stringByReplacingOccurrencesOfString:@"<br/>" withString:@""];
        titleLabel.text = strUrl;
        
        [self.ccpScrollView addSubview:titleLabel];
        
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 6+labelY, 24, 25)];
        NSString *imageName;
        if ([pmPageBean.appName isEqualToString:@"USERCENTER"]) {
            // @"用户中心";
            imageName = @"yhzx";
        } else if ([pmPageBean.appName isEqualToString:@"TMGC"]) {
            // @"透明工厂";
            imageName = @"tmgc";
        } else if ([pmPageBean.appName isEqualToString:@"FEIBIAO"]) {
            // @"非标交易";
            imageName = @"fb";
        } else if ([pmPageBean.appName isEqualToString:@"DRAW"]) {
            // @"图纸云";
            imageName = @"tzy";
        } else if ([pmPageBean.appName isEqualToString:@"SBBJY"]) {
            // @"设备备件云";
            imageName = @"";
        } else if ([pmPageBean.appName isEqualToString:@"WEIKE"]) {
            // @"智客";
            imageName = @"zk";
        } else if ([pmPageBean.appName isEqualToString:@"CRM"]) {
            // @"智造家客服";
            imageName = @"";
        }
        imageView.image = [UIImage imageNamed:imageName];
        [self.ccpScrollView addSubview:imageView];
        
    }
    
}

- (void)clickTheLabel:(UITapGestureRecognizer *)tap {
    
    if (self.clickLabelBlock) {
        
        NSInteger tag = tap.view.tag - 1;
        
        if (tag < 100) {
            
            tag = 100 + (self.dataArray.count - 1);
            
        }
        
        self.clickLabelBlock(tag - 100,self.dataArray[tag - 100]);
        
    }
    
}

- (void) clickTitleLabel:(clickLabelBlock) clickLabelBlock {
    
    self.clickLabelBlock = clickLabelBlock;
    
}

- (void)setIsCanScroll:(BOOL)isCanScroll {
    
    if (isCanScroll) {
        
        self.ccpScrollView.scrollEnabled = YES;
        
    } else {
        
        self.ccpScrollView.scrollEnabled = NO;
        
    }
    
}

- (void)setBGColor:(UIColor *)BGColor {
    
    _BGColor = BGColor;
    
    self.backgroundColor = BGColor;
    
}

- (void)nextLabel {
    
    CGPoint oldPoint = self.ccpScrollView.contentOffset;
    oldPoint.y += self.ccpScrollView.frame.size.height;
    [self.ccpScrollView setContentOffset:oldPoint animated:YES];
    
}
//当滚动时调用scrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.ccpScrollView.contentOffset.y == self.ccpScrollView.frame.size.height*(self.dataArray.count )) {
        
        [self.ccpScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        
    }
    
}


// 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    //开启定时器
    [self addTimer];
}

- (void)addTimer{
    
    /*
     scheduledTimerWithTimeInterval:  滑动视图的时候timer会停止
     这个方法会默认把Timer以NSDefaultRunLoopMode添加到主Runloop上，而当你滑tableView的时候，就不是NSDefaultRunLoopMode了，这样，你的timer就会停了。
     self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextLabel) userInfo:nil repeats:YES];
     */
    
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(nextLabel) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    
    [self.timer invalidate];
    self.timer = nil;
    
}

@end
