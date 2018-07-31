//
//  UIScrollView+Emm.h
//  ScrollViewDemo
//
//  Created by Emmm on 2018/7/31.
//  Copyright © 2018年 Emmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
#import "EmmButton.h"

#define NOTHING_IMSGEWIDTH  240
#define TOPBTN_WIDTH 30
#define TEXT_COLOR [UIColor lightGrayColor]

@interface UIScrollView (Emm)
//返回顶部Btn
@property (nonatomic,strong) UIButton *backToTopBtn;
//下拉刷新(头部)
@property (nonatomic,strong) MJRefreshGifHeader *header;
//下拉刷新(普通头部)
@property (nonatomic,strong) MJRefreshNormalHeader *normalHeader;
//上拉加载(底部)
@property (nonatomic,strong) MJRefreshAutoNormalFooter *footer;
//缺省页
@property (nonatomic,strong) UIView *nothingView;
//下拉动画背景
@property (nonatomic,strong) UIView *dropView;


/**
 设置返回顶部Btn
 */
- (void)addScrollToTopButton;

/**
 移除返回顶部Btn
 */
- (void)removeScrollToTopButton;

/**
 移除返回顶部Btn点击事件
 */
- (void)removeScrollToTopButtonTarget;

/**
 添加上拉加载控件

 @param target 目标
 @param action 方法
 */
- (void)addFooterWithTarget:(id)target
                     action:(SEL)action;


/**
 添加自动回弹的上拉加载控件

 @param target 目标
 @param action 方法
 */
- (void)addBackFooterWithTarget:(id)target
                         action:(SEL)action;

/**
 添加下拉刷新控件

 @param target 目标
 @param action 控件
 */
- (void)addHeaderWithTarget:(id)target
                     action:(SEL)action;

/**
 添加下拉刷新控件

 @param target 目标
 @param action 方法
 @param dateKey 刷新时间保存的key
 */
- (void)addHeaderWithTarget:(id)target
                     action:(SEL)action
                    dateKey:(NSString *)dateKey;

/**
 移除下拉刷新头部控件
 */
- (void)removeHeader;

/**
 进入下拉刷新状态
 */
- (void)headerBeginRefreshing;

/**
 结束下拉刷新状态
 */
- (void)headerEndRefreshing;

/**
 下拉刷新控件的隐藏状态

 @param hidden 是否隐藏
 */
- (void)setHeaderHidden:(BOOL)hidden;

- (BOOL)isHeaderHidden;

- (BOOL)isHeaderRefreshing;

/**
 *  移除上拉加载控件
 */
- (void)removeFooter;

/**
 *  进入上拉加载状态
 */
- (void)footerBeginRefreshing;

/**
 *  结束上拉加载状态
 */
- (void)footerEndRefreshing;

/**
 *  上拉加载控件隐藏状态
 */
- (void)setFooterHidden:(BOOL)hidden;

- (BOOL)isFooterHidden;

- (BOOL)isFooterRefreshing;



/**
 *  文字
 */
- (void)setFooterPullToRefreshText:(NSString *)footerPullToRefreshText;

- (void)setFooterReleaseToRefreshText:(NSString *)footerReleaseToRefreshText;

- (void)setFooterRefreshingText:(NSString *)footerRefreshingText;

- (void)setHeaderPullToRefreshText:(NSString *)headerPullToRefreshText;

- (void)setHeaderReleaseToRefreshText:(NSString *)headerReleaseToRefreshText;

- (void)setHeaderRefreshingText:(NSString *)headerRefreshingText;

/**
 * 设置列表没有更多数据(上拉加载停止刷新并且不隐藏)
 */
- (void)setFooterLastPage:(NSString *)footerText;

#pragma mark - 缺省页
/**
 *  设置缺省页
 *
 *  @param imageName  图片名称
 *  @param parentView 需要加入的View
 */
- (void)setNothingImage:(NSString *)imageName
             parentView:(UIView *)parentView
             buttonName:(NSString *)buttonName
            buttonClick:(void (^)(id click))buttonClick;


/**
 *  设置缺省页自定义按钮样式
 *
 *  @param imageName  图片名称
 *  @param parentView 需要加入的View
 *  @param button     Btn
 */
- (void)setNothingImageWithButton:(NSString *)imageName
                       parentView:(UIView *)parentView
                           button:(EmmButton *)button
                      buttonClick:(void (^)(id click))buttonClick;

/**
 *  移除缺省页
 */
- (void)removeNothingImage;
@end
