//
//  XunPanXiangQingViewControllerTest.m
//  IMEFutureTests
//
//  Created by 邓亚洲 on 2019/6/26.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "XunPanXiangQingViewController.h"
#import "ReturnEntityBean.h"
#import "MJExtension.h"


@interface XunPanXiangQingViewControllerTest : XCTestCase

@property (nonatomic, strong) XunPanXiangQingViewController *vc;

@end

@implementation XunPanXiangQingViewControllerTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [[XunPanXiangQingViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
}

- (void)testInquiryDetail {
    XCTestExpectation *exp = [self expectationWithDescription:@"异步测试 --- 询盘详情接口"];
    [self.vc requestData:^(id data) {
        ReturnEntityBean *model = data;
        XCTAssertEqualObjects(model.status, @"SUCCESS", @"询盘详情接口");
        [exp fulfill];
    }];
    [self waitForExpectationsWithTimeout:30 handler:nil];
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
