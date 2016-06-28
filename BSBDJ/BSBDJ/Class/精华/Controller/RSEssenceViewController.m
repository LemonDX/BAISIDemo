//
//  RSEssenceViewController.m
//  BSBDJ
//
//  Created by 杜鑫 on 16/6/27.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import "RSEssenceViewController.h"
#import "RSTopicViewController.h"
@interface RSEssenceViewController ()

@end

@implementation RSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    [self setChildVces];
    [self setTitles];
}

/**
 *  设置导航栏
 */
- (void)setNavigation{
    self.navigationItem.titleView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    self.view.backgroundColor=RSGlobalBg;
    
}
- (void)tagClick{

    
}
/**
 *  子控制器
 */
- (void)setChildVces{
    for ( int i=0; i<5; i++) {
        RSTopicViewController *vc=[[RSTopicViewController alloc]init];
        [self addChildViewController:vc];
    }
}
/**
 *  设置顶部标签栏
 */
- (void)setTitles{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
