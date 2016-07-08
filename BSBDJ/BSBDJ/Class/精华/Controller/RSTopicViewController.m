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
#import "RSTopModel.h"
#import "RSTopicCell.h"
@interface RSTopicViewController()
@property (nonatomic, strong) NSMutableArray *dataArrays;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, strong) NSDictionary *dicts;
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
    [self setupRefresh];
    
}
static NSString *const RsTopicCellID=@"topic";
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
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RSTopicCell class]) bundle:nil]  forCellReuseIdentifier:RsTopicCellID];
}
/**
 *  定义刷新的方法
 */
- (void)setupRefresh{
    self.tableView.mj_header=[MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDate)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.autoChangeAlpha = YES;
    self.tableView.mj_footer=[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDate)];
    
}
- (NSString *)a{
    //需要判断是新帖还是旧贴
    return @"list";
}
/**
 *  刷新数据
 */
- (void)loadNewDate{
    [self.tableView.mj_footer endRefreshing];
    NSMutableDictionary *dict=[NSMutableDictionary dictionary];
    dict[@"a"]=self.a;
    dict[@"c"]=@"data";
    dict[@"type"]=@(self.type);
    NSLog(@"%d",self.type);
    self.dicts=dict;
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        nil;
    } success: ^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if(self.dicts !=dict) return ;
     
        self.maxtime=responseObject[@"info"][@"maxtime"];
        self.dataArrays=[RSTopModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.tableView  reloadData];
        [self.tableView.mj_header endRefreshing];
        self.currentPage=0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.dicts !=dict) return ;
        [self.tableView.mj_header endRefreshing];
           
    }];

}
/**
 *  更多数据
 */
- (void)loadMoreDate{
    [self.tableView.mj_header endRefreshing];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.currentPage + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.dicts = params;
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if (self.dicts != params) return;
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // 字典 -> 模型
        NSArray *newTopics = [RSTopModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.dataArrays addObjectsFromArray:newTopics];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        // 设置页码
        self.currentPage = page;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.dicts  != params) return;
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];

}

#pragma mark-TableView dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArrays.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
    RSTopicCell *cell=[tableView dequeueReusableCellWithIdentifier:RsTopicCellID];
    RSTopModel *model=self.dataArrays[indexPath.row];
    
    cell.model1=model;

    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RSTopModel *model=self.dataArrays[indexPath.row];
    return model.cellHeight;
}
@end










