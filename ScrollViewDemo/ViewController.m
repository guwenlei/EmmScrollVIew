//
//  ViewController.m
//  ScrollViewDemo
//
//  Created by Emmm on 2018/7/31.
//  Copyright © 2018年 Emmm. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+Emm.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *myTableView;
@property(nonatomic,assign) NSInteger row;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _row = 0;
    //返回顶部
    //[self.myTableView addScrollToTopButton];
    //下拉刷新
    [self.myTableView addHeaderWithTarget:self
                                   action:@selector(loadData)];
    //上拉加载
    [self.myTableView addBackFooterWithTarget:self
                                       action:@selector(loadMoreData)];
    
    //设置缺省页
    __weak typeof(self)weakSelf = self;
    [self.myTableView setNothingImage:@"noMessage"
                           parentView:self.myTableView
                           buttonName:@"重新加载"
                          buttonClick:^(id click) {
                              [weakSelf loadData];
                          }];
}
- (void)loadData{
    _row = 10;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myTableView removeNothingImage];
        [self.myTableView reloadData];
        [self.myTableView headerEndRefreshing];
    });
    
    
}
- (void)loadMoreData{
    _row = _row + 5;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.myTableView reloadData];
        [self.myTableView footerEndRefreshing];
    });
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _row;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"customCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor orangeColor];
    }
    return cell;
}

- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView = [UITableView new];
        _myTableView.frame = self.view.bounds;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.rowHeight = 100;
        _myTableView.tableFooterView = [UIView new];
        [self.view addSubview:_myTableView];
    }
    return _myTableView;
}

@end
