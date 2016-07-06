//
//  RSPictureView.m
//  BSBDJ
//
//  Created by 杜鑫 on 16/7/5.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import "RSPictureView.h"
#import "RSProgrssView.h"
#import "RSTopModel.h"
#import <UIImageView+WebCache.h>

@interface RSPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *isGifView;
@property (weak, nonatomic) IBOutlet UIButton *seeDetailBtn;

@property (weak, nonatomic) IBOutlet RSProgrssView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@end
@implementation RSPictureView
- (void)awakeFromNib{
    self.autoresizingMask=UIViewAutoresizingNone;
    self.contentImage.userInteractionEnabled=YES;
    [self.contentImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPicture)]];
}
- (void)showPicture{

}
- (void)setModel:(RSTopModel *)model{
    _model=model;
    [self.progressView setProgress:model.pictureProgress animated:NO];
    [self.contentImage sd_setImageWithURL:[NSURL URLWithString:model.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden=NO;
        model.pictureProgress=1.0*receivedSize/expectedSize;
        [self.progressView setProgress:model.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden=YES;
        if (model.isBigPicture==NO) return ;
        //开启图形上下文
        UIGraphicsBeginImageContextWithOptions(model.pictureF.size, YES, 0.0);
        CGFloat with=model.pictureF.size.width;
        CGFloat height=with *image.size.height/image.size.width;
        [image drawInRect:CGRectMake(0, 0, with, height)];
        self.contentImage.image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }];
    NSString *pictType=model.large_image.pathExtension;
    self.isGifView.hidden=![pictType.lowercaseString isEqualToString:@"gif"];
    if(model.isBigPicture){
        self.seeDetailBtn.hidden=NO;
    }else{
        self.seeDetailBtn.hidden=YES;
    }
    
}
@end
