//4
//  UIImage+RSImage.m
//  BSBDJ
//
//  Created by 杜鑫 on 16/7/4.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import "UIImage+RSImage.h"

@implementation UIImage (RSImage)
- (UIImage *)cirImage{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGRect rect=CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [self drawInRect:rect];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
