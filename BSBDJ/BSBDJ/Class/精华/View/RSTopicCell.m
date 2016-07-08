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
@property (strong, nonatomic) IBOutlet UIButton *dingBtn;
@property (strong, nonatomic) IBOutlet UIButton *caiBtn;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
@property (strong, nonatomic) IBOutlet UIButton *mesBtn;

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
    if (_pictureView==nil) {
        RSPictureView  *pictureView = [RSPictureView viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}
- (RSViodeView *)viodeView{
    if (_viodeView==nil) {
        RSViodeView *viodeView=[RSViodeView viewFromXib];
        [self.contentView addSubview:viodeView];
        _viodeView=viodeView;
    }
    return _viodeView;
}
- (RSVoiceView *)voiceView{
    if (_voiceView==nil) {
        RSVoiceView *voiceView=[RSVoiceView viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView=voiceView;
    }
    return  _voiceView;

}
- (void)setModel1:(RSTopModel *)model1{
    _model1=model1;
  
    self.sinaV.hidden=!model1.isSina_v;
    [self.headImage setHeaderImageWithURL:model1.profile_image];
    self.nameLabel.text=model1.name;
    self.timeLabel.text=model1.create_time;
    
    
    self.topContentLabel.text=model1.text;
    if (model1.type==XMGTopicTypePicture) {
        self.pictureView.hidden=NO;
        self.pictureView.model=model1;
        self.pictureView.frame=model1.pictureF;
        self.voiceView.hidden=YES;
        self.viodeView.hidden=YES;
    }else if(model1.type==XMGTopicTypeVoice){
        self.voiceView.hidden=NO;
        self.voiceView.modle=model1;
        self.voiceView.frame=model1.voiceF;
        self.pictureView.hidden=YES;
        self.viodeView.hidden=YES;
    }else if(model1.type==XMGTopicTypeVideo){
        self.viodeView.hidden=NO;
        self.viodeView.model=model1;
        self.viodeView.frame=model1.videoF;
        self.pictureView.hidden=YES;
        self.voiceView.hidden=YES;
    }else{
        self.viodeView.hidden=YES;
        self.voiceView.hidden=YES;
        self.pictureView.hidden=YES;
    }
    
    if (model1.top_cmt) {
        self.commentLabel.hidden=NO;
        self.comContentLabel.text = [NSString stringWithFormat:@"%@ : %@", model1.top_cmt.user.username, model1.top_cmt.content];
    }else{
        self.commentLabel.hidden=YES;
    }

}

- (void)setFrame:(CGRect)frame{
    frame.size.height=self.model1.cellHeight-XMGTopicCellMargin;
    frame.origin.y += XMGTopicCellMargin;
    
    [super setFrame:frame];
}
- (void)setBtnTitle:(UIButton *)btn count:(NSInteger )count placehor:(NSString *)name{
    if (count>1000) {
        name=[NSString stringWithFormat:@"%.1f",count/1000.0];
    }else if (count>0){
        name=[NSString stringWithFormat:@"%zd",count];
        
    }
    [btn setTitle:name forState:UIControlStateNormal];
}
@end
