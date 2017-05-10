//
//  WorldMusicToolTests.m
//  MusicPlayer
//
//  Created by qqianng on 17/5/3.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "CZTestCase.h"
#import "CZMusicPlayer.h"


@interface CZMusicPlayerTests : CZTestCase

@property (weak, nonatomic) CZMusicPlayer *musicPlayer;

@end

@implementation CZMusicPlayerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.musicPlayer = [CZMusicPlayer sharePlayer];
    
    [self.musicPlayer playWithMusic:self.musicList.firstObject];
    [self.musicPlayer pause];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    [super tearDown];
}

- (void)testThatPlayWithMusic {
    //given
    [self.musicPlayer stop];
    
    //when
    BOOL res = [self.musicPlayer playWithMusic:self.musicList.firstObject];
    
    //then
    XCTAssertTrue(res, @"播放音乐失败!");
    
    
    //given
    [self.musicPlayer stop];
    
    //when
    res = [self.musicPlayer playWithMusic:nil];
    
    //then
    XCTAssertFalse(res, @"music为空时，没有播放失败！");
}

- (void)testThatPause {
    //given
    id playerMock = OCMPartialMock(self.musicPlayer.player);
    [self.musicPlayer playWithMusic:self.musicList.firstObject];
    
    //when
    [self.musicPlayer pause];
    
    //then
    OCMVerify([playerMock pause]);
}

- (void)testThatStop {
    //given
    id playerMock = OCMPartialMock(self.musicPlayer.player);
    [self.musicPlayer playWithMusic:self.musicList.firstObject];
    
    //when
    [self.musicPlayer stop];
    
    //then
    OCMVerify([playerMock stop]);
}

- (void)testThatIsPlaying {
    //given
    [self.musicPlayer stop];
    
    //then
    XCTAssertFalse(self.musicPlayer.isPlaying, @"isPlaying should be no!");
    
    
    //given
    [self.musicPlayer playWithMusic:self.musicList.firstObject];
    
    //then
    XCTAssertTrue(self.musicPlayer.isPlaying, @"isPlaying should be yes!");
}

- (void)testThatCurrentTime {
    //given
    AVAudioPlayer *playerMock = OCMPartialMock(self.musicPlayer.player);
    
    //when
    [self.musicPlayer currentTime];
    
    //then 是否正确获取currentTime
    OCMVerify([playerMock currentTime]);
    
    
    //given
    NSTimeInterval currentTime = 1.0;
    
    //when
    self.musicPlayer.currentTime = currentTime;
    
    //then 是否正确设置时间
    OCMVerify(playerMock.currentTime = currentTime);
}

- (void)testThatDuration {
    //given
    AVAudioPlayer *playerMock = OCMPartialMock(self.musicPlayer.player);
    
    //when
    [self.musicPlayer duration];
    
    //then 是否正确获取duration
    OCMVerify([playerMock duration]);
}


@end
