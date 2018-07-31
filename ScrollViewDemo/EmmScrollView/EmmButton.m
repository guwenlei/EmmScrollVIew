//
//  EmmButton.m
//  ScrollViewDemo
//
//  Created by Emmm on 2018/7/31.
//  Copyright © 2018年 Emmm. All rights reserved.
//

#import "EmmButton.h"

@implementation EmmButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)addTapBlock:(ButtonBlock)block
{
    _block = block;
    [self addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction:(UIButton *)button
{
    _block(button);
}
@end
