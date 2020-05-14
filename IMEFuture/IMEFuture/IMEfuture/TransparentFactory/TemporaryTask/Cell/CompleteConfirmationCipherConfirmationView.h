//
//  CompleteConfirmationCipherConfirmationView.h
//  IMEFuture
//
//  Created by 邓亚洲 on 2019/7/19.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CompleteConfirmationCipherConfirmationView : UIView

/**
 需要密码 1，不需要密码 0
 */
@property (nonatomic,strong) NSNumber *needPassword;

// 任务名
@property (nonatomic,copy) NSString * name;
// 存储实际工时
@property (nonatomic,strong) NSNumber * workTime;//Long
// 存储计划工时
@property (nonatomic,strong) NSNumber * planWorkTime;//Integer

@property (weak, nonatomic) IBOutlet UIButton *SelectionTimeButton;

@property (weak, nonatomic) IBOutlet UILabel *labelrenwu;
@property (weak, nonatomic) IBOutlet UITextField *textFieldshijigongshi;
@property (weak, nonatomic) IBOutlet UITextField *textFieldjihuagongshi;

@property (weak, nonatomic) IBOutlet UIView *passwordView;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *wrongPasswordView;





@property (nonatomic,copy) void(^affrimBlock)(void);

+ (instancetype)loadXibView;

- (void)initWithDataWithAffirmWithName:(NSString *)name ButtonClick:(void (^)(void))affrimBlock;

@end

NS_ASSUME_NONNULL_END
