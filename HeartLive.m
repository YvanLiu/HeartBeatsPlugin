//
//  HeartLive.m
//  HeartBeatsPlugin
//
//  Created by A053 on 16/9/9.
//  Copyright © 2016年 Yvan. All rights reserved.
//

#import "HeartLive.h"

@interface HeartLive ()
@property (strong, nonatomic) NSMutableArray *points;
@end

static CGFloat grid_w = 30.0f;

@implementation HeartLive


- (void)drawRateWithPoint:(NSNumber *)point {
    // 倒叙插入数组
    [self.points insertObject:point atIndex:0];
    
    // 删除溢出屏幕数据
    if (self.points.count > self.frame.size.width/6) {
        [self.points removeLastObject];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // 这个方法自动调取 drawRect:方法
        [self setNeedsDisplay];
    });
}

- (void)drawRate {
    
    CGFloat ww = self.frame.size.width;
    CGFloat hh = self.frame.size.height;
    CGFloat pos_x = ww;
    CGFloat pos_y = hh/2;
    // 获取当前画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 折线宽度
    CGContextSetLineWidth(context, 1.0);
    //消除锯齿
    //CGContextSetAllowsAntialiasing(context,false);
    // 折线颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextMoveToPoint(context, pos_x, pos_y);
    for (int i = 0; i < self.points.count; i++) {
        float h = [self.points[i] floatValue];
        pos_y = hh/2 + (h * hh/2) ;
        CGContextAddLineToPoint(context, pos_x, pos_y);
        pos_x -=6;
    }
    CGContextStrokePath(context);
}


#pragma mark - 网格

- (void)buildGrid {
    
    CGFloat wight  = self.frame.size.width;
    CGFloat height = self.frame.size.height;

    // 获取当前画布
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat pos_x = 0.0f;
    CGFloat pos_y = 0.0f;
    
    // 在wight范围内画竖线
    while (pos_x < wight) {
        // 设置网格线宽度
        CGContextSetLineWidth(context, 0.2);
        // 设置网格线颜色
        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
        // 起点
        CGContextMoveToPoint(context, pos_x, 1.0f);
        // 终点
        CGContextAddLineToPoint(context, pos_x, height);
        pos_x +=grid_w;
        //开始划线
        CGContextStrokePath(context);
    }
    
    // 在height范围内画横线
    while (pos_y < height) {
        
        CGContextSetLineWidth(context, 0.2);
        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
        CGContextMoveToPoint(context, 1.0f, pos_y);
        CGContextAddLineToPoint(context, wight, pos_y);
        pos_y +=grid_w;
        CGContextStrokePath(context);
    }
    pos_x = 0.0f; pos_y = 0.0f;
    
    // 在wight范围内画竖线
    while (pos_x < wight) {
        CGContextSetLineWidth(context, 0.1);
        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
        CGContextMoveToPoint(context, pos_x, 1.0f);
        CGContextAddLineToPoint(context, pos_x, height);
        pos_x +=grid_w/5;
        CGContextStrokePath(context);
    }
    
    // 在height范围内画横线
    while (pos_y < height) {
        CGContextSetLineWidth(context, 0.1);
        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
        CGContextMoveToPoint(context, 1.0f, pos_y);
        CGContextAddLineToPoint(context, wight, pos_y);
        pos_y +=grid_w/5;
        CGContextStrokePath(context);
    }

}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.points = [[NSMutableArray alloc]init];
        self.clearsContextBeforeDrawing = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [self buildGrid];
    [self drawRate];
    
}


@end
