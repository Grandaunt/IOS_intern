//
//  YZMenuButton.m
//  PullDownMenu
//
//  Created by yz on 16/8/12.
//  Copyright © 2016年 yz. All rights reserved.
//

#import "YZMenuButton.h"

@implementation YZMenuButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView.frame.origin.x < self.titleLabel.frame.origin.x)
    {
        
        CGRect titleLabelFrame = self.titleLabel.frame;
        titleLabelFrame.origin.x = self.imageView.frame.origin.x;
        self.titleLabel.frame = titleLabelFrame;
        
        CGRect imgFrame = self.imageView.frame;
        imgFrame.origin.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
        self.imageView.frame = imgFrame;
    }
}

@end
