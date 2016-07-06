//
//  RSTopicCell.m
//  BSBDJ
//
//  Created by 杜鑫 on 16/7/1.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import "RSTopicCell.h"
#import "RSTopModel.h"
#import "UIImageView+RSImageView.h"
#import "RSViodeView.h"
#import "RSVoiceView.h"
#import "RSPictureView.h"
#import "RSUser.h"
#import "RSComment.h"
@interface RSTopicCell()<UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UILabel *topContentLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sinaV;
@property (strong, nonatomic) IBOutlet UIView *commentLabel;
@property (strong, nonatomic) IBOutlet UILabel *comContentLabel;
@property (strong, nonatomic) IBOutlet UIView *bottomToolLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
/** 图片 */
@property (nonatomic,weak)RSPictureView *pictureView;
/** 视频 */
@property (nonatomic,weak)RSViodeView *viodeView;
/** 音频 */
@property (nonatomic,weak)RSVoiceView *voiceView;

@end
@implementation RSTopicCell


- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *bgVI=[[UIImageView alloc]init];
    bgVI.image=[UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView=bgVI;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}
- (RSPictureView *)pictureView
{
    if (!_pictureView) {
        RSPictureView  *pictureView = [RSPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
- (RSViodeView *)viodeView{
    if (!_viodeView) {
        RSViodeView *viodeView=[RSViodeView viewFromXib];
        [self.contentView addSubview:viodeView];
        _viodeView=viodeView;
    }
    return _viodeView;
}
- (RSVoiceView *)voiceView{
    if (!_voiceView) {
        RSVoiceView *voiceView=[RSVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView=voiceView;
    }
    return  _voiceView;

}
- (void)setMolde:(RSTopModel *)model{
    _model=model;
    self.sinaV.hidden=!model.isSina_v;
    [self.headImage setHeaderImageWithURL:model.profile_image];
    self.nameLabel.text=model.name;
    self.timeLabel.text=model.create_time;
    
    
    self.topContentLabel.text=model.text;
    if (model.type==XMGTopicTypePicture) {
        self.pictureView.hidden=NO;
        self.pictureView.model=model;
        self.pictureView.frame=model.pictureF;
        self.voiceView.hidden=YES;
        self.viodeView.hidden=YES;
    }else if(model.type==XMGTopicTypeVoice){
        self.voiceView.hidden=NO;
        self.voiceView.modle=model;
        self.voiceView.frame=model.voiceF;
        self.pictureView.hidden=YES;
        self.viodeView.hidden=YES;
    }else if(model.type==XMGTopicTypeVideo){
        self.viodeView.hidden=NO;
        self.viodeView.model=model;
        self.viodeView.frame=model.videoF;
        self.pictureView.hidden=YES;
        self.voiceView.hidden=YES;
    }else{
        self.viodeView.hidden=YES;
        self.voiceView.hidden=YES;
        self.pictureView.hidden=YES;
    }
    
    if (model.top_cmt) {
        self.commentLabel.hidden=NO;
        self.comContentLabel.text = [NSString stringWithFormat:@"%@ : %@", model.top_cmt.user.username, model.top_cmt.content];
    }else{
        self.commentLabel.hidden=YES;
    }
    
}
- (void)setFrame:(CGRect)frame{
    frame.size.height=self.model.cellHeight-XMGTopicCellMargin;
    frame.origin.y += XMGTopicCellMargin;
    
    [super setFrame:frame];
}

@end
