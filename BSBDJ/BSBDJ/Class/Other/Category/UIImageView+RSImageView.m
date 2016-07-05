//
//  UIImageView+RSImageView.m
//  BSBDJ
//
//  Created by 杜鑫 on 16/7/4.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import "UIImageView+RSImageView.h"
#import <UIImageView+WebCache.h>
#import "UIImage+RSImage.h"
@implementation UIImageView (RSImageView)
- (void)setHeaderImageWithURL:(NSString *)url{
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] cirImage];
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.image = image ? [image cirImage] : placeholder;
    }];
}
@end
