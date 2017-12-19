/**
 *  该Demo主要演示了陀螺仪和加速计的简单使用
 */


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define NAVIGATION_HEIGHT 64

#import "BasicDemoController.h"

//处理设备的动作相关的框架
#import <CoreMotion/CoreMotion.h>

@interface BasicDemoController ()

//使用动作事件的管理器
@property (strong, nonatomic) CMMotionManager *motionManager;
//UI
@property (strong, nonatomic) UISwitch *controlSwitch;          //控制Push，Pull获取数据

@property (strong, nonatomic) UIButton *starButton;             //启动 MotionManager
@property (strong, nonatomic) UIButton *pullButton;             //拉取数据
@property (strong, nonatomic) UIButton *stopButton;             //停止 MotionManager

@property (strong, nonatomic) UILabel *gyroTitleLabel;

@property (strong, nonatomic) UILabel *gyroXLabel;
@property (strong, nonatomic) UILabel *gyroYLabel;
@property (strong, nonatomic) UILabel *gyroZLabel;

@property (strong, nonatomic) UILabel *accelerometerTitleLabel;

@property (strong, nonatomic) UILabel *accelerometerXLabel;
@property (strong, nonatomic) UILabel *accelerometerYLabel;
@property (strong, nonatomic) UILabel *accelerometerZLabel;


@end

@implementation BasicDemoController

#pragma mark - 懒加载

- (CMMotionManager *)motionManager{
    
    if (!_motionManager) {
        
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = 0.1;
        _motionManager.gyroUpdateInterval = 0.1;
    }
    return _motionManager;
}

- (UISwitch *)controlSwitch{
    
    if (!_controlSwitch) {
        
        _controlSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-24.5, 50+NAVIGATION_HEIGHT, 70, 40)];
        [_controlSwitch addTarget:self action:@selector(pullOrPush) forControlEvents:UIControlEventValueChanged];
        
        
        UILabel *pullLabl = [[UILabel alloc]initWithFrame:CGRectMake(50, 50+NAVIGATION_HEIGHT, 50, 40)];
        pullLabl.textColor = [UIColor whiteColor];
        pullLabl.text = @"Pull";
        pullLabl.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:pullLabl];
        
        UILabel *pushLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 50+NAVIGATION_HEIGHT, 50, 40)];
        pushLabel.textColor = [UIColor whiteColor];
        pushLabel.text = @"Push";
        pushLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:pushLabel];
    }
    return _controlSwitch;
}

- (UIButton *)starButton{
    
    if (!_starButton) {
        
        _starButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 100+NAVIGATION_HEIGHT, 50, 50)];
        [_starButton setTitle:@"启动" forState:UIControlStateNormal];
        [_starButton addTarget:self action:@selector(startMotion) forControlEvents:UIControlEventTouchUpInside];
    }
    return _starButton;
}

- (UIButton *)pullButton{
    
    if (!_pullButton) {
        
        _pullButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 100+NAVIGATION_HEIGHT, 100, 50)];
        [_pullButton setTitle:@"拉取数据" forState:UIControlStateNormal];
        [_pullButton addTarget:self action:@selector(pullMotionData) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pullButton;
}

- (UIButton *)stopButton{
    
    if (!_stopButton) {
        
        _stopButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-100, 100+NAVIGATION_HEIGHT, 50, 50)];
        [_stopButton setTitle:@"停止" forState:UIControlStateNormal];
        [_stopButton addTarget:self action:@selector(stopMotion) forControlEvents:UIControlEventTouchUpInside];
    }
    return _stopButton;
}


- (UILabel *)gyroTitleLabel{
    
    if (!_gyroTitleLabel) {
        
        _gyroTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-75, 200+NAVIGATION_HEIGHT, 150, 30)];
        _gyroTitleLabel.text = @"陀螺仪数据展示";
        _gyroTitleLabel.textAlignment = NSTextAlignmentCenter;
        _gyroTitleLabel.textColor = [UIColor whiteColor];
    }
    return _gyroTitleLabel;
}

- (UILabel *)gyroXLabel{
    
    if (!_gyroXLabel) {
        
        _gyroXLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 250+NAVIGATION_HEIGHT, 100, 30)];
        _gyroXLabel.textAlignment = NSTextAlignmentCenter;
        _gyroXLabel.textColor = [UIColor whiteColor];
    }
    return _gyroXLabel;
}

- (UILabel *)gyroYLabel{
    
    if (!_gyroYLabel) {
        
        _gyroYLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 250+NAVIGATION_HEIGHT, 100, 30)];
        _gyroYLabel.textAlignment = NSTextAlignmentCenter;
        _gyroYLabel.textColor = [UIColor whiteColor];
    }
    return _gyroYLabel;
}

- (UILabel *)gyroZLabel{
    
    if (!_gyroZLabel) {
        
        _gyroZLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, 250+NAVIGATION_HEIGHT, 100, 30)];
        _gyroZLabel.textAlignment = NSTextAlignmentCenter;
        _gyroZLabel.textColor = [UIColor whiteColor];
    }
    return _gyroZLabel;
}

- (UILabel *)accelerometerTitleLabel{
    
    if (!_accelerometerTitleLabel) {
        
        _accelerometerTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-75, 300+NAVIGATION_HEIGHT, 150, 30)];
        _accelerometerTitleLabel.text = @"加速计数据展示";
        _accelerometerTitleLabel.textAlignment = NSTextAlignmentCenter;
        _accelerometerTitleLabel.textColor = [UIColor whiteColor];
    }
    return _accelerometerTitleLabel;
}

- (UILabel *)accelerometerXLabel{
    
    if (!_accelerometerXLabel) {
        
        _accelerometerXLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 350+NAVIGATION_HEIGHT, 100, 30)];
        _accelerometerXLabel.textAlignment = NSTextAlignmentCenter;
        _accelerometerXLabel.textColor = [UIColor whiteColor];
    }
    return _accelerometerXLabel;
}

- (UILabel *)accelerometerYLabel{
    
    if (!_accelerometerYLabel) {
        
        _accelerometerYLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, 350+NAVIGATION_HEIGHT, 100, 30)];
        _accelerometerYLabel.textAlignment = NSTextAlignmentCenter;
        _accelerometerYLabel.textColor = [UIColor whiteColor];
    }
    return _accelerometerYLabel;
}

- (UILabel *)accelerometerZLabel{
    
    if (!_accelerometerZLabel) {
        
        _accelerometerZLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-110, 350+NAVIGATION_HEIGHT, 100, 30)];
        _accelerometerZLabel.textAlignment = NSTextAlignmentCenter;
        _accelerometerZLabel.textColor = [UIColor whiteColor];
    }
    return _accelerometerZLabel;
}


#pragma mark - 生命周期处理

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.controlSwitch];
    [self.view addSubview:self.starButton];
    [self.view addSubview:self.pullButton];
    [self.view addSubview:self.stopButton];
    [self.view addSubview:self.gyroTitleLabel];
    [self.view addSubview:self.gyroXLabel];
    [self.view addSubview:self.gyroYLabel];
    [self.view addSubview:self.gyroZLabel];
    [self.view addSubview:self.accelerometerTitleLabel];
    [self.view addSubview:self.accelerometerXLabel];
    [self.view addSubview:self.accelerometerYLabel];
    [self.view addSubview:self.accelerometerZLabel];
    
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)pullOrPush{
    
    [self stopMotion];
    
    if (self.controlSwitch.isOn == 0) {
        
        self.pullButton.enabled = YES;
    } else if (self.controlSwitch.isOn == 1) {
        
        self.pullButton.enabled = NO;
    }
}

#pragma mark - Pull

- (void)startMotion{
    
    
    if (self.controlSwitch.isOn == 0) {
        
        if (self.motionManager.isAccelerometerActive == NO) {
            [self.motionManager startAccelerometerUpdates];
        }
        if (self.motionManager.isGyroActive == NO){
            [self.motionManager startGyroUpdates];
        }
        
    } else if (self.controlSwitch.isOn == 1) {
        
        [self gyroDataPush];
        [self accelerometerDataPush];
    }
    
}

- (void)pullMotionData{
    
    CMGyroData *gyroData =  [self.motionManager gyroData];
    CMRotationRate rotationrate = gyroData.rotationRate;
    self.gyroXLabel.text = [NSString stringWithFormat:@"%.03f",rotationrate.x];
    self.gyroYLabel.text = [NSString stringWithFormat:@"%.03f",rotationrate.y];
    self.gyroZLabel.text = [NSString stringWithFormat:@"%.03f",rotationrate.z];
    
    CMAccelerometerData *data = [self.motionManager accelerometerData];
    CMAcceleration acceleration = data.acceleration;
    self.accelerometerXLabel.text = [NSString stringWithFormat:@"%.03f",acceleration.x];
    self.accelerometerYLabel.text = [NSString stringWithFormat:@"%.03f",acceleration.y];
    self.accelerometerZLabel.text = [NSString stringWithFormat:@"%.03f",acceleration.z];
}

- (void)stopMotion{
    
    if (self.motionManager.isGyroActive == YES) {
        [self.motionManager stopGyroUpdates];
    }
    if (self.motionManager.isAccelerometerActive == YES) {
        [self.motionManager stopAccelerometerUpdates];
    }
}

#pragma mark - Push

- (void)gyroDataPush{
    
    CMMotionManager *manager = self.motionManager;
    
    if ([manager isGyroAvailable] && ![manager isGyroActive]){
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        //Push方式获取和处理数据
        [manager startGyroUpdatesToQueue:queue
                             withHandler:^(CMGyroData *gyroData, NSError *error)
         {
             CMRotationRate rotationrate = gyroData.rotationRate;
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.gyroXLabel.text = [NSString stringWithFormat:@"%.03f",rotationrate.x];
                 self.gyroYLabel.text = [NSString stringWithFormat:@"%.03f",rotationrate.y];
                 self.gyroZLabel.text = [NSString stringWithFormat:@"%.03f",rotationrate.z];
             });
         }];
    }
}

- (void)accelerometerDataPush{
    
    CMMotionManager *manager = self.motionManager;
    
    if ([manager isAccelerometerAvailable] && ![manager isAccelerometerActive]){
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [manager startAccelerometerUpdatesToQueue:queue
                                      withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             CMAcceleration acceleration = accelerometerData.acceleration;
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 self.accelerometerXLabel.text = [NSString stringWithFormat:@"%.03f",acceleration.x];
                 self.accelerometerYLabel.text = [NSString stringWithFormat:@"%.03f",acceleration.y];
                 self.accelerometerZLabel.text = [NSString stringWithFormat:@"%.03f",acceleration.z];
             });
             
         }];
    }
}

@end



