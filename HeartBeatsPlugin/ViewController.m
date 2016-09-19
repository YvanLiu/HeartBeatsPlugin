//
//  ViewController.m
//  HeartBeatsPlugin
//
//  Created by A053 on 16/9/6.
//  Copyright © 2016年 Yvan. All rights reserved.
//

#import "ViewController.h"
#import "HeartBeat.h"
#import "HeartLive.h"
@interface ViewController ()<HeartBeatPluginDelegate>

@property (strong, nonatomic) HeartLive *live;
@property (strong, nonatomic) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //创建了一个心电图的View
    self.live = [[HeartLive alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 150)];
    [self.view addSubview:self.live];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 30)];
    self.label.layer.borderColor = [UIColor blackColor].CGColor;
    self.label.layer.borderWidth = 1;
    self.label.textColor = [UIColor blackColor];
    self.label.font = [UIFont systemFontOfSize:28];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];

    //开启测心率方法
    [HeartBeat shareManager].delegate = self;
    [[HeartBeat shareManager] start];
    
    /*
     [[HeartBeat shareManager] startHeartRatePoint:^(NSDictionary *point) {
         
     } Frequency:^(NSInteger fre) {
         dispatch_async(dispatch_get_main_queue(), ^{
             self.label.text = [NSString stringWithFormat:@"%ld次/分",(long)fre];
         });

     } Error:^(NSError *error) {
         
     }];
    */
    /*
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HeartBeat shareManager]stop];
    });
    
     */
}

#pragma mark - 测心率回调

- (void)startHeartDelegateRatePoint:(NSDictionary *)point {
    NSNumber *n = [[point allValues] firstObject];
    //拿到的数据传给心电图View
    [self.live drawRateWithPoint:n];
    //NSLog(@"%@",point);
}

- (void)startHeartDelegateRateError:(NSError *)error {
    NSLog(@"%@",error);
}

- (void)startHeartDelegateRateFrequency:(NSInteger)frequency {
    NSLog(@"\n瞬时心率：%ld",frequency);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.label.text = [NSString stringWithFormat:@"%ld次/分",(long)frequency];
    });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
