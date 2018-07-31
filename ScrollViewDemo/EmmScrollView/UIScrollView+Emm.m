//
//  UIScrollView+Emm.m
//  ScrollViewDemo
//
//  Created by Emmm on 2018/7/31.
//  Copyright © 2018年 Emmm. All rights reserved.
//

#import "UIScrollView+Emm.h"

@implementation UIScrollView (Emm)
@dynamic backToTopBtn;
@dynamic nothingView;
@dynamic dropView;

//实现get/set方法 防止crash
- (UIButton *)backToTopBtn{
    return objc_getAssociatedObject(self, @selector(backToTopBtn));
}
- (void)setBackToTopBtn:(UIButton *)backToTopBtn{
    objc_setAssociatedObject(self, @selector(backToTopBtn), backToTopBtn, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)nothingView{
    return objc_getAssociatedObject(self, @selector(nothingView));
}
- (void)setNothingView:(UIView *)nothingView{
    objc_setAssociatedObject(self, @selector(nothingView), nothingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView *)dropView{
    return objc_getAssociatedObject(self, @selector(dropView));
}
- (void)setDropView:(UIView *)dropView{
    objc_setAssociatedObject(self, @selector(dropView), dropView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (MJRefreshGifHeader *)header{
    return objc_getAssociatedObject(self, @selector(header));
}
- (void)setHeader:(MJRefreshGifHeader *)header{
    objc_setAssociatedObject(self, @selector(header), header, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (MJRefreshNormalHeader *)normalHeader{
    
    return objc_getAssociatedObject(self, @selector(normalHeader));
}

- (void)setNormalHeader:(MJRefreshNormalHeader *)normalHeader{
    
    objc_setAssociatedObject(self, @selector(normalHeader), normalHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (MJRefreshAutoNormalFooter *)footer{
    
    return objc_getAssociatedObject(self, @selector(footer));
}

-(void)setFooterWithFooter:(MJRefreshAutoNormalFooter *)footer{
    
    objc_setAssociatedObject(self, @selector(footer), footer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
/**
 设置返回顶部按钮
 */
- (void)addScrollToTopButton{    
    CGFloat margin = 10.f;
    CGFloat x = self.frame.origin.x + self.superview.frame.size.width - TOPBTN_WIDTH -margin;
    CGFloat y = self.superview.frame.size.height - TOPBTN_WIDTH - margin;
    self.backToTopBtn = [[UIButton alloc] init];
    self.backToTopBtn.frame = CGRectMake(x, y, TOPBTN_WIDTH, TOPBTN_WIDTH);
    [self.backToTopBtn setBackgroundImage:[UIImage imageNamed:@"up-circle"] forState:0];
    self.backToTopBtn.alpha = 1.f;
    self.backToTopBtn.clipsToBounds = NO;
    self.backToTopBtn.hidden = NO;
    [self.backToTopBtn addTarget:self
                          action:@selector(backToTop)
                forControlEvents:UIControlEventTouchUpInside];
    [self.superview addSubview:self.backToTopBtn];
    [self.superview bringSubviewToFront:self.backToTopBtn];
}

/**
 移除返回顶部Btn
 */
- (void)removeScrollToTopButton{
    if (!self.backToTopBtn) return;
    
    self.backToTopBtn.hidden = YES;
    self.backToTopBtn = nil;
    [self.backToTopBtn removeFromSuperview];
    
}

/**
 移除返回顶部Btn点击事件
 */
- (void)removeScrollToTopButtonTarget{
    if (!self.backToTopBtn) return;
    [self.backToTopBtn removeTarget:self
                             action:@selector(backToTopBtn)
                   forControlEvents:UIControlEventTouchUpInside];
}

/**
 回到顶部
 */
- (void)backToTop{
    [self setContentOffset:CGPointMake(0.0f, 0.0f) animated:YES];
}

/**
 添加上拉加载控件
 
 @param target 目标
 @param action 方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action{
    self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    self.footer.stateLabel.textColor = TEXT_COLOR;
    [self.footer.stateLabel setFont:[UIFont systemFontOfSize:13.0f]];
    self.mj_footer = self.footer;
}

/**
 添加自动回弹的上拉加载控件
 
 @param target 目标
 @param action 方法
 */
- (void)addBackFooterWithTarget:(id)target action:(SEL)action{
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    // 设置颜色
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    [footer.arrowView setHidden:YES];
    self.mj_footer = footer;
}

/**
 添加下拉刷新控件
 
 @param target 目标
 @param action 控件
 */
- (void)addHeaderWithTarget:(id)target
                     action:(SEL)action{
    [self addHeaderWithTarget:target action:action dateKey:nil];
}

/**
  添加下拉刷新控件
  
  @param target 目标
  @param action 方法
  @param dateKey 刷新时间保存的key
  */
- (void)addHeaderWithTarget:(id)target
                     action:(SEL)action
                    dateKey:(NSString *)dateKey{
    self.header = [MJRefreshGifHeader headerWithRefreshingTarget:target refreshingAction:action];
    [self setHeaderWithImages];
    // 设置header
    self.mj_header = self.header;
}
- (void)setHeaderWithImages{
    
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=11; i++) {
        //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        //        [idleImages addObject:image];
        
        NSString *imageName = [NSString stringWithFormat:@"dropdown_loading_00%zd", i];
        
        
        UIImage *image = [UIImage imageNamed:imageName];
        if (!image) {
            imageName =  [NSString stringWithFormat:@"dropdown_loading_00%zd.jpg", i];
        }
        image = [UIImage imageNamed:imageName];
        if (!image) {
            image = [[UIImage alloc]init];
        }
        [idleImages addObject:image];
    }
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 11; i<=23; i++) {
        
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_00%zd", i]];
        
        if (!image) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_00%zd.jpg", i]];
        }
        if (!image) {
            image = [[UIImage alloc]init];
        }
        
        [refreshingImages addObject:image];
    }
    
    
    
    // 设置普通状态的动画图片
    [self.header setImages:idleImages forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self.header setImages:refreshingImages forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [self.header setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // 隐藏时间
    self.header.lastUpdatedTimeLabel.hidden = YES;
    self.header.mj_h = 75.0f;
    [self.header setBackgroundColor:[UIColor whiteColor]];
    // 设置颜色
    self.header.stateLabel.textColor = [UIColor lightGrayColor];
    self.header.stateLabel.hidden = YES;
    __weak typeof(self)weakSelf = self;
    self.header.beginRefreshingCompletionBlock = ^(){
        // 设置普通状态的动画图片
        NSMutableArray *idleImages = [NSMutableArray array];
        for (NSUInteger i = 24; i<=24; i++) {
            
            NSString *imageName = [NSString stringWithFormat:@"dropdown_loading_00%zd", i];
            
            
            UIImage *image = [UIImage imageNamed:imageName];
            if (!image) {
                imageName =  [NSString stringWithFormat:@"dropdown_loading_00%zd.jpg", i];
            }
            image = [UIImage imageNamed:imageName];
            if (!image) {
                image = [[UIImage alloc]init];
            }
            [idleImages addObject:image];
        }
        
        // 设置普通状态的动画图片
        [weakSelf.header setImages:idleImages forState:MJRefreshStateIdle];
    };
}

/**
 *  文字
 */
- (void)setFooterPullToRefreshText:(NSString *)footerPullToRefreshText
{
    // 设置文字
    [self.footer setTitle:footerPullToRefreshText forState:MJRefreshStateIdle];
    
}

- (void)setFooterReleaseToRefreshText:(NSString *)footerReleaseToRefreshText
{
    [self.footer setTitle:footerReleaseToRefreshText forState:MJRefreshStateRefreshing];
    
}

- (void)setFooterRefreshingText:(NSString *)footerRefreshingText
{
    [self.footer setTitle:footerRefreshingText forState:MJRefreshStateNoMoreData];
}

- (void)setHeaderPullToRefreshText:(NSString *)headerPullToRefreshText
{
    [self.header setTitle:headerPullToRefreshText forState:MJRefreshStateIdle];
}

- (void)setHeaderReleaseToRefreshText:(NSString *)headerReleaseToRefreshText
{
    [self.header setTitle:headerReleaseToRefreshText forState:MJRefreshStatePulling];
}

- (void)setHeaderRefreshingText:(NSString *)headerRefreshingText
{
    [self.header setTitle:headerRefreshingText forState:MJRefreshStateRefreshing];
}

/**
 *  移除下拉刷新头部控件
 */
- (void)removeHeader
{
    __block MJRefreshHeader *header = self.header;
    [self.header removeFromSuperview];
    self.header = nil;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        header = nil;
    });
    
    
    
}

/**
 *  主动让下拉刷新头部控件进入刷新状态
 
 */
- (void)headerBeginRefreshing
{
    [self.header beginRefreshing];
}

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing
{
    
    [self.header endRefreshing];
}

/**
 *  下拉刷新头部控件的可见性
 */
- (void)setHeaderHidden:(BOOL)hidden
{
    self.header.hidden = hidden;
}

- (BOOL)isHeaderHidden
{
    return self.header.isHidden;
}

- (BOOL)isHeaderRefreshing
{
    return self.header.isRefreshing;
}

/**
 *  移除上拉加载尾部控件
 */
- (void)removeFooter
{
    if (!self.mj_footer) {
        return;
    }
    [self.mj_footer endRefreshing];
    self.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height - self.mj_footer.mj_size.height);
    __block MJRefreshFooter *foot = self.mj_footer;
    [self.mj_footer removeFromSuperview];
    self.mj_footer = nil;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        foot = nil;
    });
    foot = nil;
}

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing
{
    if (!self.mj_footer) {
        return;
    }
    [self.mj_footer beginRefreshing];
}

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing
{
    if (!self.mj_footer) {
        return;
    }
    [self.mj_footer endRefreshing];
}

/**
 *  下拉刷新头部控件的可见性
 */
- (void)setFooterHidden:(BOOL)hidden
{
    self.mj_footer.hidden = hidden;
}

- (BOOL)isFooterHidden
{
    return self.mj_footer.isHidden;
}

- (BOOL)isFooterRefreshing
{
    return self.mj_footer.isRefreshing;
}

/**
 * 设置列表没有更多数据(上拉加载停止刷新并且不隐藏)
 */
- (void)setFooterLastPage:(NSString *)footerText{
    if (!self.mj_footer) {
        // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
        self.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:nil refreshingAction:nil];
        // 设置颜色
        self.footer.stateLabel.textColor = [UIColor lightGrayColor];
        self.mj_footer = self.footer;
    }
    [self.mj_footer endRefreshingWithNoMoreData];
}


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
            buttonClick:(void (^)(id click))buttonClick{
    EmmButton *buttonCustome =[[EmmButton alloc]init];
    
    if (buttonName) {
        //按钮部分
        
        [buttonCustome setFrame:CGRectMake((parentView.mj_w - 80.0f)/ 2 , (parentView.mj_h - NOTHING_IMSGEWIDTH)/ 2 + 180, 80.0f, 30.0f)];
        buttonCustome.layer.borderWidth =0.8;
        buttonCustome.layer.masksToBounds =YES;
        buttonCustome.layer.cornerRadius =5.0;
        [buttonCustome.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [buttonCustome setTitle:buttonName forState:UIControlStateNormal];
        [buttonCustome setTitleColor:[UIColor grayColor] forState:0];
        buttonCustome.layer.borderColor =[UIColor grayColor].CGColor;
        [buttonCustome addTapBlock:^(UIButton *button) {
            buttonClick(button);
        }];
        
    }
    
    [self setNothingImageWithButton:imageName
                         parentView:parentView
                             button:buttonName?buttonCustome:nil
                        buttonClick:^(id click) {
                            
                        }];
    
    
    
}

/**
 *  设置缺省页自定义按钮样式
 *
 *  @param imageName  图片名称
 *  @param parentView 需要加入的View
 *  @param button      Btn
 */
- (void)setNothingImageWithButton:(NSString *)imageName
                       parentView:(UIView *)parentView
                           button:(EmmButton *)button
                      buttonClick:(void (^)(id click))buttonClick{
    
    
    if (!self.nothingView) {
        self.nothingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, parentView.mj_w, parentView.mj_h)];
        [self.nothingView setBackgroundColor:[UIColor whiteColor]];
        //    [self.nothingView setAlpha:0.0f];
        [parentView addSubview:self.nothingView];
    }else{
        for (UIView *view in self.nothingView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    UIImageView *nothingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    nothingImage.contentMode = UIViewContentModeScaleAspectFit;
    [nothingImage setFrame:CGRectMake((self.nothingView.mj_w - NOTHING_IMSGEWIDTH)/ 2 , (self.nothingView.mj_h - NOTHING_IMSGEWIDTH)/ 2 - 80, NOTHING_IMSGEWIDTH, NOTHING_IMSGEWIDTH)];
    [self.nothingView addSubview:nothingImage];
    
    if (button) {
        [self.nothingView addSubview:button];
    }
    
}

/**
 *  移除缺省页
 */
- (void)removeNothingImage{
    
    if (self.nothingView) {
        //        [UIView animateWithDuration:0.2 animations:^{
        //            [self.nothingView setAlpha:0.0f];
        //
        //        } completion:^(BOOL finished) {
        [self.nothingView removeFromSuperview];
        self.nothingView = nil;
        //        }];
    }
}

- (void)drawDropDownAnimation:(UIView *)view
{
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 首先设置一个起始点
    [path moveToPoint:CGPointMake(0, 0)];
    // 添加二次曲线
    [path addQuadCurveToPoint:CGPointMake(view.frame.size.width , 0)
                 controlPoint:CGPointMake(view.frame.size.width / 2, view.frame.size.height * 2)];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineWidth = 5.0;
    
    UIColor *strokeColor = [UIColor redColor];
    [strokeColor set];
    
    [path stroke];
    /**创建带形状的图层*/
    CAShapeLayer *_shapeLayer=[CAShapeLayer layer];
    [_shapeLayer setFrame:view.bounds];
    
    /**注意:图层之间与贝塞尔曲线之间通过path进行关联*/
    _shapeLayer.path=path.CGPath;
    _shapeLayer.fillColor=[UIColor redColor].CGColor;
    view.layer.sublayers = nil;
    [view.layer addSublayer:_shapeLayer];
}


#pragma mark - KVO监听
- (void)addObservers
{
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self addObserver:self forKeyPath:MJRefreshKeyPathContentOffset options:options context:nil];
    [self addObserver:self forKeyPath:MJRefreshKeyPathPanState options:options context:nil];
}

- (void)removeObservers
{
    [self.superview removeObserver:self forKeyPath:MJRefreshKeyPathContentOffset];
    [self.superview removeObserver:self forKeyPath:MJRefreshKeyPathPanState];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    // 遇到这些情况就直接返回
    if (!self.userInteractionEnabled) return;
    
    // 看不见
    if (self.hidden) return;
    if ([keyPath isEqualToString:MJRefreshKeyPathContentOffset] && self.dropView) {
        if (self.contentOffset.y < 0) {
            [self.dropView setFrame:CGRectMake(0, self.contentOffset.y, self.frame.size.width, fabs(self.contentOffset.y))];
            
            [self drawDropDownAnimation:self.dropView];
        }
        
    } else if ([keyPath isEqualToString:MJRefreshKeyPathPanState]) {
        [self drawDropDownAnimation:self.dropView];
    }
}

@end
