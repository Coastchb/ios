//
//  WSNavigationView.h
//  网易新闻
//
//  Created by WackoSix on 15/12/27.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^itemClick)(NSInteger selectedIndex);

@interface WSNavigationView : UIScrollView

@property (assign, nonatomic) NSInteger selectedItemIndex;

@property (strong, nonatomic) NSArray<NSString *> *items;

+ (instancetype)navigationViewWithItems:(NSArray<NSString *> *)items itemClick:(itemClick)itemClick;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com