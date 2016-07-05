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
@interface RSTopicCell()
@property (strong, nonatomic) IBOutlet UILabel *topContentLabel;
@property (strong, nonatomic) IBOutlet UIImageView *sinaV;
@property (strong, nonatomic) IBOutlet UIView *commentLabel;
@property (strong, nonatomic) IBOutlet UILabel *comContentLabel;
@property (strong, nonatomic) IBOutlet UIView *bottomToolLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *headImage;
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
- (void)setMolde:(RSTopModel *)model{
    _model=model;
    self.sinaV.hidden=!model.isSina_v;
    [self.headImage setHeaderImageWithURL:model.profile_image];
    self.nameLabel.text=model.name;
    self.timeLabel.text=model.create_time;

    
}
- (void)setFrame:(CGRect)frame{
    frame.size.height=self.model.cellHeight-XMGTopicCellMargin;
    frame.origin.y += XMGTopicCellMargin;
    
    [super setFrame:frame];
}

@end
