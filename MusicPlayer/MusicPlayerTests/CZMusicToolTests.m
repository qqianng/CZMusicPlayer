//
//  CZToolTests.m
//  MusicPlayer
//
//  Created by qqianng on 17/5/6.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "CZTestCase.h"
#import "CZMusicTool.h"

@interface CZMusicToolTests : CZTestCase

@end

@implementation CZMusicToolTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatMusicTimeWithTime {
    //given
    NSTimeInterval timeInterval = 10000.0;
    
    //when
    NSString *timeStr = [CZMusicTool musicTimeWithTime:timeInterval];//00:00
    
    //then
    XCTAssertTrue([timeStr isEqualToString:@"46:40"], @"TimeInterval to '00:00' format string is wrong!");
}

- (void)testThatTimeIntervalWithString {
    //given
    NSString *timeString = @"[3:10.10]";
    
    //when
    NSTimeInterval timeInterval = [CZMusicTool timeIntervalWithString:timeString];
    
    //then
    XCTAssertTrue(timeInterval - 190.10 < 0.001);//因为浮点数在计算机中存在误差，只能将误差控制在一定范围内。
}

@end
