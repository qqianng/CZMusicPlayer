//
//  CZLyricsParserTests.m
//  MusicPlayer
//
//  Created by qqianng on 17/5/6.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "CZTestCase.h"
#import "CZLyricsParser.h"
#import "CZLyrics.h"

@interface CZLyricsParserTests : CZTestCase

@end

@implementation CZLyricsParserTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatLyricsArrWithMusic {
    //given
    
    //when
    NSArray *lyricsArr = [CZLyricsParser lyricsArrWithMusic:self.musicList.firstObject];
    
    //then
    XCTAssert(lyricsArr.count != 0, @"歌词解析失败！数组为空！");
    for (CZLyrics *lyrics in lyricsArr) {
        if (![lyrics isKindOfClass:[CZLyrics class]]) {
            XCTFail(@"歌词解析失败！数组中含有元素不是CZLyrics类型！");
        }
    }
}

@end
