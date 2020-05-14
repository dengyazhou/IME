//
//  ECOrderViewControllerTest.m
//  IMEFutureTests
//
//  Created by 邓亚洲 on 2019/6/26.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ECOrderViewController.h"
#import "ReturnListBean.h"
#import "MJExtension.h"


@interface ECOrderViewControllerTest : XCTestCase

@property (nonatomic, strong) ECOrderViewController *vc;

@end

@implementation ECOrderViewControllerTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [[ECOrderViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
}

- (void)testTradeOrderPurchaseTradeOrderList{
    XCTestExpectation *exp = [self expectationWithDescription:@"异步测试 --- 采购商订单列表查询接口"];
    [self.vc requestData:^(id data) {
        ReturnListBean *model = data;
        XCTAssertEqualObjects(model.status, @"SUCCESS", @"采购商订单列表查询接口");
        [exp fulfill];
    }];
    [self waitForExpectationsWithTimeout:5 handler:nil];
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
