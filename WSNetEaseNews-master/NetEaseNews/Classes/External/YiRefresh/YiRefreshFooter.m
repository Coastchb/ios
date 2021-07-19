
//
//  YiRefreshFooter.m
//  YiRefresh
//
//  Created by apple on 15/3/6.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//
//YiRefresh is a simple way to use pull-to-refresh.下拉刷新，大道至简，最简单的网络刷新控件
//项目地址在：https://github.com/coderyi/YiRefresh
//

#import "YiRefreshFooter.h"
@interface YiRefreshFooter (){
    
    float contentHeight;
    float scrollFrameHeight;
    float footerHeight;
    float scrollWidth;
    BOOL isAdd;//是否添加了footer,默认是NO
    BOOL isRefresh;//是否正在刷新,默认是NO
    
    UIView *footerView;
    UIActivityIndicatorView *activityView;
    
}
@end

@implementation YiRefreshFooter

- (void)footer
{
    scrollWidth=_scrollView.frame.size.width;
    footerHeight=35;
    scrollFrameHeight=_scrollView.frame.size.height;
    isAdd=NO;
    isRefresh=NO;
    footerView=[[UIView alloc] init];
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (![@"contentOffset" isEqualToString:keyPath]) return;
    contentHeight=_scrollView.contentSize.height;
    if (!isAdd) {
        isAdd=YES;
        footerView.frame=CGRectMake(0, contentHeight, scrollWidth, footerHeight);
        [_scrollView addSubview:footerView];
        activityView.frame=CGRectMake((scrollWidth-footerHeight)/2, 0, footerHeight, footerHeight);
        [footerView addSubview:activityView];
    }
    
    footerView.frame=CGRectMake(0, contentHeight, scrollWidth, footerHeight);
    activityView.frame=CGRectMake((scrollWidth-footerHeight)/2, 0, footerHeight, footerHeight);
    int currentPostion = _scrollView.contentOffset.y;
    // 进入刷新状态
    if ((currentPostion>(contentHeight-scrollFrameHeight))&&(contentHeight>scrollFrameHeight)) {
        [self beginRefreshing];
        return;
    }
    NSLog(@"%d, %f, %f,%f",currentPostion,contentHeight-scrollFrameHeight,contentHeight, scrollFrameHeight);
    
}

/**
 *  开始刷新操作  如果正在刷新则不做操作
 */
- (void)beginRefreshing
{
    if (!isRefresh) {
        isRefresh=YES;
        [activityView startAnimating];
        //        设置刷新状态_scrollView的位置
        [UIView animateWithDuration:0.3 animations:^{
            NSLog(@"%@", NSStringFromUIEdgeInsets(_scrollView.contentInset));
            _scrollView.contentInset=UIEdgeInsetsMake(0, 0, footerHeight, 0);
            footerView.hidden = false;
        }];
        //        block回调
        _beginRefreshingBlock();
    }
}

/**
 *  关闭刷新操作  请加在UIScrollView数据刷新后，如[tableView reloadData];
 */
- (void)endRefreshing
{
    isRefresh=NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            [activityView stopAnimating];
            _scrollView.contentInset= self.autoAdjustScrollView ?  UIEdgeInsetsMake(64, 0, 49, 0) : UIEdgeInsetsMake(0, 0, 0, 0);
            footerView.hidden = true;
        }];
    });
}

- (void)dealloc
{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com