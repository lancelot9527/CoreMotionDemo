#import "PopDemoController.h"
//处理设备的动作相关的框架
#import <CoreMotion/CoreMotion.h>

@interface PopDemoController ()
//使用动作事件的管理器
@property (strong, nonatomic) CMMotionManager *motionManager;

@end

@implementation PopDemoController

- (CMMotionManager *)motionManager{
    
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = 0.1;
    }
    return _motionManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self accelerometerDataPush];
    self.view.backgroundColor = [UIColor redColor];
}

- (void)accelerometerDataPush{
    
    CMMotionManager *manager = self.motionManager;
    
    if ([manager isAccelerometerAvailable] && ![manager isAccelerometerActive]){
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        [manager startAccelerometerUpdatesToQueue:queue
                                      withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
         {
             CMAcceleration acceleration = accelerometerData.acceleration;
             
             if (acceleration.x < -2.0) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self.navigationController popViewControllerAnimated:YES];
                 });
             }
             
             
         }];
    }
}

@end
