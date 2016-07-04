//
//  RSTopicViewController.m
//  BSBDJ
//
//  Created by 杜鑫 on 16/6/27.
//  Copyright © 2016年 hmt. All rights reserved.
//

#import "RSTopicViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>
#import <MJExtension.h>
@interface RSTopicViewController()
@property (nonatomic, strong) NSMutableArray *dataArrays;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@end
@implementation RSTopicViewController
- (NSMutableArray *)dataArrays{
    if (_dataArrays==nil) {
        NSMutableArray *array=[[NSMutableArray alloc]init];
        _dataArrays=array;
    }
    return _dataArrays;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self creatTableView];
    
}
/**
 *  初始化tableView
 */
- (void)creatTableView{
    CGFloat bottom=self.tabBarController.tabBar.height;
     CGFloat top = XMGTitilesViewY + XMGTitilesViewH;
    self.tableView.contentInset=UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.scrollIndicatorInsets=UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor=[UIColor clearColor];
    
    
}
/**
 *  定义刷新的方法
 */
- (void)setupRefresh{
    self.tableView.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDate)];
    self.tableView.mj_footer=[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDate)];
    
}
/**
 *  刷新数据
 */
- (void)loadNewDate{
    
}
/**
 *  更多数据
 */
- (void)loadMoreDate{

}
@end
