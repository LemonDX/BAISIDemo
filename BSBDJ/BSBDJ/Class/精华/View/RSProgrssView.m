//
//  RSProgrssView.m
//  BSBDJ
//
//  Created by 杜鑫 on 16/7/5.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import "RSProgrssView.h"

@implementation RSProgrssView

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
