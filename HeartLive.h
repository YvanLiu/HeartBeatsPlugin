//
//  HeartLive.h
//  HeartBeatsPlugin
//
//  Created by A053 on 16/9/9.
//  Copyright © 2016年 Yvan. All rights reserved.
//
/*
 
 //创建了一个心电图的View
 self.live = [[HeartLive alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 150)];
 [self.view addSubview:self.live];
 
 - (void)startHeartDelegateRatePoint:(NSDictionary *)point {
    NSNumber *n = [[point allValues] firstObject];
    //拿到的数据传给心电图View
    [self.live drawRateWithPoint:n];
 }
 */

#import <UIKit/UIKit.h>

@interface HeartLive : UIView

- (void)drawRateWithPoint:(NSNumber *)point;

@end
