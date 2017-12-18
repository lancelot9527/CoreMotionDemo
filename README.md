## Core Motiion 
用于处理加速度计，陀螺仪，计步器和与环境有关的事件。

***
Core Motion框架从iOS设备的板载硬件（包括加速计，陀螺仪，计步器，磁力计和气压计）报告与运动和环境有关的数据。您可以使用此框架访问硬件生成的数据，以便您可以在应用程序中使用它。例如，游戏可能使用加速度计和陀螺仪数据来控制屏幕上的游戏行为。
这个框架的许多服务都可以访问硬件记录的原始值和这些值的处理版本。处理后的值不包括第三方因素对该数据的造成不利影响的情况。例如，处理的加速度计值仅反映由用户引起的加速度，而不是由重力引起的加速度。
> 在iOS 10.0或之后版本的iOS应用程序必须在其Info.plist文件中包含使用说明Key的描述，以告知用户获取所需的数据类型及获取数据类型的目的。未能包含这些Key会导致应用程序崩溃。特别是访问运动和健身数据时，必须声明[NSMotionUsageDescription]
>> 以上资料均来源于[https://developer.apple.com/documentation/coremotion]

[NSMotionUsageDescription]:https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW21
[https://developer.apple.com/documentation/coremotion]: https://developer.apple.com/documentation/coremotion 
***

## 加速计
![加速计](https://user-gold-cdn.xitu.io/2017/12/15/16059a34e05eb382?w=770&h=880&f=png&s=46000)
`该图为，加速度计沿x，y和z轴的速度变化`
## 陀螺仪
![陀螺仪](https://user-gold-cdn.xitu.io/2017/12/15/160598d4b9cfab23?w=778&h=927&f=png&s=62418)
`该图为，旋转反向速率对陀螺仪绕x，y和z轴的影响变化`
## 代码示例
### Push方式获取数据
#### 加速度计   
  
    CMMotionManager *manager = [[CMMotionManager alloc] init];
    
    if ([manager isAccelerometerAvailable] && ![manager isAccelerometerActive]){

        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        manager.accelerometerUpdateInterval = 0.1;//设置信息更新频率(0.1s获取一次)
        [manager startAccelerometerUpdatesToQueue:queue
                                      withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             CMAcceleration acceleration = accelerometerData.acceleration;
             
             NSLog(@"x = %.04f", acceleration.x);
             NSLog(@"y = %.04f", acceleration.y);
             NSLog(@"z = %.04f", acceleration.z);

         }];
    }
    
#### 陀螺仪
```
CMMotionManager *manager = [[CMMotionManager alloc] init];
    
    if ([manager isGyroAvailable] && ![manager isGyroActive]){
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        manager.gyroUpdateInterval = 0.1;//设置信息更新频率(0.1s获取一次)
        [manager startGyroUpdatesToQueue:queue
                             withHandler:^(CMGyroData *gyroData, NSError *error)
         {
            CMRotationRate rotationrate = gyroData.rotationRate;
            NSLog(@"x = %.04f", rotationRate.x);
            NSLog(@"y = %.04f", rotationRate.y);
            NSLog(@"z = %.04f", rotationRate.z);
         }];
    }
```
### Pull方式获取数据
```
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (strong, nonatomic) CMMotionManager *motionManager;
//UI
@property (strong, nonatomic) UIButton *starButton;             //启动 MotionManager
@property (strong, nonatomic) UIButton *pullButton;             //拉取数据
@property (strong, nonatomic) UIButton *stopButton;             //停止 MotionManager

@end

@implementation ViewController

#pragma mark - 懒加载

- (CMMotionManager *)motionManager{
    
    if (!_motionManager) {
        
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.accelerometerUpdateInterval = 0.1;
        self.motionManager.gyroUpdateInterval = 0.1;
    }
    return _motionManager;
}


- (UIButton *)starButton{
    
    if (!_starButton) {
        
        _starButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 50, 50)];
        [_starButton setTitle:@"启动" forState:UIControlStateNormal];
        [_starButton addTarget:self action:@selector(startMotion) forControlEvents:UIControlEventTouchUpInside];
    }
    return _starButton;
}

- (UIButton *)pullButton{
    
    if (!_pullButton) {
        
        _pullButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 100, 100, 50)];
        [_pullButton setTitle:@"拉取数据" forState:UIControlStateNormal];
        [_pullButton addTarget:self action:@selector(pullMotionData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pullButton;
}

- (UIButton *)stopButton{
    
    if (!_stopButton) {
        
        _stopButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 100, 50, 50)];
        [_stopButton setTitle:@"停止" forState:UIControlStateNormal];
        [_stopButton addTarget:self action:@selector(stopMotion) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopButton;
}


#pragma mark - 生命周期处理
- (void)viewDidLoad {
    [self.view addSubview:self.starButton];
    [self.view addSubview:self.pullButton];
    [self.view addSubview:self.stopButton];
}

#pragma mark - Pull

- (void)startMotion{

   if (self.motionManager.isAccelerometerActive == NO) {
        [self.motionManager startAccelerometerUpdates];
    }
    if (self.motionManager.isGyroActive == NO){
        [self.motionManager startGyroUpdates];
    }
}

- (void)pullMotionData{
    
    //陀螺仪拉取数据
    CMGyroData *gyroData =  [self.motionManager gyroData];
    CMRotationRate rotationrate = gyroData.rotationRate;
    CMRotationRate rotationrate = gyroData.rotationRate;
    NSLog(@"x = %.04f", rotationRate.x);
    NSLog(@"y = %.04f", rotationRate.y);
    NSLog(@"z = %.04f", rotationRate.z);
    
    //加速度计拉取数据
    CMAccelerometerData *data = [self.motionManager accelerometerData];
    CMAcceleration acceleration = data.acceleration;
    NSLog(@"x = %.04f", acceleration.x);
    NSLog(@"y = %.04f", acceleration.y);
    NSLog(@"z = %.04f", acceleration.z);
}

- (void)stopMotion{
    
    //陀螺仪
    if (self.motionManager.isGyroActive == YES) {
        [self.motionManager stopGyroUpdates];
    }
    //加速度计
    if (self.motionManager.isAccelerometerActive == YES) {
        [self.motionManager stopAccelerometerUpdates];
    }
}

@end
```