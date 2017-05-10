//
//  CZMusicPlayerVC.m
//  MusicPlayer
//
//  Created by qqianng on 3/25/2016.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "CZMusicPlayerVC.h"

const float KTimerInteral = 0.1;
const float KRotateALoopInteral = 60.0;//头像旋转一圈的时间。


@interface CZMusicPlayerVC ()

@property (strong, nonatomic) CZMusicPlayer *musicPlayer;
//更新进度的计时器
@property (strong, nonatomic) NSTimer *progressTimer;
//更新歌词的计时器
@property (strong, nonatomic) NSTimer *lyricsTimer;


//歌词数组
@property (strong, nonatomic) NSArray *lyricsArr;
//记录当前歌词的下标索引
@property (assign, nonatomic) NSInteger currentLyricsIndex;


@property (weak, nonatomic) IBOutlet CZLabel *lyricsLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@property (weak, nonatomic) IBOutlet UIImageView *singerImgView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *albumLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightTimeLabel;
@property (weak, nonatomic) IBOutlet UISlider *progressSlider;

@end


@implementation CZMusicPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    // 设置毛玻璃效果
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurview = [[UIVisualEffectView alloc] initWithEffect:effect];
    [self.backgroundView addSubview:blurview];
    
    [blurview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //默认播放第一首歌
    [self playMusic:self.currentMusic];
    [self pause];
    //设置界面基本信息
    [self updateBasicInfoWithMusic:self.currentMusic];
    
    //设置圆角
    self.singerImgView.layer.cornerRadius = self.singerImgView.bounds.size.width * 0.5;
}

- (void)playMusic:(CZMusic *)music {
    if (music != self.currentMusic) {
        // 更新基本音乐信息
        [self updateBasicInfoWithMusic:music];
        //重置头像
        self.singerImgView.transform = CGAffineTransformIdentity;
    }
    
    // 播放音乐
    self.currentMusic = music;
    [self.musicPlayer playWithMusic:music];
    
    self.playBtn.selected = YES;
    
    // 开启定时器
    [self progressTimer];
    [self lyricsTimer];
}

- (void)pause {
    // 暂停音乐
    [self.musicPlayer pause];
    
    // 停止进度更新
    [self stopProgressTimer];
    [self stopLyricsTime];
}

- (BOOL)isPlaying {
    return self.musicPlayer.isPlaying;
}

#pragma mark - Action

//播放音乐
- (IBAction)playAction:(UIButton *)button {
    if ([self.musicPlayer isPlaying]) {
        [self pause];
        button.selected = NO;
    } else {
        [self playMusic:self.currentMusic];
        button.selected = YES;
    }
}

//播放上一首
- (IBAction)previousAction:(UIButton *)sender {
    NSInteger index = [self.musicList indexOfObject:self.currentMusic];
    // 如果是第一首歌, 跳转到最后一首
    if (index == 0) {
        index = self.musicList.count - 1;
    } else {
        index--;
    }
    [self playMusic:self.musicList[index]];
}

//播放下一首
- (IBAction)nextAction:(UIButton *)sender {
    NSInteger index = [self.musicList indexOfObject:self.currentMusic];
    // 如果是最后一首, 跳转到第一首
    if (index == self.musicList.count-1) {
        index = 0;
    } else {
        index++;
    }
    [self playMusic:self.musicList[index]];
}

- (IBAction)progressDownAction:(UISlider *)sender {
    // 停止进度更新
    [self stopProgressTimer];
}

- (IBAction)progressValueChangeAction:(UISlider *)sender {
    // 更新左边的当前时间
    self.leftTimeLabel.text = [CZMusicTool musicTimeWithTime:sender.value * self.musicPlayer.duration];
}

- (IBAction)progressUpInsideAction:(UISlider *)sender {
    // 更新音乐的当前时间
    self.musicPlayer.currentTime = sender.value * self.musicPlayer.duration;
    
    // 开始进度更新
    [self progressTimer];
}

#pragma mark - Update UI

// 更新歌曲的基本信息
- (void)updateBasicInfoWithMusic:(CZMusic *)music
{
    // 1. 歌手
    self.singerLabel.text = music.singer;
    // 2. 歌手图片
    UIImage *image = [UIImage imageNamed:music.image];
    self.singerImgView.image = image;
    // 3. 背景图
    self.backgroundView.image = image;
    // 4. 专辑
    self.albumLabel.text = music.album;
    // 5. 歌曲名称
    self.navigationItem.title = music.name;
    // 6. 歌曲长度
    self.rightTimeLabel.text = [CZMusicTool musicTimeWithTime:self.musicPlayer.duration];
    // 7. 加载歌曲, 歌词索引重置
    self.lyricsArr = [CZLyricsParser lyricsArrWithMusic:music];
    self.currentLyricsIndex = 0;
}

// 歌词更新
- (void)updateLyrics {
    // 在歌词数组里找到对应的歌词, 显示出来, 用歌词时间与当前时间作对比
    
    NSTimeInterval currentTime = self.musicPlayer.currentTime; // 当前的播放时间
    CZLyrics *beginLyrics = self.lyricsArr[self.currentLyricsIndex];
    NSTimeInterval beginTime = beginLyrics.time; // 当前歌词的时间
    NSTimeInterval endTime;
    // 如果最后一句歌词, 手动补充一个结束时间
    if (self.currentLyricsIndex == self.lyricsArr.count - 1) {
        CZLyrics *lastLyrics = [CZLyrics lyricsWithTime:self.musicPlayer.duration content:@""];
        endTime = lastLyrics.time;
    } else {
        CZLyrics *endLyrics = self.lyricsArr[self.currentLyricsIndex + 1];
        endTime = endLyrics.time;    // 下一句歌词开始时间(当前歌词的结束时间)
    }
    
    if (beginTime > currentTime && self.currentLyricsIndex != 0) {
    // 当前歌词时间 > 当前播放时间, 找上句歌词
        self.currentLyricsIndex--;
        [self updateLyrics];
    } else if (currentTime > endTime && self.currentLyricsIndex != self.lyricsArr.count - 1) {
    // 当前歌词时间 < 当前播放时间, 找下句歌词
        self.currentLyricsIndex++;
        [self updateLyrics];
    } else {
    // 当前歌词时间 <= 当前播放时间 <= 结束时间时, 满足条件
        // 取到正确的歌词, 更新到UI上
        CZLyrics *lyrics = self.lyricsArr[self.currentLyricsIndex];
        self.lyricsLabel.text = lyrics.content;
        
        // (当前时间-歌词开始时间) / (歌词结束时间 - 歌词开始时间)
        CGFloat progress = (currentTime - beginTime) / (endTime - beginTime);
        self.lyricsLabel.progress = progress;
        self.lyricsLabel.highLightColor = CZLyricsHighlightedColor;
    }
}

// 更新进度
- (void)progressTimerAction {
    // 更新当前时间
    NSString *time = [CZMusicTool musicTimeWithTime:self.musicPlayer.currentTime];
    self.leftTimeLabel.text = time;
    
    // 更新进度条
    CGFloat progress = self.musicPlayer.currentTime / self.musicPlayer.duration;
    self.progressSlider.value = progress;
}

// 更新歌词 旋转头像
- (void)lyricsTimerAction {
    // 更新歌词
    [self updateLyrics];
    
    // 旋转头像
    [UIView animateWithDuration:KTimerInteral animations:^{
        self.singerImgView.transform = CGAffineTransformRotate(self.singerImgView.transform, 2*M_PI/KRotateALoopInteral * KTimerInteral);
    }];
}

- (void)stopProgressTimer {
    [self.progressTimer invalidate];
    self.progressTimer = nil;
}

- (void)stopLyricsTime {
    [self.lyricsTimer invalidate];
    self.lyricsTimer = nil;
}


#pragma mark - Lazy load

- (NSArray *)musicList {
    if (!_musicList) {
        // 加载plist
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"mlist.plist" withExtension:nil];
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

// 设置默认当前音乐
- (CZMusic *)currentMusic {
    if (!_currentMusic) {
        _currentMusic = self.musicList[0];
    }
    return _currentMusic;
}

- (CZMusicPlayer *)musicPlayer {
    return [CZMusicPlayer sharePlayer];
}

- (NSTimer *)progressTimer {
    if ( !_progressTimer) {
        _progressTimer = [NSTimer scheduledTimerWithTimeInterval:KTimerInteral target:self selector:@selector(progressTimerAction) userInfo:nil repeats:YES];
    }
    return _progressTimer;
}

- (NSTimer *)lyricsTimer {
    if ( !_lyricsTimer) {
        _lyricsTimer = [NSTimer scheduledTimerWithTimeInterval:KTimerInteral target:self selector:@selector(lyricsTimerAction) userInfo:nil repeats:YES];
    }
    return _lyricsTimer;
}

@end




