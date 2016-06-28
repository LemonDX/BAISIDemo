//
//  UIBarButtonItem+RSBarButtonItem.h
//  BSBDJ
//
//  Created by 杜鑫 on 16/6/27.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (RSBarButtonItem)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
