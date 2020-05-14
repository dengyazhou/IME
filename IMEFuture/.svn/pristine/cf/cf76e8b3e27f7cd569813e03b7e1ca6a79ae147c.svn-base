//
//  ECProjectViewControllerTest.m
//  IMEFutureTests
//
//  Created by 邓亚洲 on 2019/6/26.
//  Copyright © 2019 dengyazhou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ECProjectViewController.h"
#import "ReturnListBean.h"
#import "MJExtension.h"


@interface ECProjectViewControllerTest : XCTestCase

@property (nonatomic, strong) ECProjectViewController *vc;

@end

@implementation ECProjectViewControllerTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vc = [[ECProjectViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.vc = nil;
}


- (void)testPurchaseProjectGetPurchaseProjectList {
    XCTestExpectation *exp = [self expectationWithDescription:@"异步测试 --- 采购商获取项目列表接口"];
    [self.vc requestData:^(id data) {
        ReturnListBean *model = data;
        XCTAssertEqualObjects(model.status, @"SUCCESS", @"采购商获取项目列表接口");
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
