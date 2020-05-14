//
//  ECInquiryViewControllerTest.m
//  IMEFutureTests
//
//  Created by 邓亚洲 on 2019/6/25.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ECInquiryViewController.h"
#import "ReturnListBean.h"
#import "MJExtension.h"

@interface ECInquiryViewControllerTest : XCTestCase

@property (nonatomic,strong) ECInquiryViewController *vc;

@end

@implementation ECInquiryViewControllerTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [[ECInquiryViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
}

- (void)testInquiryPurchaseList {
    //一
    XCTestExpectation *exp = [self expectationWithDescription:@"异步测试 --- 采购商查看询盘列表"];
    [self.vc requestData:^(id data) {
        ReturnListBean *model = data;
//        XCTAssertEqual(model.status, @"SUCCESS", @"采购商查看询盘列表 ERROR");//错 C语言标量、结构体联合体等
        XCTAssertEqualObjects(model.status, @"SUCCESS", @"采购商查看询盘列表");
        [exp fulfill];
    }];
    [self waitForExpectationsWithTimeout:3 handler:^(NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
    
    //二
    //里面的回调都不会走
//    [self.vc requestData:^(id data) {
//        ReturnListBean *model = data;
//        XCTAssertEqual(@"123", @"SU", @"采购商查看询盘列表");
//    }];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
