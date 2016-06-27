//
//  RSTabBar.m
//  BSBDJ
//
//  Created by 杜鑫 on 16/6/27.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import "RSTabBar.h"

@interface RSTabBar()
@property (nonatomic,weak)UIButton *publishButton;

@end
@implementation RSTabBar
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}
- (void)publishClick{

}
- (void)layoutSubviews{
    [super layoutSubviews];
    static BOOL added=NO;
    
    CGFloat width=self.width;
    CGFloat height=self.height;
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    CGFloat buttonY=0;
    CGFloat buttonW=width/5;
    CGFloat buttonH=height;
    NSInteger index=0;
    
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]]||button ==self.publishButton)
            continue;
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 增加索引
        index++;
        
        if (added == NO) {
            // 监听按钮点击
            [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
     added = YES;
    
}

- (void)buttonClick
{
    // 发出一个通知
   
}
@end
