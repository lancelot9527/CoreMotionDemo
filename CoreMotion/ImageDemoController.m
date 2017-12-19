#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#import "ImageDemoController.h"
#import <CoreMotion/CoreMotion.h>

@interface ImageDemoController ()

//使用动作事件的管理器
@property (strong, nonatomic) CMMotionManager *motionManager;
//UI
@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation ImageDemoController

#pragma mark - 懒加载

- (CMMotionManager *)motionManager{
    
    if (!_motionManager) {
        _motionManager = [[CMMotionManager alloc] init];

    }
    return _motionManager;
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
        _imageView.image = [UIImage imageNamed:@"timg.jpeg"];
    }
    return _imageView;
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.imageView];
    [self deviceMotionPush];
}

#pragma mark - Push

- (void)deviceMotionPush{
    
    CMMotionManager *manager = self.motionManager;
    
    if ([manager isDeviceMotionAvailable] && ![manager isDeviceMotionActive]){
 
        manager.deviceMotionUpdateInterval = 0.01f;
        [manager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue]
                                 withHandler:^(CMDeviceMotion *data, NSError *error) {
                                     double rotation = atan2(data.gravity.x, data.gravity.y) - M_PI;
                                     self.imageView.transform = CGAffineTransformMakeRotation(rotation);
                                 }];
    }
}


@end
