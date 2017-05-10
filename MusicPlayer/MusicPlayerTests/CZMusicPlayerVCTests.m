//
//  CZPlayerVCTests.m
//  MusicPlayer
//
//  Created by qqianng on 17/5/6.
//  Copyright © 2017年 itcast. All rights reserved.
//

#import "CZTestCase.h"
#import "CZMusicPlayerVC.h"

@interface CZMusicPlayerVCTests : CZTestCase

@property (strong, nonatomic) CZMusicPlayerVC *musicPlayerVC;
//@property (strong, nonatomic) CZMusicPlayer *mockMusicPlayer;

@end

@implementation CZMusicPlayerVCTests

- (void)setUp {
    [super setUp];
    
    //需要从storyboard中加载控制器.
    self.musicPlayerVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CZMusicPlayerVC"];
    [self.musicPlayerVC view];
    
    self.musicPlayerVC.musicList = self.musicList;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatPlayBtnIsTapped {
    //given
    [self.musicPlayerVC pause];
    
    //when 点击播放
    [self.musicPlayerVC.playBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    //then
    XCTAssertTrue(self.musicPlayerVC.isPlaying, @"音乐没有正常播放！");
    
    
    //when 再次点击暂停
    [self.musicPlayerVC.playBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    //then
    XCTAssertFalse(self.musicPlayerVC.isPlaying, @"音乐没有正常暂停！");
}

- (void)testThatPreviousBtnIsTapped {
    //given
    [self.musicPlayerVC playMusic:self.musicList.firstObject];
    
    //when
    [self.musicPlayerVC.previousBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    //then
    XCTAssertTrue(self.musicPlayerVC.currentMusic == self.musicList.lastObject, @"应该播放最后一首歌！");
    XCTAssertTrue(self.musicPlayerVC.isPlaying, @"音乐没有正常播放！");
    
    
    //when
    [self.musicPlayerVC.previousBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    //then
    XCTAssertTrue(self.musicPlayerVC.currentMusic == self.musicList[self.musicList.count-2], @"应该播放最后一首歌的上一首歌！");
    XCTAssertTrue(self.musicPlayerVC.isPlaying, @"音乐没有正常播放！");
}

- (void)testThatNextBtnIsTapped {
    //given
    [self.musicPlayerVC playMusic:self.musicList.lastObject];
    
    //when
    [self.musicPlayerVC.nextBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    //then
    XCTAssertTrue(self.musicPlayerVC.currentMusic == self.musicList.firstObject, @"应该播放第一首歌！");
    XCTAssertTrue(self.musicPlayerVC.isPlaying, @"音乐没有正常播放！");
    
    
    //given
    
    //when
    [self.musicPlayerVC.nextBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
    //then
    XCTAssertTrue(self.musicPlayerVC.currentMusic == self.musicList[1], @"应该播放第二首歌！");
    XCTAssertTrue(self.musicPlayerVC.isPlaying, @"音乐没有正常播放！");
}


@end
