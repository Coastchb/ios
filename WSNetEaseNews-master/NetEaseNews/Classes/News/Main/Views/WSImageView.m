//
//  WSImageView.m
//  网易新闻
//
//  Created by WackoSix on 15/12/29.
//  Copyright © 2015年 WackoSix. All rights reserved.
//

#import "WSImageView.h"

@implementation WSImageView

- (instancetype)init{
    
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    }
    return self;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (self.image.size.width < self.bounds.size.width && self.image.size.height < self.bounds.size.height) {
        
        self.contentMode = UIViewContentModeCenter;
    }else if(self.image.size.width >= self.bounds.size.width || self.image.size.height >= self.bounds.size.height){
        
        self.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com