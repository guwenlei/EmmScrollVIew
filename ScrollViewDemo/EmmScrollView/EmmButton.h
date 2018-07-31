//
//  EmmButton.h
//  ScrollViewDemo
//
//  Created by Emmm on 2018/7/31.
//  Copyright © 2018年 Emmm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ButtonBlock)(UIButton *);
@interface EmmButton : UIButton
@property(nonatomic,copy)ButtonBlock block;

- (void)addTapBlock:(ButtonBlock)block;
@end
