//
//  RSViewController.m
//  BSBDJ
//
//  Created by 杜鑫 on 16/6/27.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import "RSTabViewController.h"
#import "RSNewViewController.h"
#import "RSMineViewController.h"
#import "RSEssenceViewController.h"
#import "RSFriendTrendsViewController.h"
#import "RSNavViewController.h"
#import "RSTabBar.h"
@interface RSTabViewController ()

@end

@implementation RSTabViewController
+ (void)initialize{
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    NSMutableDictionary *dicts=[NSMutableDictionary dictionary];
    dicts[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    dicts[NSForegroundColorAttributeName]=[UIColor grayColor];
    
    NSMutableDictionary *selectdicts=[NSMutableDictionary dictionary];
    selectdicts[NSFontAttributeName]=[UIFont systemFontOfSize:12];
    selectdicts[NSForegroundColorAttributeName]=[UIColor darkGrayColor];
    
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:dicts forState:UIControlStateNormal ];
    [item setTitleTextAttributes:selectdicts forState:UIControlStateSelected];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setChildVC:[[RSEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectImage:@"tabBar_essence_click_icon"];
    
    [self setChildVC:[[RSNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectImage:@"tabBar_new_click_icon"];
    
    [self setChildVC:[[RSFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectImage:@"tabBar_friendTrends_click_icon"];
    
    [self setChildVC:[[RSMineViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectImage:@"tabBar_me_click_icon"];
    [self setValue:[[RSTabBar alloc] init] forKeyPath:@"tabBar"];
}
/**
 *  加载控制器
 */

- (void)setChildVC:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage{
    vc.navigationItem.title=title;
    vc.tabBarItem.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:image];
    vc.tabBarItem.selectedImage=[UIImage imageNamed:selectImage];
    
    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    RSNavViewController *nav = [[RSNavViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}
@end
