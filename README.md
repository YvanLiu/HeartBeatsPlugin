
##手机摄像头测心率
------
####原理
将手指覆盖在摄像头和闪光灯上，通过手指处脉搏跳动导致的颜色变化来实时捕捉波峰波谷，计算心率

####使用
######1. 初始化

```
#import "HeartBeat.h"

[HeartBeat shareManager];

// 结束时调用
[[HeartBeat shareManager]stop];


```
######2. 调用方法

```
 --------Block方法----------
 
 
 [[HeartBeat shareManager] startHeartRatePoint:^(NSDictionary *point) {
      // 返回心率变化浮点
 } Frequency:^(NSInteger fre) {
      // 返回瞬时心率
 } Error:^(NSError *error) {
      // 返回错误信息
 }];
  
 --------Delegate方法------------
 
 [HeartBeat shareManager].delegate = self;
 [[HeartBeat shareManager] start];

 
// 代理回调
- (void)startHeartDelegateRatePoint:(NSDictionary *)point {
    NSLog(@"%@",point);
}

// 代理错误回调
- (void)startHeartDelegateRateError:(NSError *)error {
    NSLog(@"%@",error);
}

// 返回瞬时心率
- (void)startHeartDelegateRateFrequency:(NSInteger)frequency {

}

```
######3. 折线图
```
#import "HeartLive.h"

// 创建了一个心电图的View
self.live = [[HeartLive alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-20, 150)];
[self.view addSubview:self.live];

// 在delegate 或block中调用  drawRateWithPoint: 方法
- (void)startHeartDelegateRatePoint:(NSDictionary *)point {
    NSNumber *n = [[point allValues] firstObject];
    // 拿到的数据传给心电图View
    [self.live drawRateWithPoint:n];
}

```
