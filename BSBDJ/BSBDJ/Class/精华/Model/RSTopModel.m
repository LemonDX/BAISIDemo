//
//  RSTopModel.m
//  BSBDJ
//
//  Created by 杜鑫 on 16/6/30.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import "RSTopModel.h"
#import <MJExtension.h>
#import "RSUser.h"
#import "RSComment.h"
@implementation RSTopModel
{
    CGFloat _cellHeight;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };
    
}
- (CGFloat)cellHeight{
    if (!_cellHeight) {
        CGSize maxSize=CGSizeMake([UIScreen mainScreen].bounds.size.width-2*XMGTopicCellMargin, MAXFLOAT);
        CGFloat textHeight=[self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        _cellHeight=XMGTopicCellTextY  + XMGTopicCellMargin + textHeight;
        if (self.type==XMGTopicTypePicture) {
            if (self.width!=0) {
                CGFloat picW=maxSize.width;
                CGFloat picH=picW *self.height/self.width;
                if (picH>=XMGTopicCellPictureMaxH) {
                    picH = XMGTopicCellPictureBreakH;
                    self.bigPicture = YES;
                }
                
                CGFloat picX=XMGTopicCellMargin;
                CGFloat picY = XMGTopicCellTextY + textHeight + XMGTopicCellMargin;
                _pictureF = CGRectMake(picX, picY, picW, picH);
                _cellHeight+=picH+XMGTopicCellMargin;
            }
        }else if (self.type==XMGTopicTypeVoice){
            CGFloat voiceX=XMGTopicCellMargin;
            CGFloat voiceY = XMGTopicCellTextY + textHeight + XMGTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight+=voiceH+XMGTopicCellMargin;
        }
        else if(self.type == XMGTopicTypeVideo){
            CGFloat videoX = XMGTopicCellMargin;
            CGFloat videoY = XMGTopicCellTextY + textHeight + XMGTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + XMGTopicCellMargin;
        }
        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += XMGTopicCellTopCmtTitleH + contentH + XMGTopicCellMargin;
        }
    }
    return _cellHeight;
}
@end
