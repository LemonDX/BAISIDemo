//
//  RSEssenceViewController.m
//  BSBDJ
//
//  Created by 杜鑫 on 16/6/27.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import "RSEssenceViewController.h"
#import "RSTopicViewController.h"
@interface RSEssenceViewController ()<UIScrollViewDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation RSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigation];
    
    [self setChildVces];
    [self setTitles];
    [self setConteView];
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
 *  主要内容
 */
- (void)setConteView{
    self.automaticallyAdjustsScrollViewInsets=NO;
    UIScrollView *contentView=[[UIScrollView alloc]init];
    contentView.frame=self.view.bounds;
    contentView.delegate=self;
    contentView.pagingEnabled=YES;
    contentView.contentSize= CGSizeMake(contentView.width * self.childViewControllers.count, 0);
 
    self.contentView=contentView;
     [self.view insertSubview:contentView atIndex:0];
    
    [self scrollViewDidEndDecelerating:contentView];
}

/**
 *  子控制器
 */
- (void)setChildVces{
    NSArray *titleArray=@[@"全部",@"视频",@"声音",@"图片",@"段子"];
    NSArray *typeArray=@[@(XMGTopicTypeAll),@(XMGTopicTypeVideo),@(XMGTopicTypeVoice),@(XMGTopicTypePicture),@(XMGTopicTypeWord)];
    for ( int i=0; i<5; i++) {
        RSTopicViewController *vc=[[RSTopicViewController alloc]init];
        vc.title = titleArray[i];
        vc.type = typeArray [i];
        [self addChildViewController:vc];
    }
}
/**
 *  顶部标签栏
 */
- (void)setTitles{
    //标题的背景
    UIView *samllView=[[UIView alloc]init];
    samllView.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:0.8];
    samllView.width=self.view.width;
    samllView.height=XMGTitilesViewH;
    samllView.y=XMGTitilesViewY;
    [self.view addSubview:samllView];
    self.titlesView=samllView;
    
    //红色线条
    UIView *linview=[[UIView alloc]init];
    linview.backgroundColor=[UIColor redColor];
    linview.height=2;
    linview.tag=-1;
    linview.y=samllView.height-linview.height;
    self.indicatorView=linview;
    //[self.titlesView addSubview:linview];
    
    //子标签
    CGFloat height=samllView.height;
    CGFloat width=samllView.width/self.childViewControllers.count;
    for (NSInteger i=0; i<self.childViewControllers.count; i++) {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.height=height;
        btn.width=width;
        btn.x=i*width;
        UIViewController *vc=self.childViewControllers[i];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [btn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn.titleLabel sizeToFit];
        btn.tag=i;
        [self.titlesView addSubview:btn];
        if (i==0) {
            btn.enabled=NO;
            self.selectedButton=btn;
            self.indicatorView.width = btn.titleLabel.width;
            self.indicatorView.centerX = btn.centerX;
        }
    }
    [samllView addSubview:self.indicatorView];
    
}
- (void)titleBtnClick:(UIButton *)btn{
    self.selectedButton.enabled=YES;
    self.selectedButton=btn;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = btn.titleLabel.width;
        self.indicatorView.centerX = btn.centerX;
    }];
    CGPoint offset = self.contentView.contentOffset;
    offset.x = btn.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark-<UIScrollViewDelegate>
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleBtnClick:self.titlesView.subviews[index]];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/scrollView.width;
    UIViewController *vc=self.childViewControllers[index];
    vc.view.x=scrollView.contentOffset.x;
    vc.view.y=0;
    vc.view.height=scrollView.height;
    [scrollView addSubview:vc.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
