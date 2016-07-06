//
//  RSVoiceView.m
//  BSBDJ
//
//  Created by 杜鑫 on 16/7/5.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import "RSVoiceView.h"
#import "RSTopModel.h"
#import <UIImageView+WebCache.h>

@interface RSVoiceView()
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *playNum;
@property (weak, nonatomic) IBOutlet UILabel *playTime;

@end
@implementation RSVoiceView

- (void)awakeFromNib{
}
- (void)setModle:(RSTopModel *)modle{
    _modle=modle;
    [self.contentImage sd_setImageWithURL:[NSURL URLWithString:modle.large_image]];
    self.playNum.text=[NSString stringWithFormat:@"%zd播放",modle.playcount];
    NSInteger minute = modle.voicetime / 60;
    NSInteger second = modle.voicetime % 60;
    self.playTime.text=[NSString stringWithFormat:@"%02zd:%02zd",minute,second];

}
@end
