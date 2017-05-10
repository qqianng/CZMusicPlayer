//
//  MusicPlayerTests.m
//  MusicPlayerTests
//
//  Created by qqianng on 17/5/2.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "CZTestCase.h"

@interface CZTestCase()

@end

@implementation CZTestCase

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testExample {
//    // This is an example of a functional test case.
//    
//    //given
//    //设置测试环境
//    
//    //when
//    //要测试的代码
//    
//    //then
//    //检查测试的结果
//}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

- (NSArray *)musicList {
    if ( !_musicList) {
        // 加载plist
        NSDictionary* environment = [[NSProcessInfo processInfo] environment];
        NSString* injectBundle = environment[@"XCInjectBundle"];
        NSURL *url = [[NSBundle bundleWithPath:injectBundle] URLForResource:@"tests-mlist.plist" withExtension:nil];
        NSArray *array = [NSArray arrayWithContentsOfURL:url];
        
        // 遍历字典, 创建模型
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            CZMusic *music = [[CZMusic alloc] initWithDict:dict];
            [tempArr addObject:music];
        }
        _musicList = [tempArr copy];
    }
    return _musicList;
}


@end
