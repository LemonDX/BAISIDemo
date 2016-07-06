//
//  RSViodeView.m
//  BSBDJ
//
//  Created by 杜鑫 on 16/7/6.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import "RSViodeView.h"
#import "RSTopModel.h"
#import <UIImageView+WebCache.h>
@interface RSViodeView()
@property (strong, nonatomic) IBOutlet UIImageView *contentImage;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) IBOutlet UILabel *playNum;
@property (strong, nonatomic) IBOutlet UILabel *playTime;
@end
@implementation RSViodeView

-(void)awakeFromNib{

}
-(void)setModel:(RSTopModel *)model{
    _model=model;
    [self.contentImage sd_setImageWithURL:[NSURL URLWithString:model.large_image]];
    self.playNum.text = [NSString stringWithFormat:@"%zd播放", model.playcount];
    
    // 时长
    NSInteger minute = model.videotime / 60;
    NSInteger second = model.videotime % 60;
    self.playTime.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}
@end
